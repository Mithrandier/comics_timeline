namespace :fetch_issues do
  task :from_marvel => :environment do
    API_URL = 'https://gateway.marvel.com/v1/public/comics?'\
      'apikey=cd21119b96b14effa93a1d2e932361db&'\
      "ts=#{ENV.fetch('MARVEL_API_TIMESTAMP')}&hash=#{ENV.fetch('MARVEL_API_HASH')}&"\
      'limit=100&format=comic'.freeze
    DATE_RANGE = '2017-05-01,2017-06-30'.freeze

    response = query_data
    puts "Total: #{response['total']}"
    import_issues(response.fetch('results', []))
    offset = 0
    while response['offset'] + response['limit'] < response['total']
      offset += response['limit']
      response = query_data(offset: offset)
      import_issues(response.fetch('results', []))
    end
  end

  def query_data(parameters = {})
    response = HTTParty.get(API_URL, query: parameters.merge(dateRange: DATE_RANGE))
    response.parsed_response.fetch('data', {})
  end

  def import_issues(issues_data)
    issues_data.each do |issue_data|
      issue = import_issue(issue_data)
      puts "added #{issue.title}" if issue.present?
    end
  end

  def import_issue(issue_data)
    series = Series.find_or_create_by(title: issue_data.fetch('series', {}).fetch('name')) if issue_data['series']
    return if Issue.of_series(series).with_number(issue_data.fetch('issueNumber')).exists?
    released_at = Date.parse(issue_data.fetch('dates').find { |d| d['type'] == 'onsaleDate' }.fetch('date'))
    release = Release.where('DATE(released_at) = ?', released_at).first_or_initialize
    release.released_at = released_at
    release.save!
    Issue.create!(
      title: issue_data.fetch('title'),
      issue_number: issue_data.fetch('issueNumber'),
      series: series,
      remote_cover_url: [issue_data.fetch('thumbnail').fetch('path'), issue_data.fetch('thumbnail').fetch('extension')].join('.'),
      release: release,
      details_url: issue_data.fetch('urls').first.fetch('url')
    )
  end
end
