#!/usr/bin/env ruby

def prompt_for var
  puts "Enter #{var}:"
  _v = gets
  return _v
end

class Tabular
  attr_reader :rows
  def initialize
    @rows = []
  end
  def << row
    @rows << row
  end
  
  def maxes 
    maxes = {}
    rows.each do |row|
      row.each_pair do |k,v|
        maxes[k] = [maxes[k]||k.to_s.length, v.to_s.length].max
      end
    end
    return maxes
  end
  
  def to_s
    out = []
    maxes = self.maxes()
    
    rows.first.keys.sort.each do |key|
      out << key.to_s.ljust(maxes[key] + 2)
    end
    out << "\n"
    
    rows.each do |row|
      ks = row.keys.sort
      ks.each do |key|
        v = row[key]
        if v.is_a? Float then
          v = "%.2f" % [v]
        end
        out << v.to_s.ljust(maxes[key] + 2)
      end
      out << "\n"
    end
    
    out.join('')
  end
  
end

class Scenario
  attr_reader :principle, :years, :rate, :annual_addition

  def initialize hsh={}
    @principle       = hsh[:principle]        || 0
    @years           = hsh[:years]            || 0
    @rate            = hsh[:rate]             || 1.0
    @annual_addition = hsh[:annual_addition]  || 0
  end
  
  def end_value
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
  
  def to_h
    return {
      :principle       => self.principle,
      :years           => self.years,
      :rate            => self.rate,
      :annual_addition => self.annual_addition,
      :end_value       => self.end_value
    }
  end
  
end

if $0 == __FILE__ then
  t = Tabular.new
  for r in [1,2,5,7] do
    t << s = Scenario.new(:principle       => 100_000,
                          :years           => 40,
                          :rate            => 1.to_f + (r.to_f/100.to_f),
                          :annual_addition => 0).to_h
  end
  puts t.to_s
  # puts "%.2f " % [s.end_value]
end

# principle       = prompt_for("principle").to_i
# rate            = prompt_for("rate").to_f
# years           = prompt_for("years").to_i
# annual_addition = prompt_for("annual addition").to_i
# 
# 
# puts "End value: #{end_value}"

