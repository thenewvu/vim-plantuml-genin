let s:CWD = expand('<sfile>:p:h')

function! PlantUMLGenin()
    exec '%! ' . 'awk -f ' . s:CWD . '/plantuml-genin.awk'
endfunction

command! PlantUMLGenin call PlantUMLGenin()
