# Rails Console Hints


## Run

```
bin/rails c
```

## Details

```
p = Player.first
```


### Data (Columns)
```
Player.columns.map { |c| [c.name, c.type] }
```

### Asociations
```
Player.reflect_on_all_associations.map(&:name)
```

### or Detail 
```
Player.reflect_on_association(:goods)
```

### Runtime Methods

```
(p.methods - ApplicationRecord.instance_methods).sort
```

**Filtered**
```
p.methods.grep(/planet/)
```

### Validations

```
Player.validators
Player.validators_on(:name)
```


