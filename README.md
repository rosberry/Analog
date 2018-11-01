# Analog

Analog is a simple logger for any events you want. It gives you a simple sessions mechanics and two ways to view events right in your app.

## Requirements
* iOS 10+

## Instalation
```sh
$ github "rosberry/Analog"
```

## Usage

All you need to log event is just to create instance of `Logger` and call `log(Event)` method.

`Event` is a class which have `title`, `parameters` and `date` properties.

All events take their places in sessions. `Session` is just a container for events with `UUID`. All sessions automatically save on disk in `Documents/Analog/Sessions` on every `willResignActiveNotification`.

If you want to view your events you can do it easily. Just present `logger.currentEventsModule()`. Also you have an ability to view all sessions by presenting `logger.sessionsModule()`. Also you can share a plain text of session with "Share" button in concrete session log screen.

## Authors

* Anton Kovalev, anton.kovalev@rosberry.com

## About

<img src="https://github.com/rosberry/Foundation/blob/master/Assets/full_logo.png?raw=true" height="100" />

This project is owned and maintained by [Rosberry](http://rosberry.com). We build mobile apps for users worldwide 🌏.

Check out our [open source projects](https://github.com/rosberry), read [our blog](https://medium.com/@Rosberry) or give us a high-five on 🐦 [@rosberryapps](http://twitter.com/RosberryApps).
