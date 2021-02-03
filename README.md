# Analog

Analog is a simple logger for any events you want. It gives you a simple sessions mechanics and two ways to view events right in your app.

## Requirements
* iOS 9+
* Swift 4.1+

## Instalation
### Depo

[Depo](https://github.com/rosberry/depo) is a universal dependency manager that combines CocoaPods, Carthage and SPM.
To integrate Analog into your Xcode project using Depo, specify it in your `Depofile`:
```yaml
carts:
  - kind: github
    identifier: rosberry/Analog
```

### Carthage
```sh
github "rosberry/Analog"
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
