class WorksController < ApplicationController
  def index
    @works = Work.all
  end 

  def show 
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    if @work.nil?
      head :not_found
      return
    end 
  end 

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
  
  def edit 
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
      return
    end 
  end

  def update
    @work = Work.find_by(id: params[:id])
    if @work.update(work_params)
      flash[:success] = "Successfully updated #{work.category} #{work.id}."
      redirect_to work_path(@work)
      return
    else
      render :edit
      flash.now[:failure] = "Work failed to save"
      return
    end 
  end 

  def destroy 
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    end 

    if @work.destroy
    flash[:success] = "Successfully destroyed #{work.category} #{work.id}."
    redirect_to root_path
    return 
    end 
  end 

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end 
end
