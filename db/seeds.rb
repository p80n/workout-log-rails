# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

%w(shoulders chest biceps triceps legs back arms abs pelvic).each {|mg|
  MuscleGroup.find_or_create_by(name: mg) }

{ shoulders: %w(deltoids neck traps),
  chest: %w(chest),
  biceps: %w(biceps),
  arms: %w(forearm),
  triceps: %w(triceps),
  abs: %w(abs),
  legs: %w(quads calves hamstrings glutes),
  back: %w(lower\ back lats),
  pelvic: %w(cremaster pelvic\ floor)
}.each do |mg, muscles|
  muscle_group = MuscleGroup.where(name: mg).first
  muscles.each {|muscle|
    Muscle.find_or_create_by(name: muscle, muscle_group_id: muscle_group.id) }
end

%w(ab\ roller barbell bodyweight cable dumbbell E-Z\ curl\ bar stability\ ball).each {|equipment|
  Equipment.find_or_create_by(name: equipment) }
