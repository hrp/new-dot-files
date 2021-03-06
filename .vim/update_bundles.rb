#!/usr/bin/env ruby
# Automated download and update of vim plugins
# http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen

pathogen_url = "git://github.com/tpope/vim-pathogen.git"
pathogen_dir = "vim-pathogen"

git_bundles = %w[ 
  git://github.com/scrooloose/nerdtree.git
  git://github.com/tpope/vim-haml.git
  git://github.com/tpope/vim-markdown.git
  http://github.com/tpope/vim-endwise.git
  git://github.com/tpope/vim-repeat.git
  git://github.com/tpope/vim-surround.git
  git://github.com/tpope/vim-vividchalk.git
  git://github.com/tsaleh/vim-align.git
  git://github.com/tsaleh/vim-shoulda.git
  git://github.com/ervandew/supertab.git
  git://github.com/tsaleh/vim-tcomment.git
  git://github.com/vim-ruby/vim-ruby.git
  git://repo.or.cz/vcscommand
  git://github.com/hrp/vim_colors.git
  git://github.com/hrp/rainbow-parenthesis
  git://github.com/mileszs/ack.vim.git
  git://github.com/wincent/Command-T.git
  git://github.com/borgand/ir_black.git
  git://github.com/vim-scripts/timestamp.vim.git
  git://github.com/hrp/EnhancedCommentify.git
  git://github.com/chrismetcalf/vim-autocomplpop.git
  git://github.com/tpope/vim-rails.git
  git://github.com/trapd00r/neverland-vim-theme.git
  git://github.com/vim-scripts/L9.git
  git://github.com/vim-scripts/FuzzyFinder.git
  git://github.com/nathanaelkane/vim-indent-guides.git
  git://github.com/mattn/gist-vim.git
  git://github.com/altercation/vim-colors-solarized.git
  git://github.com/ervandew/screen.git
]
  #  git://github.com/skammer/vim-css-color.git
  #  git://github.com/vim-bundles/fuzzyfinder.git,
  #  git://github.com/sukima/xmledit.git,
  #  git://github.com/vim-scripts/neocomplcache.git

vim_org_scripts = [
  %w[IndexedSearch 7062  plugin],
  %w[jquery  12107 syntax],
  %w[taglist 7701  zip],
  %w[ScrollColor 5966    plugin],
  %w[ColorSamplerPack 12179 zip],
  %w[xml 14039 ftplugin],
  %w[Rename 7262 plugin],
  %w[YankRing 13554 zip]
]

require 'fileutils'
require 'open-uri'
require 'rubygems'
require 'colorize'


#  assume this script is in ~/.vim
puts "Trashing Pathogen (lookout!)".red
FileUtils.rm_rf pathogen_dir 
FileUtils.rm_rf 'autoload'
puts "  Unpacking Pathogen".magenta
`git clone -q #{pathogen_url} #{pathogen_dir}`
FileUtils.cp_r "#{pathogen_dir}/.", '.'
FileUtils.rm_rf pathogen_dir

bundles_dir = File.join(File.dirname(__FILE__), "bundle")

FileUtils.cd(bundles_dir)

puts "Trashing all bundles (lookout!)".red
Dir["*"].each {|d| FileUtils.rm_rf d }

git_bundles.each do |url|
  dir = url.split('/').last.sub(/\.git$/, '')
  puts "  Unpacking #{url} into #{dir}".yellow
  `git clone -q #{url} #{dir}`.magenta
  FileUtils.rm_rf(File.join(dir, ".git"))
end

vim_org_scripts.each do |name, script_id, script_type|
  puts "  Downloading #{name}".cyan
  local_file = File.join(name, script_type, "#{name}.#{script_type == 'zip' ? 'zip' : 'vim'}")
  FileUtils.mkdir_p(File.dirname(local_file))
  File.open(local_file, "w") do |file|
    file << open("http://www.vim.org/scripts/download_script.php?src_id=#{script_id}").read
  end
  if script_type == 'zip'
    %x(unzip -d #{name} #{local_file})
  end
end

# Build Command-T
FileUtils.cd("Command-T")
`rake make`

# Regenerate the helpfiles
`/usr/local/bin/vim -e -c "call pathogen#helptags()" -c q`
