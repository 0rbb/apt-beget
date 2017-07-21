:<<=
==print text with green color. Usually for success messages
=
function echo_g {
    echo -e "\n\e[1m\e[48;5;28m $1 \e[0m\n"
}

:<<=
==print text with red color. Usually for error messages
=
function echo_r {
    echo -e "\n\e[1m\e[48;5;1m $1 \e[0m\n"
}

:<<=
==print text with yellow color. Usually for information messages
=
function echo_y {
    echo -e "\n\e[1m\e[48;5;11m\e[30m $1 \e[0m\n"
}
