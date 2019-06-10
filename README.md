# DemoSurvey

### Targets:

- Create an application that allows users to browse a list of surveys. 
- Integrate with an API to retrieve data.
- Write unit tests.

<center>
	<img src="./Images/img-toppage.png" width="300">
</center>

### Working progress:

- [x] Base service
- [x] Implement UI
- [x] Bind data
- [ ] Unit test [/wip]

### Application info:

- Using Cocoa Pods.
- Target iOS >= 10.0.
- Using MVVM architecture.
- Unit testing with `Quick`, `Nimble`, `OHHTTPStub`.

### Installation:

- Install Homebrew. You can find install instruction [here](https://github.com/nmint8m/macinstall#-homebrew).
- Install Bundle with Homebrew. You can find install instruction [here](https://github.com/nmint8m/macinstall#-homebrew-bundle).
- Install rbenv. You can find install instruction [here](https://github.com/nmint8m/macinstall#-rbenv). And use local version `2.5.1` for this project.

```bash
$ rbenv install 2.5.1
$ rbenv local 2.5.1
```

- Clone this repository, go to the folder that contains this project. Then run this command:

```bash
$ bundle exec pod install
```

- Run the project.

### More notes:

This part is just for note.

- Swipe to back.
- LoadMoreController.