require 'spec_helper'

describe LineLog::RequestDataExtractor do
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
  
  def extracted_data(extra_options={})
    {
      method: 'GET',
      path: '/happy_path',
      format: 'text/html',
      ip: '127.0.0.1',
      status: 200,
      duration: 2.00
    }.merge!(extra_options)
  end
  subject { described_class.call(event, status, began_at) }

  shared_examples 'request data extractor' do |custom_data|
    it 'extracts data correctly' do
      expect((extracted_data(custom_data).to_a - subject.to_a).empty?).to eq(true)
    end
  end

  before { allow(Time).to receive(:now).and_return(Time.parse('2018-03-13 16:21:25 +0000')) }

  context 'no custom data is present' do
    it_behaves_like 'request data extractor', {}
  end

  context 'custom data is present' do
    let(:extra_log_params) do
      { 
        custom_param1: 'random1',
        custom_param2: 'random2'
      }
    end
    before { LineLog::Customizer.options = extra_log_params }

    it_behaves_like 'request data extractor', { custom_param1: 'random1', custom_param2: 'random2' }
  end
end