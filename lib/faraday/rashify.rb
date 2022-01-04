# frozen_string_literal: true

require 'faraday'
require 'faraday/rashify/version'
require 'rash'

module Faraday
  # This is a Faraday middleware which turns Hashes into Hashie::Mash::Rash
  # objects, using the rash_alt gem.
  module Rashify
    # This is a middleware which acts on responses, so it implements `on_complete`.
    class Middleware < ::Faraday::Middleware
      CONTENT_TYPE = 'Content-Type'

      # Public: Converts parsed response bodies to a Hashie::Mash::Rash if they were of
      # Hash or Array type.
      def initialize(app = nil, options = {})
        super(app)
        @options = options
        @content_types = Array(options[:content_type])
      end

      def on_complete(env)
        # return early if we should not process this request
        return unless should_process?(env)

        env[:body] = parse(env[:body])
      end

      private

      # An empty list of content_types means "match everything".
      # A non-empty list is more demanding: match this String or RegExp to process

      def should_process?(env)
        @content_types.empty? || @content_types.any? do |pattern|
          type = response_type(env)

          pattern.is_a?(Regexp) ? type =~ pattern : type == pattern
        end
      end

      def response_type(env)
        type = env.dig(:response_headers, CONTENT_TYPE).to_s
        type = type.split(';', 2).first if type.include?(';')
        type
      end

      def parse(body)
        case body
        when Hash
          ::Hashie::Mash::Rash.new(body)
        when Array
          body.map { |item| parse(item) }
        else
          body
        end
      end
    end
  end
end
