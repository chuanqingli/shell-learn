#!/bin/bash
<<'COMMENT'
知识点：
or的表达式，这里只能用中括号;
字符串变量用双引号括起(单引号不行);

字符串比较说明
大多数时候，虽然可以不使用括起字符串和字符串变量的双引号，但这并不是好主意。为什么呢？因为如果环境变量中恰巧有一个空格或制表键，bash 将无法分辨，从而无法正常工作。
COMMENT

declare -a mountary=(mount "sda1 /" "sda3 /home" "0 /media/win/E" soft fstab)
dotest(){
    for aaa in "${mountary[@]}";do
        if [ "${aaa}" == fstab ] || [ "${aaa}" == soft ] ;then
            echo "111=>" $aaa
        else
            echo "222=>" $aaa
        fi
    done
}

dotest
