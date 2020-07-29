class WorkoutsController < ApplicationController


  def index
    workouts = Workout.includes(workout_sets: {exercise: :muscle}).order('id desc').limit(50)
    @workouts = {}
    workouts.each{|w| w.muscle_groups.each{|mg| @workouts[mg] ||= w } }
  end

  def create
    @workout = Workout.new
    @workout.save
    redirect_to @workout
  end

  def show
    @workout = Workout.includes(exercises: :equipment).find(show_params[:id])
    @previous_set = @workout.sets&.last
    @previous_set.notes = '' if @previous_set
# TODO maybe if workout.date < today skip previous?
    @combined = Hash.new{|k,v|k[v]=[]}
    if ( @workout.muscle_groups )
#@previous_workout = Hash{|h,k|h[k]=
      @previous_workouts = {}
      @workout.muscle_groups.each do |mg|
        @previous_workouts[mg.name] = Workout.joins(workout_sets: {exercise: :muscle}).where(muscles: { muscle_group_id: mg.id }).where('workouts.id < ?', @workout.id).last
      end
      @previous_workout = Workout.joins(workout_sets: {exercise: :muscle}).where(muscles: { muscle_group_id: @workout.muscle_groups.map(&:id) }).where('workouts.id < ?', @workout.id).last

      if @previous_workout
        @max_sets = @workout.sets.size > @previous_workout.sets.size ? @workout.sets.size : @previous_workout.sets.size
        0.upto(@max_sets) do |i|
          @combined[:current] << @workout.sets[i] if i < @workout.sets.size
          @combined[:previous] << @previous_workout.sets[i] if i < @previous_workout.sets.size
        end
      else
      @combined[:current] = @workout.sets
      @combined[:previous] = []
      @max_sets = @workout.sets.size
      end
    else
      @combined[:current] = @workout.sets
      @combined[:previous] = []
      @max_sets = @workout.sets.size
    end



    @set = WorkoutSet.new(@workout.sets&.last&.attributes)
  end
  
  def show_params
    params.permit(:id)
  end
  
end
