require 'json'
#require_relative './classes/file_dictionary'
require_relative './classes/initialization'
require_relative './modules/tools'

puts '------------------- TOOLS MODULE --------------------------\n'

#puts '------------------- FILE DICTIONARY -----------------------'
#dict1 = Tools::FileDictionary.new './resources/file1.fd'
#dict2 = Tools::FileDictionary.new './resources/file2.fd'

#dict1.explain                       # prints dictionary entries
#dict2.explain


# dict1.add("Nails Eaten", 12)        # adds "nails_eaten"
# dict1.remove("age")                 # removes key "age"
# dict1.clear("name")                 # sets key "name"'s value to nil

# dict1.merge(dict2, true)            # merges dict2 into dict1 overwritting existing keys

# dict1.explain

# dict1.save                          # saves the current dictionary into its original file

#puts '----------------- / FILE DICTIONARY -----------------------\n'


puts '----------------- STRING EXTENSION -------------------------\n'

stringer = Tools::StringExtension.new

t_string = "Teste s>Tring»"
puts "Original String :: #{t_string}\n"

r_string = stringer.regulate(t_string)
puts "Regulated String :: #{r_string}\n"

o_string = stringer.to_origin(r_string)
puts "To Origin String :: #{o_string}\n"



puts '----------------- / STRING EXTENSION -----------------------\n'



puts '------------------- / TOOLS MODULE ------------------------\n'

#puts '------------------- INITIALIZATION MODULE -----------------\n'

#puts '------------------- CONFIG --------------------------------\n'

#config = Initialization::Config.new

#config.show_params                  # prints initialization parameters

#config.explain_stuff                # prints stuff

#puts '------------------- / CONFIG ------------------------------\n'

#puts '------------------- / INITIALIZATION MODULE ---------------\n'