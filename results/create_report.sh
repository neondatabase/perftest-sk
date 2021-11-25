#!/bin/bash
set -eux

# create graph.png
python graph.py

cat <<EOF > bench_report.md
Info about the run:
\`\`\`
$(cat info.txt)
\`\`\`

Time to run \`pgbench -i\`:
\`\`\`
$(cat pgbench_init.log | tail -n 1)
\`\`\`

Pgbench result:
\`\`\`
$(cat pgbench.log | tail -n 12)
\`\`\`

walproposer messages stats:
\`\`\`
Total sent messages (to all 3 safekeepers):
$(wc -l sizes.log)

Zero-length messages (all safekeepers):
$(grep -Fx "0" sizes.log | wc -l)

Length sum of all messages:
$(awk '{ sum += $1 } END { print sum }' sizes.log)

Average message size of non-zero length messages:
$(grep -v -Fx "0" sizes.log | awk '{ sum += $1; n++ } END { print sum / n; }')
\`\`\`
EOF
cat bench_report.md

GIST=$(gh gist create bench_report.md postgresql.conf disk_test*.log ping_test.log short.log)
GIST_HASH=${GIST##*/}

rm -rf gist
git clone git@gist.github.com:$GIST_HASH.git gist
mv graph.png gist
cd gist
git add graph.png
git commit -m "Add graph.png"
git push origin master
cd ..
rm disk_test_*.log


echo "Report: " $GIST
