require_relative("../db/sql_runner.rb")

class Customer

  attr_reader :id
  attr_accessor :name, :wallet

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @wallet = options['wallet'].to_i()
  end

  def save()
    sql = "INSERT INTO customers
    (name, wallet)
    VALUES ($1, $2)
    RETURNING id"
    values = [@name, @wallet]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    values = []
    customers = SqlRunner.run(sql, values)
    result = customers.map { |customer| Customer.new(customer) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE * FROM customers WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE customers SET (name, wallet) = ($1, $2) WHERE id = $3"
    values = [@name, @wallet, @id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def films_booked()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE tickets.customer_id = $1"
    values = [@id]
    film_array = SqlRunner.run(sql, values)
    films_booked = film_array.map {|film_hash| Film.new(film_hash)}
    return films_booked
  end

  def film_count()
    sql = "SELECT COUNT (films.*) FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE tickets.customer_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    film_count = result[0]
    return film_count
  end

  def decrease_wallet(film)
    @wallet -= film.price
  end

  def buy_ticket(film)
    decrease_wallet(film)
    update
  end

end
