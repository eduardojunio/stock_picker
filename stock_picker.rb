def stock_picker(prices_indexed_by_day)
  prices_with_day = prices_indexed_by_day.map.with_index { |price, day| { day: day, price: price } }
  lowest_prices = prices_with_day.sort { |a, b| a[:price] <=> b[:price] }
  highest_prices = prices_with_day.sort { |a, b| b[:price] <=> a[:price] }
  possible_profits = []
  lowest_prices.each do |a|
    highest_prices.each do |b|
      if a[:day] >= b[:day]
        next
      end
      possible_profits.push([a, b])
      break
    end
  end
  max_profit = possible_profits.max do |a, b|
    a_profit = calculate_profit(a)
    b_profit = calculate_profit(b)
    a_profit <=> b_profit
  end
  max_profit.map { |d| d[:day] }
end

def calculate_profit(buy_and_sell_days)
  sell_day = buy_and_sell_days[1]
  buy_day = buy_and_sell_days[0]
  sell_day[:price] - buy_day[:price]
end

p stock_picker([17,3,6,9,15,8,6,1,10])
# => [1,4]  # for a profit of $15 - $3 == $12
