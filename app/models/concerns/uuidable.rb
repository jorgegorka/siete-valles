# frozen_string_literal: true

require 'active_support/concern'

module Uuidable
  extend ActiveSupport::Concern

  included do
    validates :uuid, presence: true
    after_initialize :assign_uuid, if: :new_record?
  end

  private

  def assign_uuid
    self.uuid = SecureRandom.uuid
  end

  class_methods do
  end
end
