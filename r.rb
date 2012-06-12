#!/usr/bin/env ruby

def prompt_for var
  puts "Enter #{var}:"
  _v = gets
  return _v
end



class Scenario
  attr_accessor :principle, :years, :rate, :annual_addition

  def initialize hsh={}
    self.principle       = hsh[:principle]
    self.years           = hsh[:years]
    self.rate            = hsh[:rate]
    self.annual_addition = hsh[:annual_addition]
  end
  
  def compound
    unless @compounded then
      end_value = self.principle
      self.years.times do |i|
        end_value = end_value * self.rate
        end_value += self.annual_addition
      end
      @compounded = true
      @end_value = end_value
    end
    
    return @end_value
  end
  
  
end

# principle       = prompt_for("principle").to_i
# rate            = prompt_for("rate").to_f
# years           = prompt_for("years").to_i
# annual_addition = prompt_for("annual addition").to_i
# 
# 
# puts "End value: #{end_value}"

