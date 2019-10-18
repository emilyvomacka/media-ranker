class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :if_work_missing, only: [:show, :edit, :destroy, :upvote]
  
  def index
    @works = Work.all
  end 
  
  def show ; end 
  
  def new 
    @work = Work.new
  end 
  
  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "Work added successfully"
      redirect_to root_path 
      return
    else
      flash.now[:failure] = "Work failed to save"
      render :new
      return
    end 
  end 
  
  def edit ; end
  
  def update
    if @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work)
      return
    else
      flash.now[:failure] = "Work failed to save"
      render :edit
      return
    end 
  end 
  
  def upvote 
    if session[:user_id].nil? 
      flash[:warning] = "A problem occurred: You must log in to do that"
      redirect_to work_path(@work)
      return 
    else 
      if @work.votes.find_by(user_id: session[:user_id])
        flash[:warning] = "A problem occurred: user has already voted for this work."
        redirect_to work_path(@work)
        return 
      end 
      Vote.create(user_id: session[:user_id], work_id: params[:id])
      flash[:success] = "Successfully upvoted!"
      redirect_to works_path
    end 
  end 
  
  def destroy 
    @work = Work.find_by(id: params[:id])
    if @work.destroy
      flash[:success] = "Successfully destroyed #{@work.category} #{@work.id}"
      redirect_to root_path
      return 
    end 
  end 
  
  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end 
  
  def find_work
    @work = Work.find_by(id: params[:id])
  end 
  
  def if_work_missing
    if @work.nil?
      flash[:error] = "Work with id #{params[:id]} was not found."
      head :not_found
      return
    end
  end 
end
