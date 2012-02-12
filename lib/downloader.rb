#!/usr/bin/ruby

require 'open-uri'

class Downloader
  attr_accessor :client, :pbar, :t
  
  #the NEW function of the Downloader
  def initialize(name, password, file_path)
    self.client = Client::new(name, password)
    self.download(file_path)
  end
  
  def download(file_path)
    unless File.exists?(file_path)
      puts "Link file not found"
    end
    
    File.open(file_path, 'r') do |f|
      while line = f.gets
        #some kind of initialisation 
        obj = self.client.getLink(line)
        puts "--Start downloading #{obj['link']}"
        
        open(obj['file_name'], 'w'){ |file|
          file.write(open(obj['generated_links'], :content_length_proc => lambda {|t|
            self.t = t
          },
          :progress_proc => lambda {|s| 
            unless s == 0
              pbar = s * 100/self.t
              unless pbar == self.pbar
                self.pbar = pbar
                 print " #{pbar}%"
              end
            end
          }).read)
        }
        puts "--Done #{obj['file_name']}"
      end
    end
  end
end