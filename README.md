![License](https://img.shields.io/github/license/jorgegorka/siete-valles.svg)
![Code climate](https://img.shields.io/codeclimate/maintainability/jorgegorka/siete-valles.svg)
[![CircleCI](https://circleci.com/gh/jorgegorka/siete-valles.svg?style=svg)](https://app.circleci.com/projects/project-dashboard/github/jorgegorka/)

# Siete Valles

##  Siete Valles is an event tracking and gamification engine.

With Siete Valles you can easily track user activities like adding a coment, watching a video, visiting a webpage, commiting code to a repository, submiting a form, etc.

You can then "gamify" those activities assigning points or rewards to them. For instance:

* Add 2 points to the user everytime they add a new comment.
* Add the reward "Avid reader" to a user when they click on 10 or more links in our documentation site.

What gamification does is to increase the engagement of users. When users receive feedback after completing tasks (it could be by leveling up or by receiving badges acknowledging their effort), users tend to be more involved and continue performing the tasks in the long term because they have a sense of progress and improvement.

### Examples

* Onboarding. Both you and the user can keep track of the progress when performing the onboarding tasks.
* User Profile. Show a progress bar indicating how much information users have entered in their profile pages.
* Long term progress. Boost your user's invovement and sense of progress by giving them feedback of their achievements.
* Performance. Check the performance of your team members, compare different users and track how much tasks they have completed.
* Goal meassurement. Define rules to track the progress of an activity or a group of activities so you can evaluate the progress of the goal.
* Unused features. Detect parts of your intranet or your application that are seldom visited.

### How it works

1. Define all the events (user actions) that you want to track. Ex. Get 1 point after visiting a webpage.
2. Add Rewards. Ex. Level 1 - Apprentice
3. Create the rules that will grant a reward. Ex. When reaching 50 points assign Level 1

Other features:

Add rewards based on a single event: Ex. Get the reward "Sales pro" after watching a video about "How to close sales".

Add rewards based on events performed on a specific timeframe. Ex. Get the reward "Employee of the quarter" to the user that adds more comments to the company's intranet during the third quarter.

### Documentation

You can read all the [documentation in the wiki](https://github.com/jorgegorka/siete-valles/wiki).

### Technology

* Rails 7
* Graphql
* Sidekiq
* TailwindCss

## Credits

Siete Valles has been developed by [Jorge Alvarez](https://www.alvareznavarro.es).

## License

Siete Valles is licensed under the MIT License.
