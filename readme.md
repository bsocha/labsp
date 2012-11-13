## Laboratorium 2:

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

##Laboratorium 4

Zadanie 1:
```sh
ls | tr a-z A-Z
```

Zadanie 2:
```sh
ls -l | cut -b 1-10,30-34,47-
```

Zadanie 3:
```sh
ls --sort=size -l
```

Zadanie 4:
```sh
cat /etc/passwd/ | sort --reverse --general-numeric-sort
```

Zadanie 5:
```sh
cat /etc/passwd | sort -r --field-separator=":" -g -k 4,3
```

Zadanie 6:
```sh
find / -printf "%u\n" 2> /dev/null | sort | uniq -c
```
```sh
cat /etc/passwd/ | sort --reverse --general-numeric-sort
```

##Laboratorium 5:

Zadanie 1:
```sh
find ~/ -maxdepth 1 -mtime -10
```

Zadanie 2:
```sh
find / -name \*config\* -type f 2> /dev/null
```

Zadanie 3:
```sh
find ~/ -atime 20
```

Zadanie 4:
```sh
find /etc\(-type d -and ! empty\) -or \(-type f -and -name a*\) 2> /dev/null
```

##Laboratorium 6

Zadanie 1:
```sh
grep . {1,} plik.txt
```

Zadanie 2:
```sh
grep ^[0-9] pl*
```

Zadanie 3:
```sh
ls -1 | grep -E '.{8}r.'
```

Zadanie 4:
```sh
grep -c bash /etc/passwd
```

Zadanie 5:
```sh
grep [IVXLCDM] plik.txt
```