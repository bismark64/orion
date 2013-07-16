class String
  def valid_file?
    FileTest.file?(self)
  end
end