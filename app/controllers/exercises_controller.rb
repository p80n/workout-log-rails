require 'nokogiri'

class ExercisesController < ApplicationController

  def index
    @exercises = Exercise.includes([:muscle, :equipment])
    ex = params[:id] ? Exercise.find(id_param) : nil
    # reuse muscle group and equipment from previous submit
    @exercise = Exercise.new(muscle: ex&.muscle)
  end

  def new
    @exercise = Exercise.new
  end

  def show
    { foo: 'bar' }
  end

  def bb_dot_com_params
    doc = Nokogiri::HTML(open(create_params[:link]))
    name = doc.at_css('div.ExDetail h2').text.strip
    equipment = Equipment.find{|eq| eq.name == doc.at_css("div.ExDetail li:contains('Equipment') a").text.strip.downcase}
    muscle = Muscle.find{|m| m.name == doc.at_css("div.ExDetail li:contains('Main Muscle Worked') a").text.strip.downcase}
    name.sub!(/#{muscle}/i, '')
    name.sub!(/#{equipment.name}/i, '')
    { link: create_params[:link],
      name: name,
      muscle_id: muscle.id,
      equipment_id: equipment.id
    }
  end

  def create
    @exercise = Exercise.new(create_params[:name].blank? ? bb_dot_com_params : create_params)
    @exercise.equipment_id ||= create_params[:equipment_id]
    @exercise.muscle_id ||= create_params[:muscle_id]
    @exercise.save
    redirect_to controller: :exercises, action: :index, id: @exercise.id
  end

  def edit
    @exercise = Exercise.find(id_param)    
  end
    
  def update
    @exercise = Exercise.find(id_param)
    @exercise.update!(edit_params)
    redirect_to exercises_path
  end

  def destroy   
    Exercise.find(id_param).destroy
    redirect_to exercises_path
  end
    
  def create_params
    params.require(:exercise).permit(:name, :equipment_id, :link, :muscle_id, :multiplier)
  end
  def edit_params
    create_params
  end
  def id_param
    params.require(:id)
  end
  
end
