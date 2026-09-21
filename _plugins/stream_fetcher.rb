require 'net/http'
require 'json'

Jekyll::Hooks.register :site, :pre_render do |site|
  cache_path = File.join(site.source, '_data', 'stream_cache.json')

  begin
    uri = URI('http://localhost:10020/?raw=true')
    response = Net::HTTP.get_response(uri)

    raise "unexpected response code #{response.code}" unless response.code == '200'

    stream_data = JSON.parse(response.body)
    site.data['stream'] = stream_data

    # Snapshot the freshly fetched data so builds without a running
    # local stream server (e.g. GitHub Actions) can still publish it.
    File.write(cache_path, JSON.pretty_generate(stream_data))
  rescue => e
    puts "Warning: Could not fetch live stream data (#{e.message}); falling back to cached copy."
    site.data['stream'] = File.exist?(cache_path) ? JSON.parse(File.read(cache_path)) : []
  end
end
