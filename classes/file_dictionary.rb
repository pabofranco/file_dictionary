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