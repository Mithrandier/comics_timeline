module ApplicationHelper
  def release_timestamp(release)
    release.released_at.strftime('%Y-%m-%d')
  end
end
