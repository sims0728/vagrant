# create database
db_name = 'test_db'
execute "createdb" do
	command "/usr/bin/mysql -u root < #{Chef::Config[:file_cache_path]}/createdb.sql"
	action :nothing
	not_if "/usr/bin/mysql -u root -D #{db_name}"
end

template "#{Chef::Config[:file_cache_path]}/createdb.sql" do
	owner 'root'
	group 'root'
	mode 644
	source 'createdb.sql.erb'
	variables(
		:db_name => db_name
	)
	notifies :run, 'execute[createdb]', :immediately
end

