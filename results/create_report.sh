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

EOF
cat bench_report.md

# Append something if file is empty.
[ -s short.log ] || echo 'Empty file' >> short.log


GIST=$(gh gist create bench_report.md postgresql.conf disk_test*.log ping_test.log short.log metrics_*.txt)
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
rm metrics_*.txt


echo "Report: " $GIST
