from django.http import HttpResponse
from django.shortcuts import get_object_or_404, render
from django.template import loader

from .models import Expedition, Mission
# Create your views here.

#---------------
# 1. index view
## using a shortcut: render(), tutorial #3
def index(request):
    latest_expedition_list = Expedition.objects.order_by('-start_date')[:5]
    context = {'latest_expedition_list': latest_expedition_list}
    return render(request, 'mbdb/index.html', context)

#---------------
# 2. detail view for an expedition

def detail(request, expedition_id):
    expedition = get_object_or_404(Expedition, pk=expedition_id)
    return render(request, 'mbdb/detail.html', {'expedition': expedition})

## early part of tutorial #3 (= "stub methods")
# def detail(request, expedition_id):
#     return HttpResponse("You're looking at expedition %s." % expedition_id)





#--------------
# 3. results view ... mission detail
# 
def mission(request, mission_id):
#     mission = get_object_or_404(Mission, pk=expedition_id)
#     return render(request, 'mbdb/mission.html', {'mission': mission})
#

    response = "You're looking at the missions of expedition %s."
    return HttpResponse(response % mission_id)

## omitted cuz we aren't voting
# def vote(request, question_id):
#     return HttpResponse("You're voting on question %s." % question.id)

## from tutorial #1
# def index(request):
#     return HttpResponse("Hello, world. You're at the mbdb index.")

## with page's design hard-coded in the view, mid-tutorial #3 
# def index(request):
#     latest_expedition_list = Expedition.objects.order_by('-start_date')[:5]
#     output = ', '.join([q.expedition_name for q in latest_expedition_list])
#     return HttpResponse(output)
## output: Sur Ridge, Extravert Cliff

## using a template with loader.get_template, later in tutorial #3
# def index(request):
#     latest_expedition_list = Expedition.objects.order_by('-start_date')[:5]
#     template = loader.get_template('mbdb/index.html')
#     context = {
#         'latest_expedition_list': latest_expedition_list,
#     }
#     return HttpResponse(template.render(context, request))