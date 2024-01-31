# BookMe

Проект, который помогает договариваться о встречах **быстро** и **без лишних ожиданий** от собеседника.

В этом приложении вы можете:
1. Создавать тайм-слоты, которые вы готовы выделить для гостя.
2. Отправлять эти тайм-слоты гостю.
3. Гость выбирает наиболее удобный вариант.
4. Вы получаете уведомление о выборе гостем времени.
5. Тайм-слот автоматически бронируется в вашем календаре.

## Технологии:
- Dart/Flutter (Frontend)
- Java / SpringBoot (Backend)
- Spring Security (Backend)
- Keycloak для авторизации (Backend)
- PostgreSQL
- Liquibase
- Docker
- Kafka для сообщений между сервисами
- SMTP для отправки пригласительных писем

## Участники проекта:
- [Владимир Сорокин](https://t.me/customidze) - **Frontend**
- [Айчурок Ибраимова](https://t.me/aichurok_i) - **Frontend**
- [Семенов Филипп](https://t.me/semenovfilipp) - **Backend**

### Авторизация/Регистрация
<img src="docs/Календарь_фото/1.jpg" alt="Фото 1" width="200" height="">
<img src="docs/Календарь_фото/9.jpg" alt="Фото 9" width="200" height="">

#### Авторизация
- Проверка пользователя осуществляется по email.
- Каждый пользователь получает JWT токен после авторизации.
- Все запросы к API проходят через токен, который проверяется на стороне Java.

#### Регистрация
- Регистрация происходит по email.
- После регистрации пользователь получает письмо с подтверждением.
- Для безопасности запроса токен проверяется при каждом запросе и может быть обновлен.

<img src="docs/Календарь_фото/2.jpg" alt="Фото 2" width="300" height="">
<img src="docs/Календарь_фото/3.jpg" alt="Фото 3" width="300" height="">
<img src="docs/Календарь_фото/4.jpg" alt="Фото 4" width="300" height="">
<img src="docs/Календарь_фото/5.jpg" alt="Фото 5" width="300" height="">
<img src="docs/Календарь_фото/6.jpg" alt="Фото 6" width="300" height="">
<img src="docs/Календарь_фото/7.jpg" alt="Фото 7" width="300" height="">
<img src="docs/Календарь_фото/8.jpg" alt="Фото 8" width="300" height="">
<img src="docs/Календарь_фото/9.jpg" alt="Фото 9" width="300" height="">
<img src="docs/Календарь_фото/10.jpg" alt="Фото 10" width="300" height="">
<img src="docs/Календарь_фото/11.jpg" alt="Фото 11" width="300" height="">
<img src="docs/Календарь_фото/12.jpg" alt="Фото 12" width="300" height="">


