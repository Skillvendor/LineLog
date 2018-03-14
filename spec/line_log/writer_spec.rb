require 'spec_helper'
require 'logger'

describe LineLog::Writer do
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
  let(:message_builder) { LineLog::MessageBuilder.new(event, status, began_at) }
  let(:file) { "#{fixtures_path}/log.txt" }

  subject { described_class.call(message_builder, Logger.new(file)) }

  before(:each) do 
    allow(Time).to receive(:now).and_return(Time.parse('2018-03-13 16:21:25 +0000'))

    LineLog::Customizer.options = { custom: 'random' }
    LineLog::Customizer.formatter = LineLog::Formatters::KeyValue.new
  end

  it 'includes the \'method\' key/value' do
    expect(IO.read(file)).to include('method=GET path=/happy_path format=text/html ip=127.0.0.1 status=200 duration=2.00 custom=random')
  end
end