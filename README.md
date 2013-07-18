# Orion

Orion is an tiny gem to search and delete files in the filesystem, using the Find and File Ruby modules.

## Installation

Add this line to your application's Gemfile:

    gem 'orion'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install orion

Don't forget to require it in your project:
    
    require 'orion'

## Usage

For the time being Orion allows you to run just three methods:

1. Searching files:

    Orion.search "path/where/you/want/to/search/in", "query"

The result of that request is an OpenStruct object:
    
    #<OpenStruct success= boolean, count=number_of_files_found, files= array_with_string_paths_representing_found_files> 

If Orion can't find the requested files the above hash will look like:
    
    #<OpenStruct success=false, count=0, files=[]> 

2. Deleting files

    Orion.delete "path/where/you/want/to/search/in", "query"

This returns true whether Orion could delete the files and nil if not.

3. Getting info from file
    
    Orion.get_info("path/where/you/want/to/search/in", *methods)

You can call get_info with this File methods:

    :atime, :ctime, :mtime, :ftype, :size

So a get_info example would be:

    Orion.get_info("path/where/you/want/to/search/text.txt", :atime)
    => #<OpenStruct atime=2013-07-17 19:05:08 -0300>

With more than just one method:

    Orion.get_info("path/where/you/want/to/search/text.txt", :ctime, :size, :ftype)
    => #<OpenStruct ctime=2013-06-25 13:58:57 -0300, ftype="file", size=204>

Optionally you can provide a block for an alternative sintax in all Orion methods, for example:

    Orion.delete "path/where/you/want/to/search/in", ".rb" do |response|
      puts response.files if response.success
    end

    Orion.get_info("path/where/you/want/to/search/text.txt", :ctime, :size, :ftype) do |info|
      if info.ftype == "file"
        puts info.ctime
        puts info.size
      end
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
