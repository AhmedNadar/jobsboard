class CompaniesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_company, only: [:show, :edit, :update, :destroy]

  def index
    @companies = Company.paginate(page: params[:page], per_page: 3)
    if signed_in?
      @name = current_user.companies
    else
      @names = Company.all
    end
  end

  def show
  end

  def new
    @company = Company.new
  end

  def create
    @user = current_user
    @company = @user.companies.build(company_params)
    if @company.save
      redirect_to company_url(@company), notice: "#{@company.name.capitalize} information have been saved successfuly! "
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @company.update_attributes(company_params)
      redirect_to @company, notice: 'Job was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @company.destroy
    redirect_to company_url(@company.next), :notice => "Successfully destroyed Company."
  end


  private
    def find_company
      @company = Company.friendly.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:name, :url, :location, :avatar, :email, :slug, :user_id, :jobs_attributes)
    end
end