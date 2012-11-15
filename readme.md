## Laboratorium 1:

Zadanie 10:
```sh
cal -3m
cal 11 2009 -3m
```

Zadanie 11:
```sh
date -d 1975-05-25 +%A
```

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
chmod u+rw program.c
chmod g+r program.c
chmod o-rwx program.c
```

Zadanie 5:
```sh
mv dom/wazne-sprawy/ praca/
```

Zadanie 6:
```sh
zip -r temp.zip temp
```

Zadanie 7:
```sh
rm -R temp
```

Zadanie 8:
```sh
tar xf temp.tar
unzip temp.zip
```

Zadanie 9:
```sh

```

##Laboratorium 3:

Zadanie 1:
```sh
more -5 /etc/passwd
```

Zadanie 2:
```sh
cat tekst1.txt - tekst2.txt > tekst3.txt
```

Zadanie 3:
```sh
head $HOME/* -n 5 -q
```

Zadanie 4:
```sh
head -n 5 /etc/passwd |tail -n 3
```
Zadanie 5:
```sh
tail -n 7 /etc/passwd | head -n 3
```
Zadanie 6:
```sh
cat /etc/passwd |tr "n" " "
```

Zadanie 7:
```sh
cat plik.txt | tr " \t" "\n"
```

Zadanie 8:
```sh
head -n 0 /etc/* | tr -s '[n*2]' 'n' | wc -l
```

Zadanie 9:
```sh
cut /etc/passwd | head -n 3 | wc -n
```

##Laboratorium 4:

Zadanie 1:
```sh
ls | tr a-z A-Z
```

Zadanie 2:
```sh
find . -printf "Plik: %f Rozmiar: %s Prawa: %M \n" -maxdepth 1
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

Zadanie 6:
```sh
touch xaa xab xac
rm x??
ls x*
```

Zadanie 7:
```sh
mkdir `date +%Y-%m-%d`
```