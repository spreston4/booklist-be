json.user do
  json.id @user.id
  json.email @user.email
  json.created_at @user.created_at
  json.updated_at @user.updated_at
  json.wishlist @user.wishlist.books.map do |book|
    json.id book.id
    json.title book.title
    json.description book.description
    json.created_at book.created_at
    json.updated_at book.updated_at
  end
  json.readlist @user.readlist.books.map do |book|
    json.id book.id
    json.title book.title
    json.description book.description
    json.created_at book.created_at
    json.updated_at book.updated_at
  end
end