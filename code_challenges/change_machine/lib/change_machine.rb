class ChangeMachine
  attr_reader :currency_set

  def initialize(args)
    @currency_set = args[:currency_set]
  end

  def make_change(cents)
    return "Please enter a number of cents below 100." if cents >= 100

    currency_set.map do |coin|
        coins = cents / coin
        cents %= coin
        coins
    end
  end

  def count_change(args)
    change_given = [args.fetch(:quarters, 0), args.fetch(:dimes, 0), args.fetch(:nickels, 0), args.fetch(:pennies, 0)]

    change_given.zip(currency_set).reduce(0){|init, (num_coins, coin)| num_coins * coin + init}
  end
end
