var map;
var vlon = 0;
var vlat = 0;

var modo ="edicion";
var marcadores = new Array();
var actual;
var puntossel = new Array();
var rutaactual = {"ruta": null, "marcadores": new Array(), "steps": new Array()};
var marcadoresetiqueta = {};
var caminoruta;

function refrescaruta(idpunto){

    $.getJSON('puntoruta?id='+idpunto, function(data){
        if (rutaactual.marcadores.length>0){
            for(i=0;i<rutaactual.marcadores.length;i++) {
            	map.removeLayer(rutaactual.marcadores[i]);
            	map.removeLayer(rutaactual.steps[i]);
            }
        }
        rutaactual.ruta = data;
        rutaactual.marcadores = new Array();
        rutaactual.steps = new Array();
        $( "#listapuntos" ).html("");
        $( "#listapuntos" ).append( 
        	'<li class="list-group-item" id="punto-ruta-'+rutaactual.ruta.ruta.id+'">'+
        	'<h3><span class="label label-primary">'+
        	rutaactual.ruta.ruta.nombre+'</span></h3>'+
        	'</li>' );
        	ipunto=0;
        $(rutaactual.ruta.puntos).each(function() {
        	
            LamMarker = new L.Marker([this.coordenadas.lat,this.coordenadas.lon], {draggable: false});
            LamMarker.bindPopup(this.id+"<hr>"+this.nombre).openPopup();
	        LamMarker.on('mouseover', function (e) {
	            this.openPopup();
	        });
	        LamMarker.on('mouseout', function (e) {
	            this.closePopup();
	        });
            rutastep = L.Polyline.fromEncoded(this.polyline);
            rutastep.clickable = true
            
	        rutastep.on('click', function (e) {
	            console.log(e);
	        });
	        
            $( "#listapuntos" ).append( '<li class="list-group-item" id="punto-'+ipunto+'">'+this.id+": "+this.nombre+'</li>' );
            $("#punto-"+ipunto).mouseover(function(e){
                nombrelista=e.target.id;
                indice = parseInt(nombrelista.replace("punto-",""));
	            for(i=0;i<rutaactual.steps.length;i++) {
	            	map.removeLayer(rutaactual.steps[i]);
	            }
                map.addLayer(rutaactual.marcadores[indice]);
                map.addLayer(rutaactual.steps[indice]);
            });
            $("#punto-"+ipunto).mouseout(function(e){
                nombrelista=e.target.id;
                indice = parseInt(nombrelista.replace("punto-",""));
                map.removeLayer(rutaactual.marcadores[indice]);
                map.addLayer(rutaactual.steps[indice]);
	            for(i=0;i<rutaactual.steps.length;i++) {
	            	map.removeLayer(rutaactual.steps[i]);
	            }
	            for(i=0;i<rutaactual.steps.length;i++) {
	            	map.addLayer(rutaactual.steps[i]);
	            }
            });
            
        	ipunto++;
        	
            rutaactual.steps.push(rutastep);
            rutaactual.marcadores.push(LamMarker);
            marcadores.push(LamMarker);
            
            rutastep.addTo(map);
            //map.addLayer(LamMarker);
        });

        });
}

function refrescaAll(){

    for(i=0;i<marcadores.length;i++) {
        map.removeLayer(marcadores[i]);
    }  

    $("#modo").html("modo: "+modo);

    $.getJSON('puntos', function(data){
        var marker;
        marcadores = new Array();
        var bdraggable = (modo == "edicion") ? true : false;
        $(data).each(function() {
            LamMarker = new L.Marker([this.fields.lat,this.fields.lon], {draggable:bdraggable});
            LamMarker.bindPopup(this.pk+": "+this.fields.nombre).openPopup();
            LamMarker.on('mouseover', function (e) {
	            this.openPopup();
	        });
	        LamMarker.on('mouseout', function (e) {
	            this.closePopup();
	        });
            LamMarker.on('click', function(e) {
                actual=e.target;
                console.log(actual.getLatLng());
                if (modo=="edicion"){
                    //map.setView(actual.getLatLng(),17);
                    agregaPuntoRuta(rutaactual.ruta.ruta.id, marcadoresetiqueta[actual._leaflet_id]);
                }else{
                    //puntossel.push(e.target);
                    puntossel.push(marcadoresetiqueta[actual._leaflet_id]);
                    $( "#listapuntos" ).html("");
                    for(i=0;i<puntossel.length;i++) {
                        //$( "#listapuntos" ).append( '<li class="list-group-item">'+puntossel[i].getLatLng().lat+","+puntossel[i].getLatLng().lng+'</li>' );
                        $( "#listapuntos" ).append( '<li class="list-group-item">'+puntossel[i]+'</li>' );
                    }
                }
            });
            LamMarker.on('dragend', function(e) {
                actual=e.target;
                console.log(actual.getLatLng());
            });
            
            
            map.addLayer(LamMarker);
            marcadoresetiqueta[LamMarker._leaflet_id]=this.pk;
            marcadores.push(LamMarker);
        });

        });
}

function init() {

    map = L.map('map').setView([8.9747225658,-79.5293791771], 13);

    L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors',
        maxZoom: 20
    }).addTo(map);
/*
       $('#idruta').fadeOut();
    //   $('#btedicion').fadeIn();
       
    $( "#idruta" ).click(function() {
       modo="ruta";
       $('#idruta').fadeOut();
     //  $('#btedicion').fadeIn();
       refrescaAll();
    });

    $( "#btedicion" ).click(function() {
       modo="edicion";
       $('#btedicion').fadeOut();
      // $('#idruta').fadeIn();
       refrescaAll();
    });

    $( "#idenvia" ).click(function() {
       //calcularRuta();
       trazaruta(puntossel[0],puntossel[1]);
    });
*/
    //refrescaruta(2);
    //refrescaAll();
    rutas();
}

var rutapasos=[];

var rutasel;

function agregaPuntoRuta(rutaseleccionada,puntoseleccionado){
	
    $.ajax({
         type: "POST",
         url: "puntorutaadd/",
         data: { 'ruta': rutaseleccionada, 'punto': puntoseleccionado },
            success: function( data ) {
            	refrescaruta(rutaseleccionada);
            },
         dataType: "json"});
}

function calcularRuta(){
    var puntosA  = {};
    var puntosS  = "";
    if (puntossel.length>2){
        for(i=0;i<puntossel.length;i++) {
            puntosS=puntosS+puntossel[i].getLatLng().lat+","+puntossel[i].getLatLng().lng+"|";
        }
    }  

    $.ajax({
         type: "POST",
         url: "enrutar/",
         data: { 'puntos': puntosS,
         'csrfmiddlewaretoken': '{{ csrf_token }}'},
         success: function( data ) {
             //linea=data.polyline;
             //var linearuta = L.Polyline.fromEncoded(linea);
             //linearuta.addTo(map);
             rutapasos=data.steps;
        /*     for(i=0;i<rutapasos.length;i++) {
               var linearuta = L.Polyline.fromEncoded(rutapasos[i].polyline.points);
               linearuta.addTo(map);
             }*/
            $( "#listapasos" ).html("");
            for(i=0;i<rutapasos.length;i++) {
                $( "#listapasos" ).append( '<li class="list-group-item" id="paso-'+i+'">'+rutapasos[i].html_instructions+'</li>' );
                $("#paso-"+i).hover(function(e){
                    nombrelista=e.target.id;
                    indice = parseInt(nombrelista.replace("paso-",""));
                    console.log(rutapasos[indice]);
                    try{
                        map.removeLayer(rutasel);
                    }catch(e){
                        console.log(e);
                    }
                    rutasel = L.Polyline.fromEncoded(rutapasos[indice].polyline.points);
                    rutasel.addTo(map);
                });
            }

         },
         dataType: "json"});
}

function rutas(){
	    $.getJSON('rutas', function(data){
        rutas = data;
        $( "#listarutas" ).html("");
        $(rutas).each(function() {
			$( "#listarutas" ).append( '<li class="list-group-item" id="ruta-'+this.id+'">'+this.nombre+'</li>' );
            $("#ruta-"+this.id).click(function(e){
                nombrelista=e.target.id;
                indice = parseInt(nombrelista.replace("ruta-",""));
                refrescaruta(indice);
            });
        });
  /*
        $( "#listarutas" ).append( '<li class="list-group-item" id="ruta-todos">Todos</li>' );
            $("#ruta-todos").click(function(e){
                refrescaAll();
            });
*/
        });
}
var enrutado=new Array();

function trazaruta(idorigen, iddestino){
	    $.getJSON('calcularuta',{"origen": idorigen, "destino": iddestino}, function(data){
        caminoruta = data;
        $( "#listaposibles" ).html("");
        j=0;
        
        if (enrutado.length>0){
            for(i=0;i<enrutado.length;i++) {
            	map.removeLayer(enrutado[i]);
            }
        }
        enrutado=new Array();
        if(caminoruta.rutascomun.length>0){
	        $(caminoruta.rutascomun).each(function() {
				$( "#listaposibles" ).append( '<li class="list-group-item" id="posiblec-'+j+'">'+this.nombre+'</li>' );
	            $("#posiblec-"+j).click(function(e){
	                nombrelista=e.target.id;
	                indice = parseInt(nombrelista.replace("posiblec-",""));
        			$(caminoruta.rutascomun[indice].pasos).each(function() {
                    	rutac = L.Polyline.fromEncoded(this.polyline);
                    	enrutado.push(rutac);
                    	rutac.addTo(map);
        			});
	            });
	        	j++;
	        });
        }

        j=0;
        if(caminoruta.rutas.length>0){
	        $(caminoruta.rutas).each(function() {
				$( "#listaposibles" ).append( '<li class="list-group-item" id="posible-'+j+'">'+
				this.rutainicia.nombre+': '+this.rutafin.nombre+'</li>' );
	            $("#posible-"+j).click(function(e){
	                nombrelista=e.target.id;
	                indice = parseInt(nombrelista.replace("posible-",""));
        			$(caminoruta.rutas[indice].rutainicia.pasos).each(function() {
                    	rutac = L.Polyline.fromEncoded(this.polyline);
                    	enrutado.push(rutac);
                    	rutac.addTo(map);
        			});
        			$(caminoruta.rutas[indice].rutafin.pasos).each(function() {
                    	rutac = L.Polyline.fromEncoded(this.polyline);
                    	enrutado.push(rutac);
                    	rutac.addTo(map);
        			});
	            });
	        	j++;
	        });
        }
        });
}
