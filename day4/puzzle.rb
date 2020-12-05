required = %w[byr: iyr: eyr: hgt: hcl: ecl: pid:]

regexes = [
  /\bbyr:(19[2-9][0-9]|200[0-2])\b/,
  /\biyr:(201[0-9]|2020)\b/,
  /\beyr:(202[0-9]|2030)\b/,
  /\bhgt:((1[5-8][0-9]|19[0-3])cm)|((59|6[0-9]|7[0-6])in)\b/,
  /\bhcl:#[0-9a-f]{6}\b/,
  /\becl:(amb|blu|brn|gry|grn|hzl|oth)\b/,
  /\bpid:[0-9]{9}\b/
]

passports = File.open("input.txt").read.split("\n\n")

result1 = passports.count { |p| required.all? { |r| p.include?(r) } }
puts "puzzle1: #{result1}"
result2 = passports.count { |p| regexes.all? { |r| r =~ p } }
puts "puzzle1: #{result2}"
