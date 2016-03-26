require_relative '../test_helper'

class TaskManagerTest < Minitest::Test
  include TestHelpers
  def test_it_creates_a_task
    create_tasks(1)

    task = task_manager.all.last
    assert_equal "Task Title 1", task.title
    assert_equal "Task Description 1", task.description
  end

  def test_it_returns_all_tasks
    create_tasks(3)

    all = task_manager.all

    assert_equal Array, all.class
    assert_equal 3, all.length
    assert_equal Task, all[0].class
    assert_equal "Task Title 1", all[0].title
    assert_equal "Task Title 2", all[1].title
    assert_equal "Task Title 3", all[2].title
  end

  def test_it_finds_a_specific_task
    create_tasks(3)

    task = task_manager.all[-3]
    assert_equal "Task Title 1", task.title
    assert_equal "Task Description 1", task.description

    task = task_manager.all[-2]
    assert_equal "Task Title 2", task.title
    assert_equal "Task Description 2", task.description

    task = task_manager.all.last
    assert_equal "Task Title 3", task.title
    assert_equal "Task Description 3", task.description
  end

  def test_it_updates_a_task
    create_tasks(1)

    before = task_manager.all.last
    assert_equal "Task Title 1", before.title
    assert_equal "Task Description 1", before.description

    changes = {:title => "a changed title", :description => "a changed description"}
    task_manager.update(before.id, changes)

    after = task_manager.all.last
    assert_equal "a changed title", after.title
    assert_equal "a changed description", after.description
  end

  def test_it_destroys_a_task
    create_tasks(3)

    all = task_manager.all
    assert_equal 3, all.length
    assert all.any?{|task| task.title == "Task Title 3"}
    assert all.any?{|task| task.title == "Task Title 2"}
    assert all.any?{|task| task.title == "Task Title 1"}

    task_manager.destroy(all[-2].id)
    all = task_manager.all
    assert_equal 2, all.length
    assert all.any?{|task| task.title == "Task Title 3"}
    refute all.any?{|task| task.title == "Task Title 2"}

  end
end
