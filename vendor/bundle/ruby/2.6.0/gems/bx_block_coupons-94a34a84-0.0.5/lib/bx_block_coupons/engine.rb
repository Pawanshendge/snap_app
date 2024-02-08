# frozen_string_literal: true

module BxBlockCoupons
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockCoupons
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_coupons.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockCoupons::Engine => base + '/coupons'
      end
    end
  end
end
