#!/bin/bash

TO_BE_DONE='# To be done'
COMPLETED='# Completed'
TASK_PATH="$HOME/.todo/tasks.txt"
TODO_EMPTY='To do is Empty'
COMPLETED_EMPTY='Complete is Empty'
FILE="$HOME/.todo/tasks"

function createTaskFile() {
    if [ ! -d $HOME/.todo ]
        then
        mkdir $HOME/.todo
        fi
    touch ${TASK_PATH}
    chmod +rw ${TASK_PATH}
    echo "${TO_BE_DONE}" > "${TASK_PATH}"
    echo "${TODO_EMPTY}" >> "${TASK_PATH}"
    echo "${COMPLETED}" >> "${TASK_PATH}"
    echo "${COMPLETED_EMPTY}" >> "${TASK_PATH}"

    echo "Initialized successfully"
}

function checkLineIndex() {
    return "$(sed -n "/^$1$/=" "${TASK_PATH}")"
}

function deleteEmpty() {
    if [[ $1 == "$TO_BE_DONE" ]]
    then
    sed -i "/^$TODO_EMPTY$/d" "${TASK_PATH}"
    elif [[ $1 == "$COMPLETED_EMPTY" ]]
    then
    sed -i "/^$COMPLETED_EMPTY$/d" "${TASK_PATH}"
    fi
}

function checkFileExisted() {
    if [[ ! -f ${TASK_PATH} ]]
    then 
    echo "Please run 'todo init' before runnung '$1' command"
    exit
    fi
}

function init() {
    if [[ -f $HOME/.todo/tasks.txt ]]
    then
    echo "task file has existed, you can use 'todo reset' command to reset the task"
    else
    createTaskFile
    fi
}

function list() {
    cat "$TASK_PATH";
}

function add() {
    checkFileExisted "add"
    deleteEmpty "$TO_BE_DONE"
    checkLineIndex "$COMPLETED"
    sed -i "/^${COMPLETED}$/i `expr $? - 1` $1" "${TASK_PATH}"
}

function edit() {
    # sed "0 a\HELLO111" ${TASK_PATH}
    # cat HELLO > "${TASK_PATH}"
    # echo "${TO_BE_DONE}" > "${TASK_PATH}"
    # echo "${COMPLETED}" >> "${TASK_PATH}"
    # cat "${TASK_PATH}" ｜ grep "${COMPLETED}"
    # number=$(sed -n  "/^${COMPLETED}$/=" "${TASK_PATH}")
    item=$(grep "^[$1] " $TASK_PATH)
    newToDO="$1 $2"
    sed -i "s/$item/$newToDO/g" "${TASK_PATH}"
    # item=$(grep "234234" $TASK_PATH)
    # hasEmpty=false
    # if [[ $item == '' ]]
    # then hasEmpty=true
    # fi
    # echo $hasEmpty
    # cat "${TASK_PATH}" | grep -n "${COMPLETED}"
}

function reset() {
    checkFileExisted 'reset'
    rm -rf TASK_PATH
    createTaskFile
}

# function remove() {

# }

case $1 in
'init')
init
;;
'list')
list
;;
"add")
add $2
;;
"edit")
edit $2 $3
;;
"remove")
remove $2
;;
"reset")
reset
;;
*)
echo "'${$1}' commond not existed"
esac