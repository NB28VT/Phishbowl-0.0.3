class PredictionsController < ApplicationController

  def new
    # missing required keys
    @prediction = Prediction.new
    @concert = Concert.find(params[:concert_id])
  end

  def create
    # @user = User.find(current_user.id)
    @prediction = Prediction.create(prediction_params)
    @concert = Concert.find(params[:concert_id])

    if @prediction.save
      redirect_to (concert_path(@concert)), notice: "Predictions submitted!"
    else
      render 'new'
    end
  end

  private

  def prediction_params
    params.require(:prediction).permit(
    :set_one_opener,
    :set_one_closer,
    :set_two_opener,
    :set_two_closer,
    :encore,
    :random_song
    )

  end
end
