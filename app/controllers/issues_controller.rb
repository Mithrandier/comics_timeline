class IssuesController < ApplicationController
  def index
    @issues = Issue.includes(:release).order('releases.released_at ASC').order(:title)
  end
end
