# Интерфейсы обмена данными СУМ

Формат: JSON (UTF-8), заголовок `Content-Type: application/json`. Даты в формате ISO 8601. Ошибка возвращается как `{"error": "код", "message": "текст"}`.

| Код | Метод и адрес | Назначение | Параметры | Коды ответа |
|---|---|---|---|---|
| ИФ-01 | GET /supplier/prices | Получить прайс и наличие поставщика | нет | 200 |
| ИФ-02 | POST /supplier/orders | Отправить заявку поставщику | тело: заявка | 201, 400 |
| ИФ-03 | POST /api/sales | Принять продажу от кассы | тело: чек | 201, 400, 404, 409 |
| ИФ-04 | GET /api/stock/{sku} | Отдать остаток товара | sku в адресе | 200, 404 |
| ИФ-05 | GET /api/movements | Выгрузить движение товаров | from, to | 200, 400 |

## ИФ-01. Прайс поставщика (ответ)
```json
{
  "supplierId": "SUP-001",
  "items": [
    {
      "sku": "A-1001",
      "name": "Дрель ударная",
      "price": 4500,
      "available": 120
    },
    {
      "sku": "A-1002",
      "name": "Шуруповёрт",
      "price": 3200,
      "available": 80
    }
  ]
}
```

## ИФ-02. Заявка поставщику
Запрос:
```json
{
  "orderId": 1,
  "supplierId": "SUP-002",
  "createdAt": "2026-10-14T15:20:00Z",
  "items": [
    {
      "sku": "B-2002",
      "quantity": 30
    }
  ]
}
```
Ответ:
```json
{
  "orderId": 1,
  "status": "accepted"
}
```

## ИФ-03. Продажа от кассы
Запрос:
```json
{
  "docNumber": "CH-000106",
  "createdAt": "2026-10-16T12:35:10Z",
  "items": [
    {
      "sku": "A-1001",
      "quantity": 2,
      "price": 4500
    }
  ]
}
```
Ответ:
```json
{
  "status": "accepted",
  "docNumber": "CH-000106"
}
```

Ошибки: 404 (неизвестный артикул), 409 (недостаточно товара на складе).

## ИФ-04. Остаток товара (ответ)
```json
{
  "sku": "A-1001",
  "name": "Дрель ударная",
  "quantity": 37,
  "unit": "шт",
  "updatedAt": "2026-10-12T12:20:00Z"
}
```

## ИФ-05. Движение товаров (ответ)
Запрос: `GET /api/movements?from=2026-10-01&to=2026-10-16`
```json
{
  "from": "2026-10-01",
  "to": "2026-10-16",
  "movements": [
    {
      "id": 1,
      "sku": "A-1001",
      "type": "receipt",
      "quantity": 50,
      "price": 4000,
      "docNumber": "PN-0001",
      "createdAt": "2026-10-05T09:00:00Z"
    },
    {
      "id": 6,
      "sku": "A-1001",
      "type": "sale",
      "quantity": 13,
      "price": 4500,
      "docNumber": "CH-000101",
      "createdAt": "2026-10-12T12:20:00Z"
    },
    {
      "id": 11,
      "sku": "B-2001",
      "type": "write_off",
      "quantity": 3,
      "price": null,
      "docNumber": "AS-0001",
      "createdAt": "2026-10-15T11:00:00Z"
    }
  ]
}
```
