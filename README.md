# Проект ETL

### Описание

Создание новой витрины данных и добавление новых колонок к существующим таблицам. Создание ETL на Airflow: получение данных через POST и GET запросы, загрузка данных на staging и заполнение mart на PostgreSQL с идемпотентностью

### Как запустить контейнер

Запустите локально команду:

```
docker run -d --rm -p 3000:3000 -p 15432:5432 --name=de-project-sprint-3-server cr.yandex/crp1r8pht0n0gl25aug1/project-sprint-3:latest
```

После того как запустится контейнер, у вас будут доступны:

1. Visual Studio Code
2. Airflow v2.3.0
3. Database
