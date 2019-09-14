require 'os' # gem install os
require 'pathname'

if not OS.windows? then
    puts("Firefox settings link only supported on windows.")
    exit(1)
end

def link(from, to)
    File.symlink(from, to)
end

def find_firefox_profile()
    appDataPath = ENV['APPDATA']
    firefoxAllProfilesPath = "#{appDataPath}\\Mozilla\\Firefox\\Profiles"
    firefoxProfilePath = nil

    Pathname.new(firefoxAllProfilesPath).children.select { |c| 
        if c.directory? then
            firefoxProfilePath = c
            break
        end
    }

    return firefoxProfilePath
end


destination = File.join(find_firefox_profile(), "user.js")

if File.symlink?(destination) then
    puts("Symlink aready exists at [#{destination}]")
    exit(1)
end

link("user.js", destination)