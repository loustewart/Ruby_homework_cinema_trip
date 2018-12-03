require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')

require('pry-byebug')

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({'name' => 'Bob', 'wallet' => '50'})
customer1.save()
customer2 = Customer.new({'name' => 'Jim', 'wallet' => '35'})
customer2.save()
customer3 = Customer.new({'name' => 'Lucy', 'wallet' => '45'})
customer3.save()


film1 = Film.new({'title' => 'Highlander', 'price' => 5})
film1.save()
film2 = Film.new({'title' => 'Back to the Future', 'price' => 6})
film2.save()
film3 = Film.new({'title' => 'Jaws', 'price' => 4})
film3.save()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()
ticket2 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film3.id})
ticket2.save()
ticket3 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
ticket3.save()
ticket4 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film3.id})
ticket4.save()


binding.pry
nil
