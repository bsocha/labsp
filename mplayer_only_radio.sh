#!/bin/bash

clear
echo "Wybierz stacje radiowa"
echo ""
echo "W razie potrzeby wpisac => mplayer -h <= gdyz skrypt bazuje na mplayerze"
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
		"Nagrywanie RMF FM") adres1="http://217.74.72.3:8000/rmf_fm" ;;
		"Nagrywanie RMF Classic") adres2="http://217.74.72.3:8000/rmf_classic" ;;
		"Nagrywanie RMF Maxxx") adres3="http://217.74.72.3:8000/rmf_maxxx" ;;
		"Nagrywanie RMF 90s") adres4="http://217.74.72.3:8000/rmf_90s" ;;
		"Nagrywanie RMF 80s") adres5="http://217.74.72.3:8000/rmf_80s " ;;
		"Nagrywanie RMF 2000") adres6="http://217.74.72.3:8000/rmf_2000 " ;;
		"Nagrywanie RMF Reggae") adres7="http://217.74.72.3:8000/rmf_reggae" ;;
		"Nagrywanie Eska Rock") adres8="http://poznan5.radio.pionier.net.pl:8000/eskarock.mp3" ;;
		"Nagrywanie Zlote Przeboje") adres9="http://poznan5-6.radio.pionier.net.pl:8000/tuba9-1.mp3" ;;
		"Nagrywanie Planeta FM") adres10="http://planetamp3-01.eurozet.pl:8400" ;;
		"Zakoncz") exit ;;
	esac
break
done
mplayer $adres
mplayer $adres1 -ao pcm:file=RMF_FM.mp3
mplayer $adres2 -ao pcm:file=RMF_Classic.mp3
mplayer $adres3 -ao pcm:file=RMF_Maxxx.mp3
mplayer $adres4 -ao pcm:file=RMF_90s.mp3
mplayer $adres5 -ao pcm:file=RMF_80s.mp3
mplayer $adres6 -ao pcm:file=RMF_2000.mp3
mplayer $adres7 -ao pcm:file=RMF_Reggae.mp3
mplayer $adres8 -ao pcm:file=Eska_Rock.mp3
mplayer $adres9 -ao pcm:file=Zlote_Przeboje.mp3
mplayer $adres10 -ao pcm:file=Planeta_FM.mp3
