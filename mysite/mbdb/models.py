import datetime

from django.db import models
from django.utils import timezone

# Create your models here.
class Expedition(models.Model):
    expedition_name = models.CharField(max_length=200)
    region_name = models.CharField(max_length=200)
    start_date = models.DateTimeField(null=True)
    def __str__(self):
        return self.expedition_name
    def __str__(self):
        return self.region_name
    def was_started_recently(self):
        now = timezone.now()
        return now-datetime.timedelta(days=30) <= self.start_date <= now
    was_started_recently.admin_order_field = 'start_date'
    was_started_recently.boolean = True
    was_started_recently.short_description = 'Started recently?'

#  from earlier part of the tutorial
#        return self.start_date >= timezone.now() - datetime.timedelta(days=1)

class Mission(models.Model):
    expedition = models.ForeignKey(Expedition, on_delete=models.CASCADE)
    survey_name = models.CharField(max_length=20)
    start_depth = models.FloatField(default=0)
    def __str__(self):
        return self.survey_name


