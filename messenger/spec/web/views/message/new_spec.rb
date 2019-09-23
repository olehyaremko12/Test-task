# frozen_string_literal: true

RSpec.describe Web::Views::Message::New, type: :view do
  let(:exposures) { Hash[format: :html] }
  let(:template)  do
    Hanami::View::Template
      .new('apps/web/templates/message/new.html.erb')
  end
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    expect(view.format).to eq exposures.fetch(:format)
  end

  it 'format safelink' do
    expect(view.generate_safe_link).to be_kind_of(String)
  end
end
