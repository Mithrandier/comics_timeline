# == Schema Information
#
# Table name: issues
#
#  id           :integer          not null, primary key
#  series_id    :integer
#  release_id   :integer
#  title        :string           not null
#  issue_number :float
#  cover        :string
#  details_url  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_issues_on_release_id                  (release_id)
#  index_issues_on_series_id                   (series_id)
#  index_issues_on_series_id_and_issue_number  (series_id,issue_number) UNIQUE
#

class Issue < ApplicationRecord
  belongs_to :series, class_name: Series.name
  belongs_to :release

  mount_uploader :cover, ::IssueCoverUploader

  validates_presence_of :title

  scope :of_series, -> (series) { includes(:series).where(series: { id: series }) }
  scope :with_number, -> (number) { where(issue_number: number) }
end
