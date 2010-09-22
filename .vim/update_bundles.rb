#!/usr/bin/env ruby
# Automated download and update of vim plugins
# http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen

git_bundles = [ 
  "git://github.com/scrooloose/nerdtree.git",
  "git://github.com/tpope/vim-haml.git",
  "git://github.com/tpope/vim-markdown.git",
  "http://github.com/tpope/vim-endwise.git",
  "git://github.com/tpope/vim-repeat.git",
  "git://github.com/tpope/vim-surround.git",
  "git://github.com/tpope/vim-vividchalk.git",
  "git://github.com/tsaleh/vim-align.git",
  "git://github.com/tsaleh/vim-shoulda.git",
  "git://github.com/tsaleh/vim-supertab.git",
  "git://github.com/tsaleh/vim-tcomment.git",
  "git://github.com/vim-ruby/vim-ruby.git",
  "git://repo.or.cz/vcscommand",
  #  "git://github.com/vim-bundles/fuzzyfinder.git",
  "git://github.com/hrp/vim_colors.git",
  "git://github.com/hrp/rainbow-parenthesis",
  "git://github.com/mileszs/ack.vim.git",
  "git://github.com/wincent/Command-T.git",
  "git://github.com/borgand/ir_black.git",
  "git://github.com/sukima/xmledit.git",
  "git://github.com/hrp/EnhancedCommentify.git"
]

vim_org_scripts = [
  ["IndexedSearch",      "7062",  "plugin"],
  ["gist",               "12732", "plugin"],
  ["jquery",             "12107", "syntax"],
  ["taglist", "7701",    "zip"],
  ["ScrollColor", "5966",    "plugin"],
  ["ColorSamplerPack", "12179", "zip"],
  ["YankRing", "13554", "zip"]
]

require 'fileutils'
require 'open-uri'

bundles_dir = File.join(File.dirname(__FILE__), "bundle")

FileUtils.cd(bundles_dir)

puts "Trashing everything (lookout!)"
Dir["*"].each {|d| FileUtils.rm_rf d }

git_bundles.each do |url|
  dir = url.split('/').last.sub(/\.git$/, '')
  puts "  Unpacking #{url} into #{dir}"
  `git clone #{url} #{dir}`
  FileUtils.rm_rf(File.join(dir, ".git"))
end

vim_org_scripts.each do |name, script_id, script_type|
  puts "  Downloading #{name}"
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
