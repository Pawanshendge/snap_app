# ## https://github.com/krisleech/wisper-activerecord#setup-a-publisher

# Wisper::ActiveRecord.extend_all

# A change that would allow to receive response from event invoke operation immediately
# Decided to do like this not to rebuild the gem
Wisper::ObjectRegistration.class_eval do
  def broadcast(event, publisher, *args)
    method_to_call = map_event_to_method(event)
    if should_broadcast?(event) &&
        listener.respond_to?(method_to_call) &&
        publisher_in_scope?(publisher)
      result = broadcaster.broadcast(listener, publisher, method_to_call, args)
      listener_name = listener.public_send('get_listener_name', *args)
      return listener_name, result
    end
  end
end

Wisper::Publisher.class_eval do
  def broadcast(event, *args)
    result_hash = {}
    registrations.each do | registration |
      listener_name, result = registration.broadcast(clean_event(event), self, *args)
      result_hash[listener_name] = result
    end
    result_hash
  end
end
