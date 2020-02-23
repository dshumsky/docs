#### Android development

- https://hackernoon.com/web-apps-turn-website-into-mobile-app-your-four-best-options-78fcb2277be8
- https://blog.jscrambler.com/react-native-vs-ionic-vs-nativescript-a-practical-guide/
- https://ionicframework.com/getting-started
- https://www.techiediaries.com/ionic-ui-forms-theming/
- https://www.techiediaries.com/ionic/ionic-5-jwt-authentication-node-expressjs/
- https://www.freecodecamp.org/news/how-to-turn-your-website-into-a-mobile-app-with-7-lines-of-json-631c9c9895f5/
- https://jasonelle.com/jasonette-old-docs/android/"

#### Mount
```
sudo apt-get install mtp-tools jmtpfs
sudo mtp-detect
jmtpfs ~/android

# vim ~/.bashrc
alias android-mount="jmtpfs ~/android"
alias android-unmount="fusermount -u ~/android"
```

