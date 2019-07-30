# == Schema Information
#
# Table name: posessions
#
#  id           :bigint           not null, primary key
#  accessory_id :integer
#  character_id :integer
#  x_pos        :float
#  y_pos        :float
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Posession < ApplicationRecord
  # A character has many posessions, and each posession has one accessory.
  # A posession has many characters.
  has_many :accessories
  belongs_to :character, :optional => true
end
