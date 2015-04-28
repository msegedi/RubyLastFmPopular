
class Track
  attr_reader :mbid
  attr_reader :name
  attr_reader :artist
  attr_reader :earliest_play_date
  attr_reader :play_count

  def initialize(mbid, name, artist, play_date)
    @mbid = mbid
    @name = name
    @artist = artist
    @earliest_play_date = play_date
    @play_count = 1
  end

  def get_number_of_days_since_earliest_play_date
    (Time.now - @earliest_play_date).to_i / (24 * 60 * 60)
  end

  def get_play_frequency
    @play_count.to_f / get_number_of_days_since_earliest_play_date.to_f
  end

  def increment_play_count
    @play_count += 1
  end

  def update_earliest_play_date_if_earlier(time)
    @earliest_play_date = time if time < @earliest_play_date
  end
end

