# frozen_string_literal: true

module BxBlockProfile
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockProfile
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_profile.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockProfile::Engine => base + '/profile'
      end
    end
  end
end
