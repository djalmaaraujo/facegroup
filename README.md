# FaceGroup App

The idea is to read facebook groups feed, without using the facebook.com website. Developers and group administrators will love it. No distractions.

# Features
* Read your facebook Groups outside of the facebook website
* Create "tagged" feeds. Combine two or more groups into one single timeline. (Ex: javascript groups)
* Post/Edit/Comment posts
* Favorite posts and list later
* Post in multiple groups (Maybe, this is dangerous)

# Roadmap

## Small Wins
* ~~add a sidebar with groups (people have too many groups)~~
* [#2](https://github.com/djalmaaraujo/facegroup/issues/2) - Add links to users mentions in comments / posts. (When someone mention another user, create a facebook.com/user)
* [#3](https://github.com/djalmaaraujo/facegroup/issues/3) - Add a toggle to view more comments (limit to 3)
* [#4](https://github.com/djalmaaraujo/facegroup/issues/4) - Add a gallery when someone posts more than 1 photo. (Some posts act like a gallery. Look for object_id)
* [#4](https://github.com/djalmaaraujo/facegroup/issues/4) - ~~Add user avatar in comments list~~

## Goals
* Built the front-end based on the existing layout
* Add cache to requests
* ~~Setup the domain to gh-pages~~
* Add embed.ly or noembed to make the timeline pretty
* Create "grouped" or "tagged" timelines (Select multiple groups and read the feed in only one timeline)
* Add feature to LIKE the post
* Add feature to POST in groups
* Add feature to favorite posts
* ~~Add feature to comment in posts~~
* Add feature to delete posts

# Layout Preview
![image](https://raw.github.com/djalmaaraujo/facegroup/master/_assets/preview/facegroup.png)

# Help
Yes, please, help me =)

# Quick start

**If you want to help, please open an issue so we can add you as
Facebook group developer.**

## Installation instructions
```
gem install compass
npm install -d
bower install
grunt server
```

**Change 127.0.0.1 to localhost in your browser**

# Deploy

For now:
```
grunt build # On the root and master branch
cd dist # make sure that dist is on gh-pages branch
git add --all
git commit 'deploy actual-date.number' # Ex: deploy 05-03-14.2
git push origin gh-pages
cd ..
git add .
git commit 'deploy actual-date.number' # Ex: deploy 05-03-14.2
git push origin master
```

## License

[MIT License](http://djalmaaraujo.mit-license.org/) © Djalma Araújo
