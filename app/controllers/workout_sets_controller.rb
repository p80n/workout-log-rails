class WorkoutSetsController < ApplicationController


  def create
    permitted = create_params
    permitted[:reps] = permitted[:reps].split.map(&:to_i)
    weights = permitted[:weights].split.map(&:to_f)
    if weights.size < permitted[:reps].size
      if weights.size == 0
        weights = permitted[:reps].map{0}
      else
        weights = weights + reps[0..weights.size-1].map{weights.last}.map{weights.last}
      end
    end
    permitted[:weights] = weights
    set = WorkoutSet.new(permitted)
    set.save

    workout = Workout.find(workout_param[:id])

    # if workout.muscle_groups.nil? or  workout.muscle_groups.empty? #or (! workout.muscle_groups.any?{|mg| mg == set.exercise.muscle_group} )
    #   workout.muscle_groups ||= []
    #   workout.muscle_groups << set.exercise.muscle.muscle_group
    #   workout.save
    # end
    redirect_to workout
  end

  def edit
    @set = WorkoutSet.find(set_id_param)
    @exercises = Exercise.all
  end
  def update
    @set = WorkoutSet.find(set_id_param)
    permitted = update_params
    permitted[:reps] = permitted[:reps].split.map(&:to_i)
    permitted[:weights] = permitted[:weights].split.map(&:to_f)
    
    @set.update_attributes(permitted)
    redirect_to Workout.find(@set.workout_id)
  end

  def destroy
    WorkoutSet.find(set_id_param).destroy
    redirect_to workouts_path
  end


  def create_params
    params.require(:workout_set).permit(:exercise_id, :reps, :weights, :notes, :warmup).merge(workout_id: workout_param[:id])
  end
  def update_params
    params.require(:workout_set).permit(:id, :exercise_id, :reps, :weights, :notes, :warmup)
  end
  def set_id_param
    params.require(:id)
  end
                     
  def workout_param
    params.require(:workout).permit(:id)
  end
  
end
