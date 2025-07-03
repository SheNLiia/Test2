```markdown
# Руководство по системе резервного копирования BorgBackup

![BorgBackup Logo](https://borgbackup.readthedocs.io/en/stable/_static/logo.svg)

## Содержание
1. [Обзор](#обзор)
2. [Установка](#установка)
3. [Быстрый старт](#быстрый-старт)
4. [Основные операции](#основные-операции)
5. [Аварийные ситуации](#аварийные-ситуации)
6. [Рекомендации](#рекомендации)
7. [Лицензия](#лицензия)

## Обзор

BorgBackup — современная система резервного копирования с:
- Дедупликацией на уровне блоков
- Шифрованием AES-256
- Сжатием данных (LZ4, zstd)
- Поддержкой инкрементальных бэкапов

**Системные требования**:
- Linux (Ubuntu 20.04/22.04 LTS)
- 1 ГБ ОЗУ (рекомендуется 4+ ГБ для больших репозиториев)
- Достаточное дисковое пространство

## Установка

### Ubuntu/Debian
```bash
sudo apt update
sudo apt install borgbackup
```

### Проверка установки
```bash
borg --version
```

## Быстрый старт

1. Инициализация репозитория:
```bash
borg init --encryption=repokey /backup/borg-repo
```

2. Создание первого бэкапа:
```bash
borg create --stats --progress /backup/borg-repo::'{hostname}-{now}' /path/to/data
```

3. Просмотр архивов:
```bash
borg list /backup/borg-repo
```

## Основные операции

### Создание бэкапа
```bash
borg create /backup/borg-repo::'{hostname}-{now:%Y-%m-%d}' /path/to/data
```

### Восстановление
```bash
borg extract /backup/borg-repo::archive-name /path/to/restore
```

### Управление архивами
```bash
# Просмотр содержимого архива
borg list /backup/borg-repo::archive-name

# Удаление старых архивов (сохранение: 7 дневных, 4 недельных, 12 месячных)
borg prune --keep-daily=7 --keep-weekly=4 --keep-monthly=12 /backup/borg-repo
```

## Аварийные ситуации

### Восстановление доступа
```bash
borg key export /backup/borg-repo /path/to/backup-key  # резервная копия ключа
borg key import /backup/borg-repo /path/to/backup-key  # восстановление ключа
```

### Проверка и восстановление репозитория
```bash
borg check /backup/borg-repo
borg check --repair /backup/borg-repo
```

## Рекомендации

1. **Автоматизация**: Используйте cron для регулярных бэкапов
```bash
0 3 * * * /usr/bin/borg create --stats /backup/borg-repo::'{hostname}-{now:%Y-%m-%d}' /path/to/data
```

2. **Мониторинг**: Интегрируйте с Zabbix/Nagios через `borg list`

3. **Хранение ключей**: Храните резервные копии ключей в безопасном месте

## Лицензия
BorgBackup распространяется под лицензией BSD. Подробнее см. в [официальной документации](https://borgbackup.readthedocs.io/).

---

> **Примечание**: Для получения подробной информации используйте `borg --help` или посетите [официальный сайт](https://borgbackup.github.io/).
```

Этот README.md:
1. Содержит все ключевые разделы оригинального руководства
2. Оптимизирован для GitHub (Markdown-форматирование)
3. Включает удобные примеры команд
4. Имеет четкую структуру для быстрого поиска информации
5. Содержит ссылки на официальные ресурсы

Вы можете дополнить его:
- Badges (версия, статус сборки)
- Скриншотами (если есть GUI-оболочка)
- Более подробными примерами конфигурации
- Информацией о мониторинге и интеграциях