# Origo – City bikes

## About the setup

### Stack
Very basic backend server in Kotlin, using [Ktor](https://ktor.io/docs/welcome.html).

Frontend in [Elm](https://elm-lang.org/), using [elm-land](https://elm.land) for routing/SPA functionality and [elm-css](https://package.elm-lang.org/packages/rtfeldman/elm-css/latest/) / [elm-tailwind-modules](https://matheus23.github.io/elm-tailwind-modules/) for styling. 

Frontend assets collected from [Oslo Punkt](https://punkt.oslo.kommune.no/latest/kom-i-gang/for-utviklere/assets/).

### Is this a viable setup?

No. A full-fledged SPA is way too much for the goal of the application (diisplay bike data). This is a showcase of my capabilities of setting up more complex applications. 

The required build tools, styling setup and overall complexity are overkill. 

A _plain_ Elm application (without e.g. elm-land, elm-spa or elm-pages), or just plain ol' HTML from the backend would be a better choice.

## Run using docker

> TODO.

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