
# Simple Ticket Widget

[![pub package](https://img.shields.io/badge/pub-1.0.1-blue.svg)](https://pub.dev/packages/simple_ticket_widget)

A simple, ticket-style clipper widget for your Flutter project that supports both horizontal and vertical orientations, with built-in shadow effect and corner radius.

<div> 
  <img width="300" height="600" src="https://raw.githubusercontent.com/hemantbeast/simple_ticket_widget/refs/heads/main/screenshots/Screenshot_1.png" />
  <img width="300" height="600" src="https://raw.githubusercontent.com/hemantbeast/simple_ticket_widget/refs/heads/main/screenshots/Screenshot_2.png" />
</div>

## Getting started

Add the dependency to pubspec.yaml

```yml
dependencies:
  simple_ticket_widget: ^1.0.1
```

Import the package.

```Dart
import 'package:simple_ticket_widget/simple_ticket_widget.dart';
```

Use the widget in your code.

```Dart
SimpleTicketWidget(
    position: 50,
    arcRadius: 20,
    direction: Axis.horizontal,
    child: Container(
        color: Colors.green,
        height: 200,
        width: 350,
        alignment: Alignment.center,
        child: Text('Ticket Clipper'),
    ),
),
```

## Usage

| Parameter        |      Default      |                                 Description |
|------------------|:-----------------:|--------------------------------------------:|
| **arcRadius**    |       16.0        |          The circular arc radius of ticket. |
| **direction**    |   Axis.vertical   |     The direction of the ticket widget arc. |
| **position**     |        100        | The position of the arc based on direction. |
| **borderRadius** | BorderRadius.zero |            The corner radius of the ticket. |
| **shadowColor**  |   Colors.black    |             The shadow color of the ticket. |
| **blurRadius**   |        4.0        |                     The shadow blur radius. |

## Example
The sample code can be found under the `example` package.
You can try changing all parameters.