let s:CWD = expand('<sfile>:p:h')

function! PlantUMLGenin()
    let save_pos = getpos(".")
    exec '%! ' . 'awk -f ' . s:CWD . '/plantuml-genin.awk'
    call setpos('.', save_pos)
endfunction

command! PlantUMLGenin call PlantUMLGenin()
