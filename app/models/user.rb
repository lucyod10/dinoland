# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :text
#  username        :text
#  coins           :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#

class User < ApplicationRecord
  has_secure_password
  # TODO: check out the rails validates guide to customise
  validates :email, :presence => true, :uniqueness => true

  has_many :accessories
  has_many :characters
  has_many :species
end
