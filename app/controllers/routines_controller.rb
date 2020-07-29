class RoutinesController < ApplicationController


  def index
    @routines = Routine.all
  end

  def new
    @routine = Routine.new
  end

  def create
    @routine = Routine.new
  end

  def show
    @routine = Routine.find(show_params[:id])
  end
  
  def show_params
    params.permit(:id)
  end
  
end
