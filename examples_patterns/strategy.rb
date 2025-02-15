# Шаг 1. Абстрактный класс (интерфейс стратегии)
class ChessStrategy
  def move
    raise NotImplementedError, 'This method must be overridden'
  end
end

# Шаг 2. Разные стратегии игры
class AggressiveStrategy < ChessStrategy
  def move
    puts "Атакуем короля!"
  end
end

class DefensiveStrategy < ChessStrategy
  def move
    puts "Укрепляем оборону!"
  end
end

# Шаг 3. Контекст (главный класс)
class ChessAI
  attr_accessor :strategy

  def initialize(strategy)
    @strategy = strategy
  end

  def make_move
    @strategy.move
  end
end

# Шаг 4. Использование
ai = ChessAI.new(AggressiveStrategy.new)
ai.make_move # Выведет: "Атакуем короля!"

ai.strategy = DefensiveStrategy.new
ai.make_move # Выведет: "Укрепляем оборону!"
