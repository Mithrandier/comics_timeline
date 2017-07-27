# == Schema Information
#
# Table name: series
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Series < ApplicationRecord
  has_many :issues

  validates_presence_of :title
end
