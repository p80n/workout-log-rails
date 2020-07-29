class Exercise < ApplicationRecord

  belongs_to :muscle
  belongs_to :equipment

  validates :name, presence: true
  validates :muscle, presence: true
  validates :equipment, presence: true

  def self.grouped_by_muscle_group
    grouped = Hash.new{|h,k|h[k]=[]}
    Exercise.includes(:muscle, :equipment).sort_by(&:title).each{|ex| grouped[ex.muscle.muscle_group.name] << [ex.title, ex.id]}
    grouped
  end

  def title
    "#{equipment&.name} #{name}".titleize
  end

end
