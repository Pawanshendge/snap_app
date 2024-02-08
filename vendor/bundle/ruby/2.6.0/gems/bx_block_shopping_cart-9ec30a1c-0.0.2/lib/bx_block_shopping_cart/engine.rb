# frozen_string_literal: true

module BxBlockShoppingCart
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockShoppingCart
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_shopping_cart.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockShoppingCart::Engine => base + '/shopping_cart'
      end
    end
  end
end
