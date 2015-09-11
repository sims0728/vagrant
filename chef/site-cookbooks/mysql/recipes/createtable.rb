db_name='test_db'
execute "createtable" do
	command "/usr/bin/mysql -u root #{db_name} < #{Chef::Config[:file_cache_path]}/createtable.sql"
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

template "#{Chef::Config[:file_cache_path]}/createtable.sql" do
	owner 'root'
	group 'root'
	mode '0600'
	source 'createtable.sql.erb'
	notifies :run, 'execute[createtable]', :immediately
end
