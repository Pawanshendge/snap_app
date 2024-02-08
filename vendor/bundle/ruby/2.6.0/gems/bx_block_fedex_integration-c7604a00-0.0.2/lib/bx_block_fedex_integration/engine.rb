# frozen_string_literal: true

module BxBlockFedexIntegration
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockFedexIntegration
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_fedex_integration.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockFedexIntegration::Engine => base + '/fedex_integration'
      end
    end
  end
end
