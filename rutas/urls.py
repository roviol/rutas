# -*- coding: utf-8 -*-
from django.conf.urls import patterns, include, url

from django.contrib import admin
from home import views

admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^blog/', include('blog.urls')),

    url(r'^grappelli/', include('grappelli.urls')), # grappelli URLS
    url(r'^$', 'home.views.index'),
    url(r'^puntos/', 'transporte.views.puntos'),
    url(r'^rutas/', 'transporte.views.rutas'),
    url(r'^punto/', 'transporte.views.punto'),
    url(r'^puntoruta/', 'transporte.views.puntoruta'),
    url(r'^puntorutaadd/', 'transporte.views.puntorutaadd'),
    url(r'^calcularuta/', 'transporte.views.calcularuta'),
    url(r'^rutacsv/', 'transporte.views.rutacsv'),
    url(r'^puntoadd/', 'transporte.views.puntoadd'),
    url(r'^enrutar/', 'transporte.views.enrutar'),
    url(r'^admin/', include(admin.site.urls)),
)
