#/bin/bash

outfile="E:\个人开发\游戏\饥荒联机版\Toomanyitemsplus\src\scripts\mods_atlas.lua"
despath="F:\Steam\steamapps\workshop\content\322330"
cur_modid=""
function ergodic() {
    for file in $(ls $1); do
        modid=$(echo $file | tr -cd '[0-9]')
        if [[ $modid != "" && ${#modid} -gt 8 && ${#modid} -lt 13 ]]; then
            cur_modid=$modid
            # echo "}," >>  $outfile
            # echo "[\"workshop-${cur_modid}\"] = {" >>  $outfile
            echo "\"workshop-$cur_modid\","
        fi
        if [ -d "$1/$file" ]; then
            ergodic "$1/$file"
        # else
        #     if [[ $(echo $file | cut -d '.' -f2) == "xml" ]]; then
        #         echo "\"$1/$file\",">> $outfile
        #     fi
        fi
    done
}

# for i in $(ls); do
#   if [[ $(echo $i | cut -d '.' -f2) == 'xml' ]]
#   then
#     echo '"../mods/workshop-1909182187/images/'$i'",'
#   fi
# done
echo 'return {
        ["all"] = {
        "minimap/minimap_data.xml",
        "images/inventoryimages1.xml",
        "images/inventoryimages2.xml",
        "../mods/workshop-1365141672/images/customicobyysh.xml"
    },' >$outfile
ergodic $despath
echo '}' >>$outfile
