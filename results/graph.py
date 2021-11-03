import re
import matplotlib.pyplot as plt

prog = re.compile(r'progress: ([\d\.]+) s, ([\d\.]+) tps, lat ([\d\.]+) ms stddev ([\d\.]+)')

tps = []
sec = []

with open('pgbench.log') as f:
    lines = f.readlines()
    for line in lines:
      result = prog.match(line)
      if result:
        sec.append(float(result[1]))
        tps.append(float(result[2]))

plt.figure(figsize=(12, 8), dpi=80)
plt.plot(sec, tps, label="TPS")
ax = plt.gca()
ax.set_ylim([0, None])
plt.savefig('graph.png')