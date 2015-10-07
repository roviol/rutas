# -*- coding: utf-8 -*-
from django.contrib import admin
from transporte.models import Punto
from transporte.models import Ruta
from transporte.models import PuntoRuta
import json, urllib
from transporte.views import recalcularuta

class PuntoRutaInline(admin.TabularInline):
    model = PuntoRuta
    fields = ("ruta","punto","orden","polyline","tipo","latlon",)
    extra = 0
    sortable_field_name = "orden"
    # define the raw_id_fields
    raw_id_fields = ('punto',)
    # define the related_lookup_fields
    autocomplete_lookup_fields = {
        'fk': ['punto'],
    }

class RutaAdmin(admin.ModelAdmin):
    fieldsets = [
        (None, {'fields': ['nombre']}),
        ('Information', {'fields': ['tipo'], 'classes': ('grp-collapse grp-closed',),}),
    ]
    inlines = [PuntoRutaInline]
    list_display = ('nombre','tipo',)
    list_filter = ['tipo',]
    search_fields = ['nombre',]
    def save_model(self, request, obj, form, change):
        obj.save()
    def save_related(self, request, form, formsets, change):
        form.save_m2m()
        for formset in formsets:
            self.save_formset(request, form, formset, change=change)
        recalcularuta(form.instance.id)



class PuntoAdmin(admin.ModelAdmin):
    list_display = ('nombre','tipo',)
    list_filter = ['tipo',]
    search_fields = ['nombre',]

class PuntoRutaAdmin(admin.ModelAdmin):
    list_display = ('punto','ruta','orden','tipo',)
    list_filter = ['ruta',]
    search_fields = ['punto__nombre','ruta__nombre',]
    sortable_field_name = "orden"
    raw_id_fields = ('punto',)
    autocomplete_lookup_fields = {
        'fk': ['punto'],
    }

admin.site.register(Punto, PuntoAdmin)
admin.site.register(Ruta, RutaAdmin)
admin.site.register(PuntoRuta, PuntoRutaAdmin)
