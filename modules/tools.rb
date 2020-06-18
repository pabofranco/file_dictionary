# Module responsible for tools aggregation
module Tools

    # Creates a dictionary based on a file passed as argument.
    # If the file does not exist, it will be an empty dictionary
    # that can be saved afterwards
    class FileDictionary
        attr_reader :dictionary
        attr_reader :path
        attr_reader :separator

        def initialize(file_path, separator='=')
            @dictionary = {}
            @path = file_path
            @separator = separator

            load
        end

        def load
            if File.exist?(self.path)
                File.open(self.path, 'r:UTF-8') do |f|
                    f.each_line do |line|
                        dict_key, dict_value = line.split(self.separator)
                    
                        self.dictionary[prepare_key(dict_key)] = dict_value.strip
                    end
                end
            end
            self.dictionary
        end

        def explain
            self.dictionary.each_key do |key|
                puts "#{key} => #{self.dictionary[key]}"
            end
        end
        
        def add(key, value)
            self.dictionary[prepare_key(key)] = value
            self.dictionary
        end

        def clear(key)
            self.dictionary[prepare_key(key)] = nil
            self.dictionary
        end
        
        def remove(key)
            self.dictionary.delete(key)
            self.dictionary
        end
        
        def save(file_path=self.path)
            File.open(file_path, 'w:UTF-8') do |f|
                self.dictionary.each_key do |key|
                    line = create_line(key, self.dictionary[key])
                    f.write(line)
                end
            end
        end

        def merge(to_merge_dict, overwrite)
            raise ArgumentInvalid if to_merge_dict.nil?
            to_merge_dict.dictionary.each_key do |key|
                if overwrite
                    self.dictionary[key] = to_merge_dict.dictionary[key] 
                elsif !overwrite && !self.dictionary.key?(key)
                    self.dictionary[key] = to_merge_dict.dictionary[key]
                end
            end
            self.dictionary
        end

        def create_line(key, value)
            "#{key.gsub(/_/,' ').split.map(&:capitalize).join(' ')} #{self.separator} #{value}\n"
        end

        def prepare_key(key)
            key.strip.gsub(/\s/, '_').downcase
        end
    end

    class StringExtension
        SPECIAL_CHARS = "|\\!\"@#£$§%&/{([])}=?'«»*+¨`´~^ºª-_:.;,<>"

        def regulate(target_string)
            regulated = ""
            target_string.each_char do |char|
                if is_special?(char)
                    regulated << "\\#{char}"
                elsif char.strip.empty?
                    regulated << "_"
                elsif is_upcase?(char)
                    regulated << "»#{char.downcase}"
                else
                    regulated << "«#{char.downcase}"
                end
            end

            regulated
        end

        def to_origin(target_string)
            origin = ""
            target_string.split('_').each do |word|
                curr_char = 0
                idx = 0
                max = word.size / 2

                while curr_char < max 
                    block = word[idx,2]
                    char_case, char = block[0], block[1]

                    if is_special?(char)
                        origin << char
                    elsif char_case == '»'
                        origin << char.upcase
                    else
                        origin << char
                    end
                    idx += 2
                    curr_char += 1
                end
                origin << ' '
            end

            origin
        end

        def is_upcase?(char)
            char != char.downcase
        end

        def is_downcase?(char)
            char != char.upcase
        end

        def is_special?(char)
            SPECIAL_CHARS.include?(char)
        end
    end
end