require 'rspec'
require 'vcr'
require './lib/scraper'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
  c.configure_rspec_metadata!
end

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
end

describe "Scraper" do
  before(:each) do
    @scraper = Scraper
  end

  it "should be able to scrape" do
    @scraper.should respond_to :scrape
  end
end

describe "NewRelicScraper", :vcr do
  before(:each) do
    @scraper = NewRelicScraper
  end

  it "should format scraped results into an array" do
    jobs = @scraper.scrape
    jobs.first.should eq(["Agent SDK Engineer", "http://newton.newtonsoftware.com/career/JobIntroduction.action?clientId=4028f88b20d6768d0120f7ae45e50365&id=8a42a12b3fa43372013fbf737b7a6b21&gnewtonResize=http://newton.newtonsoftware.com/career/GnewtonResize.htm&source="])
  end
end

describe "CrowdCompassScraper", :vcr do
  before(:each) do
    @scraper = CrowdCompassScraper
  end

  it "should be able to get an array of jobs" do
    jobs = @scraper.scrape
    jobs.first.should eq(["Front End Web Developer", "http://ch.tbe.taleo.net/CH06/ats/careers/requisition.jsp?org=CVENT2&cws=40&rid=784"])
  end
end

describe "PuppetLabsScraper", :vcr do
  before(:each) do
    @scraper = PuppetLabsScraper
  end

  it "should be able to get an array of jobs" do
    jobs = @scraper.scrape
    jobs.first.should eq(["Professional Services Engineer (Boston)", "http://www.jobscore.com/job_seeker/jobs/apply_jump_page?job_id=cYhvqeTPir4OK0iGakhP3Q&ref=rss&sid=68"])
  end
end