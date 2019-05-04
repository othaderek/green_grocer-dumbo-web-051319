def consolidate_cart(cart)
  new_hash = {}
  cart.each do |item| # Here we are iterating into the array that contains the hashes 
    item.each do |item_name, item_hash|
      if new_hash.key?(item_name) == false 
        new_hash[item_name] = item_hash
        new_hash[item_name][:count] = 1 
      else
        new_hash[item_name][:count] += 1 
      end
    end
  end
end