require_relative("../db/sql_runner.rb")
require_relative("./film.rb")
require_relative("./customer.rb")

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id']
  end

  def save()
    sql = "INSERT INTO tickets
    (customer_id, film_id)
    VALUES ($1, $2)
    RETURNING id"
    values = [@customer_id, @film_id]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    values = []
    users = SqlRunner.run(sql, values)
    result = tickets.map { |ticket| Ticket.new(ticket) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE * FROM tickets WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE tickets SET (customer_id, film_id) = ($1, $2) WHERE id = $3"
    values = [@customer_id, @film_id, @id]
    result = SqlRunner.run(sql, values)
    @id = result[0],['id'].to_i
  end

  def customer()
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [@customer_id]
    customer_hash = SqlRunner.run(sql, values)[0]
    customer = Customer.new(customer_hash)
    return customer
  end




end
