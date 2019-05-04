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
  new_hash
end

def apply_coupons(cart, coupon_array)
  if cart.size == 0
    return cart
  elsif coupon_array.size == 0
    return cart
  else
    consolidated_coupons_hash = {}
    coupon_array.each do |coupon|
      item_name = coupon[:item]
      if consolidated_coupons_hash.key?(item_name) == false
        coupon = coupon.merge({coupon_count: 1})
        consolidated_coupons_hash[item_name] = coupon
      else
          consolidated_coupons_hash[item_name][:num] += coupon[:num]
          consolidated_coupons_hash[item_name][:coupon_count] += 1
      end
    end
    consolidated_coupons_hash.each do |consolidated_key, value|
      if cart.key?(consolidated_key)
        consolidated_coupon_number = consolidated_coupons_hash[consolidated_key][:num]
        cart_item_count = cart[consolidated_key][:count]
        coupon_item_price = consolidated_coupons_hash[consolidated_key][:cost]
        coupon_count = consolidated_coupons_hash[consolidated_key][:coupon_count]
        cart_item_count_after_coupon = cart_item_count - consolidated_coupon_number
        cart_item_clearance = cart[consolidated_key][:clearance]

        cart[consolidated_key][:count] = cart_item_count_after_coupon
        cart["#{consolidated_key} W/COUPON"] = {price: coupon_item_price, clearance: cart_item_clearance, count: coupon_count}
        #if cart[consolidated_key][:count] == 0
          #cart.delete(consolidated_key)
        #end
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item_name, item_hash|
    if item_hash[:clearance] == true
      clearance_price = item_hash[:price] - (item_hash[:price] * 0.2)
      item_hash[:price] = clearance_price
    end
  end
  cart
end



