begin
  # load wirble
  require 'rubygems'
  require 'wirble'
  require 'ap'

  %w{hpricot open-uri htmlentities time}.each {|x| require x}
   
  # start wirble (with color)
 
  Wirble.init
  Wirble.colorize

  IRB::Irb.class_eval do
    def output_value
      ap @context.last_value
    end
  end

rescue LoadError => err
  warn "Couldn't load Wirble: #{err}"
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
