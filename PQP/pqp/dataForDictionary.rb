path="/Users/shannonmrush/Contests/PQP/pqp/subset.csv"
goodbag_file="/Users/shannonmrush/Contests/PQP/pqp/goodBag.csv"
badbag_file="/Users/shannonmrush/Contests/PQP/pqp/badBag.csv"
dict_file="/Users/shannonmrush/Contests/PQP/pqp/dictionary.csv"
y_file="/Users/shannonmrush/Contests/PQP/pqp/yInfo.csv"

require 'set'
indexes = [6,7,8]
good_bag = Array.new
bad_bag = Array.new
y=0
records=0
File.open(path, "r") do |f|
  while (line = f.gets)
    records += 1
    record = line.split(",")
    puts record[0]
    indexes.each do |index|
      val = record[index]
      unless val.empty?
        if record[9].to_i==0
          bad_bag += val.split
        else
          good_bag += val.split
          y += 1
        end
      end
    end
  end
end

dictionary = [good_bag,bad_bag].flatten.uniq
y_info = [y,records]
File.open(dict_file, "w") { |f| f.puts(dictionary.join(',')) }
File.open(goodbag_file, "w") { |f| f.puts(good_bag.join(',')) }
File.open(badbag_file, "w") { |f| f.puts(bad_bag.join(',')) }
File.open(y_file, "w") { |f| f.puts(y_info.join(',')) }


