require 'net/http'
require 'json'

Jekyll::Hooks.register :site, :pre_render do |site|
  begin
    uri = URI('http://localhost:10020/?raw=true')
    response = Net::HTTP.get_response(uri)
    
    if response.code == '200'
      stream_data = JSON.parse(response.body)
      site.data['stream'] = stream_data
    else
      site.data['stream'] = []
    end
  rescue => e
    puts "Warning: Could not fetch stream data: #{e.message}"
    site.data['stream'] = []
  end
end