require_relative("../db/sql_runner.rb")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i()
  end

  def save()
    sql = "INSERT INTO films
    (title, price)
    VALUES ($1, $2)
    RETURNING id"
    values = [@title, @price]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    values = []
    users = SqlRunner.run(sql, values)
    result = films.map { |film| Film.new(film) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE * FROM films WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    result = SqlRunner.run(sql, values)
    @id = result[0],['id'].to_i
  end


end
