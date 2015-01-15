class DashboardController < ApplicationController
  def index
    @random_concert = Concert.create_random_show
  end
end
