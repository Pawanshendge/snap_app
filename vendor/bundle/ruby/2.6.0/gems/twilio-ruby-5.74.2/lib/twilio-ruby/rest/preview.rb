##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /
#
# frozen_string_literal: true

module Twilio
  module REST
    class Preview < Domain
      ##
      # Initialize the Preview Domain
      def initialize(twilio)
        super

        @base_url = 'https://preview.twilio.com'
        @host = 'preview.twilio.com'
        @port = 443

        # Versions
        @deployed_devices = nil
        @hosted_numbers = nil
        @marketplace = nil
        @sync = nil
        @understand = nil
        @wireless = nil
      end

      ##
      # Version deployed_devices of preview
      def deployed_devices
        @deployed_devices ||= DeployedDevices.new self
      end

      ##
      # Version hosted_numbers of preview
      def hosted_numbers
        @hosted_numbers ||= HostedNumbers.new self
      end

      ##
      # Version marketplace of preview
      def marketplace
        @marketplace ||= Marketplace.new self
      end

      ##
      # Version sync of preview
      def sync
        @sync ||= Sync.new self
      end

      ##
      # Version understand of preview
      def understand
        @understand ||= Understand.new self
      end

      ##
      # Version wireless of preview
      def wireless
        @wireless ||= Wireless.new self
      end

      ##
      # @param [String] sid Contains a 34 character string that uniquely identifies this
      #   Fleet resource.
      # @return [Twilio::REST::Preview::DeployedDevices::FleetInstance] if sid was passed.
      # @return [Twilio::REST::Preview::DeployedDevices::FleetList]
      def fleets(sid=:unset)
        self.deployed_devices.fleets(sid)
      end

      ##
      # @param [String] sid A 34 character string that uniquely identifies this
      #   AuthorizationDocument.
      # @return [Twilio::REST::Preview::HostedNumbers::AuthorizationDocumentInstance] if sid was passed.
      # @return [Twilio::REST::Preview::HostedNumbers::AuthorizationDocumentList]
      def authorization_documents(sid=:unset)
        self.hosted_numbers.authorization_documents(sid)
      end

      ##
      # @param [String] sid A 34 character string that uniquely identifies this
      #   HostedNumberOrder.
      # @return [Twilio::REST::Preview::HostedNumbers::HostedNumberOrderInstance] if sid was passed.
      # @return [Twilio::REST::Preview::HostedNumbers::HostedNumberOrderList]
      def hosted_number_orders(sid=:unset)
        self.hosted_numbers.hosted_number_orders(sid)
      end

      ##
      # @param [String] sid The unique string that we created to identify the
      #   AvailableAddOn resource.
      # @return [Twilio::REST::Preview::Marketplace::AvailableAddOnInstance] if sid was passed.
      # @return [Twilio::REST::Preview::Marketplace::AvailableAddOnList]
      def available_add_ons(sid=:unset)
        self.marketplace.available_add_ons(sid)
      end

      ##
      # @param [String] sid The unique string that we created to identify the
      #   InstalledAddOn resource. This Sid can also be found in the Console on that
      #   specific Add-ons page as the 'Available Add-on Sid'.
      # @return [Twilio::REST::Preview::Marketplace::InstalledAddOnInstance] if sid was passed.
      # @return [Twilio::REST::Preview::Marketplace::InstalledAddOnList]
      def installed_add_ons(sid=:unset)
        self.marketplace.installed_add_ons(sid)
      end

      ##
      # @param [String] sid The sid
      # @return [Twilio::REST::Preview::Sync::ServiceInstance] if sid was passed.
      # @return [Twilio::REST::Preview::Sync::ServiceList]
      def services(sid=:unset)
        self.sync.services(sid)
      end

      ##
      # @param [String] sid A 34 character string that uniquely identifies this
      #   resource.
      # @return [Twilio::REST::Preview::Understand::AssistantInstance] if sid was passed.
      # @return [Twilio::REST::Preview::Understand::AssistantList]
      def assistants(sid=:unset)
        self.understand.assistants(sid)
      end

      ##
      # @param [String] sid The sid
      # @return [Twilio::REST::Preview::Wireless::CommandInstance] if sid was passed.
      # @return [Twilio::REST::Preview::Wireless::CommandList]
      def commands(sid=:unset)
        self.wireless.commands(sid)
      end

      ##
      # @param [String] sid The sid
      # @return [Twilio::REST::Preview::Wireless::RatePlanInstance] if sid was passed.
      # @return [Twilio::REST::Preview::Wireless::RatePlanList]
      def rate_plans(sid=:unset)
        self.wireless.rate_plans(sid)
      end

      ##
      # @param [String] sid The sid
      # @return [Twilio::REST::Preview::Wireless::SimInstance] if sid was passed.
      # @return [Twilio::REST::Preview::Wireless::SimList]
      def sims(sid=:unset)
        self.wireless.sims(sid)
      end

      ##
      # Provide a user friendly representation
      def to_s
        '#<Twilio::REST::Preview>'
      end
    end
  end
end