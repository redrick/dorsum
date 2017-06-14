module Dorsum
  class Downloader
    def initialize
      @frozen_time ||= Time.now
      @datetime = @frozen_time.strftime("%d-%m-%Y-%H-%M-%S")
    end

    def self.download
      new.download
    end

    def download
      ::Dorsum.configuration.databases.each do |db_name, settings|
        create_dump(db_name, settings)
        ensure_destination(db_name, settings)
        download_dump(db_name, settings)
      end
      true
    end

    private

    def create_dump(db_name, settings)
      puts 'Connecting to remote'
      Net::SSH.start(settings['host'], settings['user']) do |ssh|
        puts 'Creating dump'
        ssh.exec("dokku postgres:export #{settings['container_name']} > /tmp/#{db_name}-#{@datetime}.sql")
      end
      puts 'Dump ready now!'
    end

    def ensure_destination(db_name, settings)
      puts 'Checking destination folder'
      response = FileUtils.mkdir_p("#{settings['destination']}/#{db_name}/#{@frozen_time.year}/#{@frozen_time.month}")
      puts "Destination #{response.first} prepared"
    end

    def download_dump(db_name, settings)
      puts 'Starting download of dump'
      `scp #{settings['user']}@#{settings['host']}:/tmp/#{db_name}-#{@datetime}.sql #{settings['destination']}/#{db_name}/#{@frozen_time.year}/#{@frozen_time.month}/`
      puts 'Dump download finished, you are backed up!'
    end
  end
end
