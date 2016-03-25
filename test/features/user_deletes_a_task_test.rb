require_relative '../test_helper'

class UserCanDeleteAnExistingTask < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_existing_task_is_deleted_successfully
    task_manager.create({
      title: 'Original Title',
      description: 'Original Description'
    })

    visit '/tasks'
    assert page.has_content? 'Original Title'

    click_button 'Remove Task'

    refute page.has_content? 'Original Title'
  end
end
