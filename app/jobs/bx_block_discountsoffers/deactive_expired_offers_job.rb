class BxBlockDiscountsoffers::DeactiveExpiredOffersJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.info '=======================Job started================'
    offers = BxBlockDiscountsoffers::Offer.where(active: true)
    offers.each do |offer|
      Rails.logger.info "=======================#{offer.id}================"
      if Time.zone.now.to_date > offer&.valid_to&.to_date
        offer.update_column(:active, false)
      end
      Rails.logger.info "=======================Failed: #{offer.errors.inspect}================"
    end
    Rails.logger.info '=======================Job completed================'
  end
end
