#!/bin/fish

echo "#!/bin/bash"
    
echo -n "echo -e \""

while read -l line
    echo -n "\033[48;2;"
    set colorstr (string sub -s 2 -e 3 "$line")
    echo -n (math -- "0x$colorstr") 
    echo -n ";"
    set colorstr (string sub -s 4 -e 5 "$line")
    echo -n (math -- "0x$colorstr") 
    echo -n ";"
    set colorstr (string sub -s 6 -e 7 "$line")
    echo -n (math -- "0x$colorstr") 
    echo -n "m"
    echo -n "  "
    echo -n "\033[0m"
end

echo "\""
