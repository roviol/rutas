# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from django.db import models

class Punto(models.Model):
    nombre = models.CharField(max_length=100)
    lat = models.FloatField()
    lon = models.FloatField()
    tipo = models.CharField(max_length=2)
    class Meta:
        ordering = ['nombre']
    def __unicode__(self):
        return u"%s" % (self.nombre)
    @staticmethod
    def autocomplete_search_fields():
        return ("id__iexact", "nombre__icontains",)

class Ruta(models.Model):
    nombre = models.CharField(max_length=250)
    tipo = models.CharField(max_length=2)
    puntos = models.ManyToManyField(Punto, through='PuntoRuta')
    def __str__(self):
        return self.nombre
    @staticmethod
    def autocomplete_search_fields():
        return ("id__iexact", "nombre__icontains",)

class PuntoRuta(models.Model):
    ruta = models.ForeignKey(Ruta)
    punto = models.ForeignKey(Punto)
    orden = models.IntegerField()
    polyline = models.CharField(max_length=1000,blank=True)
    tipo = models.CharField(max_length=1,default='A')
    latlon = models.CharField(max_length=4000,blank=True)
    class Meta:
        ordering = ['orden']
    def __str__(self):
        return self.ruta.nombre+': '+self.punto.nombre

    @staticmethod
    def autocomplete_search_fields():
        return ("id__iexact", "punto__icontains",)
