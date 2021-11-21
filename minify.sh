#/bin/bash

srcpath="src"
despath="F:\Steam\steamapps\workshop\content\322330\1365141672"

function ergodic(){
  for file in ` ls $1 `
  do
    if [ -d "$1/$file" ]
    then
      mkdir -pv "${despath}/$1/$file"
      ergodic "$1/$file" $2
    else
      #echo "$1/$file"
      if [[ $(echo $file | cut -d '.' -f2) == "lua" && $2 != 'dev' ]]
      then
        echo "Minify lua file: $1/$file to ${despath}/$1/$file"
        luamin -f "$1/$file" > "${despath}/$1/$file"
      else
        cp -v "$1/$file" "${despath}/$1/$file"
      fi
    fi
  done
}

rm -rvf "${despath}"
mkdir -pv "${despath}/src"
cp LICENSE "${despath}/"
ergodic "$srcpath" $1
mv -v "${despath}/$srcpath"/* "${despath}/"
rm -rf "${despath}/$srcpath"
