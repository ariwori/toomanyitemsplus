#/bin/bash

srcpath="src"

function ergodic(){
  for file in ` ls $1 `
  do
    if [ -d $1"/"$file ]
    then
      mkdir -pv "dist/"$1"/"$file
      ergodic $1"/"$file
    else
      #echo "$1/$file"
      if [[ $(echo $file | cut -d '.' -f2) == "lua" ]]
      then
        echo "Minify lua file: "$1"/"$file" to dist/"$1"/"$file
        luamin -f $1"/"$file > "dist/"$1"/"$file
      else
        cp -v $1"/"$file "dist/"$1"/"$file
      fi
    fi
  done
}

rm -rf dist/*
mkdir -pv dist/src
cp readme/LICENSE dist/
ergodic $srcpath
mv -v dist/$srcpath/* dist/
rm -rf dist/$srcpath
