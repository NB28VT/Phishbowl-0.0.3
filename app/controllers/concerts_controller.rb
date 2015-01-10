class ConcertsController < ApplicationController
  def index
    @concerts = Concert.all
  end

  def show
    @concert = Concert.find(params[:id])
    @predictions = @concert.predictions
  end

  private

  def concert_params
    params.require(:concert).permit(:venue, :date_time)

  end
end
