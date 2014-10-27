module LexileHelper
  def set_testing_configuration
    Lexile.reset!
    Lexile.username  = lexile_username
    Lexile.password  = lexile_password
    Lexile.testing   = true
  end

  def lexile_username
    'AUSERNAME'
  end

  def lexile_password
    'APASSWORD'
  end

  def lexile_book_id
    315833 #ISBN 9780062012722 Title: It Happened to Nancy: By An Anonymous Teenager: A True Story from Her Diary
  end

  def lexile_book_isbn13
    9780062012722 #id: 315833  Title: It Happened to Nancy: By An Anonymous Teenager: A True Story from Her Diary
  end

  def lexile_book_title
    "Malala"
  end

end
