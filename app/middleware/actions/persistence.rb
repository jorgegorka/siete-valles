# frozen_string_literal: true

module Actions
  class Persistence
    class << self
      def create(params)
        Action.create(params)
      end

      def update(params)
        action = Action.find_by(uuid: params.delete(:id))
        action.update(params)

        action
      end

      def destroy(params)
        action = Action.find_by(uuid: params[:id])
        action.destroy

        action
      end
  end
  end
end
