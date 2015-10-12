require 'nokogiri'
require 'open-uri'

module Fixtures
  FIXTURES_PATH = File.expand_path(File.join('.', 'fixtures'))

  def self.doc_for_id(id)
    tries ||= 2
    Nokogiri::HTML(File.read(path_for_id(id)))
  rescue Errno::ENOENT
    tries -= 1
    if !tries.zero?
      self.save_id(id)
      retry
    end
  end

  def self.path_for_id(id)
    File.join(FIXTURES_PATH, id)
  end

  def self.save_id(id)
    content = open("http://www.imdb.com/title/#{id}/").read
    File.open(self.path_for_id(id), 'w') do |f|
      f.write(content)
    end
  end
end
