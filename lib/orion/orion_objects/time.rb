class Time
  def >(other_time)
    (self <=> other_time) == 1 ? true : false
  end

  def <(other_time)
    (self <=> other_time) == -1 ? true : false
  end

  def ==(other_time)
    (self <=> other_time) == 0 ? true : false
  end
end