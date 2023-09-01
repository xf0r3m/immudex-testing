![Image](https://i.ibb.co/NxtyJ3T/immudex2.png)

# IMMutable DEbian with Xfce

## GNU/LINUX Debian testing (trixie)

To repozytorium zawiera pliki służące do tworzenia dystrybucji immudex.
Zawiera ono wiele ciekawych informacji, jednak podstawowe infomacje na temat 
tej dystrybucji znajdują się pod adresem:

[https://morketsmerke.github.io/articles/immudex/immudex.html](https://morketsmerke.github.io/articles/immudex/immudex.html)

### Tworzenie obrazu płyty dystrybucji:
  
  ```
  $ git clone https://github.com/xf0r3m/immudex-testing
  $ cd immudex-testing
  $ ./immudex-build --<amd64/i386>
  ```

### Dodawanie zmian do obrazu płyty:

Aby dołączyć jakiekolwiek zmiany do obrazu płyty należy przed rozpoczęciem
procesu tworzenia obrazu płyty umieścić modyfikacje, przed poleceniem `tidy` w
pliku *versions/base.sh*.

### Zastrzeżenia i uznanie autorstwa:

immudex is not affiliated with Debian. Debian is a registered trademark owned 
by Software in the Public Interest, Inc.

[Rss icons created by Freepik - Flaticon](https://www.flaticon.com/free-icons/rss)
 
