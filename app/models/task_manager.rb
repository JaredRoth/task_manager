require 'yaml/store'

class TaskManager
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(task)
    database.from(:tasks).insert(task)
  end

  def raw_tasks
    database.from(:tasks)
  end

  def all
    raw_tasks.map { |data| Task.new(data)}
  end

  def raw_task(id)
    database.from(:tasks).where(:id => id).to_a.first
  end

  def find(id)
    Task.new(raw_task(id))
  end

  def update(id, task)
    database.from(:tasks).where(:id => id).update(task)
  end

  def destroy(id)
    database.from(:tasks).where(:id => id).delete
  end

  def delete_all
    database.from(:tasks).delete
  end
end
