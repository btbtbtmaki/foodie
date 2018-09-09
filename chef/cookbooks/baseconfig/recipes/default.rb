# Make sure the Apt package lists are up to date, so we're downloading versions that exist.
cookbook_file "apt-sources.list" do
  path "/etc/apt/sources.list"
end
execute 'apt_update' do
  command 'apt-get update'
end

# Base configuration recipe in Chef.
package "wget"
package "ntp"
cookbook_file "ntp.conf" do
  path "/etc/ntp.conf"
end

cookbook_file "unicore_init" do
  path "/etc/init.d/unicore_init"
end

execute 'ntp_restart' do
  command 'service ntp restart'
end
package "nginx"
cookbook_file "nginx-default" do
  path "/etc/nginx/sites-available/default"
end
execute 'nginx_restart' do
  command 'sudo service nginx restart'
end

package "postgresql"
execute 'create_database' do
  command 'echo "CREATE DATABASE mydb; CREATE USER ubuntu; GRANT ALL PRIVILEGES ON DATABASE mydb TO ubuntu;" | sudo -u postgres psql'
end




package "build-essential"
package "libreadline-dev"
package "libyaml-dev"
package "libxml2-dev"
package "libxslt1-dev"
package "libssl-dev"
package "libcurl4-openssl-dev"
package "python-software-properties"
package "libffi-dev"

package "liblzma-dev"


package "ruby-dev"
#package "sqlite3"
#package "libsqlite3-dev"
package "zlib1g-dev"
package "nodejs"
#for postpreSQL
package "libpq-dev"

execute 'install bundler' do
  command 'gem install bundler'
end
execute 'fk_nokogiri' do
  command 'gem install nokogiri'
end



execute 'bundle' do
  command 'bundle install'
  cwd '/home/ubuntu/project'
  user 'ubuntu'
  returns [0,]
end

execute 'set psql' do
  command 'bash ./db.sh'
  cwd '/home/ubuntu/project'
end

execute 'create' do
  command 'rake db:create'
  cwd '/home/ubuntu/project'
  user 'ubuntu'
end

#execute 'setup' do
#  command 'rake db:seed'
#  cwd '/home/ubuntu/project'
#  user 'ubuntu'
#end

execute 'migrate' do
  command 'rake db:migrate'
  cwd '/home/ubuntu/project'
  user 'ubuntu'
end

execute 'precompile assets' do
  command 'rake assets:precompile'
  cwd '/home/ubuntu/project'
  user 'ubuntu'
end

#execute 'run_server' do
#  command 'rails server -d -b 0.0.0.0'
#  cwd '/home/ubuntu/project'
#  user 'ubuntu'
#end

execute 'unicorn chmod' do
  command 'sudo chmod 755 unicore_init'
  cwd '/etc/init.d'
end

execute 'unicorn set' do
  command 'sudo update-rc.d unicore_init defaults'
  cwd '/etc/init.d'
end

execute 'unicorn start' do
  command 'sudo service unicore_init start'
end
