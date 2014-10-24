require 'bundler'
Bundler.require
require 'sinatra/activerecord/rake'
require_relative 'connection.rb'


namespace :db do
  desc "Create blog_db database"
  task :create_db do
    conn = PG::Connection.open()
    conn.exec('CREATE DATABASE blog_db;')
    conn.close
  end

  desc "Drop blog_db database"
  task :drop_db do
    conn = PG::Connection.open()
    conn.exec('DROP DATABASE blog_db;')
    conn.close
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