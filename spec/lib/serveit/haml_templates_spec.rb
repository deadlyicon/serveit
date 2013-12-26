require 'spec_helper'

describe Serveit::HamlTemplates do

  def app
    @app ||= Rack::Builder.new do
      use Serveit::HamlTemplates, root: TEST_APP_ROOT
      run Serveit::NotFound
    end
  end

  it "works" do
    response = get '/about.html'
    expect( response.status  ).to eq 200
    expect( response.body    ).to eq "<h1>About page</h1>\n"
    expect( response.headers ).to eq("Content-Length"=>"20")
  end

end
