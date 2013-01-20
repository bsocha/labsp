#!/bin/bash

clear
echo "Wybierz stacje radiowa"
echo ""
echo "UWAGA! GDY NAGRYWASZ MOZESZ SLUCHAC NAGRYWANEGO RADIA WPISUJAC => mplayer http://localhost:8000 <= W INNYM TERMINALU"
echo ""
select radio in RMF' 'FM Nagrywanie' 'RMF' 'FM RMF' 'Classic Nagrywanie' 'RMF' 'Classic RMF' '80s Nagrywanie' 'RMF' '80s RMF' '90s Nagrywanie' 'RMF' '90s RMF' '2000 Nagrywanie' 'RMF' '2000 RMF' 'Reggae Nagrywanie' 'RMF' 'Reggae Eska' 'Rock Nagrywanie' 'Eska' 'Rock Zlote' 'Przeboje Nagrywanie' 'Zlote' 'Przeboje Planeta' 'FM Nagrywanie' 'Planeta' 'FM Zakoncz

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
		"Nagrywanie RMF FM") adresn="http://217.74.72.3:8000/rmf_fm" ;;
		"Nagrywanie RMF Classic") adresn="http://217.74.72.3:8000/rmf_classic" ;;
		"Nagrywanie RMF Maxxx") adresn="http://217.74.72.3:8000/rmf_maxxx" ;;
		"Nagrywanie RMF 90s") adresn="http://217.74.72.3:8000/rmf_90s" ;;
		"Nagrywanie RMF 80s") adresn="http://217.74.72.3:8000/rmf_80s " ;;
		"Nagrywanie RMF 2000") adresn="http://217.74.72.3:8000/rmf_2000 " ;;
		"Nagrywanie RMF Reggae") adresn="http://217.74.72.3:8000/rmf_reggae" ;;
		"Nagrywanie Eska Rock") adresn="http://poznan5.radio.pionier.net.pl:8000/eskarock.mp3" ;;
		"Nagrywanie Zlote Przeboje") adresn="http://poznan5-6.radio.pionier.net.pl:8000/tuba9-1.mp3" ;;
		"Nagrywanie Planeta FM") adresn="http://planetamp3-01.eurozet.pl:8400" ;;
		"Zakoncz") exit ;;
	esac
break
done
mplayer $adres
streamripper $adresn -r
