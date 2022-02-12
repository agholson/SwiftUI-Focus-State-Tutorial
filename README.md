#  Focus State Tutorial
This project explains how to use the `FocusState` iOS 15 parameter. It is based on SwiftFul Thinking's, Nick Sarno's excellent 
iOS Boot Camp tutorial
[How to use @FocusState in SwiftUI | Bootcamp #60](https://www.youtube.com/watch?v=9OC8e0OULBg). The `.focused` parameter can be used
to pop a user right back up to fill in a field he or she perhaps forgot to fill in as part of a form.

The `FocusState` paramater allows us to programmatically activate a `TextField` with the user's keyboard.

- [Focus State Tutorial](#focus-state-tutorial)
- [Design](#design)
- [Code](#code)
  - [Make TextField Selected at Launch](#make-textfield-selected-at-launch)
  - [Multiple Text Fields](#multiple-text-fields)

# Design
[Shows the app's appearance](img/design.png)

# Code
Setup code:
```
struct ContentView: View {
    
    // Boolean equal to whether/ not the text field is clicked
    @FocusState private var usernameInFocus: Bool
    @State var username: String = ""
    
    var body: some View {
        VStack {
            TextField("Add your name here...", text: $username)
                .focused($usernameInFocus)
                .padding(.leading) // Pushes text inwards towards center
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.gray.brightness(0.3))
                .cornerRadius(10)
        }
        .padding(40)
        
        Button("TOGGLE FOCUS STATE") {
            // Makes the boolean take the opposite value
            usernameInFocus.toggle()
        }
        
    }
}
```

## Make TextField Selected at Launch
If we set the `usernameInFocus` boolean to true, by hitting the button, then it will pop-up the user's keyboard at that add name `TextField`.
You can even choose to make the username field active after the screen's launch with the following code added as a modifier to the `VStack`:
```
VStack {...}
.onAppear {
    // As soon as the View loads, wait a tenth of a second, then toggle the userNameInFocus
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        usernameInFocus.toggle()
    }
}
```

## Multiple Text Fields
Instead of having multiple `@FocusState` properties for each of the `TextField`s, you can replace it with a single `@FocusState`
by using a custom `enum`. 

First, define the `enum`:
```
// Case that dictates, which field to place in focus
// Made hashable so it can be used with the FocusedState
enum OnboardingField: Hashable {
    case username
    case password
}
```
Next, make one `@FocusState` property as a type of this new `OnboardingField enum`:
```
// Tracks the field in focus
@FocusState private var fieldInFocus: OnboardingField?  // Optional, by default, no field is in focus
```
From here, modify the `.focused` modifier, so it uses the `equals` versus `condition` argument. Set it equal to the name
of the username or password, you want to control:
```
TextField("Add your name here...", text: $username)
    .focused($fieldInFocus, equals: .username)
```



