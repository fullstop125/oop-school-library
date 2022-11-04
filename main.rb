require_relative './app'

@functions = App.new

def menu
  print "Welcome to OOP School Library App:
1. List all books
2. List all people
3. Create a person
4. Create a book
5. Create a rental
6. List all rentals for a given person id
7. Exit
Choose (1-7)
"
end

def choose_by_user
  gets.chomp.to_i
end

def input_match(menu)
  case menu
  when 1
    @functions.list_all_book
  when 2
    @functions.list_all_people
  when 3
    @functions.create_a_person
  when 4
    @functions.create_new_book
  when 5
    @functions.create_new_rental
  when 6
    @functions.list_rental_by_id
  when 7
    @functions.exit_app
  else
    puts 'Invalid Choice'
  end
end

def main(status)
  loop do
    break unless status

    menu
    user_input = choose_by_user
    input_match(user_input)
  end
end

main(true)
