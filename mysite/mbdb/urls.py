from django.urls import path

from . import views

app_name='mbdb'

urlpatterns = [
    # ex: /mbdb/
    path('', views.index, name='index'),
    
     # ex: /mbdb/5/
    path('<int:expedition_id>/', views.detail, name='detail'),
    path('<int:expedition_id>/detail/', views.detail, name='detail'),
    path('<int:expedition_id>/mission/', views.mission, name='mission'),    
    ]

