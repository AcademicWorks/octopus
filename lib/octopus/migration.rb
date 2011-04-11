module Octopus::Migration  
  def self.extended(base)
    class << base
      def announce_with_octopus(message)
        announce_without_octopus("#{message} - #{get_current_shard}")
      end
      alias_method_chain :announce, :octopus
      attr_accessor :current_shard
    end
  end

  def using(*args)
    warn "Octopus::Migration#using is not used; all shards are being migrated"
  end

  def using_group(*args)
    warn "Octopus::Migration#using is not used; all shards are being migrated"
  end
  
  def get_current_shard
    "Shard: #{ActiveRecord::Base.connection.current_shard()}" if ActiveRecord::Base.connection.respond_to?(:current_shard)
  end

end

ActiveRecord::Migration.extend(Octopus::Migration)
