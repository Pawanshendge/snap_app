# frozen_string_literal: true

module BxBlockOrderManagement
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockOrderManagement
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_order_management.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockOrderManagement::Engine => base + '/order_management'
      end
    end
  end
end
