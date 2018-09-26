#!/bin/bash
<<'COMMENT'
知识点：
or的表达式，这里只能用中括号;
字符串变量用双引号括起(单引号不行);
双中括号可以避免字符串变量转义的问题；

COMMENT

declare -a mountary=(mount "sda1 /" "sda3 /home" "0 /media/win/E" soft fstab)
dotest(){
    for aaa in "${mountary[@]}";do
        if [[ ${aaa} == fstab ]] || [[ ${aaa} == soft ]] ;then
            echo "111=>" $aaa
        else
            echo "222=>" $aaa
        fi
    done
}

dotest
