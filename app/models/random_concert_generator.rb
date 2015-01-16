class RandomConcertGenerator

  def generate_random_concert
    new_concert = ConcertLoader.new
    new_concert.concert_builder(
      "https://api.phish.net/api.json?api=2.0&method=pnet.shows.setlists.random"
    )
  end
end
