require 'json'

class Application
  def run
    tracks = []
    Dir.glob('*.json') do |file|
      add_tracks_from_file tracks, file
    end

    if !tracks.any?
      puts 'No tracks found.'
      return
    end

    tracks.sort_by {|t| t.get_play_frequency}.each do |t|
      printf "Frequency: %12g | Plays: %6d | Song: %s\n", t.get_play_frequency, t.play_count, t.name
    end

    puts "it ran. #{tracks.length} tracks"
  end

  def add_tracks_from_file(tracks, file_name)
    file_contents = File.read(file_name)
    data = JSON.parse(file_contents)

    data.each do |i|
      mbid = i['track']['mbid']
      name = i['track']['name']
      artist = i['track']['artist']['name']
      time = Time.at(i['timestamp']['unixtimestamp'])

      track = tracks.find {|t| t.mbid == mbid}

      if track
        track.increment_play_count
        track.update_earliest_play_date_if_earlier time
      else
        tracks << Track.new(mbid, name, artist, time)
      end
    end

    tracks
  end
end

