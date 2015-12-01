`ruby texttest_fixture.rb 30 > regression/current.txt`
diff = `diff regression/master.txt regression/current.txt`

if diff == ''
  puts 'Pass'
else
  puts 'Fail'
  puts diff
end
