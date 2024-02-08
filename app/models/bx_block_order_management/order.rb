# == Schema Information
#
# Table name: orders
#
#  id                      :bigint           not null, primary key
#  order_number            :string
#  amount                  :float
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  account_id              :bigint
#  coupon_code_id          :bigint
#  delivery_address_id     :bigint
#  sub_total               :decimal(, )      default(0.0)
#  total                   :decimal(, )      default(0.0)
#  status                  :string
#  applied_discount        :decimal(, )      default(0.0)
#  cancellation_reason     :text
#  order_date              :datetime
#  is_gift                 :boolean          default(FALSE)
#  placed_at               :datetime
#  confirmed_at            :datetime
#  in_transit_at           :datetime
#  delivered_at            :datetime
#  cancelled_at            :datetime
#  refunded_at             :datetime
#  source                  :string
#  shipment_id             :string
#  delivery_charges        :string
#  tracking_url            :string
#  schedule_time           :datetime
#  payment_failed_at       :datetime
#  returned_at             :datetime
#  tax_charges             :decimal(, )      default(0.0)
#  deliver_by              :integer
#  tracking_number         :string
#  is_error                :boolean          default(FALSE)
#  delivery_error_message  :string
#  payment_pending_at      :datetime
#  order_status_id         :integer
#  is_group                :boolean          default(TRUE)
#  is_availability_checked :boolean          default(FALSE)
#  shipping_charge         :decimal(, )
#  shipping_discount       :decimal(, )
#  shipping_net_amt        :decimal(, )
#  shipping_total          :decimal(, )
#  total_tax               :float
#
module BxBlockOrderManagement
  class Order < BxBlockOrderManagement::ApplicationRecord
    self.table_name = :orders

    ORDER_NO_FORMAT = '00000000'

    belongs_to :account, class_name: "AccountBlock::Account"
    belongs_to :coupon_code, class_name: "BxBlockCouponCg::CouponCode", optional: true

    belongs_to :order_status, optional: true

    has_one :order_transaction

    has_many :order_items, dependent: :destroy
    has_many :catalogues, class_name: "BxBlockCatalogue::Catalogue", through: :order_items
    has_one :address, class_name: "BxBlockAddress::Address" 
    
    has_many :order_trackings, class_name: "OrderTracking", as: :parent
    has_many :trackings, through: :order_trackings

    has_many :delivery_address_orders
    has_many :delivery_addresses, through: :delivery_address_orders


    validates :status, presence: true, inclusion: {
      in: %w(
        draft
        in_cart
        created
        placed
        confirmed
        in_transit
        delivered
        cancelled
        refunded
        payment_failed
        returned
        payment_pending
      )
    }

    accepts_nested_attributes_for :order_items, allow_destroy: true

    enum deliver_by: %i[fedex]

    before_save :set_status
    before_create :add_order_number
    after_create :send_order_draft_mail
    
    include AASM
    aasm column: 'status' do
      state :draft, initial: true
      state :created,:placed, :confirmed, :in_transit, :delivered, :cancelled, :refunded,
            :payment_failed, :returned, :payment_pending

      event :draft do
        transitions  to: :draft
      end

      event :created do
        transitions  to: :created
      end

      event :pending_order do
        transitions from: %i[draft created payment_failed],
                    to: :payment_pending,
                    after: proc { |*_args| update_state_process }
      end

      event :place_order do
        transitions  to: :placed, after: proc { |*_args| update_state_process }
      end

      event :confirm_order do
        transitions to: :confirmed, after: proc{|*_args| update_state_process}
      end

      event :to_transit do
        transitions to: :in_transit, after: proc { |*_args| update_state_process }
      end

      event :payment_failed do
        transitions  to: :payment_failed, after: proc { |*_args| update_state_process }
      end

      event :deliver_order do
        transitions  to: :delivered, after: proc { |*_args| update_state_process }
      end

      event :cancel_order do
        transitions to: :cancelled, after: proc { |*_args| update_state_process }
      end

      event :refund_order do
        transitions  to: :refunded, after: proc { |*_args| update_state_process }
      end

      event :return_order do
        transitions to: :returned, after: proc { |*_args| update_state_process }
      end

      OrderStatus.new_statuses.each do |order_status|
        state order_status.status.to_s.downcase.to_sym
      end

    end

    EVENTS = %w[
      pending_order!
      place_order!
      confirm_order!
      to_transit!
      deliver_order!
      refund_order!
      cancel_order!
      payment_failed!
      return_order!
    ]

    def update_state_process
      StateProcess.new(self, aasm).call
    end

    def send_order_draft_mail
      if sharable_code.nil?
        o = [('a'..'z'), ('A'..'Z'), ('1'..'9')].map(&:to_a).flatten
        sharable_code = (0...10).map { o[rand(o.length)] }.join
        self.update(sharable_code: sharable_code)
      end
      timer = AccountBlock::DraftMailTimer.last
      half_hour = (Time.now) + (timer&.first_mail_in_minuts || 30).minutes
      after_seven_days = (Time.now) + (timer&.second_mail_in_days || 7).days
      BxBlockOrderManagement::SendDraftOrderMailWorker.perform_at(half_hour, self.id)
      BxBlockOrderManagement::SendDraftOrderMailWorker.perform_at(after_seven_days, self.id)
    end

    def update_additional_page_price(total_page_count, family_member)
      get_price = BxBlockBook::Price.find_by(cover_type: cover_type)
      price_per_page = BxBlockBook::AdditionalPricePerPage.last
      delivery_charges = BxBlockBook::DeliveryCharge.first.charge

      if family_member
        calculate_pricing(get_price, price_per_page, delivery_charges, total_page_count, 2)
      else
        calculate_pricing(get_price, price_per_page, delivery_charges, total_page_count, 1)
      end
    end

    def set_status
      # check_holds
      if (OrderStatus::USER_STATUSES.include? self.status) && !(order_status_id_changed?)
        order_status = OrderStatus.find_or_create_by(status: self.status) if self.status.present?
        self.order_status_id = order_status.id unless self.order_status_id == order_status.id
      end
      if (order_items.pluck(:order_status_id).uniq != [order_status_id]) && (is_group?)
        self.order_items&.update(order_status_id: order_status_id)
      end
    end

    def total_price
      (order_items.sum(:total_price) - applied_discount)&.round(2)
    end

    def total_after_shipping_charge
      # applied_shipping_charge = ShippingCharge.last
      applied_shipping_charge = { below: 500.0, charge: 50.0 }
      if applied_shipping_charge.present?
        charge = applied_shipping_charge[:charge]
        self.shipping_charge = charge
        unless self.total <= applied_shipping_charge[:below]
          self.shipping_discount = charge
        else
          self.shipping_discount = 0.0
        end
      else
        self.shipping_charge = 0.0
        self.shipping_discount = 0.0
      end
      self.shipping_total = self.shipping_charge - self.shipping_discount
      self.shipping_net_amt = self.shipping_charge - self.shipping_discount
      self.total = self.total + self.shipping_total
    end

    def total_after_tax_charge
      # applied_tax = Tax.last
      applied_tax = { tax_percentage: 18 }
      if applied_tax.present?
        tax_charge = ((self.total.to_f * applied_tax[:tax_percentage].to_f)/100).to_f.round(2)
        self.total_tax = tax_charge
        self.total = self.total.round(2) + self.total_tax
      end
    end

    def sub_total_price
      order_items.sum(:total_price)&.round(2)
    end

    def full_order_cancelled?
      self.order_items.cancelled.count == self.order_items.count
    end

    def add_order_number
      self.order_number = 'OD' + Order.next_order_number
    end

    def self.next_order_number
      return Order::ORDER_NO_FORMAT.succ if Order.count.nil?
      (Order.count&.positive? ?
         Order.last&.order_number&.split('OD')[1] : Order::ORDER_NO_FORMAT).succ
    end

    def update_shipment_details(json_response)
      if json_response['status'].to_s.downcase == 'NEW'
        order_status_id = OrderStatus.find_by(status:"confirmed").id
      end
      puts "======================= update shipment details ================"
      self.update(logistics_ship_rocket_enabled: true, ship_rocket_order_id: json_response['order_id'], ship_rocket_shipment_id: json_response['shipment_id'], ship_rocket_status: json_response['status'].to_s.downcase, ship_rocket_status_code: json_response['status_code'], ship_rocket_onboarding_completed_now: json_response['onboarding_completed_now'], ship_rocket_awb_code: json_response['awb_code'], ship_rocket_courier_company_id: json_response['courier_company_id'], ship_rocket_courier_name: json_response['courier_name'], order_status_id: order_status_id.present? ? order_status_id : self.order_status_id )
    end
    
    def calculate_pricing(get_price, price_per_page, delivery_charges, total_page_count, multiply)
      base_price = get_price.price * multiply
      delivery_charges = delivery_charges * multiply
      if total_page_count > get_price.min_limit
        extra_pages = total_page_count - get_price.min_limit
        additional_price = (extra_pages * price_per_page.additional_price) * multiply
        total = additional_price + base_price
      else
        extra_pages = nil
        additional_price = nil
        total = base_price.round(2)
      end

      delivery_and_tax_charges = (base_price.to_i + delivery_charges.to_i + additional_price.to_i - self.applied_discount.to_i).round(2)
      tax = (delivery_and_tax_charges *(18.0 / 100)).round(2)
      sub_total_amount = (base_price.to_i + delivery_charges.to_i + additional_price.to_i + tax.to_f).round(2)

      self.update(base_price: base_price, total: total, additional_price: additional_price, additional_pages: extra_pages, no_of_pages: total_page_count, sub_total: sub_total_amount, tax_charges: tax, amount: sub_total_amount)
      
    end
    def test(image)
      "data:image/jpeg\;base64\,\ #{Base64.encode64(AccountBlock::DocxDownloadService.new(image).doc)}".delete "\n"
    end
  end
end
