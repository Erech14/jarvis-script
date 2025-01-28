#!/bin/bash
echo -n "Это терминал
"
# Воспроизведение аудиофайла go.wav
aplay go.wav 2>/dev/null || echo "Не удалось воспроизвести аудиофайл go.wav" &

# Функция для запуска программы
launch_program() {
    local command=$1
    local program=$(grep -i "^$command;" program.csv | cut -d';' -f2)
    
    if [ -n "$program" ]; then
        play /home/efim/Рабочий-стол/ok4.wav 2>/dev/null &
        #xterm -e "$program" &
        sleep 1.5
        $program 2>/dev/null &
        disown
    else
        aplay not_found.wav 2>/dev/null 
    fi
}

# Основной цикл программы
while true; do
    echo -n "Введите что вы хотите сделать?
"
    echo -n ">>> "
    read input
    
    if [[ $input =~ ^запусти\ (.+)$ ]]; then
        command=${BASH_REMATCH[1]}
        launch_program "$command"
    else
        aplay not_found.wav 2>/dev/null 
    fi
done
