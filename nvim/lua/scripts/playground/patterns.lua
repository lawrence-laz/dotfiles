-- \.\.\. (.*)\n
local s = '1/1 test.my test... expected 5, found 4'
local pattern = '%.%.%. .*'
print(string.sub(s, string.find(s, pattern) + 4))
