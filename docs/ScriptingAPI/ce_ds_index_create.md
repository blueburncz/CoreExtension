# ce_ds_index_create
`script`
```gml
ce_ds_index_create()
```

## Description
Creates a new index, which is a map designed for holding another maps
 and retrieving them quickly by their properties. You can think of it as of
 a simple in-memory database. Currently only properties with string of real
 values are indexed (keys that have arrays etc. as values won't be indexed).

## Returns
`real` The id of the created index.

## Note
 Reindexing data is currently not supported, so you should not edit the
maps once they are added to the index, otherwise it won't work properly!