begin
  # load wirble
  require 'rubygems'
  #  require 'ap'
  #  require 'irbtools'
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
    #  def output_value
      #  ap @context.last_value
    #  end
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

# 
# Cool IRB Helpers
# http://www.themomorohoax.com/2009/04/07/ruby-irb-tip-try-again-faster
#

def ls
   %x{ls}.split("\n")
end

def fl(file_name)
   file_name += '.rb' unless file_name =~ /\.rb/
   @@recent = file_name 
   load "#{file_name}"
end
 
def rl
  fl(@@recent)
end

def rt
  rl
  eval(choose_last_command)
end

# prevent 'rt' itself from recursing. 
def choose_last_command
  real_last = Readline::HISTORY.to_a[-2]
  real_last == 'rt' ? @@saved_last :  (@@saved_last = real_last)
end

# set some colors
Wirb.schema = {

 # container
 :open_hash        => :light_green,
 :close_hash       => :light_green,
 :open_array       => :light_green,
 :close_array      => :light_green,

 :open_set         => :green,
 :close_set        => :green,
 :open_enumerator  => :green,
 :close_enumerator => :green,

 # delimiter colors
 :comma            => :green,
 :refers           => :green,

 # class
 :class            => :light_green,
 :class_separator  => :green,
 :object_class     => :light_green,

 # object
 :open_object               => :green,
 :object_description_prefix => :green,
 :object_description        => :brown,
 :object_addr_prefix        => :brown_underline,
 :object_addr               => :brown_underline,
 :object_line_prefix        => :brown_underline,
 :object_line               => :brown_underline,
 :object_line_number        => :brown_underline,
 :close_object              => :green,

 # symbol
 :symbol_prefix       => :yellow,
 :symbol              => :yellow,
 :open_symbol_string  => :brown,
 :symbol_string       => :yellow,
 :close_symbol_string => :brown,

 # string
 :open_string  => :light_gray,
 :string       => :white,
 :close_string => :light_gray,

 # regexp
 :open_regexp  => :light_blue,
 :regexp       => :dark_gray,
 :close_regexp => :light_blue,
 :regexp_flags => :light_red,

 # number
 :number => :cyan,
 :range  => :red,
 :open_rational      => :light_cyan,
 :rational_separator => :light_cyan,
 :close_rational     => :light_cyan,

 # misc
 :keyword => nil,
 :nil     => :light_red,
 :false   => :red,
 :true    => :green,

}
