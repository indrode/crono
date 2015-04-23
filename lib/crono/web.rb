require 'haml'
require 'sinatra/base'
require 'crono'

module Crono
  # Web is a Web UI Sinatra app
  class Web < Sinatra::Base
    set :root, File.expand_path(File.dirname(__FILE__) + '/../../web')
    set :public_folder, proc { "#{root}/assets" }
    set :views, proc { "#{root}/views" }

    use Rack::Auth::Basic, "Restricted Area" do |username, password|
      username == ENV['CRONO_USER'] and password == ENV['CRONO_PW']
    end

    get '/' do
      @jobs = Crono::CronoJob.all
      haml :dashboard, format: :html5
    end

    get '/log' do
      logfile = Crono::Config.new.logfile
      @log = File.file?(logfile) ? File.read(logfile) : 'Logfile does not exist'
      haml :log
    end

    get '/job/:id' do
      @job = Crono::CronoJob.find(params[:id])
      haml :job
    end
  end
end
