#!/bin/bash
# from http://ubuntuforums.org/showthread.php?t=2200866

if [ $# -ne 1 ]; then
    echo "Usage: $0 <destination_path>"
else    
    #remove trail slash
    DESTINATION_PATH=${1%/}
    
    if [ ! -d "$DESTINATION_PATH" ]; then 
        echo "Invalid destination path ${DESTINATION_PATH} it does not exists"
        exit
    fi

    if [ ! -d "${DESTINATION_PATH}/dev" ]; then 
        echo "Create dir path ${DESTINATION_PATH}/dev"
        mkdir -p ${DESTINATION_PATH}"/"dev
    fi

    if ! grep -qs ${DESTINATION_PATH}"/"dev /proc/mounts; then
          mount --bind /dev ${DESTINATION_PATH}"/"dev
          if [ $? -eq 0 ]; then
               echo "Mount success ${DESTINATION_PATH}"/"dev"
          else
               echo "Something went wrong with the mount ${DESTINATION_PATH}"/"dev"
          fi
    fi

    if [ ! -d "${DESTINATION_PATH}/proc" ]; then 
        echo "Create dir path ${DESTINATION_PATH}/proc"
        mkdir -p ${DESTINATION_PATH}"/"proc
    fi
    
    if ! grep -qs ${DESTINATION_PATH}"/"proc /proc/mounts; then
          mount --bind /proc ${DESTINATION_PATH}"/"proc
          if [ $? -eq 0 ]; then
               echo "Mount success ${DESTINATION_PATH}"/"proc"
          else
               echo "Something went wrong with the mount ${DESTINATION_PATH}"/"proc"
          fi
    fi

    if [ ! -d "${DESTINATION_PATH}/sys" ]; then 
        echo "Create dir path ${DESTINATION_PATH}/sys"
        mkdir -p ${DESTINATION_PATH}"/"sys
    fi

    if ! grep -qs ${DESTINATION_PATH}"/"sys /proc/mounts; then
          mount --bind /sys ${DESTINATION_PATH}"/"sys
          if [ $? -eq 0 ]; then
               echo "Mount success ${DESTINATION_PATH}"/"sys"
          else
               echo "Something went wrong with the mount ${DESTINATION_PATH}"/"sys"
          fi
    fi

    if [ ! -d "${DESTINATION_PATH}/dev/pts" ]; then 
        echo "Create dir path ${DESTINATION_PATH}/dev/pts"
        mkdir -p ${DESTINATION_PATH}"/"dev/pts
    fi

    if ! grep -qs ${DESTINATION_PATH}"/"dev/pts /proc/mounts; then
          mount --bind /dev/pts ${DESTINATION_PATH}"/"dev/pts
          if [ $? -eq 0 ]; then
               echo "Mount success ${DESTINATION_PATH}"/"dev/pts"
          else
               echo "Something went wrong with the mount ${DESTINATION_PATH}"/"dev/pts"
          fi
    fi

    if [ ! -d "${DESTINATION_PATH}/etc" ]; then 
        echo "Create dir path ${DESTINATION_PATH}/etc"
        mkdir -p ${DESTINATION_PATH}"/"etc
        cp /etc/resolv.conf ${DESTINATION_PATH}"/"etc/resolv.conf
    fi

    for i in $( ldd /bin/bash | grep -v dynamic | cut -d " " -f 3 | sed 's/://' | sort | uniq )
      do
            cp --parents $i ${DESTINATION_PATH}
      done

    # ARCH amd64
    if [ -f /lib64/ld-linux-x86-64.so.2 ]; then
           cp --parents /lib64/ld-linux-x86-64.so.2 /${DESTINATION_PATH}
    fi

    # ARCH i386
    if [ -f  /lib/ld-linux.so.2 ]; then
           cp --parents /lib/ld-linux.so.2 /${DESTINATION_PATH}
    fi

    echo "Chroot jail is ready: ${DESTINATION_PATH}"

    if [ ! -d "${DESTINATION_PATH}/bin" ]; then 
        echo "Create dir path ${DESTINATION_PATH}/bin"
        mkdir -p ${DESTINATION_PATH}"/"bin
        cp /bin/{cat,echo,rm,bash} ${DESTINATION_PATH}"/bin/"
    fi

    /usr/sbin/chroot ${DESTINATION_PATH}
fi

