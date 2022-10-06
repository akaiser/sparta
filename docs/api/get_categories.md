# Categories API

## Request

```
// Path
api/org/:org/categories
```

## Response

```javascript
{
  // CategoriesJson
  "categories": [
    // CategoryJson
    {
      "id": "$uuid",
      "title": "Some title",
      "color": "$6_char_hex",
    },
    {
      "id": "$uuid",
      ...
    },
    ...
  ]
}
```

### Response contract

- All fields are mandatory.
- Categories returned are alphabetically sorted by title.
