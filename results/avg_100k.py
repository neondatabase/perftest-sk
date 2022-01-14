import re
import matplotlib.pyplot as plt

avg_size = 100000

sizes = []
pos = []

i = 0
cursum = 0
curcnt = 0

with open('sizes.log') as f:
    while True:
      line = f.readline()
      if not line:
        break
      cur = int(line)
      if cur == 0:
        continue
      cursum += cur
      curcnt += 1
      i += 1
      if curcnt == avg_size:
        sizes.append(cursum / curcnt)
        pos.append(i)
        cursum = 0
        curcnt = 0

if curcnt > 0:
  sizes.append(cursum / curcnt)
  pos.append(i)

sizes = list(map(int, sizes))
print(sizes)
