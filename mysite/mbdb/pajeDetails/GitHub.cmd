# GitHub notes 
# work from top of working directory, e.g., MB-Mapping

cd mbdb 
cd https://github.com/jbpaduan/MB-Mapping.git

---- initial commit ----
git add mysite && git commit -m "Initial commit"
git status

git push origin master #"origin, master" by default, optional - but use to be cautious
 
---- when you only want to commit certain files and ignore others ----
( git reset HEAD mysite
 vi .gitignore  # to ignore - not commit - listed directories and files )
 git add mysite
 git status
 git add .gitignore  # so it is over there for the record
 
 git status
 git commit
 
  ---- to pull files from Mike's branch ----
 git status
 git remote -v  # for Mike's changes ???
 
 git pull
 
 ---- want Mike's file changes, but it won't overwrite files I have here by same name... ----
 git diff mysite/mysite/settings.py
 git checkout mysite/mysite/settings.py # to blow away my file settings.py prior to pulling Mike's from GitHub
 git diff mysite/mysite/settings.py # should be same now
 git diff mysite/mysite/urls.py
 git checkout mysite/mysite/urls.py
 git pull
 
 ---- push changed file models.py up to GitHub ----
  git status
  git diff mysite/mbdb/models.py # to see what's different
  git add mysite/mbdb/models.py
  git commit mysite/mbdb/models.py -m "fixed typos in start_date"
  git config --global user.name "Jenny Paduan"
  git config --global user.email paje@mbari.org
  git commit mysite/mbdb/models.py -m ""
  git commit --amend --reset-author
  git push origin master
 
 ---- when all is done ----
 ./test.sh