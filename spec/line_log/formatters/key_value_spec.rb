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

  it { expect(subject).to include('method=GET') }

  it { expect(subject).to include('path=/my_path') }

  it { expect(subject).to include('status=200') }

  it { expect(subject).to include('custom=random') }
end