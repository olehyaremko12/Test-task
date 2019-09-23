# frozen_string_literal: true

RSpec.describe Interactors::EncryptAndDecryptMessage do
  let(:interactor) { Interactors::EncryptAndDecryptMessage.new }
  let(:result_encrypt) { interactor.encrypt(attribute_encrypt) }
  let(:result_decrypt) do
    interactor.decrypt(attribute_decrypt[:text], attribute_decrypt[:i_v])
  end
  let(:attribute_encrypt) { Hash[text: 'Text'] }
  let(:attribute_decrypt) do
    Hash[text: result_encrypt, i_v: attribute_encrypt[:iv]]
  end

  context 'encrypt and decrypt message' do
    it 'encrypt message' do
      expect(result_encrypt).to be_kind_of(String)
    end

    it 'decrypt message' do
      expect(result_decrypt).to eq('Text')
    end
  end
end
