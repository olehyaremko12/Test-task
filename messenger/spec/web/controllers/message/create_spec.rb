# frozen_string_literal: true

RSpec.describe Web::Controllers::Message::Create do
  let(:action) { described_class.new }
  let(:params) do
    Hash[message:
                  { text: 'some text', safelink: 'safelink', password: 'password' }]
  end
  let(:repository) { MessageRepository.new }

  before do
    repository.clear
  end

  it 'creates a new message' do
    action.call(params)
    message = repository.last
    expect(message.id).to_not be_nil
    expect(message.text).to be_kind_of(String)
    expect(message.safelink).to eq('safelink')
    expect(message.destroy_after_1_hour).to eq(2)
    expect(message.destroy_after_1_visit).to eq(2)
    expect(message.iv).to be_kind_of(String)
  end

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
