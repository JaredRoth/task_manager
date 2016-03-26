require_relative '../test_helper'

class TaskTest < Minitest::Test
  include TestHelpers
  def test_assigns_attributes_correctly
    create_tasks(1)
    task = task_manager.all.last

    assert_equal "Task Title 1", task.title
    assert_equal "Task Description 1", task.description
  end
end
