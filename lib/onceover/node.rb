require 'onceover/controlrepo'

class Onceover
  class Node
    @@all = []


    attr_accessor :name
    attr_accessor :beaker_node
    attr_accessor :fact_set

    def initialize(name, facts)
      @name = name
      @beaker_node = nil

      # TODO:***
      # If we can't find the factset it will fail, so just catch that error and ignore it
      # begin
      #   facts_file_index = Onceover::Controlrepo.facts_files.index {|facts_file|
      #     File.basename(facts_file, '.json') == name
      #   }
      #   @fact_set = Onceover::Controlrepo.facts[facts_file_index]
      # rescue TypeError
      #   @fact_set = nil
      # end
      @fact_set = facts
      @@all << self

    end

    def self.find(node_name)
      @@all.each do |node|
        if node_name.is_a?(Onceover::Node)
          if node = node_name
            return node
          end
        elsif node.name == node_name
          return node
        end
      end
      logger.warn "Node #{node_name} not found"
      nil
    end

    def self.all
      @@all
    end
  end
end
