# frozen_string_literal: true

module Activities
  class Persistence
    extend Shared::Finders

    class << self
      def create(params)
        receiver = find_receiver(params.delete(:receiver_id))
        action = find_action(params.delete(:action_id))

        receiver.activities.create(action: action, value: action_value(action))
      end

      def update(_params)
        raise Exceptions::OperationNotAllowed
      end

      def destroy(params)
        activity = Activity.find_by(uuid: params[:id])
        activity.destroy
      end

      private

      def action_value(action)
        action&.value || 0
      end
    end
  end
end
