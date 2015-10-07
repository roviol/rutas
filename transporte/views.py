# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from django.utils import simplejson
from django.http import HttpResponse
from transporte.models import Punto
from transporte.models import Ruta
from transporte.models import PuntoRuta
from django.core import serializers
from django.views.decorators.csrf import csrf_exempt
import json, urllib
from transporte import gispoly
import sys

def puntos(request):
    puntos = Punto.objects.all()
    data = serializers.serialize('json', puntos)
    return HttpResponse(data, content_type='application/json')

def rutas(request):
    rutas = Ruta.objects.all()
    rutaslista=[]
    for ruta in rutas:
        rutaslista.append({"nombre": ruta.nombre, "id": ruta.id})
    #data = serializers.serialize('json', rutas)
    data=simplejson.dumps(rutaslista)
    return HttpResponse(data, content_type='application/json')

def punto(request):
    puntos = Punto.objects.filter(pk=request.GET['id'])
    #data=simplejson.dumps(puntos)
    data = serializers.serialize('json', puntos)
    return HttpResponse(data, content_type='application/json')

def puntoruta(request):
    ruta = Ruta.objects.filter(pk=request.GET['id'])
    puntosruta = PuntoRuta.objects.filter(ruta=ruta)
    #data=simplejson.dumps(puntos)

    listapuntos=[]
    for puntoruta in puntosruta:
        if (puntoruta.punto.tipo=='P'):
            listapuntos.append({
                "orden": puntoruta.orden,
                "id": puntoruta.punto.id,
                "nombre": puntoruta.punto.nombre,
                "coordenadas": {
                    "lat": puntoruta.punto.lat,
                    "lon": puntoruta.punto.lon
                },
                "polyline": puntoruta.polyline
                })

    to_json = {
        "ruta": {"id": ruta[0].id, "nombre": ruta[0].nombre},
        "puntos": listapuntos,
    }
    data=simplejson.dumps(to_json)

    return HttpResponse(data, content_type='application/json')

def rutacsv(request):
    #ruta = Ruta.objects.filter(pk=request.GET['id'])
    ruta = Ruta.objects.get(pk=request.GET['id'])
    puntos = PuntoRuta.objects.filter(ruta=ruta)

    csv="start_name;start_lng;start_lat;end_name;end_lng;end_lat\n"
    rutaant = None
    rutaprimero = None
    contador = 0
    #for item in ruta[0].puntos.all():
    for item in puntos:
        contador=contador+1
        if not (rutaant==None):
            csv=csv+";"+item.punto.nombre+";"+str(item.punto.lon)+";"+str(item.punto.lat)+"\n"
            csv=csv+item.punto.nombre+";"+str(item.punto.lon)+";"+str(item.punto.lat)
        else:
            rutaprimero=item
            csv=csv+item.punto.nombre+";"+str(item.punto.lon)+";"+str(item.punto.lat)
        rutaant = item
    csv=csv+";"+rutaprimero.punto.nombre+";"+str(rutaprimero.punto.lon)+";"+str(rutaprimero.punto.lat)+"\n"
    return HttpResponse(csv, content_type='text/plain')


def puntoadd(request):
    punto = Punto(nombre=request.POST['nombre'], lon=request.POST['lon'], lat=request.POST['lat'], tipo=request.POST['tipo'])
    punto.save()
    to_json = {
        "id": punto.id,
    }
    data=simplejson.dumps(to_json)
    return HttpResponse(data, content_type='application/json')

@csrf_exempt
def puntorutaadd(request):
    rutaobj = Ruta.objects.get(pk=request.POST['ruta'])
    puntorutamax = PuntoRuta.objects.filter(ruta=rutaobj).order_by('-orden')[0]
    puntoobj = Punto.objects.get(pk=request.POST['punto'])
    puntoruta = PuntoRuta(ruta=rutaobj, punto=puntoobj, orden=puntorutamax.orden+1)
    puntoruta.save()
    recalcularuta(rutaobj.id)
    
    to_json = {
        "id": puntoruta.id,
    }
    data=simplejson.dumps(to_json)
    return HttpResponse(data, content_type='application/json')


@csrf_exempt
def enrutar(request):
    puntos = request.POST['puntos']
    lista=puntos.split("|");
    cantidad=len(lista)
    urlruta="http://maps.googleapis.com/maps/api/directions/json?origin=";
    urlruta=urlruta+lista[0];
    urlfinal="&destination="+lista[cantidad-2]
    urlwait="&waitpoints="+puntos[len(lista[0])+1:-len(lista[cantidad-2])-2]
    urlenvio= urlruta
    if (cantidad > 3):
        urlenvio=urlenvio+urlwait
    urlenvio=urlenvio+urlfinal+"&sensor=false"
    print urlenvio

    data = json.load(urllib.urlopen(urlenvio))
    #print json.dumps(data,indent=4)
    print json.dumps(data["routes"][0]["legs"][0]["steps"],indent=4)

    to_json = {
        "polyline": data["routes"][0]["overview_polyline"]["points"],
        "steps": data["routes"][0]["legs"][0]["steps"],
    }
    data=simplejson.dumps(to_json)
    return HttpResponse(data, content_type='application/json')

def recalcularuta(rutaid):
    ruta = Ruta.objects.filter(pk=rutaid)
    puntosruta = PuntoRuta.objects.filter(ruta=ruta)
    listapuntos=[]
    buffercorrige=[]
    anterior=""
    urlruta="http://maps.googleapis.com/maps/api/directions/json?origin=";
    totalpuntos=len(puntosruta)
    for punto in puntosruta:
        actual=str(punto.punto.lat)+","+str(punto.punto.lon)
        if (anterior!=""):
            urlenvio = urlruta+anterior+"&destination="+actual+"&sensor=false"
            if punto.punto.tipo=='P':
                data = json.load(urllib.urlopen(urlenvio))
                #print json.dumps(data,indent=4)
                try:
                    if punto.tipo=="A":
                        strpoly=data["routes"][0]["overview_polyline"]["points"]
                        puntosactuales=gispoly.decode(strpoly)
                        if (len(buffercorrige)>1):
                            puntosactuales=buffercorrige + puntosactuales
                        strpoly=gispoly.encode_coords(puntosactuales)
                        punto.latlon = str(puntosactuales)
                        punto.polyline = strpoly
                        punto.save()
                        buffercorrige=[]
                        #if (len(puntosactuales)>1):
                        #    buffercorrige=[]
                        #    buffercorrige.append((punto.punto.lon,punto.punto.lat))
                        print buffercorrige
                except:
                    print "Unexpected error:", sys.exc_info()[0]
                    print punto.id
            else:
                buffercorrige.append((punto.punto.lon,punto.punto.lat))
        anterior=actual

def calcularuta(request):
    idorigen = int(request.GET['origen'])
    iddestino = int(request.GET['destino'])
    origen = Punto.objects.get(pk=idorigen)
    destino = Punto.objects.get(pk=iddestino)
      
    rutasa = PuntoRuta.objects.filter(punto=origen)
    rutasb = PuntoRuta.objects.filter(punto=destino)
    listarutasa=[]
    for ruta in rutasa:
        listarutasa.append({"nombre": ruta.ruta.nombre, "id": ruta.ruta.id, "orden": ruta.orden})
        
    listarutasb=[]
    for ruta in rutasb:
        listarutasb.append({"nombre": ruta.ruta.nombre, "id": ruta.ruta.id, "orden": ruta.orden})
    
    rutascompleta=[]
    
    #Ruta con puntos comunes
    for ruta1 in listarutasa:
        for ruta2 in listarutasb:
            if (ruta1["id"]==ruta2["id"]):
                listapuntos=PuntoRuta.objects.filter(ruta=ruta1["id"]).filter(orden__gte=ruta1["orden"]).filter(orden__lte=ruta2["orden"])
                puntosenruta = []
                for puntoruta1 in listapuntos:
                    puntosenruta.append({"orden": puntoruta1.orden, 
                                         "id": puntoruta1.id,
                                         "polyline": puntoruta1.polyline,
                                         "punto":{"id": puntoruta1.punto.id,
                                                  "nombre": puntoruta1.punto.nombre,
                                                  }
                                         }
                                        )
                rutascompleta.append({"nombre": ruta1["nombre"], "id": ruta1["id"], 
                                      "desde": ruta1["orden"], "hasta": ruta2["orden"],
                                      "pasos": puntosenruta
                                     })
    #En caso de no encontrar comunes buscar rutas que complementan el trayecto
    rutascomplementan=[]
    if (len(rutascompleta)==0):
        for ruta1 in listarutasa:
            rutaini = Ruta.objects.get(pk=ruta1["id"])
            #Ubicar los puntos siguientes al punto actual en una ruta
            puntos1=PuntoRuta.objects.filter(ruta=rutaini).filter(orden__gte=ruta1["orden"])
            listapuntos=[]
            for punto1 in puntos1:
                listapuntos.append(punto1)
            for ruta2 in listarutasb:
                rutafin = Ruta.objects.get(pk=ruta2["id"])
                #Ubicar los puntos anteriores al punto actual en una ruta
                puntos2=PuntoRuta.objects.filter(ruta=rutafin).filter(orden__lte=ruta2["orden"])
                listapuntos2=[]
                for punto2 in puntos2:
                    listapuntos2.append(punto2)
                puntosinicia = []
                for puntoruta1 in listapuntos:
                    puntosinicia.append({"orden": puntoruta1.orden, 
                                         "id": puntoruta1.id,
                                         "polyline": puntoruta1.polyline,
                                         "punto":{"id": puntoruta1.punto.id,
                                                  "nombre": puntoruta1.punto.nombre,
                                                  }
                                         }
                                        )
                    puntosfin = []
                    for puntoruta2 in listapuntos2:
                        if (puntoruta1.punto.id==puntoruta2.punto.id):
                            desde=puntoruta2.orden
                            for puntoruta2tmp in listapuntos2:
                                if (desde < puntoruta2tmp.orden):
                                    puntosfin.append({"orden": puntoruta2tmp.orden, 
                                                         "id": puntoruta2tmp.id,
                                                         "polyline": puntoruta2tmp.polyline,
                                                         "punto":{"id": puntoruta2tmp.punto.id,
                                                                  "nombre": puntoruta2tmp.punto.nombre,
                                                                  }
                                                         }
                                                        )
                            rutascomplementan.append({
                                                      "rutainicia": {
                                                                     "id": ruta1["id"],
                                                                     "nombre": ruta1["nombre"],
                                                                     "pasos": puntosinicia
                                                                     },
                                                      "rutafin": {
                                                                     "id": ruta2["id"],
                                                                     "nombre": ruta2["nombre"],
                                                                     "pasos": puntosfin
                                                                     },
                                                      "puntointermedio":{
                                                                         "id": puntoruta1.punto.id,
                                                                         "nombre": puntoruta1.punto.nombre
                                                                         }
                                                      })

    to_json = {
        "origen": origen.id,
        "destino": destino.id,
        "rutasorigen": listarutasa,
        "rutasdestino": listarutasb,
        "rutascomun": rutascompleta,
        "rutas": rutascomplementan
    }
    data=simplejson.dumps(to_json)
    return HttpResponse(data, content_type='application/json')
