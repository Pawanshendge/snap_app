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
  class OrderSerializer < BuilderBase::BaseSerializer

    attributes *[
        :id,
        :order_number,
        :amount,
        :account_id,
        :coupon_code_id,
        :delivery_address_id,
        :sub_total,
        :status,
        :applied_discount,
        :cancellation_reason,
        :order_date,
        :is_gift,
        :placed_at,
        :confirmed_at,
        :in_transit_at,
        :delivered_at,
        :cancelled_at,
        :refunded_at,
        :source,
        :shipment_id,
        :delivery_charges,
        :tracking_url,
        :schedule_time,
        :payment_failed_at,
        :payment_pending_at,
        :returned_at,
        :tax_charges,
        :deliver_by,
        :tracking_number,
        :is_error,
        :delivery_error_message,
        :order_status_id,
        :is_group,
        :is_availability_checked,
        :shipping_charge,
        :shipping_discount,
        :shipping_net_amt,
        :shipping_total,
        :total_tax,
        :created_at,
        :updated_at,
        :delivery_addresses,
        :razorpay_order_id,
        :no_of_pages,
        :book_size,
        :book_title,
        :book_color,
        :book_url,
        :cover_type,
        :paper_type,
        :book_id,
        :no_of_pages,
        :quantity,
        :gift_note,
        :image,
        :title_layout,
        :order_child_id,
        :additional_pages,
        :total,
        :additional_price,
        :base_price,
        :sharable_code,
        :cover_image
    ]

    attribute :image do |object|
      book = BxBlockBook::Book.find_by(id: object.book_id)
      book&.images&.where(is_cover: true)&.first.present? ? book&.images&.where(is_cover: true)&.first&.service_url : book&.images&.first&.service_url
    end

    attribute :cover_image do |object|
      book = BxBlockBook::Book.find_by(id: object.book_id)
      book&.cover_image&.present? ? book&.cover_image&.service_url : ""
    end

    attribute :book_title do |object|
      book = BxBlockBook::Book.find_by(id: object.book_id)
      book&.book_title.present? ? book&.book_title : "#{book&.month} #{book&.year}" 
    end

    attribute :spine_title do |object|
      book = BxBlockBook::Book.find_by(id: object.book_id)
      book&.spine_title
    end

    attribute :title_color do |object|
      book = BxBlockBook::Book.find_by(id: object.book_id)
      book&.title_color 
    end

    attribute :logo_color do |object|
      book = BxBlockBook::Book.find_by(id: object.book_id)
      book&.logo_color 
    end

    attribute :book_color do |object|
      book = BxBlockBook::Book.find_by(id: object.book_id)
      if book.present? && book&.book_color.present?
        book&.book_color
      elsif book.present? && object&.book_color.present?
        object&.book_color
      else
        "black"
      end  
    end

    attribute :book_url do |object|
      object&.book_url.present? ? object&.book_url : ''
    end

    attribute :title_layout do |object|
      book = BxBlockBook::Book.find_by(id: object.book_id)
      book&.title_layout.present? ? book&.title_layout : ''
    end

    attribute :max_order_refers do |object|
      limit = BxBlockReferrals::ReferralLimitSetting.where(active: true).last
      limit&.max_order_refers
    end

    attribute :coupon_details do |object|
      if object&.coupon_code_id.present?
        BxBlockDiscountsoffers::Offer.find_by(id: object.coupon_code_id)
      else
        nil
      end
    end

    attribute :address do |object|
      if object&.address.present?
        object&.address
      else
        nil
      end
    end
  end
end