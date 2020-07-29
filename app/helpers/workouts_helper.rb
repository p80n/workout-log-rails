module WorkoutsHelper

  def hours(seconds)
    "#{(seconds / 3600).to_i}h " if seconds >= 3600
  end

  def minutes(seconds)
    %Q|#{(seconds % 3600).to_i / 60}m| if seconds % 60 != 0
  end

  def remaining_seconds(seconds)
  end

  def format_seconds(seconds)
    "#{hours(seconds)}#{minutes(seconds)}" if seconds
  end

end
