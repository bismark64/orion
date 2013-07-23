class Fixnum
  def seconds
    self
  end

  def minutes
    self * 60.seconds
  end

  def hours
    self * 60.minutes
  end

  def days
    self * 24.hours
  end

  def weeks
    self * 7.days
  end

  def months
    self * 4.weeks
  end

  def years
    self * 12.months
  end

  alias_method :second, :seconds
  alias_method :minute, :minutes
  alias_method :hour, :hours
  alias_method :day, :days
  alias_method :week, :weeks
  alias_method :month, :months
  alias_method :year, :years
end