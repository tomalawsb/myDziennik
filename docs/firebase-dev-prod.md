# Firebase DEV i PROD

## Pakiety

- PROD: `pl.tomalawsb.mydziennik`
- DEV: `pl.tomalawsb.mydziennik.dev`

## Konfiguracje

- `composeApp/src/prod/google-services.json`
- `composeApp/src/dev/google-services.json`

Obecne pliki są szablonami. Zastąp je plikami pobranymi z dwóch właściwych aplikacji Android w Firebase. Nie zamieniaj ich miejscami.

## Budowanie

- PROD: `gradlew.bat :composeApp:assembleProdRelease`
- DEV: `gradlew.bat :composeApp:assembleDevDebug`
