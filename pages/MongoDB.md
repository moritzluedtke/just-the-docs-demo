# MongoDB

## Show documents where field ABC exists

```
{"an_attribute":{$exists:true}}
{"some_attribue_list.another_attribute":{$exists:true}}

db.myDatabase.find(THE_QUERY_ABOVE)
```

## Object in List has attribute and `id` starts with `de_de`

```shell
{"arrayName": {$elemMatch: { keyName: "SOME_ATTRIBUTE" }}, "_id": {$regex: "^de_de"}}
{"arrayName.keyName": "SOME_VALUE", "_id": {$regex: "^de_de"}}
```

## Access DB with `-` in name

```shell
db["some-database"]
```

## Get total number of items of all arrays in multiple documents

```shell
db["some-collection"].aggregate({$group: { _id: null, totalSize: { $sum: { $size: "$myArrayField"}} }})
```
*`_id` must be set to something that's why we set it here to `null`*

## Get size of array in document for each document

```shell
db["some-collection"].aggregate(
    [
        {
            $project: {
                _id: null,
                array_size:{ $size:"$myArrayField" },
            }
        }
    ]
)
```

## See only one attribute from array in document

```shell
# Use PROJECT (projection) e.g. in Compass
{ "some_array.some_attribute": 1 }
```

## Regex

```shell
{ some_array.some_attribute": { $regex: "," } }
```
