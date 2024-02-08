##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /
#
# frozen_string_literal: true

module Twilio
  module REST
    class IpMessaging < Domain
      class V2 < Version
        class ServiceContext < InstanceContext
          class ChannelContext < InstanceContext
            class MemberList < ListResource
              ##
              # Initialize the MemberList
              # @param [Version] version Version that contains the resource
              # @param [String] service_sid The service_sid
              # @param [String] channel_sid The channel_sid
              # @return [MemberList] MemberList
              def initialize(version, service_sid: nil, channel_sid: nil)
                super(version)

                # Path Solution
                @solution = {service_sid: service_sid, channel_sid: channel_sid}
                @uri = "/Services/#{@solution[:service_sid]}/Channels/#{@solution[:channel_sid]}/Members"
              end

              ##
              # Create the MemberInstance
              # @param [String] identity The identity
              # @param [String] role_sid The role_sid
              # @param [String] last_consumed_message_index The last_consumed_message_index
              # @param [Time] last_consumption_timestamp The last_consumption_timestamp
              # @param [Time] date_created The date_created
              # @param [Time] date_updated The date_updated
              # @param [String] attributes The attributes
              # @param [member.WebhookEnabledType] x_twilio_webhook_enabled The
              #   X-Twilio-Webhook-Enabled HTTP request header
              # @return [MemberInstance] Created MemberInstance
              def create(identity: nil, role_sid: :unset, last_consumed_message_index: :unset, last_consumption_timestamp: :unset, date_created: :unset, date_updated: :unset, attributes: :unset, x_twilio_webhook_enabled: :unset)
                data = Twilio::Values.of({
                    'Identity' => identity,
                    'RoleSid' => role_sid,
                    'LastConsumedMessageIndex' => last_consumed_message_index,
                    'LastConsumptionTimestamp' => Twilio.serialize_iso8601_datetime(last_consumption_timestamp),
                    'DateCreated' => Twilio.serialize_iso8601_datetime(date_created),
                    'DateUpdated' => Twilio.serialize_iso8601_datetime(date_updated),
                    'Attributes' => attributes,
                })
                headers = Twilio::Values.of({'X-Twilio-Webhook-Enabled' => x_twilio_webhook_enabled, })

                payload = @version.create('POST', @uri, data: data, headers: headers)

                MemberInstance.new(
                    @version,
                    payload,
                    service_sid: @solution[:service_sid],
                    channel_sid: @solution[:channel_sid],
                )
              end

              ##
              # Lists MemberInstance records from the API as a list.
              # Unlike stream(), this operation is eager and will load `limit` records into
              # memory before returning.
              # @param [Array[String]] identity The identity
              # @param [Integer] limit Upper limit for the number of records to return. stream()
              #    guarantees to never return more than limit.  Default is no limit
              # @param [Integer] page_size Number of records to fetch per request, when
              #    not set will use the default value of 50 records.  If no page_size is defined
              #    but a limit is defined, stream() will attempt to read the limit with the most
              #    efficient page size, i.e. min(limit, 1000)
              # @return [Array] Array of up to limit results
              def list(identity: :unset, limit: nil, page_size: nil)
                self.stream(identity: identity, limit: limit, page_size: page_size).entries
              end

              ##
              # Streams MemberInstance records from the API as an Enumerable.
              # This operation lazily loads records as efficiently as possible until the limit
              # is reached.
              # @param [Array[String]] identity The identity
              # @param [Integer] limit Upper limit for the number of records to return. stream()
              #    guarantees to never return more than limit. Default is no limit.
              # @param [Integer] page_size Number of records to fetch per request, when
              #    not set will use the default value of 50 records. If no page_size is defined
              #    but a limit is defined, stream() will attempt to read the limit with the most
              #    efficient page size, i.e. min(limit, 1000)
              # @return [Enumerable] Enumerable that will yield up to limit results
              def stream(identity: :unset, limit: nil, page_size: nil)
                limits = @version.read_limits(limit, page_size)

                page = self.page(identity: identity, page_size: limits[:page_size], )

                @version.stream(page, limit: limits[:limit], page_limit: limits[:page_limit])
              end

              ##
              # When passed a block, yields MemberInstance records from the API.
              # This operation lazily loads records as efficiently as possible until the limit
              # is reached.
              def each
                limits = @version.read_limits

                page = self.page(page_size: limits[:page_size], )

                @version.stream(page,
                                limit: limits[:limit],
                                page_limit: limits[:page_limit]).each {|x| yield x}
              end

              ##
              # Retrieve a single page of MemberInstance records from the API.
              # Request is executed immediately.
              # @param [Array[String]] identity The identity
              # @param [String] page_token PageToken provided by the API
              # @param [Integer] page_number Page Number, this value is simply for client state
              # @param [Integer] page_size Number of records to return, defaults to 50
              # @return [Page] Page of MemberInstance
              def page(identity: :unset, page_token: :unset, page_number: :unset, page_size: :unset)
                params = Twilio::Values.of({
                    'Identity' => Twilio.serialize_list(identity) { |e| e },
                    'PageToken' => page_token,
                    'Page' => page_number,
                    'PageSize' => page_size,
                })

                response = @version.page('GET', @uri, params: params)

                MemberPage.new(@version, response, @solution)
              end

              ##
              # Retrieve a single page of MemberInstance records from the API.
              # Request is executed immediately.
              # @param [String] target_url API-generated URL for the requested results page
              # @return [Page] Page of MemberInstance
              def get_page(target_url)
                response = @version.domain.request(
                    'GET',
                    target_url
                )
                MemberPage.new(@version, response, @solution)
              end

              ##
              # Provide a user friendly representation
              def to_s
                '#<Twilio.IpMessaging.V2.MemberList>'
              end
            end

            class MemberPage < Page
              ##
              # Initialize the MemberPage
              # @param [Version] version Version that contains the resource
              # @param [Response] response Response from the API
              # @param [Hash] solution Path solution for the resource
              # @return [MemberPage] MemberPage
              def initialize(version, response, solution)
                super(version, response)

                # Path Solution
                @solution = solution
              end

              ##
              # Build an instance of MemberInstance
              # @param [Hash] payload Payload response from the API
              # @return [MemberInstance] MemberInstance
              def get_instance(payload)
                MemberInstance.new(
                    @version,
                    payload,
                    service_sid: @solution[:service_sid],
                    channel_sid: @solution[:channel_sid],
                )
              end

              ##
              # Provide a user friendly representation
              def to_s
                '<Twilio.IpMessaging.V2.MemberPage>'
              end
            end

            class MemberContext < InstanceContext
              ##
              # Initialize the MemberContext
              # @param [Version] version Version that contains the resource
              # @param [String] service_sid The service_sid
              # @param [String] channel_sid The channel_sid
              # @param [String] sid The sid
              # @return [MemberContext] MemberContext
              def initialize(version, service_sid, channel_sid, sid)
                super(version)

                # Path Solution
                @solution = {service_sid: service_sid, channel_sid: channel_sid, sid: sid, }
                @uri = "/Services/#{@solution[:service_sid]}/Channels/#{@solution[:channel_sid]}/Members/#{@solution[:sid]}"
              end

              ##
              # Fetch the MemberInstance
              # @return [MemberInstance] Fetched MemberInstance
              def fetch
                payload = @version.fetch('GET', @uri)

                MemberInstance.new(
                    @version,
                    payload,
                    service_sid: @solution[:service_sid],
                    channel_sid: @solution[:channel_sid],
                    sid: @solution[:sid],
                )
              end

              ##
              # Delete the MemberInstance
              # @param [member.WebhookEnabledType] x_twilio_webhook_enabled The
              #   X-Twilio-Webhook-Enabled HTTP request header
              # @return [Boolean] true if delete succeeds, false otherwise
              def delete(x_twilio_webhook_enabled: :unset)
                headers = Twilio::Values.of({'X-Twilio-Webhook-Enabled' => x_twilio_webhook_enabled, })

                 @version.delete('DELETE', @uri, headers: headers)
              end

              ##
              # Update the MemberInstance
              # @param [String] role_sid The role_sid
              # @param [String] last_consumed_message_index The last_consumed_message_index
              # @param [Time] last_consumption_timestamp The last_consumption_timestamp
              # @param [Time] date_created The date_created
              # @param [Time] date_updated The date_updated
              # @param [String] attributes The attributes
              # @param [member.WebhookEnabledType] x_twilio_webhook_enabled The
              #   X-Twilio-Webhook-Enabled HTTP request header
              # @return [MemberInstance] Updated MemberInstance
              def update(role_sid: :unset, last_consumed_message_index: :unset, last_consumption_timestamp: :unset, date_created: :unset, date_updated: :unset, attributes: :unset, x_twilio_webhook_enabled: :unset)
                data = Twilio::Values.of({
                    'RoleSid' => role_sid,
                    'LastConsumedMessageIndex' => last_consumed_message_index,
                    'LastConsumptionTimestamp' => Twilio.serialize_iso8601_datetime(last_consumption_timestamp),
                    'DateCreated' => Twilio.serialize_iso8601_datetime(date_created),
                    'DateUpdated' => Twilio.serialize_iso8601_datetime(date_updated),
                    'Attributes' => attributes,
                })
                headers = Twilio::Values.of({'X-Twilio-Webhook-Enabled' => x_twilio_webhook_enabled, })

                payload = @version.update('POST', @uri, data: data, headers: headers)

                MemberInstance.new(
                    @version,
                    payload,
                    service_sid: @solution[:service_sid],
                    channel_sid: @solution[:channel_sid],
                    sid: @solution[:sid],
                )
              end

              ##
              # Provide a user friendly representation
              def to_s
                context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
                "#<Twilio.IpMessaging.V2.MemberContext #{context}>"
              end

              ##
              # Provide a detailed, user friendly representation
              def inspect
                context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
                "#<Twilio.IpMessaging.V2.MemberContext #{context}>"
              end
            end

            class MemberInstance < InstanceResource
              ##
              # Initialize the MemberInstance
              # @param [Version] version Version that contains the resource
              # @param [Hash] payload payload that contains response from Twilio
              # @param [String] service_sid The service_sid
              # @param [String] channel_sid The channel_sid
              # @param [String] sid The sid
              # @return [MemberInstance] MemberInstance
              def initialize(version, payload, service_sid: nil, channel_sid: nil, sid: nil)
                super(version)

                # Marshaled Properties
                @properties = {
                    'sid' => payload['sid'],
                    'account_sid' => payload['account_sid'],
                    'channel_sid' => payload['channel_sid'],
                    'service_sid' => payload['service_sid'],
                    'identity' => payload['identity'],
                    'date_created' => Twilio.deserialize_iso8601_datetime(payload['date_created']),
                    'date_updated' => Twilio.deserialize_iso8601_datetime(payload['date_updated']),
                    'role_sid' => payload['role_sid'],
                    'last_consumed_message_index' => payload['last_consumed_message_index'] == nil ? payload['last_consumed_message_index'] : payload['last_consumed_message_index'].to_i,
                    'last_consumption_timestamp' => Twilio.deserialize_iso8601_datetime(payload['last_consumption_timestamp']),
                    'url' => payload['url'],
                    'attributes' => payload['attributes'],
                }

                # Context
                @instance_context = nil
                @params = {
                    'service_sid' => service_sid,
                    'channel_sid' => channel_sid,
                    'sid' => sid || @properties['sid'],
                }
              end

              ##
              # Generate an instance context for the instance, the context is capable of
              # performing various actions.  All instance actions are proxied to the context
              # @return [MemberContext] MemberContext for this MemberInstance
              def context
                unless @instance_context
                  @instance_context = MemberContext.new(
                      @version,
                      @params['service_sid'],
                      @params['channel_sid'],
                      @params['sid'],
                  )
                end
                @instance_context
              end

              ##
              # @return [String] The sid
              def sid
                @properties['sid']
              end

              ##
              # @return [String] The account_sid
              def account_sid
                @properties['account_sid']
              end

              ##
              # @return [String] The channel_sid
              def channel_sid
                @properties['channel_sid']
              end

              ##
              # @return [String] The service_sid
              def service_sid
                @properties['service_sid']
              end

              ##
              # @return [String] The identity
              def identity
                @properties['identity']
              end

              ##
              # @return [Time] The date_created
              def date_created
                @properties['date_created']
              end

              ##
              # @return [Time] The date_updated
              def date_updated
                @properties['date_updated']
              end

              ##
              # @return [String] The role_sid
              def role_sid
                @properties['role_sid']
              end

              ##
              # @return [String] The last_consumed_message_index
              def last_consumed_message_index
                @properties['last_consumed_message_index']
              end

              ##
              # @return [Time] The last_consumption_timestamp
              def last_consumption_timestamp
                @properties['last_consumption_timestamp']
              end

              ##
              # @return [String] The url
              def url
                @properties['url']
              end

              ##
              # @return [String] The attributes
              def attributes
                @properties['attributes']
              end

              ##
              # Fetch the MemberInstance
              # @return [MemberInstance] Fetched MemberInstance
              def fetch
                context.fetch
              end

              ##
              # Delete the MemberInstance
              # @param [member.WebhookEnabledType] x_twilio_webhook_enabled The
              #   X-Twilio-Webhook-Enabled HTTP request header
              # @return [Boolean] true if delete succeeds, false otherwise
              def delete(x_twilio_webhook_enabled: :unset)
                context.delete(x_twilio_webhook_enabled: x_twilio_webhook_enabled, )
              end

              ##
              # Update the MemberInstance
              # @param [String] role_sid The role_sid
              # @param [String] last_consumed_message_index The last_consumed_message_index
              # @param [Time] last_consumption_timestamp The last_consumption_timestamp
              # @param [Time] date_created The date_created
              # @param [Time] date_updated The date_updated
              # @param [String] attributes The attributes
              # @param [member.WebhookEnabledType] x_twilio_webhook_enabled The
              #   X-Twilio-Webhook-Enabled HTTP request header
              # @return [MemberInstance] Updated MemberInstance
              def update(role_sid: :unset, last_consumed_message_index: :unset, last_consumption_timestamp: :unset, date_created: :unset, date_updated: :unset, attributes: :unset, x_twilio_webhook_enabled: :unset)
                context.update(
                    role_sid: role_sid,
                    last_consumed_message_index: last_consumed_message_index,
                    last_consumption_timestamp: last_consumption_timestamp,
                    date_created: date_created,
                    date_updated: date_updated,
                    attributes: attributes,
                    x_twilio_webhook_enabled: x_twilio_webhook_enabled,
                )
              end

              ##
              # Provide a user friendly representation
              def to_s
                values = @params.map{|k, v| "#{k}: #{v}"}.join(" ")
                "<Twilio.IpMessaging.V2.MemberInstance #{values}>"
              end

              ##
              # Provide a detailed, user friendly representation
              def inspect
                values = @properties.map{|k, v| "#{k}: #{v}"}.join(" ")
                "<Twilio.IpMessaging.V2.MemberInstance #{values}>"
              end
            end
          end
        end
      end
    end
  end
end