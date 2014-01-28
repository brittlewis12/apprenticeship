def make_change(cents)
  currency_set = [25, 10, 5, 1]

  currency_set.map do |coin|
      coins = cents / coin
      cents %= coin
      coins
  end
end
