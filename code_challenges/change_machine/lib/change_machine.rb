def make_change(cents)
  return "Please enter a number of cents below 100." if cents >= 100
  currency_set = [25, 10, 5, 1]

  currency_set.map do |coin|
      coins = cents / coin
      cents %= coin
      coins
  end
end
