class ConcertsController < ApplicationController
  def index
    # Upcoming shows?
  end

  def show
    @concert = Concert.find(params[:id])
  end

  private

  def concert_params
    params.require(:concert).permit(:venue, :date_time)
  end
end
