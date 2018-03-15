require 'spec_helper'
require 'logger'

describe LineLog::Customizer do
  let(:app) { ->(env) { [200, env, "app"] } }
  let(:file) { "#{fixtures_path}/log.txt" }
  let(:logger) { Logger.new(file) }
  let(:event) do
    {
      'REQUEST_METHOD' => 'GET',
      'HTTP_ACCEPT' => 'text/html',
      'HTTP_X_REAL_IP' => '127.0.0.1',
      'REQUEST_PATH' => '/happy_path?param1=maybe'
    }
  end
  
  let :middleware do
    LineLog::Customizer.new(app, logger)
  end

  subject { middleware.call(event) }

  before(:each) do 
    LineLog::Customizer.data = { custom: 'random'}
    subject
  end

  after { File.open(file, 'w') {} }

  it { expect(IO.read(file)).to include("method='GET'") }

  it { expect(IO.read(file)).to include("path='/happy_path'") }

  it { expect(IO.read(file)).to include("format='text/html'") }

  it { expect(IO.read(file)).to include("ip='127.0.0.1'") }

  it { expect(IO.read(file)).to include('status=200') }

  it { expect(IO.read(file)).to include('duration=0.00') }

  it { expect(IO.read(file)).to include("custom='random'") }
end