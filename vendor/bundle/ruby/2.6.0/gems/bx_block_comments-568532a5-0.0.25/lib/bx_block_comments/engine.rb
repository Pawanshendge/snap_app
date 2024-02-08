# frozen_string_literal: true

module BxBlockComments
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockComments
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer "bx_block_comments.configuration" do |app|
      base = app.config.builder.root_url || ""
      app.routes.append do
        mount BxBlockComments::Engine => "#{base}/comments"
      end
    end
  end
end
