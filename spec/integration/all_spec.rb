require 'spec_helper'
require 'haml'

describe 'all together now' do

  def app
    @app ||= Rack::Builder.new do
      use Serveit::InferIndex, root: TEST_APP_ROOT
      use Serveit::InferExtension, root: TEST_APP_ROOT
      use Serveit::HamlTemplates, root: TEST_APP_ROOT
      use Serveit::Static, root: TEST_APP_ROOT
      run Serveit::NotFound
    end
  end

  subject do
    response = get(self.class.description)
    [response.status, response.headers.to_hash, response.body]
  end

  # alias_method :response, :last_responce

  def not_found
    [404, {"Content-Type"=>"text/plain"}, ""]
  end

  def static_file path
    path = TEST_APP_ROOT + path
    body = File.read(path)
    headers = {
      "Last-Modified"  => File.mtime(path).httpdate,
      "Content-Type"   => Rack::Mime.mime_type(File.extname(path), 'text/plain'),
      "Content-Length" => body.size.to_s,
    }
    [200, headers, body]
  end

  def haml_tamplate path
    path = TEST_APP_ROOT + path
    body = Haml::Engine.new(File.read(path)).render
    headers = {
      "Content-Type"   => "text/html",
      "Content-Length" => body.size.to_s,
    }
    [200, headers, body]
  end

  describe '/about' do
    it { should eq haml_tamplate '/about.html.haml' }
  end

  describe '/about.html' do
    it { should eq haml_tamplate '/about.html.haml' }
  end

  describe '/about.html.haml' do
    it { should eq not_found }
  end

  describe '/about/' do
    it { should eq not_found }
  end

  describe '/contact' do
    it { should eq static_file '/contact.html' }
  end

  describe '/contact.html' do
    it { should eq static_file '/contact.html' }
  end

  describe '/contact/' do
    it { should eq static_file '/contact/index.html' }
  end

  describe '/contact/address' do
    it { should eq static_file '/contact/address.html' }
  end

  describe '/contact/address.html' do
    it { should eq static_file '/contact/address.html' }
  end

  describe '/contact/address/' do
    it { should eq not_found }
  end

  describe '/contact/index' do
    it { should eq not_found }
  end

  describe '/contact/index.html' do
    it { should eq not_found }
  end

  describe '/contact/index/' do
    it { should eq not_found }
  end

  # describe '/hitch' do
  #   it { should eq not_found }
  # end

  # describe '/hitch.JPG' do
  #   it { should eq not_found }
  # end

  # describe '/hitch/' do
  #   it { should eq not_found }
  # end

  describe '/index' do
    it { should eq not_found }
  end

  describe '/index.css' do
    it { should eq not_found }
  end

  describe '/index.css.sass' do
    it { should eq not_found }
  end

  describe '/' do
    it { should eq haml_tamplate '/index.html.haml' }
  end

  describe '/index.html' do
    it { should eq not_found }
  end

  describe '/index.html.haml' do
    it { should eq not_found }
  end

  describe '/index.js' do
    it { should eq not_found }
  end

  describe '/index.rb' do
    it { should eq not_found }
  end

  describe '/index/' do
    it { should eq not_found }
  end

  describe '/posts' do
    it { should eq haml_tamplate '/posts/index.html.haml' }
  end

  describe '/posts/' do
    it { should eq haml_tamplate '/posts/index.html.haml' }
  end

  describe '/posts/index' do
    it { should eq not_found }
  end

  describe '/posts/index.css' do
    it { should eq not_found } # this should render from sass in the future
  end

  describe '/posts/index.css.sass' do
    it { should eq not_found }
  end

  describe '/posts/index.html' do
    it { should eq not_found }
  end

  describe '/posts/index.html.haml' do
    it { should eq not_found }
  end

  describe '/posts/index.js' do
    it { should eq not_found }
  end

  describe '/posts/index.rb' do
    it { should eq not_found }
  end

  describe '/posts/index/' do
    it { should eq not_found }
  end

  describe '/posts/show' do
    it { should eq haml_tamplate '/posts/show.html.haml' }
  end

  describe '/posts/show.css' do
    it { should eq not_found }
  end

  describe '/posts/show.css.sass' do
    it { should eq static_file '/posts/show.css.sass' }
  end

  describe '/posts/show.html' do
    it { should eq haml_tamplate '/posts/show.html.haml' }
  end

  describe '/posts/show.html.haml' do
    it { should eq not_found }
  end

  describe '/posts/show.js' do
    it { should eq static_file '/posts/show.js' }
  end

  describe '/posts/show.rb' do
    it { should eq static_file '/posts/show.rb' }
  end

  describe '/posts/show/' do
    it { should eq not_found }
  end



  # context '/contact.html' do
  #   it "renders /contact.html as a 200" do

  #     # response = get '/contact.html'
  #     # expect( response.status  ).to eq 200
  #     # expect( response.body    ).to eq "<h1>Contact us at:</h1>\n"
  #     # expect( response.headers['Content-Type']   ).to eq 'text/html'
  #     # expect( response.headers['Content-Length'] ).to eq '24'
  #     # expect( response.headers['Last-Modified']  ).to_not be_nil
  #   end
  # end

  # context '/contact' do
  #   it "renders /contact.html as a 200" do
  #     response = get '/contact'
  #     expect( response.status  ).to eq 200
  #     expect( response.body    ).to eq "<h1>Contact us at:</h1>\n"
  #     expect( response.headers['Content-Type']   ).to eq 'text/html'
  #     expect( response.headers['Content-Length'] ).to eq '24'
  #     expect( response.headers['Last-Modified']  ).to_not be_nil
  #   end
  # end

  # context '/contact/' do
  #   it "renders /contact/index.html as a 200" do
  #     response = get '/contact/'
  #     expect( response.status  ).to eq 200
  #     expect( response.body    ).to eq "<h1>Contact Page:<h1>\n"
  #     expect( response.headers['Content-Type']   ).to eq 'text/html'
  #     expect( response.headers['Content-Length'] ).to eq '22'
  #     expect( response.headers['Last-Modified']  ).to_not be_nil
  #   end
  # end

  # context '/contact/index' do
  #   it "renders /contact/index.html as a 200" do
  #     response = get '/contact/index'
  #     expect( response.status  ).to eq 200
  #     expect( response.body    ).to eq "<h1>Contact Page:<h1>\n"
  #     expect( response.headers['Content-Type']   ).to eq 'text/html'
  #     expect( response.headers['Content-Length'] ).to eq '22'
  #     expect( response.headers['Last-Modified']  ).to_not be_nil
  #   end
  # end

  # context '/contact/index.html' do
  #   it "renders /contact/index.html as a 200" do
  #     response = get '/contact/index.html'
  #     expect( response.status  ).to eq 200
  #     expect( response.body    ).to eq "<h1>Contact Page:<h1>\n"
  #     expect( response.headers['Content-Type']   ).to eq 'text/html'
  #     expect( response.headers['Content-Length'] ).to eq '22'
  #     expect( response.headers['Last-Modified']  ).to_not be_nil
  #   end
  # end

  # context '/contact/address' do
  #   it "renders /contact/address.html as a 200" do
  #     response = get '/contact/address'
  #     expect( response.status  ).to eq 200
  #     expect( response.body    ).to eq "<h1>Our Address</h1>\n"
  #     expect( response.headers['Content-Type']   ).to eq 'text/html'
  #     expect( response.headers['Content-Length'] ).to eq '21'
  #     expect( response.headers['Last-Modified']  ).to_not be_nil
  #   end
  # end

  # context '/contact/address.html' do
  #   it "renders /contact/address.html as a 200" do
  #     response = get '/contact/address.html'
  #     expect( response.status  ).to eq 200
  #     expect( response.body    ).to eq "<h1>Our Address</h1>\n"
  #     expect( response.headers['Content-Type']   ).to eq 'text/html'
  #     expect( response.headers['Content-Length'] ).to eq '21'
  #     expect( response.headers['Last-Modified']  ).to_not be_nil
  #   end
  # end


end
