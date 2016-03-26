require 'yaml/store'

class TaskManager
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(task)
    database.from(:tasks).insert(task)
  end

  def all
    database.from(:tasks).map { |data| Task.new(data)}
  end

  def find(id)
    Task.new(database.from(:tasks).where(:id => id).to_a.first)
  end

  def update(id, task)
    database.from(:tasks).where(:id => id).update({:title => task[:title], :description => task[:description]})
  end

  def destroy(id)
    database.from(:tasks).where(:id => id).delete
  end

  def delete_all
    database.from(:tasks).delete
  end
end
