#!/usr/bin/ruby

require 'digest/md5'
require 'net/http'
require 'uri'
require 'json'

  
class Client
  attr_accessor :name, :password, :cookie
  
  def initialize(name, password)
    self.name = name
    self.password = password
    self.login()
  end
  #login is a simple ajax get call
  #his aim is to get the cookie for log 
  def login
    pass = Digest::MD5.hexdigest(password)
    #url as described before
    uri = URI("http://real-debrid.fr/ajax/login.php?user=#{name}&pass=#{pass}&captcha_challenge=&captcha_answer=&time="+Time.now.to_i.to_s)
    req = Net::HTTP::Get.new(uri.request_uri)
    req['User-Agent'] = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:8.0.1) Gecko/20100101 Firefox/8.0.1'
    
    res = Net::HTTP.start(uri.hostname, uri.port) {|http|
      http.request(req)
    }
    self.cookie= res['Set-Cookie']
    puts "--Logged"
  end
  #whith this metod you transform your normal link into a premium link
  def getLink(link)
    link = URI.escape(link, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    uri = URI("http://real-debrid.fr/ajax/unrestrict.php?link=#{link}&password=&remote=0&time="+Time.now.to_i.to_s)
    req = Net::HTTP::Get.new(uri.request_uri)
    req['User-Agent'] = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:8.0.1) Gecko/20100101 Firefox/8.0.1'
    req['Cookie'] = self.cookie
    res = Net::HTTP.start(uri.hostname, uri.port) {|http|
      http.request(req)
    }
    risposta = JSON.parse(res.body)
    risposta['generated_links'] = risposta['generated_links'].slice(/http:\/\/(.)+/i)
    #puts risposta['generated_links']
    return risposta 
  end
  
  #just clean the cookie
  def logout
    self.cookie= nil
  end

end
