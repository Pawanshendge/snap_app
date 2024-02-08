# frozen_string_literal: true

module BxBlockHelpCentre
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockHelpCentre
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_help_centre.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockHelpCentre::Engine => base + '/help_centre'
      end
    end
  end
end
