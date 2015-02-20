class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :set_job_redirect , only: [:show]

  def index
    @jobs = Job.paginate(page: params[:page], per_page: 2)
     @title = Job.all
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
    redirect_to jobs_path, notice: 'Job was successfully destroyed.'
  end

  private
    def set_job_redirect
      # Use callbacks to share common setup or constraints between actions.
      @job = Job.friendly.find(params[:id])

      # If an old id or a numeric id was used to find the record, then
      # the request path will not match the job_path, and we should do
      # a 301 redirect that uses the current friendly id.
      if request.path != job_path(@job)
        redirect_to @job, status: :moved_permanently
      end
    end

    def set_job
      @job = Job.friendly.find(params[:id])
    end

    def job_params
      params.require(:job).permit(:title, :slug, :description, :company, :url)
    end
end
