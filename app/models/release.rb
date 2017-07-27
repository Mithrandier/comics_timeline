# == Schema Information
#
# Table name: releases
#
#  id          :integer          not null, primary key
#  released_at :datetime         not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_releases_on_released_at  (released_at) UNIQUE
#

class Release < ApplicationRecord
  has_many :issues

  validates_presence_of :released_at
  validates_uniqueness_of :released_at
end
