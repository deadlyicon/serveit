require 'spec_helper'

describe Serveit::HamlTemplates do

  def app
    @app ||= Rack::Builder.new do
      use Rack::Lint
      use Serveit::HamlTemplates, root: TEST_APP_ROOT
      run Serveit::NotFound
    end
  end

  context 'GET /about.html' do
    it "renders /about.html.haml as a 200" do
      response = get '/about.html'
      expect( response.status  ).to eq 200
      expect( response.body    ).to eq "<h1>About page</h1>\n"
      expect( response.headers ).to eq(
        'Content-Type'   => 'text/html',
        'Content-Length' => '20',
      )
    end
  end

  context 'GET /about' do
    it "renders /about.html.haml as a 200" do
      response = get '/about'
      expect( response.status  ).to eq 200
      expect( response.body    ).to eq "<h1>About page</h1>\n"
      expect( response.headers ).to eq(
        'Content-Type'   => 'text/html',
        'Content-Length' => '20',
      )
    end
  end

  context 'GET /index.html' do
    it "renders /index.html.haml as a 200" do
      response = get '/index.html'
      expect( response.status  ).to eq 200
      expect( response.body    ).to eq "<h1>Welcome to my app</h1>\n"
      expect( response.headers ).to eq(
        'Content-Type'   => 'text/html',
        'Content-Length' => '27',
      )
    end
  end

  context 'GET /index' do
    it "renders /index.html.haml as a 200" do
      response = get '/index'
      expect( response.status  ).to eq 200
      expect( response.body    ).to eq "<h1>Welcome to my app</h1>\n"
      expect( response.headers ).to eq(
        'Content-Type'   => 'text/html',
        'Content-Length' => '27',
      )
    end
  end

  context 'GET /index.json' do
    it "renders /index.json.rb as a 200" do
      response = get '/about.json'
      expect( response.status  ).to eq 404
      expect( response.body    ).to eq ""
      expect( response.headers ).to eq("Content-Type"=>"text/plain")
    end
  end

  context 'GET /' do
    it "renders /index.html.haml as a 200" do
      response = get '/'
      expect( response.status  ).to eq 200
      expect( response.body    ).to eq "<h1>Welcome to my app</h1>\n"
      expect( response.headers ).to eq(
        'Content-Type'   => 'text/html',
        'Content-Length' => '27',
      )
    end
  end

  context 'GET /posts/index.html' do
    it "renders /posts/index.html.haml as a 200" do
      response = get '/posts/index.html'
      expect( response.status  ).to eq 200
      expect( response.body    ).to eq "<h1>Posts</h1>\n"
      expect( response.headers ).to eq(
        'Content-Type'   => 'text/html',
        'Content-Length' => '15',
      )
    end
  end

  context 'GET /posts/index' do
    it "renders /posts/index.html.haml as a 200" do
      response = get '/posts/index'
      expect( response.status  ).to eq 200
      expect( response.body    ).to eq "<h1>Posts</h1>\n"
      expect( response.headers ).to eq(
        'Content-Type'   => 'text/html',
        'Content-Length' => '15',
      )
    end
  end

  context 'GET /posts/' do
    it "renders /posts/index.html.haml as a 200" do
      response = get '/posts/'
      expect( response.status  ).to eq 200
      expect( response.body    ).to eq "<h1>Posts</h1>\n"
      expect( response.headers ).to eq(
        'Content-Type'   => 'text/html',
        'Content-Length' => '15',
      )
    end
  end

  context 'GET /posts' do
    it "renders /posts/index.html.haml as a 200" do
      response = get '/posts'
      expect( response.status  ).to eq 200
      expect( response.body    ).to eq "<h1>Posts</h1>\n"
      expect( response.headers ).to eq(
        'Content-Type'   => 'text/html',
        'Content-Length' => '15',
      )
    end
  end

  context 'GET /posts/show.html' do
    it "renders /posts/show.html.haml as a 200" do
      response = get '/posts/show.html'
      expect( response.status  ).to eq 200
      expect( response.body    ).to eq "<h1>Post 14</h1>\n"
      expect( response.headers ).to eq(
        'Content-Type'   => 'text/html',
        'Content-Length' => '17',
      )
    end
  end

  context 'GET /posts/show/' do
    it "renders /posts/show.html.haml as a 200" do
      response = get '/posts/show/'
      expect( response.status  ).to eq 200
      expect( response.body    ).to eq "<h1>Post 14</h1>\n"
      expect( response.headers ).to eq(
        'Content-Type'   => 'text/html',
        'Content-Length' => '17',
      )
    end
  end

  context 'GET /posts/show' do
    it "renders /posts/show.html.haml as a 200" do
      response = get '/posts/show'
      expect( response.status  ).to eq 200
      expect( response.body    ).to eq "<h1>Post 14</h1>\n"
      expect( response.headers ).to eq(
        'Content-Type'   => 'text/html',
        'Content-Length' => '17',
      )
    end
  end

end
