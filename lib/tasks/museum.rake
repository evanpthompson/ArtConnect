###############################################################################
#museum.rake
###############################################################################
require 'net/http'
require "uri"

namespace :museum do
  task :import => :environment do
    museum = {}
    fin = File.open("lib/museum/combined.txt", "r")
    fin.each_line.with_index do |line, i|
      if (i + 1) % 2 == 1
        museum[:name] = line.strip
      else
        museum[:website] = line.strip
        puts museum
        new_museum = Museum.new(museum)
        if new_museum.valid?
          Museum.create!(museum)
        end
        museum = {}
      end
    end
    fin.close
  end

  task :export => :environment do
    fout = File.open("lib/museum/combined.txt", "w")
    all_museums = Museum.all
    all_museums.each do |museum|
      fout.write(museum.name + "\n")
      fout.write(museum.website + "\n")
    end
    fout.close()
  end

  task :web_check => :environment do
    fout_success = File.open("log/website_status/success.log", "w")
    fout_fail = File.open("log/website_status/failure.log", "w")
    fout_error = File.open("log/website_status/error.log", "w")
    all_museums = Museum.all
    all_museums.each do |museum|
      puts museum.id
      puts museum.name
      puts museum.website
      begin
        uri = URI.parse(museum.website)
        request = Net::HTTP.get_response(uri)
        if request != nil
          if request.code.to_s == "200"
            fout_success.write(museum.id.to_s + "\n" + museum.name + "\n" +
              museum.website + "\n" + request.code.to_s + "\n\n")
          else
            fout_fail.write(museum.id.to_s + "\n" + museum.name + "\n" +
              museum.website + "\n" + request.code.to_s + "\n\n")
          end
        end
      rescue Exception => e
        fout_error.write(museum.id.to_s + "\n" + museum.name + "\n" +
            museum.website + "\n\n")
      end
    end
    fout_success.close
    fout_fail.close
    fout_error.close

  end

  task :manual_update_website => :environment do
    fin_fail = File.open("log/website_status/failure.log", "r")
    fin_error = File.open("log/website_status/error.log", "r")

    fin_fail.each_line.with_index do |line, i|
      puts i % 5
      puts line
    end

    fin_error.each_line.with_index do |line, i|
      puts i % 4
      puts line
    end
  end
end