require 'spec_helper'

describe LineLog::Formatters::KeyValue do
  let(:options) do
    {
      custom: 'random',
      status: 200,
      method: 'GET',
      path: '/my_path'
    }
  end

  subject { described_class.new.call(options) }

  it "includes the 'method' key/value" do
    expect(subject).to include('method=GET')
  end

  it "includes the 'path' key/value" do
    expect(subject).to include('path=/my_path')
  end

  it "includes the 'status' key/value" do
    expect(subject).to include('status=200')
  end

  it "includes the 'custom' key/value" do
    expect(subject).to include('custom=random')
  end
end