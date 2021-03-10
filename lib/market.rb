class Market
  attr_reader :name, :vendors
  
  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    vendors << vendor
  end

  def vendor_names
    vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    vendors.find_all do |vendor|
      !vendor.check_stock(item).zero?
    end
  end

  def total_inventory
    full_stock = Hash.new { |hash, key| hash[key] = { quantity: 0, vendors: [] }}
    @vendors.each do |vendor|
      vendor.inventory.each do |item, amount|
        full_stock[item][:quantity] += amount
        full_stock[item][:vendors] << vendor
      end
    end
    full_stock
  end

  def overstocked_items
    overstocked = total_inventory.select do |item, hash|
      hash[:quantity] > 50 && hash[:vendors].size > 1
    end
    # require 'pry'; binding.pry
    overstocked.keys
  end
end