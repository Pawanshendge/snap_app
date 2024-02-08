# frozen_string_literal: true

module BxBlockReviews
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockReviews
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_reviews.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockReviews::Engine => base + '/reviews'
      end
    end
  end
end
