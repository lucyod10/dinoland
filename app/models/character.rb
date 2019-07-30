# == Schema Information
#
# Table name: characters
#
#  id         :bigint           not null, primary key
#  name       :text
#  age        :integer
#  talent     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  species_id :integer
#

class Character < ApplicationRecord
  belongs_to :user, :optional => true
  belongs_to :species, :optional => true
  has_many :posessions
end
