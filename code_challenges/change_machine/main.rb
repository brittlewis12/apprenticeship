require_relative 'lib/change_machine'

def welcome
  puts "\n" + '
   $$$$$$\  $$\   $$\  $$$$$$\  $$\   $$\  $$$$$$\  $$$$$$$$\
  $$  __$$\ $$ |  $$ |$$  __$$\ $$$\  $$ |$$  __$$\ $$  _____|
  $$ /  \__|$$ |  $$ |$$ /  $$ |$$$$\ $$ |$$ /  \__|$$ |
  $$ |      $$$$$$$$ |$$$$$$$$ |$$ $$\$$ |$$ |$$$$\ $$$$$\
  $$ |      $$  __$$ |$$  __$$ |$$ \$$$$ |$$ |\_$$ |$$  __|
  $$ |  $$\ $$ |  $$ |$$ |  $$ |$$ |\$$$ |$$ |  $$ |$$ |
  \$$$$$$  |$$ |  $$ |$$ |  $$ |$$ | \$$ |\$$$$$$  |$$$$$$$$\
   \______/ \__|  \__|\__|  \__|\__|  \__| \______/ \________|

  $$\      $$\  $$$$$$\   $$$$$$\  $$\   $$\ $$$$$$\ $$\   $$\ $$$$$$$$\
  $$$\    $$$ |$$  __$$\ $$  __$$\ $$ |  $$ |\_$$  _|$$$\  $$ |$$  _____|
  $$$$\  $$$$ |$$ /  $$ |$$ /  \__|$$ |  $$ |  $$ |  $$$$\ $$ |$$ |
  $$\$$\$$ $$ |$$$$$$$$ |$$ |      $$$$$$$$ |  $$ |  $$ $$\$$ |$$$$$\
  $$ \$$$  $$ |$$  __$$ |$$ |      $$  __$$ |  $$ |  $$ \$$$$ |$$  __|
  $$ |\$  /$$ |$$ |  $$ |$$ |  $$\ $$ |  $$ |  $$ |  $$ |\$$$ |$$ |
  $$ | \_/ $$ |$$ |  $$ |\$$$$$$  |$$ |  $$ |$$$$$$\ $$ | \$$ |$$$$$$$$\
  \__|     \__|\__|  \__| \______/ \__|  \__|\______|\__|  \__|\________|' + "\n\n\n"
  puts "I'll help you with all your change-related needs.\n\n"

  sleep 1
end

def menu_prompt
  puts "What would you like me to help you do today?"
  puts "** (1) Make change from cents"
  puts "** (2) Count change from coins"
  puts "** (q) Quit"
  print "\nType your selection, and press 'return': "

  gets.chomp.downcase
end

def make_change
  print "\nHow much change do you need, in cents? $."
  cents = get_user_integer

  dollars = cents / 100
  cents %= 100
  coins = cm.make_change(cents)

  puts "\nDollars:  #{dollars}" if dollars > 0
  wrap "Quarters: #{coins[0]}\nDimes:    #{coins[1]}\nNickels:  #{coins[2]}\nPennies:  #{coins[3]}"
end

def count_change
  print "\nHow many Quarters do you have? "
  quarters = get_user_integer

  print "How many Dimes do you have? "
  dimes = get_user_integer

  print "How many Nickels do you have? "
  nickels = get_user_integer

  print "How many Pennies do you have? "
  pennies = get_user_integer

  cents = cm.count_change(pennies:  pennies,
                          nickels:  nickels,
                          dimes:    dimes,
                          quarters: quarters)
  dollars = cents / 100
  cents %= 100
  cents = "%02d" % cents if cents < 10

  wrap "You have $#{dollars}.#{cents}"
end

### Helpers

def cm # get or instantiate ChangeMachine to use calculation methods
  @cm ||= ChangeMachine.new(currency_set: [25, 10, 5, 1])
end

def get_user_integer # get user string input, change to integer
  gets.chomp.to_i
end

def wrap string # draws attentions to text, making it easy to read in terminal
  puts "\n*************************************"
  puts string
  puts "*************************************\n\n"
end

### Start program

welcome

while true
  choice = menu_prompt

  case choice
  when '1'
    make_change
  when '2'
    count_change
  when "q"
    break
  else
    wrap "*** Please type '1', '2', or 'q' ***"
  end

  sleep 2 # allow time for user to read the output
end

puts "\nGoodbye!"
