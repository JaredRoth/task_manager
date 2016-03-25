require_relative '../test_helper'

class UserCanEditAnExistingTask < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_existing_task_is_updated_with_new_information
    task_manager.create({ title: 'Original Title',
                         description: 'Original Description' })

    visit '/tasks/1/edit'

    fill_in 'task[title]', with: 'Updated Title'
    fill_in 'task[description]', with: 'Updated Description'
    click_button 'Save Changes'

    assert_equal '/tasks/1', current_path

    within 'h3' do
      assert page.has_content? 'Updated Title'
    end

    within 'p' do
      assert page.has_content? 'Updated Description'
    end
  end
end
