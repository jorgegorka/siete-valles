# Gamification

This application will let you gamify any process. It uses a graphql interface that will allow you to integrate it easily with your current application.

The basic structure is like this:

1. **Create rewards.** Currently **badges** and **levels** available.
2. **Create events.** Events are actions users have to do like press a like button, add a comment, read a document...
3. **Add rules.** Rules will dictate how users can earn rewards. For instace a rule can be:
   _A user needs to read 10 documents to gain a badge called "Frequent Reader"_ or
   _A user needs to gain 1000 points to reach Level 2_
4. **Send activities** Activities are events that users do in a specific moment.
5. **Done!** Once you start sending activities the app will take care of saving them and checking whether that activity has result in the user winning an award. For instance: If an Event named _press like button_ earns the user 1 point and to reach level 1 you need 100 points.
   When you send 100 activities of a user doing the event, they will gain the reward.

## Structure

Check the [documentation available](https://github.com/jorgegorka/gamification/wiki).

## Examples

[Some examples of use](https://github.com/jorgegorka/gamification/wiki/Examples)

## Todo

- Avoid Graphql gem doing N+1 queries [How to solve it](https://www.youtube.com/watch?v=gMm4andQdh0)
- Add Redis to send notifications when new awards are received.

## About

Created by [Jorge Alvarez](https://www.alvareznavarro.es)
