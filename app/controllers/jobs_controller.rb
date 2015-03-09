class JobsController < ApplicationController

  # before_action :authenticate_user!, except: [:index, :show]
  before_action :find_job, only: [:show, :edit, :update, :destroy]
  before_action :set_job_redirect , only: [:show]

  def index
    @jobs = Job.paginate(page: params[:page], per_page: 5)
  end

  def premium
    @jobs = Job.where(premium: true).most_recent.includes(:company).paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  def new
    @job = Job.new
  end

  def edit
  end


  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to @job, notice: "Jobs was successfully posted!"
    else
      flash[:error] = "Please try again"
      render :new
    end
  end

  def update
    if @job.update(job_params)
      redirect_to @job, notice: 'Job was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
    redirect_to jobs_url, notice: 'Job was successfully destroyed.'
  end

  private
    def find_job
      @job = Job.friendly.find(params[:id])
    end

    def job_params
      params.require(:job).permit(:title, :slug, :description, :url, :premium, :company_id)
    end

    def set_job_redirect
      # Use callbacks to share common setup or constraints between actions.
      # @user = current_user
      # @job = @user.jobs.friendly.find(params[:id])
      @job = Job.friendly.find(params[:id])

      # If an old id or a numeric id was used to find the record, then
      # the request path will not match the job_path, and we should do
      # a 301 redirect that uses the current friendly id.
      if request.path != job_path(@job)
        redirect_to @job, status: :moved_permanently
      end
    end
end
