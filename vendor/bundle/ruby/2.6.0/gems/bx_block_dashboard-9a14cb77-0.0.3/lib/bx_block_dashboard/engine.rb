# frozen_string_literal: true

module BxBlockDashboard
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockDashboard
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_dashboard.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockDashboard::Engine => base + '/dashboard'
      end
    end
  end
end
