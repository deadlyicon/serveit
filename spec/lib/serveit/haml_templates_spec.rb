require 'spec_helper'

describe Serveit::HamlTemplates do

  def app
    @app ||= Rack::Builder.new do
      use Rack::Lint
      use Serveit::HamlTemplates, root: TEST_APP_ROOT
      run Serveit::NotFound
    end
  end

  context 'when given a path that matches a files basename and extension' do
    it "renders the hamle template and returns a 200 ok" do
      response = get '/about.html'
      expect( response.status  ).to eq 200
      expect( response.body    ).to eq "<h1>About page</h1>\n"
      expect( response.headers ).to eq(
        'Content-Type'   => 'text/html',
        'Content-Length' => '20',
      )
    end
  end

end
