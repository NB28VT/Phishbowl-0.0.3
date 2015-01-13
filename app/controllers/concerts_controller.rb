class ConcertsController < ApplicationController
  def index
    # REPLACE WITH UPCOMING CONCERTS
    # @concerts = Concert.all
    @random_concert = Concert.create_random_show
  end

  def show
    @concert = Concert.find(params[:id])
    @predictions = @concert.prediction
  end

  private

  def concert_params
    params.require(:concert).permit(:venue, :date_time)
  end
end
