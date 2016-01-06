namespace :db do
  task :close_connections => :environment do
    puts "------------------- Closing DB connections -------------------"

    q = "SELECT pg_terminate_backend(pg_stat_activity.pid)
            FROM pg_stat_activity
            WHERE pg_stat_activity.datname = '#{Rails.configuration.database_configuration[Rails.env]['database']}'
            AND pid <> pg_backend_pid();"
    ActiveRecord::Base.connection.execute q

    puts "------------------- Finished closing db connections -------------------"
  end
end