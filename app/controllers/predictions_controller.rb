class PredictionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @prediction = Prediction.new
    @concert = Concert.find(params[:concert_id])
    @song_list = Song.all
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

  def show
    @prediction = Prediction.find(params[:id])
    @prediction_calculator = PredictionCalculator.new
    @prediction_score = @prediction_calculator.get_prediction_score(@prediction)
  end

  private

  def prediction_params
    params.require(:prediction).permit(
    :set_one_opener_song_id,
    :set_one_closer_song_id,
    :set_two_opener_song_id,
    :set_two_closer_song_id,
    :encore_song_id,
    :random_pick_song_id,
    :concert_id,
    :user_id
    )
  end
end
