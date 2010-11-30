begin
  # load wirble
  require 'rubygems'
  require 'irbtools'
  #  require 'irb_rocket'

  #
  # For 1.8.4
  #
  #  require 'wirble'
  #  require 'ap'
  #  Wirble.init
  #  Wirble.colorize

  %w{hpricot open-uri htmlentities time}.each {|x| require x}
   
  IRB::Irb.class_eval do
    def output_value
      ap @context.last_value
    end
  end

end

class Object
  def interesting_methods
    (self.methods - Object.new.methods).sort
  end
end

HASH = { 
  :bob => 'Marley', :mom => 'Barley', 
  :gods => 'Harley', :chris => 'Farley'} unless defined?(HASH)
ARRAY = HASH.keys unless defined?(ARRAY)
