require 'spec_helper'
require 'logger'

describe LineLog::Writer do
  let(:message) { 'this is my message'}
  let(:file) { "#{fixtures_path}/log.txt" }

  subject { described_class.call(message, Logger.new(file)) }

  after { File.open(file, 'w') {} }

  it 'includes the \'method\' key/value' do
    subject
    expect(IO.read(file)).to include('this is my message')
  end
end