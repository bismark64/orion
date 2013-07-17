# Orion

Orion is an tiny gem to search and delete files in the filesystem, using the Find and File Ruby modules.

## Installation

Add this line to your application's Gemfile:

    gem 'orion'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install orion

## Usage

For the time being Orion allows you to run just two methods:

1. Searching files:

    Orion.search "path/where/you/want/to/search/in", "query"

The result of that request has the following form:

    {success: boolean, count: number_of_files_found, files: array_with_string_paths_representing_found_files}

If Orion can't find the requested files the above hash will look like:

    {success: false, count: nil, files: nil}

2. Deleting files

There are two ways to delete files with Orion, the first is a command like call:

    Orion.delete "path/where/you/want/to/search/in", "query"

This returns true whether Orion could delete the files and nil if not.

The second way adds a block to the delete call:

    Orion.delete "path/where/you/want/to/search/in", "query" do |response|
      puts response[:files] if response[:success]
    end

The response hash is the same than search method:

    {success: boolean, count: number_of_files_deleted, files: array_with_string_paths_representing_deleted_files}
    
If Orion can't find the requested files the above hash will look like:

    {success: false, count: nil, files: nil}    

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
