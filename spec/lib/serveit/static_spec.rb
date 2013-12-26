require 'spec_helper'

describe Serveit::HamlTemplates do

  def app
    @app ||= Rack::Builder.new do
      use Serveit::Static, root: TEST_APP_ROOT
      run Serveit::NotFound
    end
  end

  context 'GET /about.html' do
    it "renders a 404" do
      response = get '/about.html'
      expect( response.status  ).to eq 404
      expect( response.body    ).to eq ""
      expect( response.headers ).to eq("Content-Type"=>"text/plain")
    end
  end

  context 'GET /contact.html' do
    it "renders /contact.html as a 200" do
      response = get '/contact.html'
      expect( response.status  ).to eq 200
      expect( response.body    ).to eq "<h1>Contact us at:</h1>\n"
      expect( response.headers['Content-Type']   ).to eq 'text/html'
      expect( response.headers['Content-Length'] ).to eq '24'
      expect( response.headers['Last-Modified']  ).to_not be_nil
    end
  end

  context 'GET /contact' do
    it "renders /contact.html as a 200" do
      response = get '/contact'
      expect( response.status  ).to eq 200
      expect( response.body    ).to eq "<h1>Contact us at:</h1>\n"
      expect( response.headers['Content-Type']   ).to eq 'text/html'
      expect( response.headers['Content-Length'] ).to eq '24'
      expect( response.headers['Last-Modified']  ).to_not be_nil
    end
  end

  context 'GET /' do
    it "renders a 404" do
      response = get '/'
      expect( response.status  ).to eq 404
      expect( response.body    ).to eq ""
      expect( response.headers ).to eq("Content-Type"=>"text/plain")
    end
  end

  context 'GET /index' do
    it "renders a 404" do
      response = get '/index'
      expect( response.status  ).to eq 404
      expect( response.body    ).to eq ""
      expect( response.headers ).to eq("Content-Type"=>"text/plain")
    end
  end

  context 'GET /index.html' do
    it "renders a 404" do
      response = get '/index.html'
      expect( response.status  ).to eq 404
      expect( response.body    ).to eq ""
      expect( response.headers ).to eq("Content-Type"=>"text/plain")
    end
  end


  context 'GET /index.html.haml' do
    it "renders /index.html.haml as a 200" do
      response = get '/index.html.haml'
      expect( response.status  ).to eq 200
      expect( response.body    ).to eq "%h1 Welcome to my app\n"
      expect( response.headers['Content-Type']   ).to eq 'text/plain'
      expect( response.headers['Content-Length'] ).to eq '22'
      expect( response.headers['Last-Modified']  ).to_not be_nil
    end
  end

end
