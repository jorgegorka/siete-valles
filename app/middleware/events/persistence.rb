# frozen_string_literal: true

module Events
  class Persistence
    class << self
      def create(params)
        Event.create(params)
      end

      def update(params)
        event = Event.find_by(uuid: params.delete(:id))
        event.update(params)

        event
      end

      def destroy(uuid)
        event = Event.find_by(uuid: uuid)
        event.destroy

        event
      end
  end
  end
end
