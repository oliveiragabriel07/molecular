require 'resque/tasks'

task "resque:setup" => :environment do
  Resque.before_fork = proc do
    ActiveRecord::Base.connection.disconnect!
  end

  Resque.after_fork = proc do
    ActiveRecord::Base.establish_connection
  end
end
