# == Schema Information
#
# Table name: species
#
#  id         :bigint           not null, primary key
#  genus      :text
#  order      :text
#  diet       :text
#  image      :text
#  fun_fact   :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Species < ApplicationRecord
  has_many :characters
  belongs_to :user, :optional => true
end
