# frozen_string_literal: true

module Activities
  class Persistence
    extend Shared::Finders

    class << self
      def create(params)
        receiver = find_receiver(params.delete(:receiver_id))
        event = find_event(params.delete(:event_id))

        receiver.activities.create(event: event, value: event_value(params[:value].to_i, event))
      end

      def update(_params)
        raise Exceptions::OperationNotAllowed
      end

      def destroy(params)
        activity = Activity.find_by(uuid: params[:id])
        activity.destroy
      end

      private

      def event_value(custom_value, event)
        custom_value.positive? ? custom_value : event&.value || 0
      end
    end
  end
end
