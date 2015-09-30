#
# Cookbook Name:: ruby
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w[
	ruby
	rubygems
].each do |pkg|
	package "#{pkg}" do
		action :install
	end
end
