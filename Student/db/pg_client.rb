require 'pg'
class PG_client

  def exec(query)
    client.exec(query)
  end
  def exec_params(query, params =[])
    client.exec_params(query, params)
  end
  
  def self.instance
    @instance ||= new
  end
  
  
  private
  attr_accessor :client
  @instance = nil


  def initialize
    self.client = PG.connect(
      dbname: 'postgres',
      user: 'postgres',
      password: '76717671',
      host: 'localhost',
      port: 5432  
    )
  end
  
end