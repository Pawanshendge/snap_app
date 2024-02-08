##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /
#
# frozen_string_literal: true

module Twilio
  module REST
    class Insights < Domain
      ##
      # Initialize the Insights Domain
      def initialize(twilio)
        super

        @base_url = 'https://insights.twilio.com'
        @host = 'insights.twilio.com'
        @port = 443

        # Versions
        @v1 = nil
      end

      ##
      # Version v1 of insights
      def v1
        @v1 ||= V1.new self
      end

      ##
      # @param [String] sid The sid
      # @return [Twilio::REST::Insights::V1::CallInstance] if sid was passed.
      # @return [Twilio::REST::Insights::V1::CallList]
      def calls(sid=:unset)
        self.v1.calls(sid)
      end

      ##
      # @return [Twilio::REST::Insights::V1::CallSummariesInstance]
      def call_summaries
        self.v1.call_summaries()
      end

      ##
      # @param [String] room_sid Unique identifier for the room.
      # @return [Twilio::REST::Insights::V1::RoomInstance] if room_sid was passed.
      # @return [Twilio::REST::Insights::V1::RoomList]
      def rooms(room_sid=:unset)
        self.v1.rooms(room_sid)
      end

      ##
      # Provide a user friendly representation
      def to_s
        '#<Twilio::REST::Insights>'
      end
    end
  end
end