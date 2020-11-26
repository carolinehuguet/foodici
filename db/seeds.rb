# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
require "open-uri"

puts "Cleaning database..."
OrderLine.destroy_all
OrderShop.destroy_all
Order.destroy_all
User.destroy_all
Product.destroy_all
Shop.destroy_all
puts "Database is clean!"

csv_options = { col_sep: ',', headers: :first_row }
filepath_users    = 'lib/seeds/users.csv'
filepath_shops    = 'lib/seeds/shops.csv'
filepath_orders    = 'lib/seeds/orders.csv'
filepath_products    = 'lib/seeds/products.csv'
filepath_order_shops    = 'lib/seeds/order_shops.csv'
filepath_order_lines    = 'lib/seeds/order_lines.csv'

puts "Creating users..."

CSV.foreach(filepath_users, csv_options) do |row|
  User.create!(
    email: row['email'],
    first_name: row['first_name'],
    last_name: row['last_name'],
    password: row['password']
  )
end

users = User.all.order(:id)

puts "Users created!"
puts "Creating shops..."

CSV.foreach(filepath_shops, csv_options) do |row|
  # name,address,opening_hour,closing_hour,opening_days,phone_number,category,description
 Shop.create!(
    name: row['name'],
    address: row['address'],
    opening_hour: row['opening_hour'],
    closing_hour: row['closing_hour'],
    opening_days: row['opening_days'],
    phone_number: row['phone_number'],
    category: row['category'],
    description: row['description']
  )
end

shops = Shop.all.order(:id)

puts "Shops created!"
puts "Creating orders..."

CSV.foreach(filepath_orders, csv_options) do |row|
  # starting_address, status, user_id,	total_price
  user = users[row['user_index'].to_i]
  Order.create!(
    starting_address: row['starting_address'],
    status: row['status'],
    user: user,
    total_price: row['total_price'].to_f
  )
end

orders = Order.all.order(:id)

puts "Orders created!"
puts "Creating products... 'To lose patience is to lose the battle.'"

CSV.foreach(filepath_products, csv_options) do |row|
  # name,organic,price,amount,unit,shop_id,description,image
  puts row['name']
  shop = shops[row['shop_index'].to_i]
  file = URI.open(row['image'])
  product = Product.new(
    name: row['name'],
    organic: row['organic'],
    price: row['price'].to_f,
    amount: row['amount'],
    unit: row['unit'],
    shop: shop,
    description: row['description'],
  )
  product.photo.attach(io: file, filename: row['name'], content_type: 'image/png' )
  product.save!
end

products = Product.all.order(:id)

puts "Products created!"
puts "Creating order_shops..."

CSV.foreach(filepath_order_shops, csv_options) do |row|
  # status, order_id,	shop_id, subtotal_price
  order = orders[row['order_index'].to_i]
  shop = shops[row['shop_index'].to_i]
  OrderShop.create!(
    status: row['status'],
    order: order,
    shop: shop,
    subtotal_price: row['subtotal_price'].to_f
  )
end

order_shops = OrderShop.all.order(:id)

puts "Order_shops created!"
puts "Creating order_lines..."

CSV.foreach(filepath_order_lines, csv_options) do |row|
  # quantity, product_id,	order_shop_id, subtotal_price
  order_shop = order_shops[row['order_shop_index'].to_i]
  product = products[row['product_index'].to_i]
  OrderLine.create!(
    quantity: row['quantity'],
    product: product,
    order_shop: order_shop,
    subtotal_price: row['subtotal_price'].to_f
  )
end

puts "Order_lines created! Finished :)"
