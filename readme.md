## Laboratorium 2

Zadanie 1:

```sh
head -n 2 program.c
```

Zadanie 2:
```sh
tail -n 4 program.c
```

Zadanie 3:
```sh
grep 'main' program.c
```

Zadanie 4:
```sh
chmod u=rw program.c
chmod g=r program.c
```

Zadanie 5:
```sh

## Labolatorium 5

ZADANIE 1

```sh
find ~/ -maxdepth 1 -mtime -10
```

ZADANIE 2

```sh
find / -name \*config\* -type f 2> /dev/null
```

ZADANIE 3

```sh
find ~/ -atime 20
```

ZADANIE 4

```sh
find /etc\(-type d -and ! empty\) -or \(-type f -and -name a*\) 2> /dev/null
```

## Labolatorium 6

ZADANIE 2

```sh
grep ^[0-9] pl*
```
ZADANIE 4

```sh
grep -c bash /etc/passwd
```

ZADANIE 5

```sh
grep [IVXLCDM] plik.txt
```