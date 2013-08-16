require 'bundler'
Bundler.require(:default)

class Transform

  def initialize
    @conn = Faraday.new(:url => 'http://api.nytimes.com/') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def fetch
    result = @conn.get '/svc/politics/v3/us/legislative/congress/111/house/bills/introduced.xml', { "api-key" => '50fd6f9bbfad172616d65c4ea7c793ca:8:68003226' }
    json = Nokogiri::XML.parse(result.body).css('bill')
    @bills = json.map { |element| Bill.new(element) }
  end

  def to_json
    @bills ||= fetch
    @bills.to_json
  end

end

class Bill
  include ActiveModel::Serializers::JSON

  def initialize(element)
    @element = element
  end

  def title
    @element.css('title').inner_text
  end

  def latest_major_action
    @element.css('latest_major_action').inner_text
  end

  def attributes
    { 'title' => title, 'latest_major_action' => latest_major_action }
  end

end