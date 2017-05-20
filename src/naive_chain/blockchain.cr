require "./block"

module NaiveChain::Blockchain
  extend self

  @@blockchain : Array(Block) = [@@genesis_block]
  @@genesis_block = Block.new 0, "0", 1465154705.to_i64, "my genesis block!!"
  
  def blockchain
    @@blockchain
  end
  
  def genesis_block
    @@genesis_block
  end
  
  def latest_block
    blockchain.last
  end
  
  def replace(new_chain)
    if valid_chain?(new_chain) && new_chain.size > blockchain.size
      @@blockchain = new_chain
    end
  end
  
  def valid_block?(new_block, previous_block)
    if previous_block.index + 1 != new_block.index
      return false
    elsif previous_block.hash != new_block.previous_hash
      return false
    elsif new_block.hash != new_block.hash
      return false
    end
    true
  end
  
  def valid_chain?(new_chain)
    new_chain.each_cons(2) do |cons|
      return false if valid_block?(cons[1], cons[0])
    end
    new_chain.first.hash == genesis_block.hash
  end
end
