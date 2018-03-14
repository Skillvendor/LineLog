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

  before { LineLog::Customizer.options = { custom: 'random'} }

  after { File.open(file, 'w') {} }

  it 'includes the \'method\' key/value' do
    subject
    expect(IO.read(file)).to include('method=GET')
  end

  it 'includes the \'path\' key/value' do
    subject
    expect(IO.read(file)).to include('path=/happy_path')
  end

  it 'includes the \'format\' key/value' do
    subject
    expect(IO.read(file)).to include('format=text/html')
  end

  it 'includes the \'ip\' key/value' do
    subject
    expect(IO.read(file)).to include('ip=127.0.0.1')
  end

  it 'includes the \'status\' key/value' do
    subject
    expect(IO.read(file)).to include('status=200')
  end

  it 'includes the \'duration\' key/value' do
    subject
    expect(IO.read(file)).to include('duration=0.00')
  end

  it 'includes the \'custom\' key/value' do
    subject
    expect(IO.read(file)).to include('custom=random')
  end
end