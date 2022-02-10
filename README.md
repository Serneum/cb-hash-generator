### Usage

Run the script:
```
ruby hash-generator.rb
```

#### CLI

```
Usage: hash-generator [options]
    -h, --header HEADER              The complete header, including the timestamp and sha256 value.
    -f, --file PAYLOAD_FILE          The name of the file containing the JSON payload.
    -s, --secret SECRET
```

#### Example usage

```
ruby hash-generator.rb -h "CityBase-Signature: t=2022-02-10T03:50:54Z,sha256=<sha here>" -f payload.json -s <some secret here>
```
