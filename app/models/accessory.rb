# == Schema Information
#
# Table name: accessories
#
#  id         :bigint           not null, primary key
#  name       :text
#  image      :text
#  cost       :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Accessory < ApplicationRecord
  belongs_to :user, :optional => true
  has_and_belongs_to_many :characters
end
