node[:deploy].each do |application, deploy|

  template "#{node[:deploy][application][:deploy_to]}/current/db-connect.php" do
    source "db-connect.php.erb"
    mode 0660
    group deploy[:group]

    if platform?("ubuntu")
      owner "www-data"
    elsif platform?("amazon")   
      owner "apache"
    end

    #variables(
    #  :host =>     (deploy[:database][:host] rescue nil),
    #  :user =>     (deploy[:database][:username] rescue nil),
    #  :password => (deploy[:database][:password] rescue nil),
    #  :db =>       (deploy[:database][:database] rescue nil),
    #  :table =>    (node[:phpapp][:dbtable] rescue nil)
    #)
    variables(
      :host =>     ("host_name_here" rescue nil),
      :user =>     ("user_here" rescue nil),
      :password => ("pass_here" rescue nil),
      :db =>       ("database_here" rescue nil),
      :table =>    (node[:phpapp][:dbtable] rescue nil)
    )

   only_if do
     File.directory?("#{node[:deploy][application][:deploy_to]}/current")
   end
  end
end

