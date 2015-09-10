# php インストール
%w[php php-devel php-common php-cli php-pear php-pdo php-mysqlnd php-xml php-process php-mbstring php-mcrypt php-pecl-xdebug].each do |p|
	package p do
		action :install
		options "--enablerepo=remi --enablerepo=remi-php55"
	end
end
