# frozen_string_literal: true

module Receivers
  class Persistence
    class << self
      def create(params)
        Receiver.create(external_id: params[:external_id])
      end

      def update(params)
        receiver = Receiver.find_by(uuid: params.delete(:id))
        receiver.update(params)

        receiver
      end

      def destroy(params)
        receiver = Receiver.find_by(uuid: params[:id])
        receiver.destroy

        receiver
      end
    end
  end
end
