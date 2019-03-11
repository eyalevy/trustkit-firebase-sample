# trustkit-firebase-sample

- This repository illustrates a collision between trustkit and the firebase sdk on ios.
- Run this react native project with this command: ```react-native start ios```
- you will see the crash: ```Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[GTMSessionFetcher setFetcher:forTask:]: unrecognized selector sent to instance```
- it seems like the issue is caused due to swizzeling ios networking apis.
