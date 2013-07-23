class String
  def valid_file?
    FileTest.file?(self) or File.directory?(self)
  end
end