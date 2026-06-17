# myDziennik

Nieoficjalna aplikacja na Androida do obsługi eduVULCAN i Dziennika VULCAN.

## Wersja

- wersja bazowa: `1.5 - 1706261953`
- versionCode: `10007`
- gałąź Firebase: `firebase-dev`

## Warianty

- PROD: `pl.tomalawsb.mydziennik`, nazwa `myDziennik`
- DEV: `pl.tomalawsb.mydziennik.dev`, nazwa `myDziennik DEV`

Warianty mają osobne pliki `google-services.json`, nazwy i ikony, dlatego mogą działać równocześnie na jednym telefonie.

## Firebase

- PROD: `composeApp/src/prod/google-services.json`
- DEV: `composeApp/src/dev/google-services.json`

W repozytorium znajdują się szablony. Przed testami należy zastąpić je plikami pobranymi z odpowiednich projektów Firebase.

## Budowanie

- PROD: `gradlew.bat :composeApp:assembleProdRelease`
- DEV: `gradlew.bat :composeApp:assembleDevDebug`

Artefakty, pliki podpisu i pliki tymczasowe nie są przechowywane w repozytorium.

Projekt powstał na bazie `DzienniczekSzpontniczek` i zachowuje licencję MIT.
