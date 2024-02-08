# frozen_string_literal: true

module BxBlockAccountGroups
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockAccountGroups
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer "bx_block_account_groups.configuration" do |app|
      base = app.config.builder.root_url || ""
      app.routes.append do
        mount BxBlockAccountGroups::Engine => base + "/account_groups"
      end
    end
  end
end
