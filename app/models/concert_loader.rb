class ConcertLoader

  # DATA FORMATTING

  def web_request(api_call)
    begin
      HTTParty.get(api_call)
    rescue HTTParty::Error
      return false
    end
  end

  def json_parser(raw_concert)
    begin
      JSON.parse(raw_concert)
    rescue JSON::JSONError
      return false
    end
  end

  def scrape_set_html(setlist_data)
    begin
      Nokogiri::HTML(setlist_data)
    rescue Nokogiri::XML::SyntaxError
      return false
    end
  end

  def parse_setlist(css_index)
    full_set = []
    set_data = @setlist.css('p')[css_index]

    set_data.css('a').each do |song|
      full_set << song.children.text
    end

    full_set
  end

  # LOAD CONCERT DATA

  def concert_loader(api_call)
    raw_concert = web_request(api_call)

    jsoned = json_parser(raw_concert)

    concert_data_hash = {}

    concert_data_hash[:concert_date] = jsoned[0]["mmddyy"]
    concert_data_hash[:city] = jsoned[0]["city"]
    concert_data_hash[:state] = jsoned[0]["state"]
    concert_data_hash[:venue] = jsoned[0]["venue"]
    setlist_data = jsoned[0]["setlistdata"]

    @setlist = scrape_set_html(setlist_data)

    concert_data_hash[:set_one_array] = parse_setlist(0)
    concert_data_hash[:set_two_array] = parse_setlist(1)

    if @setlist.css('p')[2]
      concert_data_hash[:encore_array] = parse_setlist(2)
    else
      concert_data_hash[:encore_array] = nil
    end

    concert_data_hash
  end

  # BUILDS CONCERT SONGS IN DATABASE

  def load_songs_for_concert(set_array, set_index, new_concert)
    song_index = 1
    set_array.each do |song|
      new_song = ConcertSong.find_or_initialize_by(
      song_id: (Song.find_or_initialize_by(song_name: song)).id,
      play_index: song_index,
      set_index: set_index,
      concert_id: new_concert.id,
      songs_in_set: set_array.count
      )
      song_index += 1
      new_song.save!
    end
  end

  # MAIN METHOD

  def concert_builder(api_call)
    concert_data_hash = concert_loader(api_call)

    new_concert = Concert.find_or_initialize_by(
    concert_date: concert_data_hash[:concert_date],
    city: concert_data_hash[:city],
    state: concert_data_hash[:state],
    venue: concert_data_hash[:venue]
    )
    new_concert.save!

    load_songs_for_concert(concert_data_hash[:set_one_array], 1, new_concert)
    load_songs_for_concert(concert_data_hash[:set_two_array], 2, new_concert)

    if concert_data_hash[:encore_array]
      load_songs_for_concert(concert_data_hash[:encore_array], 3, new_concert)
    end

    new_concert
  end
end
