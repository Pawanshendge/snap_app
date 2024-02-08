# frozen_string_literal: true

module BxBlockCouponCg
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockCouponCg
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_coupon_cg.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockCouponCg::Engine => base + '/coupon_cg'
      end
    end
  end
end
