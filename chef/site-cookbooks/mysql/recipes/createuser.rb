user_name = 'mysql'
user_password = 'mysql'

# create database user
execute 'createuser' do
	command "/usr/bin/mysql -u root < #{Chef::Config[:file_cache_path]}/createuser.sql"
	action :nothing
	not_if "/usr/bin/mysql -u #{user_name} -p#{user_password} -D #{db_name}"
end

template "#{Chef::Config[:file_cache_path]}/createuser.sql" do
	owner 'root'
	group 'root'
	mode 644
	source 'createuser.sql.erb'
	variables({
		:db_name => db_name,
		:username => user_name,
		:password => user_password,
	})
	notifies :run, 'execute[createuser]', :immediately
end
