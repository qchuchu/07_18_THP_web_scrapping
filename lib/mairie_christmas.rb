# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'pry'

def get_townhall_email(townhall_url)
  # Open the url
  begin
    url = "https://www.annuaire-des-mairies.com#{townhall_url}"
    page = Nokogiri::HTML(open(url))
    begin
      path = '/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]'
      page.xpath(path).text
    rescue NoMethodError => e
      puts "XPath not good // No email"
      return ni
    end
  rescue Errno::ETIMEDOUT, Errno::ECONNREFUSED, Errno::ENOENT => e
    puts "URL not reached"
    return nil
  end
end

def get_townhall_urls
  index_url = 'https://www.annuaire-des-mairies.com/val-d-oise.html'
  page = Nokogiri::HTML(open(index_url))
  urls = []
  links = page.xpath('//a[@class="lientxt"]')
  return "Wrong Xpath" if links == []
  links.each do |link|
    begin
      urls << link['href'][1..-1]
    rescue NoMethodError => e
      puts "Anchor not linked to something"
    end
  end

  urls
end

def perform
  array = []
  puts "Et c'est partie!\n\n"
  get_townhall_urls.each_with_index do |url, i|
    puts "#{i + 1}/#{get_townhall_urls.length} url checkées !"
    hash = {}
    townhall_name = url.gsub('/95/','').gsub('.html','').split('-') \
                        .map(&:capitalize).join('-')
    hash[townhall_name] = get_townhall_email(url)
    array << hash
    puts "Tout est bon ! On passe à la suivante\n\n"
  end

  array
end

p perform
