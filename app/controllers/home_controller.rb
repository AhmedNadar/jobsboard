class HomeController < ApplicationController
  def index
    @jobs = Job.paginate(page: params[:page], per_page: 5)
  end
end
