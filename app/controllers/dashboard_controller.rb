class DashboardController < ApplicationController
  def index
    concert = RandomConcertGenerator.new
    @random_concert = concert.generate_random_concert
  end
end
