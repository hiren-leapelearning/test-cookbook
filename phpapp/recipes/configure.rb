node[:deploy].each do |application, deploy|

Chef::Log.debug("start phpapp configure.rb")
Chef::Log.debug("#{deploy[:deploy_to]}/current/db-connect.php")
  template "#{deploy[:deploy_to]}/current/db-connect.php" do
    source "db-connect.php.erb"
    mode 0660
    group deploy[:group]

    if platform?("ubuntu")
      owner "www-data"
    elsif platform?("amazon")   
      owner "apache"
    end

    variables(
      :host =>     "host_name_here",
      :user =>     "user_here",
      :password => "pass_here",
      :db =>       "database_here",
      :table =>    "table_here"
    )

   only_if do
     File.exists?("#{deploy[:deploy_to]}/current")
   end
  end
Chef::Log.debug("end phpapp configure.rb")
end

