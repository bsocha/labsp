#!/bin/bash

clear
echo "Wybierz stacje radiowa"
echo ""
select radio in RMF' 'FM RMF' 'Classic RMF' 'Maxxx RMF' '90s RMF' '80s RMF' '2000 RMF' 'Reggae Eska' 'Rock Zlote' 'Przeboje Planeta' 'FM Zakoncz

do
  case $radio in
		"RMF FM") adres="http://217.74.72.3:8000/rmf_fm" ;;
		"RMF Classic") adres="http://217.74.72.3:8000/rmf_classic" ;;
		"RMF Maxxx") adres="http://217.74.72.3:8000/rmf_maxxx" ;;
		"RMF 90s") adres="http://217.74.72.3:8000/rmf_90s" ;;
		"RMF 80s") adres="http://217.74.72.3:8000/rmf_80s " ;;
		"RMF 2000") adres="http://217.74.72.3:8000/rmf_2000 " ;;
		"RMF Reggae") adres="http://217.74.72.3:8000/rmf_reggae" ;;
		"Eska Rock") adres="http://poznan5.radio.pionier.net.pl:8000/eskarock.mp3" ;;
		"Zlote Przeboje") adres="http://poznan5-6.radio.pionier.net.pl:8000/tuba9-1.mp3" ;;
		"Planeta FM") adres="http://planetamp3-01.eurozet.pl:8400" ;;
		"Zakoncz") exit ;;
	esac
break
done
mplayer $adres
