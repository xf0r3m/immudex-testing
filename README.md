![Image](https://i.ibb.co/NxtyJ3T/immudex2.png)

# IMMutable DEbian with Xfce - Testing

## GNU/LINUX Debian testing (trixie)

Immudex to wersja GNU/Linux Debian zawierająca niezmienne środowisko pracy. Wykorzystuje
ona bowiem archiwum .squashfs znane z LiveCD. Przyczym pozwala ona na pełen
dostęp do partycji zawierające archiwum, w razie aktualizacji. Tak przygotowana
wersja popularnego systemu operacyjnego pozwoli bezpieczniejsze korzystanie
z komputera oraz zasobów internetu. Jeśli coś się stanie, wystarczy uruchomić
komputer ponownie.

Immudex nastawiowny jest na wykorzystanie do przechowywania danych szyfrowanych
partycji za pomocą mechanizmu LUKS. Dodatkowy mechanizm pozwala na 
zabezpieczenie danych składowanych na tego typu partycjach, na przykład jeśli
mamy otwarte jakieś pliki na zaszyfrowanej partycji przeglądarka się nie
uruchomi. Musimy wówczas zamknąć wszystkie pliki oraz opuścić punkt montowania
szyfrowanej partycji, wtenczas zostanie ona odmontowana szyfrowany wolumin
zostanie zamknięty. Po tych czynnościach przeglądarką uruchomi się
samodzielnie. W ramach bezpieczeństwa dostępny jest również sandboxer FireJail,
zablokowano również wszelkie sieciowe połączenia przychodzące.

Immudex domyślnie korzysta z wolnego oprogramowania, nie zainstalowano na nim
niewolnych pakietów, w konfiguracji nie ma również niewolnych repozytoriów.
Do dyspozycji mamy:
  * Standardowe środowisko XFCE dostępne na Debian Testing
  * Odtwarzacz muzyki QMMP
  * Odtwarzacz multimedialny VLC
  * virt-manager (KVM)

**Uwaga! Od wersji 0.2.3, immudex-testing będzie wymagać min. 6GB wolnego
miejsca na dysku**

Obraz płyty znajduje się na dedykowanym serwisie WWW. Poniżej znajduje się 
odnośniki.

Tygodniowy build: 18.06.2023 
  
  * 64-bit: [https://ftp.morketsmerke.org/immudex/testing/iso/1.0.0/immudex-testing64.iso](https://ftp.morketsmerke.org/immudex/testing/iso/1.0.0/immudex-testing64.iso)

    CRC: 716291321 SHA1: 8fad1ec9fd7220017d94e7735917e9492d597970
  * 32-bit: [https://ftp.morketsmerke.org/immudex/testing/iso/1.0.0/immudex-testing32.iso](https://ftp.morketsmerke.org/immudex/testing/iso/1.0.0/immudex-testing32.iso)

    CRC: 3798275420 SHA1: 66caa8696196d606ff1d9181e6e5817dc4f57c98

Domyślnym użytkownikiem jest user, dostęp to niego uzyskujemy za pomocą hasła
user1. Możemy również skorzystać z konta superużytkownika root z hasłem toor.

Dokumentacja systemu znajduje się pod [tym](https://morketsmerke.github.io/articles/immudex/index.html) adresem.

immudex is not affiliated with Debian. Debian is a registered trademark owned 
by Software in the Public Interest, Inc.

[Lock icons created by Freepik - Flaticon](https://www.flaticon.com/free-icons/lock)

[Rss icons created by Freepik - Flaticon](https://www.flaticon.com/free-icons/rss)
 
