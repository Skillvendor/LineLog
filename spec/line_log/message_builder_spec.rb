require 'spec_helper'

describe LineLog::MessageBuilder do
  let(:event) do
    {
      'REQUEST_METHOD' => 'GET',
      'HTTP_ACCEPT' => 'text/html',
      'HTTP_X_REAL_IP' => '127.0.0.1',
      'REQUEST_PATH' => '/happy_path?param1=maybe'
    }
  end
  let(:status) { 200 }
  let(:began_at) { Time.parse('2018-03-13 16:21:23 +0000') }

  subject { described_class.new(event, status, began_at).call }

  before(:each) do 
    allow(Time).to receive(:now).and_return(Time.parse('2018-03-13 16:21:25 +0000'))

    LineLog::Customizer.data = { custom: 'random random' }
    LineLog::Customizer.formatter = LineLog::Formatters::KeyValue.new
  end

  it { expect(subject).to include("method='GET'") }

  it { expect(subject).to include("path='/happy_path'") }

  it { expect(subject).to include('status=200') }

  it { expect(subject).to include('duration=2.00') }

  it { expect(subject).to include("format='text/html'") }

  it { expect(subject).to include("ip='127.0.0.1'") }

  it { expect(subject).to include("custom='random random'") }
end