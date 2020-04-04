# Commands executed in the python shell, aka "database API",  modified for running back through the tutorial
# Starting with Tutorial 2 (answers here are what is to be expected if it worked)
# I've left their notes and annotated with some of my own.

# to get into the postgres shell:
psql -U postgres -p 5438
for help:
\?
to quit:
\q

# for Django help at command line:
mysite/manage.py help
mysite/manage.py help createsuperuser

# to get into the python shell:
python manage.py shell
# for python help: type "?"

#-------------------------------------------------------------
# Tutorial 2:
# get into the shell by typing
> python manage.py shell

#--------------------
>>> from mbdb.models import Mission, Expedition  # Import the model classes we just wrote.

# No expeditions are in the system yet.
>>> Expedition.objects.all()
<QuerySet []>

# Create a new Expedition.
# Support for time zones is enabled in the default settings file, so
# Django expects a datetime with tzinfo for pub_date. Use timezone.now()
# instead of datetime.datetime.now() and it will do the right thing.
>>> from django.utils import timezone

# Note to me, have to figure out the format to enter prior dates in the API (should be no problem in a web form)
#  plan to use their "timezone.now" for now.

q = Expedition(expedition_name="Extravert Cliff", region_name="Monterey Bay", start_date=timezone.now())  
#--------
# Save the object into the database. You have to call save() explicitly.
>>> q.save()

# Now it has an ID.
>>> q.id
1

# Access model field values via Python attributes.
>>> q.expedition_name
"Extravert Cliff"


#----- still don't know what format to use for entering dates
##datetime.datetime(2012, 2, 26, 13, 0, 0, 775217, tzinfo=<UTC>) # but this gave an error
#ValidationError: ['“2020, 2, 26, 13, 0, 0, 775217, tzinfo=<UTC>” value has an invalid format. It must be in YYYY-MM-DD HH:MM[:ss[.uuuuuu]][TZ] format.']
# so did
#q = Expedition(expedition_name="Extravert Cliff", region_name="Monterey Bay", start_date="
   ...: 2020-02-26 UTC")
   
   
#------
# Change values by changing the attributes, then calling save().
>>> q.expedition_name = "Extravert Cliff"
>>> q.save()

# objects.all() displays all the expeditions in the database.
>>> Expedition.objects.all()
<QuerySet [<Expedition: Expedition object (1)>]>
# ? actual: <QuerySet [<Expedition: Monterey Bay>]> # why doesn't it say "Expedition: Extravert Cliff"?

#--------------------- further down in Tutorial 2 ------
> python manage.py shell

>>> from mbdb.models import Mission, Expedition

# Make sure our __str__() addition worked.
>>> Expedition.objects.all()
<QuerySet [<Expedition: Monterey Bay>]>
## ? (as above) Why is the admin page returning "region_name", not "expedition_name"? Does it need an explicit field, "ID"?

# Django provides a rich database lookup API that's entirely driven by
# keyword arguments.
>>> Expedition.objects.filter(id=1)
<QuerySet [<Expedition: Extravert Cliff>]>
>>> Expedition.objects.filter(expedition_name__startswith='Extr')
<QuerySet [<Expedition: Extravert Cliff>]>

# Get the expedition that started this year.
>>> from django.utils import timezone
>>> current_year = timezone.now().year
>>> Expedition.objects.get(start_date__year=current_year)
<Expedition: Extravert Cliff>
#----

# Request an ID that doesn't exist, this will raise an exception.
>>> Expedition.objects.get(id=2)
Traceback (most recent call last):
    ...
DoesNotExist: Expedition matching query does not exist.

# Lookup by a primary key is the most common case, so Django provides a
# shortcut for primary-key exact lookups.
# The following is identical to Expedition.objects.get(id=1).
>>> Expedition.objects.get(pk=1)
<Expedition: Extravert Cliff>

# Make sure our custom method in models.py worked.
>>> q = Expedition.objects.get(pk=1)
>>> q.was_started_recently()
True

# Give the Expedition a couple of Missions. The create call constructs a new
# Mission object, does the INSERT statement, adds the mission to the set
# of available missions and returns the new Mission object. Django creates
# a set to hold the "other side" of a ForeignKey relation
# (e.g. an expeditions's mission) which can be accessed via the API.
>>> q = Expedition.objects.get(pk=1)

# Display any missions from the related object set -- none so far.
>>> q.mission_set.all()
<QuerySet []>

# Create three missions.
>>> q.mission_set.create(survey_name='20200101m1', start_depth='-1030')
<Mission: 20200101m1>
>>> q.mission_set.create(survey_name='20200101m2', start_depth='-1050')
<Mission: 20200101m2>
>>> q.mission_set.create(survey_name='20191230m1', start_depth='-2010')
<Mission:20191230m1>

# Mission objects have API access to their related Expedition objects.
>>> c = Mission.objects.get(pk=1)
>>> c.expedition
<Expedition: Monterey Bay>

# And vice versa: Expedition objects get access to Mission objects.
>>> q.mission_set.all()
<QuerySet [<Mission: 20200101m1>, <Mission: 20200101m2>, <Mission: 20191230m1>]>
>>> q.mission_set.count()
3

# The API automatically follows relationships as far as you need.
# Use double underscores to separate relationships.
# This works as many levels deep as you want; there's no limit.
# Find all Missions for any expedition whose start_date is in this year
# (reusing the 'current_year' variable we created above).
>>> Mission.objects.filter(expedition__start_date__year=current_year)
<QuerySet [<Mission: 20200101m1>, <Mission: 20200101m2>, <Mission: 20191230m1>]>

#---- didn't do this yet ----
# Let's delete one of the missions. Use delete() for that.
>>> c = q.mission_set.filter(survey_name__startswith='2019')
>>> c.delete()

#--------- END TUTORIAL 2 --------------