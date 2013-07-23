# Original from:
#   https://github.com/ruby/ruby/blob/trunk/lib/find.rb?source=cc
# Modified to fit Orion purposes

require "orion/orion_support/i18n"
require "orion/orion_objects/fixnum"

module Orion
  module Find
    def find(*paths, conditions) # :yield: path
      raise I18n.t("errors.search.not_conditions_provided") if conditions.empty?
      condition_string = condition_statement(validate(conditions))
      results = []

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

    def self.validate(conditions)
      valid_conditions = [:name, :atime, :ctime, :mtime, :ftype, :size, :absolute_path, :basename, :directory?, :dirname, :executable?, :exists?, :extname, :file?, :readable?, :socket?, :symlink?, :writable?, :zero?]
      invalid_cond = ((valid_conditions+conditions.keys)-(valid_conditions&conditions.keys))-(valid_conditions-(valid_conditions&conditions.keys))
      invalid_cond.empty? ? conditions : raise(NoMethodError)
    end

    def self.arrange_conditions(conditions)
      @comparative_conditions = conditions.select{|k,v| v =~ /(>)|(<)/ } # size: '> 999'
      @equality_conditions = Hash.diff(conditions, @comparative_conditions) # name: '.rb'
    end

    # Creates a conditional statement string with the given conditions
    def self.condition_statement(conditions)
      arrange_conditions(conditions)
      conditions_array = conditions.has_key?(:name) ? ["file.include?(conditions[:name])"] : []
      @equality_conditions.each do |k, v|
        conditions_array << "File.send(:#{k}, file) == conditions[:#{k}]" unless k == :name
      end
      @comparative_conditions.each do |k, v|
        conditions_array << "File.send(:#{k}, file) #{conditions[k]}"
      end
      conditions_array.join(" && ")
    end

    def prune
      throw :prune
    end

    module_function :find, :prune
  end
end