require './person'
require './student'
require './teacher'
require './rental'
require './book'
require './classroom'
require './nameable'
require './decorator'
require './capitalizedecorator'
require './trimmerdecorator'

class App
  attr_accessor :people, :book, :rental

  def initialize
    @people = []
    @person = nil
    @rentals = []
    @books = []
    @book = nil
  end

  def list_all_book
    if @books.length.zero?
      puts 'You do not have any books'
    else
      @books.each_with_index do |book, index|
        puts "#{index}) Title: #{book.title}, Author: #{book.author}"
      end
    end
  end

  def list_all_people
    if @people.length.zero?
      puts 'You do not have any people'
    else
      @people.each_with_index do |person, index|
        puts "#{index})  Name: #{person.name}, Age: #{person.age}, ID: #{person.id} "
      end
    end
  end

  def create_new_student
    puts 'Great! Lets create a new student'
    print 'Student Name: '
    student_name = gets.chomp
    print 'Student Age: '
    student_age = gets.chomp.to_i
    print 'Student Classroom: '
    student_classroom = gets.chomp
    print 'Parent permissions true/false: '
    parent_permissions = gets.chomp

    case parent_permissions
    when 'true'
      @people.push(Student.new(student_name, student_age, true, student_classroom))
    when 'false'
      @people.push(Student.new(student_name, student_age, false, student_classroom))
    else
      puts 'That was invalid entry'
    end

    puts 'Student created successfully.'
  end

  def create_new_teacher
    puts 'Great! Lets create a new Teacher'
    print 'Teacher Name: '
    teacher_name = gets.chomp
    print 'Teacher Age: '
    teacher_age = gets.chomp.to_i
    print 'Teacher Specialization: '
    teacher_specialization = gets.chomp
    teacher_permission = true

    @people.push(Teacher.new(teacher_name, teacher_age, teacher_specialization, teacher_permission))
    puts 'Teacher created successfully.'
  end

  def create_a_person
    print "Do you want to create a:
    1.Student
    2.Teacher
    [Choose between the two]:
    "
    choose_person = gets.chomp.to_i
    case choose_person
    when 1
      create_new_student
    when 2
      create_new_teacher
    else
      puts 'That was invalid entry'
    end
  end

  def create_new_book
    puts 'Lets create a new book'
    print 'Enter the title: '
    book_title = gets.chomp
    print 'Enter the author: '
    book_author = gets.chomp

    @books.push(Book.new(book_title, book_author))

    puts 'Book created successfully'
  end

  def create_new_rental
    if @books.length.zero? && @people.length.zero?
      puts 'Sorry, nothing to see here'
    else
      puts 'Select one of the following book id: '
      @books.each_with_index do |book, index|
        puts "#{index + 1}) Title: #{book.title} Author: #{book.author}"
      end
      num = gets.chomp.to_i
      index = num - 1

      puts 'Type your id: '
      @people.each do |person|
        puts "[#{person.class}] Name: #{person.name} | Age: #{person.age} | ID: #{person.id}"
      end
      identity = gets.chomp.to_i

      individual = @people.select { |person| person.id == identity }.first

      if individual
        print 'Enter date of rent a book [yyyy-mm-dd]: '
        date = gets.chomp.to_s
        rent = Rental.new(date, individual, @books[index])

        @rentals << rent
        puts 'Book rented successfully'
      else
        puts 'Please enter valid identity!'
      end
    end
  end

  def list_rental_by_id
    if @rentals.empty?
      puts 'There are no rentals available at the moment'
    else
      print "Lets find your book!
     Type your id: "
      id = gets.chomp.to_i
      rental = @rentals.select { |rent| rent.person.id == id }
      if rental.empty?
        puts 'Sorry, there is no rental with that id'
      else
        puts 'Here is your rental:'
        @rentals.each_with_index do |record, index|
          puts "#{index + 1}) Date: #{record.date} Borrower: #{record.person.name}
        Status: #{record.person.class} Borrowed book: \"#{record.book.title}\" by #{record.book.author}"
        end
      end
    end
  end

  def exit_app
    puts 'Goodbye!'
    exit(true)
  end
end
