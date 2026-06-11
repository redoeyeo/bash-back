#!/bin/bash

# Получаем директорию, где расположен текущий скрипт
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


# Теперь все пути задаём относительно этой директории
REPO_DIR="$SCRIPT_DIR"
BACKUP="$REPO_DIR/bashrc"
SOURCE="$HOME/.bashrc"
# Абсолютный путь к SSH‑ключу (адаптируйте под вашу систему)
SSH_KEY="/c/Users/redoe/.ssh/id_bashrc"

# Запуск SSH-агента в текущей сессии
eval "$(ssh-agent -s)"

# Загрузка ключа с проверкой
if [ -f "$SSH_KEY" ]; then
    ssh-add "$SSH_KEY"
else
    echo "Ошибка: SSH-ключ не найден: $SSH_KEY"
    exit 1
fi
# Проверяем существование исходного файла
if [[ ! -f "$SOURCE" ]]; then
    echo "Ошибка: исходный файл $SOURCE не найден!"
    exit 1
fi
# Копируем файл с сохранением атрибутов, только если он новее
cp -u -p "$SOURCE" "$BACKUP"
echo "Файл .bashrc скопирован в репозиторий."

# Переходим в директорию репозитория (уже там, но для надёжности)
cd "$REPO_DIR" || { echo "Ошибка: не удалось перейти в $REPO_DIR"; exit 1; }

# Добавляем все изменённые файлы в индекс Git
git add -A
echo "Изменения добавлены в индекс Git."

# Создаём коммит с текущей датой и временем
COMMIT_MESSAGE="Auto-sync: updated .bashrc at $(date '+%Y-%m-%d %H:%M:%S')"
git commit -m "$COMMIT_MESSAGE"
echo "Создан коммит: $COMMIT_MESSAGE"

# Отправляем изменения на удалённый репозиторий
git push
echo "Изменения отправлены на удалённый репозиторий."
echo "Синхронизация завершена успешно!"
