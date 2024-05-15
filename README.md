# Origo – City bikes

## About the setup

Very basic backend server in Kotlin, using [Ktor]().

Frontend in [Elm](https://elm-lang.org/), using  [elm-land](https://elm.land) for routing/SPA functionality and [elm-css](https://package.elm-lang.org/packages/rtfeldman/elm-css/latest/) / [elm-tailwind-modules](https://matheus23.github.io/elm-tailwind-modules/) for styling. 

Frontend assets collected from [Oslo Punkt](https://punkt.oslo.kommune.no/latest/kom-i-gang/for-utviklere/assets/).

## Run using docker

## Run by just using your terminal
### Backend
Run the backend module `Application.kt` via your IDE, or:

Compile:
```shell
kotlinc Application.kt -include-runtime -d application.jar
```
Then run:
```shell
kotlin -classpath application.jar ApplicationKt
```
### Frontend
Navigate to frontend module `frontend/`. Make sure dependencies are installed:

```shell
yarn install
```

Then start the application:

```shell
yarn start
```

See `frontend/package.json` for command details.

##