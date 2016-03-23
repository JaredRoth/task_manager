require_relative '../test_helper'

class TaskManagerTest < Minitest::Test
  include TestHelpers
  def test_it_creates_a_task
    task_manager.create({
      :title       => "a title",
      :description => "a description"
    })

    task = task_manager.find(1)
    assert_equal "a title", task.title
    assert_equal "a description", task.description
    assert_equal 1, task.id
  end

  def test_it_returns_all_tasks
    task_manager.create({
      :title       => "a title",
      :description => "a description"
    })
    task_manager.create({
      :title       => "another title",
      :description => "another description"
    })
    task_manager.create({
      :title       => "a third title",
      :description => "a third description"
    })

    all = task_manager.all

    assert_equal Array, all.class
    assert_equal 3, all.length
    assert_equal Task, all[0].class
    assert_equal "a title", all[0].title
    assert_equal "another title", all[1].title
    assert_equal "a third title", all[2].title
  end

  def test_it_finds_a_specific_task
    task_manager.create({
      :title       => "a title",
      :description => "a description"
    })
    task_manager.create({
      :title       => "another title",
      :description => "another description"
    })
    task_manager.create({
      :title       => "a third title",
      :description => "a third description"
    })

    task = task_manager.find(1)
    assert_equal "a title", task.title
    assert_equal "a description", task.description

    task = task_manager.find(2)
    assert_equal "another title", task.title
    assert_equal "another description", task.description

    task = task_manager.find(3)
    assert_equal "a third title", task.title
    assert_equal "a third description", task.description
  end

  def test_it_updates_a_task
    task_manager.create({
      :title       => "a title",
      :description => "a description"
    })

    before = task_manager.find(1)
    assert_equal "a title", before.title
    assert_equal "a description", before.description

    changes = {:title => "a changed title", :description => "a changed description"}
    task_manager.update(1, changes)

    after = task_manager.find(1)
    assert_equal "a changed title", after.title
    assert_equal "a changed description", after.description
  end

  def test_it_deletes_a_task
    task_manager.create({
      :title       => "a title",
      :description => "a description"
    })
    task_manager.create({
      :title       => "another title",
      :description => "another description"
    })
    task_manager.create({
      :title       => "a third title",
      :description => "a third description"
    })

    all = task_manager.all
    assert_equal 3, all.length
    assert_equal "a third title", all[2].title
    assert_equal "another title", all[1].title

    task_manager.destroy(2)
    all = task_manager.all
    assert_equal 2, all.length
    assert_equal "a third title", all[1].title
    assert_equal "a title", all[0].title

  end
end
