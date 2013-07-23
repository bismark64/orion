# Orion

Orion is an tiny gem to perform some file-related tasks in the filesystem, using the Find and File Ruby modules.

## Installation [![Gem Version](https://badge.fury.io/rb/orion.png)](http://badge.fury.io/rb/orion)

Add this line to your application's Gemfile:

```ruby
gem 'orion'
```
And then execute:

```bash
$ bundle
```
Or install it yourself as:

```bash
$ gem install orion
```
Don't forget to require it in your project:

```ruby 
require 'orion'
```
## Usage

Using Orion you can perform this actions:

### Searching files

```ruby
Orion.search "path/where/you/want/to/search/in", conditions
```

##### Paths

You can use both relative and absolute paths as the root path where Orion will search in.

##### Conditions

You can specify conditions or criteria in the Orion search method, via the conditions hash. 
Orion only accepts some conditions as valid, so be aware of only use those included in this list:

```ruby
#Condition            Allowed type  
:name                 #string
:atime                #time
:ctime                #time
:mtime                #time
:ftype                #ftype
:size                 #integer (representing bytes)
:absolute_path        #string
:basename             #string
:directory?           #boolean
:dirname              #string
:executable?          #boolean
:exists?              #boolean
:extname              #string
:file?                #boolean
:readable?            #boolean
:socket?              #boolean
:symlink?             #boolean
:writable?            #boolean
:zero?                #boolean
```

E.g:
```ruby
Orion.search "/home", name: "my_file_name" #will return all files which include my_file_name in /home
Orion.search "~/ruby_projects/my_ruby_project", name: ".rb", size: '> 9999' #will return all ruby files in my_ruby_project directory which size is larger than 9999 bytes
Orion.search "/var/www", ftype: "socket", ctime: "> Time.now - 2.weeks" #will return all sockets in /var/www created since two weeks ago.
```
The result of those requests are OpenStruct objects:
    
    #<OpenStruct success= boolean, count=number_of_files_found, files= array_with_string_paths_representing_found_files> 

If Orion can't find the requested files the above object will look like:
    
    #<OpenStruct success=false, count=0, files=[]> 

### Deleting files

```ruby
Orion.delete "path/where/you/want/to/search/in", conditions
```
Eg:

```ruby
Orion.delete "/home", name: "my_file_name" #will delete all files which include my_file_name in /home
Orion.delete "~/ruby_projects/my_ruby_project", name: ".rb", size: '> 9999' #will delete all ruby files in my_ruby_project directory which size is larger than 9999 bytes
```
This returns true whether Orion could delete the files and nil if not.

If you provide a block, then the delete method will return the same OpenStruct object than search:

    #<OpenStruct success= boolean, count=number_of_deleted_files, files= array_with_string_paths_representing_deleted_files>

This object will be passed to the block for your use.

### Getting info from file

```ruby
Orion.get_info("path/to/a/particular/file", *methods)
```
The methods may be all of the `Orion.search` conditions, except :name

So a `get_info` example would be:

```ruby
Orion.get_info("path/where/you/want/to/search/text.txt", :atime)
=> #<OpenStruct atime=2013-07-17 19:05:08 -0300>
```
With more than just one method:

```ruby
Orion.get_info("path/where/you/want/to/search/text.txt", :ctime, :size, :ftype, :writable?)
=> #<OpenStruct ctime=2013-06-25 13:58:57 -0300, ftype="file", size=204, writable=true>
```

### Using Orion with blocks 

Optionally you can provide a block for an alternative sintax in all Orion methods, for example:

```ruby
Orion.search "/home/username/ruby_projects/my_ruby_project", name: ".rb" do |results|
  puts results.files if results.success 
end

Orion.delete "path/where/you/want/to/search/in", name: ".rb" do |response|
  puts response.files if response.success 
end

Orion.get_info("path/where/you/want/to/search/text.txt", :ctime, :size, :ftype) do |info|
  if info.ftype == "file"
    puts info.ctime
    puts info.size
  end
end
```
A practical example would be:
```ruby   
require 'orion'

Orion.search "~/username/code/", ctime: "< Time.now - 3.weeks", file?: true do |results|
  if results.success
    results.files.each do |file|
      puts file
      Orion.get_info file, :atime, :ctime, :mtime, :ftype, :size do |info|
        puts info.atime
        puts info.ctime
        puts info.mtime
        puts info.ftype
        puts info.size
      end
      puts ""
    end
  end
end
```
This snippet searches files in "~/username/code/" created until 3 weeks ago and for each one returns the path, and some information about that file.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
