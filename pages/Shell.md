# Shell

## Count line numbers in file

```shell script
grep -w "^.*$" -c input-file.txt
```

## Replace char with other char in large text file

```shell
# Repeat multiple times
# Overrides the original file progressively
# -i.bak creates a backup file while changing the original
# but the backup file will be overridden with every call and thus be the new file at the end)
sed -i.bak $'s/\t\t/;/' categories_semicolon.csv
```

## Replace char with other char in large text file

```shell
# Repeat multiple times
# Overrides the original file progressively
# -i.bak creates a backup file while changing the original
# but the backup file will be overridden with every call (just ignore it, but without it won't work)
sed -i.bak $'s/\t\t/;/' file_to_change.csv
```

## Batch rename files (Mac)

```shell
for f in *.csv; do mv "$f" "$(echo "$f" | sed s/.csv/_semicolon.csv/)"; done

# Explained
for f in EVERY_FILE_TO_CHANGE; do mv "$f" "$(echo "$f" | sed s/OLD_TEXT/NEW_TEXT/)"; done
```

## Download SSL certificate

```shell
function ssl-download-certificate {
  local host=$1
  local port=${2:-443}
  openssl s_client -showcerts -connect "${host}:${port}" </dev/null 2>/dev/null | openssl 'x509' -outform 'PEM' > "${host}:${port}.pem"
}
```

Usage:
```shell
$ ssl-download-certificate my-host:123
```

Credit: Bengt Brodersen
