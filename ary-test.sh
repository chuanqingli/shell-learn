#!/bin/bash
<<'COMMENT'
知识点：
切片；

or的表达式，这里只能用中括号;
字符串变量用双引号括起(单引号不行);

字符串比较说明
大多数时候，虽然可以不使用括起字符串和字符串变量的双引号，但这并不是好主意。为什么呢？因为如果环境变量中恰巧有一个空格或制表键，bash 将无法分辨，从而无法正常工作。
COMMENT

mountary=(mount "sda1 /" "sda3 /home" "0 /media/win/E" soft fstab)
dotest(){
    echo ${mountary}
    #用另一个变量代替
    aaa=($("${""mountary""[@]}"))

    echo ${aaa[@]} ";" ${#aaa[@]} ";" ${#mountary[@]}

    echo "${mountary[4]}"
    echo "${aaa[@]:0:1}"
    echo "${aaa[@]:0:4}"
    echo "${mountary[@]:0:4}"
    echo "${mountary[@]:2:100}"
}

dotest
