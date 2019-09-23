# frozen_string_literal: true

RSpec.describe Web::Views::Message::Create, type: :view do
  let(:exposures) { Hash[format: :html] }
  let(:template)  do
    Hanami::View::Template
      .new('apps/web/templates/message/create.html.erb')
  end
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }
  let(:params) do
    Hash[message: { text: 'text', password: 'Password', safelink: 'safelink', iv: 'iv' }]
  end
  let(:repository) { MessageRepository.new }

  before do
    repository.clear

    repository.create(params[:message])
  end

  it 'exposes #format' do
    expect(view.format).to eq exposures.fetch(:format)
  end
end
