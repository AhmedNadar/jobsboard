class CompaniesController < ApplicationController
  def index
    @companies = Job.companies.all
  end

  def create
    @job     = Job.find(params[:job_id])
    @comapny = @job.companies.create(params_comapnies)
    redirect_to job_path(@job)
  end

  private
    def params_comapnies
      params.require(:comapny).permit(:name, :url, :location, :avatar)
    end
end