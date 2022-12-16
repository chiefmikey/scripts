while
  [ -z ${ROOT} ] ||
  [ ! -d ${ROOT} ]; do
    if [ -z ${Y1} ]; then
      export Y1="unset"
    fi
    if [ -z ${ROOT} ]; then
      while
        [ ${Y1} != "y" ] &&
        [ ${Y1} != "yes" ] &&
        [ ${Y1} != "n" ] &&
        [ ${Y1} != "no" ]; do
          echo "+ Use Default Root (${DEFAULT_ROOT})? (y/n):"
          read Y1
          if [ -z ${Y1} ]; then
            export Y1="unset"
          fi
      done
      if [ ${Y1} = "y" ] || [ ${Y1} = "yes" ]; then
        export ROOT=${DEFAULT_ROOT}
      elif [ ${Y1} = "n" ] || [ ${Y1} = "no" ]; then
        echo "+ Input Root:"
        read ROOT
        if [ -z ${ROOT} ]; then
          export ROOT="unset"
        else
          export ROOT=${ROOT/"~"/${HOME}}
        fi
      fi
    fi
    if [ ! -d ${ROOT} ]; then
      if [ ${ROOT} != "unset" ]; then
        echo "Invalid Root"
      fi
      echo "+ Input Root:"
      read ROOT
      if [ -z ${ROOT} ]; then
        export ROOT="unset"
      else
        export ROOT=${ROOT/"~"/${HOME}}
      fi
    fi
done
