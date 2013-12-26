require 'spec_helper'

describe Serveit::InferExtension do

  def app
    @app ||= Rack::Builder.new do
      use Serveit::InferExtension
      use Serveit::Static, root: TEST_APP_ROOT
      run Serveit::NotFound
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

  context 'GET /contact/' do
    it "renders /contact/index.html as a 200" do
      response = get '/contact/'
      expect( response.status  ).to eq 200
      expect( response.body    ).to eq "<h1>Contact Page:<h1>\n"
      expect( response.headers['Content-Type']   ).to eq 'text/html'
      expect( response.headers['Content-Length'] ).to eq '22'
      expect( response.headers['Last-Modified']  ).to_not be_nil
    end
  end

  context 'GET /contact/index' do
    it "renders /contact/index.html as a 200" do
      response = get '/contact/index'
      expect( response.status  ).to eq 200
      expect( response.body    ).to eq "<h1>Contact Page:<h1>\n"
      expect( response.headers['Content-Type']   ).to eq 'text/html'
      expect( response.headers['Content-Length'] ).to eq '22'
      expect( response.headers['Last-Modified']  ).to_not be_nil
    end
  end

  context 'GET /contact/index.html' do
    it "renders /contact/index.html as a 200" do
      response = get '/contact/index.html'
      expect( response.status  ).to eq 200
      expect( response.body    ).to eq "<h1>Contact Page:<h1>\n"
      expect( response.headers['Content-Type']   ).to eq 'text/html'
      expect( response.headers['Content-Length'] ).to eq '22'
      expect( response.headers['Last-Modified']  ).to_not be_nil
    end
  end

  context 'GET /contact/address' do
    it "renders /contact/address.html as a 200" do
      response = get '/contact/address'
      expect( response.status  ).to eq 200
      expect( response.body    ).to eq "<h1>Our Address</h1>\n"
      expect( response.headers['Content-Type']   ).to eq 'text/html'
      expect( response.headers['Content-Length'] ).to eq '21'
      expect( response.headers['Last-Modified']  ).to_not be_nil
    end
  end

  context 'GET /contact/address.html' do
    it "renders /contact/address.html as a 200" do
      response = get '/contact/address.html'
      expect( response.status  ).to eq 200
      expect( response.body    ).to eq "<h1>Our Address</h1>\n"
      expect( response.headers['Content-Type']   ).to eq 'text/html'
      expect( response.headers['Content-Length'] ).to eq '21'
      expect( response.headers['Last-Modified']  ).to_not be_nil
    end
  end


end
