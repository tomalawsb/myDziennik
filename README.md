# myDziennik

Nieoficjalna aplikacja na Androida do obsługi eduVULCAN i Dziennika VULCAN.

Repozytorium: https://github.com/tomalawsb/myDziennik

## Budowanie APK w Windows

Uruchom plik:

```text
ZBUDUJ_APK.bat
```

Skrypt automatycznie:

- sprawdza lub instaluje JDK 17,
- pobiera Android SDK Command-line Tools, jeśli SDK nie jest dostępne,
- instaluje wymagane składniki Android SDK,
- tworzy stały klucz podpisu aplikacji przy pierwszym uruchomieniu,
- buduje podpisane APK w katalogu `dist`.

## Wysyłka na GitHub

Uruchom:

```text
WYSLIJ_NA_GITHUB.bat
```

Skrypt buduje APK, synchronizuje kod z repozytorium i publikuje APK w GitHub Releases.
Adres repozytorium jest zapisany na stałe jako `https://github.com/tomalawsb/myDziennik.git`.

## Ważne

Katalog `.signing` zawiera klucz podpisu. Nie jest wysyłany na GitHub. Trzeba zachować jego kopię, ponieważ wszystkie przyszłe aktualizacje APK muszą być podpisane tym samym kluczem.

## Wersja

- wersja aplikacji: `1.0 - 1606261701`
- tag wydania: `v1.0-1606261701`
- plik APK: `myDziennik-v1.0-1606261701.apk`

## Pochodzenie projektu

Projekt powstał na bazie otwartoźródłowego projektu `DzienniczekSzpontniczek` autorstwa `szponciciel04`, udostępnionego na licencji MIT. Oryginalna licencja została zachowana w pliku `LICENSE`.

Aplikacja jest projektem nieoficjalnym i nie jest produktem firmy VULCAN.
