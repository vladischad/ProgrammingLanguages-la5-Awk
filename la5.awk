BEGIN {
    FS = ",";                           # Set input field separator to comma
    IGNORECASE = 1;                     # Ignore case for matching
    print "<html>\n<head>\n<title>Building Permits</title>\n</head>\n<body>";
    print "<h1>Single Family Dwelling Permits</h1>\n";
    print "<table border=\"1\">";
}

/^"Date"/ {
    date_col = block_col = lot_col = sub_col = value_col = 0;
    for (i = 1; i <= NF; i++) {
        if ($i ~ /Date/) date_col = i;
        if ($i ~ /Subdivision/) sub_col = i;
        if ($i ~ /Lot/) lot_col = i;
        if ($i ~ /Block/) block_col = i;
        if ($i ~ /Value/) value_col = i;
    }
    next;
}

/single.family/ {
    # Clean fields by removing quotes
    gsub(/"/, "", $date_col);
    gsub(/"/, "", $sub_col);
    gsub(/"/, "", $lot_col);
    gsub(/"/, "", $block_col);
    gsub(/"/, "", $value_col);

    print "<tr>";
    print "  <td>" $date_col "</td>";
    print "  <td>" $sub_col "</td>";
    print "  <td>" $lot_col "</td>";
    print "  <td>" $block_col "</td>";
    print "  <td>" $value_col "</td>";
    print "</tr>";
}

END {
    print "</table>\n</body>\n</html>";
}
