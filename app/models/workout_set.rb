class WorkoutSet < ApplicationRecord

  belongs_to :exercise
  belongs_to :workout

  def total_weight
    reps.each_with_index.map{|rep,i| rep * weights[i] * multiplier }.sum
  end

  def multiplier
    exercise.multiplier || 1
  end

  def load_exercise
    @exercise = Rails.cache.fetch(exercise_id){ Exercise.find(exercise_id) } unless exercise_id.blank?
  end

  def warmup?
    warmup
  end

  def pr_by_weight

  end

  def pr_by_volume

  end


end
