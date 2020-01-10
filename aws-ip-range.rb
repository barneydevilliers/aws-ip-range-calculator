require 'net/http'
require 'json'
require 'pp'

url = 'https://ip-ranges.amazonaws.com/ip-ranges.json'
uri = URI(url)
response = Net::HTTP.get(uri)
prefixes = JSON.parse(response)['prefixes']

regions = [
  'eu-west-1'
]

services = [
  'EC2',
  'AMAZON'
]

pp prefixes
  .select{ |prefix| regions.include?(prefix['region'])  }
  .select{ |prefix| services.include?(prefix['service']) }
  .map{    |prefix| prefix['ip_prefix']}
  .uniq!