#!/usr/bin/env ruby

file_type = ARGV[0]

if not file_type then
  puts "Please give a file type. e.g. `clean.rb mp4`."
  exit
end

if file_type[0] == '.' then
  file_type = file_type[1..-1]
end

search_str = "#{Dir.pwd}/*.#{file_type}"
file_list = Dir[search_str]

if file_list.empty? then
  puts "Couldn't file any files of type [#{file_type}]."
  exit
end


##
## Generate a mask for the command parts of the path
##

MaskEntry = Struct.new(:string, :common) do
  def to_s()
    mark = (common == true ? 'X' : ' ')
    "[#{mark}] #{string}"
  end
end
token_mask = []
tokenized_path_list = []

file_list.each_with_index do | path, index |
  path_tokens = File.basename(path).split(/[\s,-,_]/)
  tokenized_path_list[index] = path_tokens

  first_time = token_mask.empty?

  path_tokens.each_with_index do | token, index |

    if first_time then
      token_mask[index] = MaskEntry.new(token, true)
    else
      token_mask[index].common = token_mask[index].string == token
    end

  end

end

isMaskingAnything = false
token_mask.each do | entry |
  if entry.common == true then
    isMaskingAnything = true
    break
  end
end

if not isMaskingAnything then
  puts "Couldn't find commonalities between files."
  exit
end

file_list.each_with_index do | path, index |

  new_file_name = ""
  tokenized_path_list[index].each_with_index do | token, iToken|
    if not token_mask[iToken].common then

      #
      # Hackily pad numbers
      #
      if token.length == 2 and token[0][/\d/] and token[1][/\d/] then
        token = '0' + token
      end

      new_file_name << token
    end
  end
  old_path = file_list[index]
  new_path = "#{Dir.pwd}/#{new_file_name}.#{file_type}"

  File.rename(old_path, new_path)
end

puts "#{file_list.count} renamed."

