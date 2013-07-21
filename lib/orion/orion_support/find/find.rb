#Source from:
#https://github.com/ruby/ruby/blob/trunk/lib/find.rb?source=cc
#
# find.rb: the Find module for processing all files under a given directory.
#

#
# The +Find+ module supports the top-down traversal of a set of file paths.
#
# For example, to total the size of all files under your home directory,
# ignoring anything in a "dot" directory (e.g. $HOME/.ssh):
#
#   require 'find'
#
#   total_size = 0
#
#   Find.find(ENV["HOME"]) do |path|
#     if FileTest.directory?(path)
#       if File.basename(path)[0] == ?.
#         Find.prune       # Don't look any further into this directory.
#       else
#         next
#       end
#     else
#       total_size += FileTest.size(path)
#     end
#   end
#
module Find

  #
  # Calls the associated block with the name of every file and directory listed
  # as arguments, then recursively on their subdirectories, and so on.
  #
  # Returns an enumerator if no block is given.
  #
  # See the +Find+ module documentation for an example.
  #
  # Return files based in the conditions hash. E.g {:name => "my_file", :size => ">258", :ftype => "file"}
  def find(*paths, conditions) # :yield: path
    results = []
    condition_string = condition_statement(conditions)

    paths.collect!{|d| raise Errno::ENOENT unless File.exist?(d); d.dup}
    while file = paths.shift
      catch(:prune) do
        results << file.dup.taint if eval(condition_string)
        begin
          s = File.lstat(file)
        rescue Errno::ENOENT, Errno::EACCES, Errno::ENOTDIR, Errno::ELOOP, Errno::ENAMETOOLONG
          next
        end
        if s.directory? then
          begin
            fs = Dir.entries(file)
          rescue Errno::ENOENT, Errno::EACCES, Errno::ENOTDIR, Errno::ELOOP, Errno::ENAMETOOLONG
            next
          end
          fs.sort!
          fs.reverse_each {|f|
            next if f == "." or f == ".."
            f = File.join(file, f)
            paths.unshift f.untaint
          }
        end
      end
    end
    results
  end

  # Creates a conditional statement with the given conditions
  def self.condition_statement(conditions)
    comparative_conditions = conditions.reject{|k,v| (v =~ /(>)|(<)/).nil? }
    equality_conditions = Hash.diff(conditions, comparative_conditions) 

    condition_string = conditions.has_key?(:name) ? "file.include?(conditions[:name]) &&" : ""
    equality_conditions.each do |k, v|
      condition_string << " File.send(:#{k}, file) == conditions[:#{k}] &&" unless k == :name
    end
    comparative_conditions.each do |k, v|
      condition_string << " File.send(:#{k}, file) #{conditions[k]} &&"
    end
    condition_string << " true"
  end

  #
  # Skips the current file or directory, restarting the loop with the next
  # entry. If the current file is a directory, that directory will not be
  # recursively entered. Meaningful only within the block associated with
  # Find::find.
  #
  # See the +Find+ module documentation for an example.
  #
  def prune
    throw :prune
  end

  module_function :find, :prune
end