# Visual Notes app

This a visual notes app that using Clean Architecture and sqflite for local storage.

There are 3 main Layers to help separate the code:

1- Domain.                                                                                                                                                                       
2- Data.                                                                                                                                                                         
3- Presentation.                                                                                                                                                                                                                                                                                                                                                 

Domain Layer:
defines the business logic of the application and contains UseCases, Domain Entities, and Repository Interfaces.

Data Layer:
responsible for data retrieval and contains APIs, Local Storage, Data objects (Request, Response and DB objects), and the Repository Implementation.

Presentation
the UI of the application and contains Screens, Widgets and Presentation logic.


## Libraries
* [Get](https://pub.dev/packages/get)
* [GetIt](https://pub.dev/packages/get_it)
* [image_picker](https://pub.dev/packages/image_picker)
* [sqflite](https://pub.dev/packages/sqflite)
* [path_provider](https://pub.dev/packages/path_provider)
* [bot_toast](https://pub.dev/packages/bot_toast)
* [datetime_picker_formfield](https://pub.dev/packages/datetime_picker_formfield)
