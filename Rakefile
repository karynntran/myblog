require 'bundler'
Bundler.require
require 'sinatra/activerecord/rake'

ActiveRecord::Base.establish_connection({
  adapter: 'postgresql',
  database: 'blog_db'
})

namespace :db do
  desc "Create blog_db database"
  task :create_db do
    conn = PG::Connection.open()
    conn.exec('CREATE DATABASE blog_db;')
    conn.close
  end

  desc "Connection"
  task :connect_db do
    ActiveRecord::Base.establish_connection({
    adapter: 'postgresql',
    database: 'blog_db'
  })
  end

  desc "Drop blog_db database"
  task :drop_db do
    conn = PG::Connection.open()
    conn.exec('DROP DATABASE blog_db;')
    conn.close
  end

  desc "Add admin"
  task :admin do

    require_relative 'connection'
    require_relative 'models/user'

    User.new({username: "karynn", password_hash: "password"})

  end

  desc "load database with initial data"
  task :load_data do

    require 'csv'

    conn = PG::Connection.open({dbname: 'blog_db'})

    CSV.foreach('entries.csv', :headers => true) do |row|
      header = row["header"]
      post = row["post"]
      date_created = row["date_created"]
      sql_statement = <<-eos
        INSERT INTO entries
          (header, post, date_created)
        VALUES
          ($1, $2, $3)
      eos

      conn.exec_params(sql_statement, [header, post, date_created])
    end
    conn.close
  end
end