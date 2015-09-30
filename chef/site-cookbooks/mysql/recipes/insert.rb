db_name = 'test_db'
execute "insert" do
	command "/usr/bin/mysql -u root -d #{db_name} < #{Chef::Config[:file_cache_path]}/insert.sql"
	action :nothing
	only_if do
		require 'rubygems'
		Gem.clear_paths
		require 'mysql'
		m = Mysql.new("localhsot", "root", "")
		begin
			m.select_db(db_name)
			m.list_tables.empty?
		rescue Mysql::Error
			return false
		end
	end
end

template "#{Chef::Config[:file_cache_path]}/insert.sql" do
	owner 'root'
	group 'root'
	mode '0600'
	source 'insert.sql.erb'
	notifies :run, 'execute[insert]', :immediately
end
