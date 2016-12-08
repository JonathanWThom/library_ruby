require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new book', {:type => :feature}) do
  it('allows an admin to add a book') do
    visit('/')
    fill_in('add_title', :with => 'This is a book title')
    click_button('Add Book')
    expect(page).to have_content('Success!')
  end
end

describe('adding a new author', {:type => :feature}) do
  it('allows an admin to add an author') do
    visit('/')
    fill_in('name', :with => 'Jonathan Thom')
    click_button('Add Author')
    expect(page).to have_content('Success!')
  end
end

describe('go to book page', {:type => :feature}) do
  it('allows a user to see a book page') do
    visit('/')
    book = Book.new({:title => "Little Women", :id => nil})
    book.save()
    visit('/')
    click_link('Little Women')
    expect(page).to have_content('Little Women')
  end
end

describe('delete a book', {:type => :feature}) do
  it('allows a user to delete a book') do
    visit('/')
    book = Book.new({:title => "Little Women", :id => nil})
    book.save()
    visit('/')
    click_button('Delete Book')
    expect(page).to_not have_content('Little Women')
  end
end

describe('add an author to a book', {:type => :feature}) do
  it('allows user to add authors to a book') do
    visit('/')
    book = Book.new({:title => "Little Women", :id => nil})
    book.save()
    visit('/')
    author = Author.new({:name => "Jonathan Thom", :id => nil})
    author.save()
    visit('/')
    click_link('Little Women')
    page.check('Jonathan Thom')
    click_button('Add Authors')
    expect(page).to have_content('Here are all the authors credited:')
  end
end
