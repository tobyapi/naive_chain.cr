require "./blockchain"
require "openssl"

module NaiveChain
  class Block
    getter index : Int32
    getter previous_hash : String
    getter timestamp : Int64
    getter data : String
    getter hash : String
    
    def initialize(@index, @previous_hash, @timestamp, @data)
      @hash = calculate_hash(@index, @previous_hash, @timestamp, @data)
    end
  
    def calculate_hash(index, previous_hash, timestamp, data)
      OpenSSL::Digest.new("sha256")
        .update(index.to_s + previous_hash + timestamp.to_s + data)
        .to_s
    end
    
    def generate_next(block_data)
      previous_block = Blockchain.latest_block
      next_index = previous_block.index.succ
      next_timestamp = Time.new.epoch
      Block.new(next_index, previous_block.hash, next_timestamp, block_data)
    end
    
  end
end
