class BankAccount
  
  def initialize(balance)
    @balance = balance  
  end

  # получения текущего баланса
  def get_balance
    @balance
  end

  # Попалнение счёта 
  def deposit(balance)
    @balance += balance
    puts "Внесено: #{balance}. Новый баланс: #{@balance}."
  end

end

client = BankAccount.new(1000)
client.deposit(500)
puts "Текущий баланс: #{client.get_balance}."