# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :text
#  username   :text
#  coins      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  has_many :accessories
  has_many :characters
  has_many :species
end
