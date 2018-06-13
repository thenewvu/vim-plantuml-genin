BEGIN {
    started = 0
    comment = 0
    out = ""
}

/^@enduml/ {
    started = 0

    plantuml = "plantuml -pipe -tutxt << EOF @startuml\n" uml "@enduml EOF"

    leading = 99999
    for (i in tmp) {
        delete tmp[i]
    }

    len = 0
    while ((plantuml | getline l) > 0) {
        match(l, /^ */);
        if (RLENGTH < leading) {
            leading = RLENGTH
        }
        tmp[len] = l
        len ++
    }

    close(plantuml)
    
    art = ""
    for (i = 0; i < len; i++) {
        art = art "\n" substr(tmp[i], leading)
    }

    out = out uml "/'" art "\n'/\n"
}

/\/'/ {
    if (started == 1) {
        comment = 1
    }
}

{
    if (started == 1) {
        if (comment == 0) {
            uml = uml $0 "\n" 
        }
    } else {
        out = out $0 "\n"
    }
}

/^@startuml/ {
    started = 1
    uml = ""
}



/'\// {
    if (started == 1) {
        comment = 0
    }
}

END {
    print out
}
