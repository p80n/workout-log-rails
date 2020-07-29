class Workout < ApplicationRecord

  has_many :workout_sets, ->{ order(:id) }, dependent: :delete_all
  has_many :exercises, through: :workout_sets

  alias_attribute :sets, :workout_sets

  def muscle_groups
    #sets.includes(exercise: :muscle).pluck(:muscle_group).sort.uniq
    sets.collect{|s| s.exercise.muscle.muscle_group}.sort.uniq
  end

  def total_weight_per_group
    h = Hash.new{|h,k|h[k]=0}
    workout_sets.each{|ws| h[ws.exercise.muscle.muscle_group] += ws.total_weight}
    h
  end

  def total_weight
    sets.reject{|s| s.warmup? }.sum(&:total_weight)
  end

  def total_reps
    sets.exists? ? sets.collect_concat(&:reps).sum : 0
  end

  def duration
    sets.exists? ? sets.last.created_at - created_at : 0
  end

  def rate # reps per minute
    sets.exists? ? total_reps / duration * 60 : 0
  end

  def intensity
    sets.exists? ? total_weight / total_reps : 0
  end

end
