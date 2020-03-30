from django.contrib import admin

# Register your models here.
from .models import Mission, Expedition

class MissionInline(admin.TabularInline):
    model = Mission
    extra = 3
    
# class MissionInline(admin.StackedInline):
#     model = Choice
#     extra = 3

class ExpeditionAdmin(admin.ModelAdmin):
    fieldsets = [
        ('Expedition',        {'fields': ['expedition_name']}),
        ('Region',            {'fields': ['region_name']}),
    ]    
#
#('Start date',        {'fields': ['start_date']}),
#    ]
#        ('Date information', {'fields': ['start_date'], 'classes': ['collapse']}),

    inlines = [MissionInline]
#    list-display = ['survey_name']
#    list_filter = ['start_depth']
#    search_fields = ['survey_name']
    #    list_display = ('expedition_name', 'start_depth', 'was_started_recently')
    
admin.site.register(Expedition, ExpeditionAdmin)

#complains:
# File "/vagrant/dev/DjangoTutorial/mysite/mbdb/admin.py", line 23
#    list-display = ('expedition_name', 'start_depth') 
#    ^
# SyntaxError: cannot assign to operator