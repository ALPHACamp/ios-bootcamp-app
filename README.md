# ios-bootcamp-app

# First time install

Open terminal, change directory to the path you want. For example:

```
$ cd ios-projects
```

Clone github project to the path. You may find the clone URL on the home page right hand side SSH clone URL section.
```
git clone git@github.com:ALPHACamp/ios-bootcamp-app.git
``` 

Install [cocoapods](http://cocoapods.org/). (If you already have, then skip this.)  

Install pods file under root directory.  
```
$ pod install
```

Now you can open ALPHACampApp.xcworkspace

# Update to latest version

Open terminal, change directory to the project path.

```
$ cd ios-projects
```

We want to update to the latest code from github.
```
$ git pull --rebase
```

Update pods file under root directory.  
```
$ pod install
```  
Now you can open ALPHACampApp.xcworkspace

# Third-party library

They are list in the Podfile.
