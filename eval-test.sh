#!/bin/bash
declare -a mkfsary=("ext4 sda1 sda3" "swap sda2")
# 指定的挂载
declare -a mountary=("sda1 /" "sda3 /home" "0 /media/win/E")
# 需要增加的挂载
declare -a fstabary=("# /dev/sda5" "UUID=000B89830009F592 /media/win/E ntfs-3g defaults 0 0") #blkid查uuid
# 自定义的安装命令
declare -a softary=()
# 操作所指向的磁盘
declare -A diskmap=([cfdisk]="sda sdb sda sdb" [grub]="sda")
# 主机名和用户名 如连网用静态ip，需要增加nic、addr、gw、dns节点
declare -A hostmap=([host]=chuanqing [user]=chuanqing)

extend-eval(){
    if [[ $1 == cfdisk ]] || [[ $1 == grub ]] ;then
	    str=${diskmap[$1]}
        ppp=($str)

        comd0=$1
        if [[ $1 == grub ]];then
            comd0="grub-install --recheck"
        fi
	    for key in ${ppp[*]};do
            ${comd0} /dev/"${key}"
	    done
        return
    fi

    aaa=()
    case "${1}" in
        mkfs)
            aaa=("${mkfsary[@]}")
            ;;
        mount)
            aaa=("${mountary[@]}")
            ;;
        fstab)
            aaa=("${fstabary[@]}")
            ;;
        soft)
            aaa=("${softary[@]}")
            ;;
        *)
            return
            ;;
    esac

    for str in "${aaa[@]}";do
        if [[ $1 == fstab ]] || [[ $1 == soft ]] ;then
            if [[ $1 == soft ]];then
                $str
                continue
            fi
            echo "$str">>/mnt/etc/fstab
            continue
        fi

        bbb=(${str})
        bbb0=${bbb[0]}
        bbbn=${bbb[*]:1:1000}
        for bbb1 in ${bbbn[*]};do
            single-$1 "${bbb0}" "${bbb1}"
        done
    done
}

single-mount(){
    if [[ $# != 2 ]];then
        return
    fi

    if [[ ! $2 =~ ^/ ]];then
        return
    fi

    if [[ $2 != / ]];then
        mkdir -p /mnt$2
    fi

    if [[ $1 == 0 ]];then
        return
    fi
    mount /dev/$1 /mnt$2
}

single-mkfs(){
    if [[ $# != 2 ]];then
        return
    fi

    if [[ $1 == swap ]];then
        mkswap /dev/$2
        swapon /dev/$2
        return
    fi
    mkfs -t $1 /dev/$2
}

single-comd(){
    if [[ $# != 1 ]];then
        return
    fi
    $1
}

#extend-eval cfdisk
extend-eval $1

#extend-eval-main "${mkfsary[@]}"

