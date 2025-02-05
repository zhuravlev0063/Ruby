require 'pg'
class PG_client
  def initialize
    self.client = PG.connect(
      dbname: 'postgres',
      user: 'postgres',
      password: '76717671',
      host: 'localhost',
      port: 5432
    )
  end
  
  def exec(query)
    client.exec(query)
  end

  def exec_params(query, params =[])
    client.exec_params(query, params)
  end
  
  private
  attr_accessor :client
end