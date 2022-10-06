# GET Days API

## Request

```
// Path
api/org/:org/days

// Query params
from=:utc_date&to=:utc_date

// Example
api/org/:org/days?from=2022-09-29T00:00:00Z&to=2022-09-30T23:59:59Z
```

## Response

```javascript
{
  // DaysJson
  "days": [
    // DayJson
    {
      "date": "2022-09-29",
      "day_events": [
        // DayEventJson
        {
          "id": "$uuid",
          "calender_id": "$uuid",
          "category_ids": [
            "$uuid",
            "$uuid"
          ],
          "title": "Some title",
          "description": "Some free text",
          "start_date": "2022-09-29T00:00:00Z",
          "end_date": "2022-09-29T23:59:59Z"
        },
        ...
      ]
    },
    {
      "date": "2022-09-30",
      "day_events": [
        ...
      ],
      ...
    },
    ...
  ]
}
```

### Response contract

- All fields are mandatory.
- If ("start_date".startOfDay() && "end_date".endOfDay()) -> Full day event.
- Response can contain duplicate events but on different days.
