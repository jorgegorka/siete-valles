# Siete Valles

![Siete valles dashboard](https://dev-to-uploads.s3.amazonaws.com/i/altqc15um5le4tuaerlt.png)

Event tracking and gamification application.

Siete Valles (seven valleys) is an open source application that you can use to track important events from your application, mobile or web page.

It includes a powerful rewards/rules system that will let you gamify any process. You can setup and configure it to your needs using the web interface or using the graphql interface.

Rules will help you detect important activities or set of activities.

Some Examples:

* You have a course on your intranet and you want to track the progress of your employees.  
* An E-commerce site wants to know the most engaged customers, tracking activities like who's creating reviews, likes, orders, sharing stuff on social media...

## Structure

1. **Create rewards.** Currently **badges** and **levels** available by default.
2. **Create events.** Events are actions users have to do like press a like button, add a comment, read a document...
3. **Add rules.** Rules will dictate how users can earn rewards. For instace a rule can be:
   _A user needs to read 10 documents to gain a badge called "Frequent Reader"_ or
   _A user needs to gain 1000 points to reach Level 2_
4. **Send activities** Activities are events that users do in a specific moment.
5. **Done!** Once you start sending activities the app will take care of saving them and checking whether that activity has result in the user winning an award. For instance: If an Event named _press like button_ earns the user 1 point and to reach level 1 you need 100 points.
   When you send 100 activities of a user doing the event, they will obtain the reward.

Check the [documentation available](https://github.com/jorgegorka/gamification/wiki).

## Examples

[Levels](https://github.com/jorgegorka/gamification/wiki/example-levels)

[Badges](https://github.com/jorgegorka/gamification/wiki/example-badges)

[Constrain rules to a specific timeframe](https://github.com/jorgegorka/gamification/wiki/example-activity-for-specific-timeframe)

[Rules with multiple conditions](https://github.com/jorgegorka/gamification/wiki/example-multiple-conditions)

## Todo

- Avoid Graphql gem doing N+1 queries [How to solve it](https://www.youtube.com/watch?v=gMm4andQdh0)
- Add Redis to send notifications when new awards are received.

## About

Siete Valles means Seven Valleys. This is [where the name comes from](https://en.wikipedia.org/wiki/La_Rioja#Hydrography).

Created by [Jorge Alvarez](https://www.alvareznavarro.es)
