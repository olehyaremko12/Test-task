# frozen_string_literal: true

require 'features_helper'

RSpec.describe 'Create Message', js: true do
  it 'check content' do
    visit '/'

    expect(page).to have_content('Add message')
    expect(page).to have_content('Text')
    expect(page).to have_field('Password')
    expect(page).to have_content('Password')
    expect(page).to have_field('Text')
    expect(page).to have_content('Destroy after 1 visit')
    expect(page).to have_content('Destroy after 1 hour')
    expect(page).to have_selector('#btn_create', visible: false)
  end

  let(:last_repository) { MessageRepository.new.last }
  let(:link) do
    "Your safe link: http://localhost:2300/message/#{last_repository.safelink}"
  end

  context 'create and show message when check checkbox destroy after 1 visit' do
    it 'create message' do
      visit '/'

      fill_in 'Text', with: 'Some amazing message'
      fill_in 'Password', with: 'Password'

      check 'destroy_after_1_visit'

      click_button 'Create Message'

      expect(page).to have_current_path('/message')
      expect(page).to have_content('Message was created')
      expect(page).to have_content('Some amazing message')
      expect(page).to have_content('Password')
      expect(page).to have_content('Password to see message:')
      expect(page).to have_content(link)
    end

    it 'show message' do
      visit "/message/#{last_repository.safelink}"

      fill_in 'confirm_password', with: 'Password'

      click_button('Show message')

      expect(page).to have_selector('#content', visible: false)

      visit "/message/#{last_repository.safelink}"

      expect(page).to have_content('Wrong url')
    end
  end

  context 'create and show message when check checkbox destroy after 1 hour' do
    it 'create message' do
      visit '/'

      fill_in 'Text', with: 'Some amazing message'
      fill_in 'Password', with: 'Password'

      check 'destroy_after_1_hour'

      click_button 'Create Message'
    end

    it 'show message' do
      visit "/message/#{last_repository.safelink}"

      fill_in 'confirm_password', with: 'Password'

      click_button('Show message')

      expect(page).to have_selector('#content', visible: false)

      Timecop.travel(Date.today + 3700) do
        visit "/message/#{last_repository.safelink}"

        expect(page).to have_content('Wrong url')
      end
    end
  end

  context 'create and show message when put hours in field' do
    it 'create message' do
      visit '/'

      fill_in 'Text', with: 'Some amazing message'
      fill_in 'Password', with: 'Password'
      fill_in 'destroy_after_hours', with: 2

      click_button 'Create Message'
    end

    it 'show message' do
      visit "/message/#{last_repository.safelink}"

      fill_in 'confirm_password', with: 'Password'

      click_button('Show message')

      expect(page).to have_selector('#content', visible: false)

      Timecop
        .travel(Date.today + (3700 * last_repository.destroy_after_hours)) do
        visit "/message/#{last_repository.safelink}"

        expect(page).to have_content('Wrong url')
      end
    end
  end
end
