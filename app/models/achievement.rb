class Achievement < ApplicationRecord
  belongs_to :reward
  belongs_to :receiver
end
