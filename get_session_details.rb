# frozen_string_literal: true

require 'rubygems'
require 'rest-client'
require 'json'
require 'net/http'

build_id = ARGV[0]
limit = 100
offset = 0
File.write('output.txt',"")
File.write('output.txt', "Build Name\tProject Name\tSession Name\tBrowser Name\tBrowser Version\tOS Name\tOS Version\tDevice\tStatus\n", mode: 'a')
loop do
  base_url = "https://#{ARGV[1]}:#{ARGV[2]}@api.browserstack.com/automate/builds/#{build_id}/sessions.json?limit=#{limit}&offset=#{offset}"
  results = RestClient.get(base_url)
  results_json = JSON.parse(results.body)
  if !results_json.empty?
    (0..results_json.length - 1).each do |i|
      automation_session = results_json[i]['automation_session']
      File.write('output.txt', "#{automation_session['build_name']}\t#{automation_session['project_name']}\t#{automation_session['name']}\t#{automation_session['browser']}\t#{automation_session['browser_version']}\t#{automation_session['os']}\t#{automation_session['os_version']}\t#{automation_session['device']}\t#{automation_session['status']}\n", mode: 'a')
    end
  else
    break
  end
  offset += limit
end
