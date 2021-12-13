#!/bin/bash

export GIST_AUTHOR=petuhovskiy

markdown_info() {
    GIST=$1

    info=$(gh gist view $GIST -f bench_report.md -r)

    if [[ -z "$info" ]]; then
        exit
    fi

    is_simple_update=$(echo "$info" | grep "builtin: simple update")
    if [[ -z "$is_simple_update" ]]; then
        exit
    fi

    test_name=$(echo "$info" | grep "Test: " | awk '{ print $2 }')
    connections_count=$(echo "$info" | grep "number of clients:" | awk '{ print $4 }')
    tps=$(echo "$info" | grep "tps =" | awk '{ print int($3) }')
    
    echo "$test_name - \`\`\`pgbench -c $connections_count -N\`\`\` –– [$tps TPS](https://gist.github.com/$GIST_AUTHOR/$GIST)"
}

LIMIT=$1

GISTS=$(gh gist list -L $LIMIT | awk '{ print $1 }')

for gist in $GISTS; do
    markdown_info $gist
done
