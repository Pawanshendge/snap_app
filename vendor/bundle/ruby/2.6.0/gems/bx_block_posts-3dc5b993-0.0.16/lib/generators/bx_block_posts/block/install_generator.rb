# frozen_string_literal: true

require 'builder_base/generators/install/base'

module BxBlockPosts
  module Block
    class InstallGenerator < BuilderBase::Generators::Install::Base
      set_file_directory __dir__

      source_root File.expand_path('templates', __dir__)

      def execute
        super

        add_gems
        install_gems
      end

      private

      def add_gems
        insert_lines(
          'Gemfile',
          nil,
          [
            "gem 'activestorage-validator'"
          ]
        )
      end

      def install_gems
        require 'bundler'

        Bundler.with_clean_env do
          run "bundle install"
        end
      end

      def insert_lines(file_name, target_line, new_lines)
        contents = File.read(file_name)
        if target_line.nil?
          target_position = contents.split("\n").count
        else
          target_position = contents.split("\n").find_index(target_line) + 1
        end

        new_lines.each do |line|
          next if contents.include? line
          split_contents = contents.split("\n")
          split_contents.insert(target_position, line)
          contents = split_contents.join("\n")
        end
        File.open(file_name, 'w') {|file| file.puts contents }
      end


    end
  end
end
