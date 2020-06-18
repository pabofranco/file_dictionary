# TODO >>> initialize module correcly

module Initialization
    
    class Config
        attr_reader :params
        attr_reader :stuff

        def initialize
            @params = load_initial_parameters
            @stuff = load_initial_stuff
        end


        def load_initial_parameters
            {
                'timestamp' => Time.now.to_i,
                'is_valid' => true
            }
        end

        def load_initial_stuff
            %w[Alan Edgar Poe Elliot Johana Jannove Jonne]
        end

        def show_params
            self.params.each_key do |key|
                puts "#{key} => #{self.params[key]}"
            end
        end

        def explain_stuff
            self.stuff.each do |name|
                puts "---> #{name}"
            end
        end
    end
end