# queries

```json
// returns collections where images key exists
find({ "image": { "$exists": 1 } }) // 1 or true?

// multiple AND conditions
find({
  "image": { "$exists": 1 },
  "zone.6b": 12,
}) // returns if image is true and zone.6b nested key is 12

// multiple $or conditions

find({
  "image": { "$exists": 1 },
  "$or" : [
    { "zone.6b" : 12 },
    { "zone.7a" : 6 }
  ]
})

find(
{"ltm.edge" : "test"}
) // ltm can be a list of dicts "ltm" : [{ "edge" : { "test" : "v"}}]
// returns edge if it exists in the array
```

### projections or field filtering

```json
// field filter -> returns only fields specified by 1

find({ "name" : "test"}, { "name": 1, "age" : 0}) // returns only field "name"

find({ "name" : "test"}, { "name": 1, "age" : 0, "_id" : 0}) // returns only field "name"
// also removes "_id" from document, we dont have to filter


```

### text indexes

https://www.youtube.com/watch?v=dTN8cBDEG_Q
