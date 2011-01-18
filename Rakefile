require 'rubygems'
require 'colorize'

namespace :nginx do

  desc 'start nginx, default config is config/nginx.conf'
  task :start do
    `sudo /opt/nginx/sbin/nginx`
    puts "nginx started".green
  end

  desc 'stop nginx'
  task :stop do |t, args|
    `sudo pkill nginx`
    puts "nginx stopped".red
  end

  desc 'restart nginx'
  task :restart => [:stop, :start]

  desc 'show nginx processes'
  task :show do
    puts `ps -ef | grep nginx`
  end

end

namespace :varnish do
  desc 'start varnish'
  task :start do
    `sudo varnishd -f /etc/varnish/default.vcl -s malloc,1G -T 127.0.0.1:2000 -a 0.0.0.0:80`
    puts "varnishd started".green
  end

  desc 'stop varnish'
  task :stop do
    `sudo pkill varnishd`
    puts "varnishd stopped".red
  end

  desc 'restart varnish'
  task :restart => [:stop, :start]

  desc 'show varnish processes'
  task :show do
    puts `ps -ef | grep varnishd`
  end
end
