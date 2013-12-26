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

end
