#!/bin/bash

# Константы
PROCESS="test"
URL="https://test.com/monitoring/test/api"
LOGFILE="/var/log/monitoring.log"
STATEFILE="/var/run/test_monitor.pid"

# Создаем лог-файл, если нет
if [[ ! -f "$LOGFILE" ]]; then
    touch "$LOGFILE"
    chmod 664 "$LOGFILE"
    chown root:root "$LOGFILE"
fi

# Создаем файл состояния, если нет
if [[ ! -f "$STATEFILE" ]]; then
    touch "$STATEFILE"
    chmod 644 "$STATEFILE"
    chown root:root "$STATEFILE"
fi

echo "$(date '+%Y-%m-%d %H:%M:%S') - Запуск проверки" >> "$LOGFILE"

# Проверяем процесс
PID=$(pgrep -n "$PROCESS")
if [[ -z "$PID" ]]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Процесс '$PROCESS' не найден" >> "$LOGFILE"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Найден процесс '$PROCESS' с PID=$PID" >> "$LOGFILE"

    # Проверяем, изменился ли PID
    if [[ -s "$STATEFILE" ]]; then
        OLD_PID=$(cat "$STATEFILE")
        if [[ "$PID" != "$OLD_PID" ]]; then
            echo "$(date '+%Y-%m-%d %H:%M:%S') - Процесс $PROCESS перезапущен (PID $OLD_PID → $PID)" >> "$LOGFILE"
        fi
    fi
    echo "$PID" > "$STATEFILE"
fi

# Запрос к серверу мониторинга
echo "$(date '+%Y-%m-%d %H:%M:%S') - Выполняем curl к $URL" >> "$LOGFILE"
RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$URL")
echo "$(date '+%Y-%m-%d %H:%M:%S') - Ответ сервера: HTTP $RESPONSE" >> "$LOGFILE"

if [[ "$RESPONSE" -ne 200 ]]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Сервер мониторинга недоступен (код $RESPONSE)" >> "$LOGFILE"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Сервер мониторинга доступен" >> "$LOGFILE"
fi