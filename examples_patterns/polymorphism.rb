class BankAccount
  def initialize(balance)
    @balance = balance  
  end

  def get_balance
    @balance
  end

  # Метод для пополнения счета 
  def deposit(amount)
    raise NotImplementedError, "Этот метод должен быть переопределен в производных классах"
  end
end

# сберегательный счет
class SavingsAccount < BankAccount
  def deposit(amount)
    @balance += amount
    puts "Внесено на сберегательный счет: #{amount}. Новый баланс: #{@balance}."
  end
end

#  расчетный счет
class CheckingAccount < BankAccount
  def deposit(amount)
    @balance += amount-(amount*0.05)
    puts "Внесено на расчетный счет: #{amount-(amount*0.05)}. Новый баланс: #{@balance}. Комиссия составила:  #{amount*0.05} "
  end
end


savings = SavingsAccount.new(1000)
checking = CheckingAccount.new(2000)

savings.deposit(500)  
checking.deposit(300)  

puts "Текущий баланс сберегательного счета: #{savings.get_balance}."  
puts "Текущий баланс расчетного счета: #{checking.get_balance}."      