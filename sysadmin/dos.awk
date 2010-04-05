# creates a histogram of values in the first column of piped-in data
function max(arr, big) {
    big = 0;
    for (i in cat) {
        if (cat[i] > big) { big=cat[i]; }
    }
    return big
}

NF > 0 {
    cat[$1]++;
}
END {
    maxm = max(cat);
    for (i in cat) {
        scaled = 60 * cat[i] / maxm;
        printf "%-25.25s  [%8d]:", i, cat[i]
        for (i=0; i<scaled; i++) {
            printf "#";
        }
        printf "\n";
    }
}
