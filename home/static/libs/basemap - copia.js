var map;
var markers = new OpenLayers.Layer.Markers( "Paradas" );
var size = new OpenLayers.Size(21,25);
var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
var icon = new OpenLayers.Icon('/gstatic/openlayers/img/marker.png', size, offset);
var icon2 = new OpenLayers.Icon('/gstatic/openlayers/img/marker-green.png', size, offset);
var vlon = 0;
var vlat = 0;

            OpenLayers.Control.Click = OpenLayers.Class(OpenLayers.Control, {
                defaultHandlerOptions: {
                    'single': true,
                    'double': false,
                    'pixelTolerance': 0,
                    'stopSingle': false,
                    'stopDouble': false
                },

                initialize: function(options) {
                    this.handlerOptions = OpenLayers.Util.extend(
                        {}, this.defaultHandlerOptions
                    );
                    OpenLayers.Control.prototype.initialize.apply(
                        this, arguments
                    );
                    this.handler = new OpenLayers.Handler.Click(
                        this, {
                            'click': this.trigger
                        }, this.handlerOptions
                    );
                },

                trigger: function(e) {

                    var lonlat = map.getLonLatFromPixel(e.xy);

                    var WGS84PMercatorProjection = new OpenLayers.Projection("EPSG:3857");
                    var WGS84Projection = new OpenLayers.Projection("EPSG:4326");
                    var WebMercatorProjection = new OpenLayers.Projection("EPSG:900913");

                    var WebMercatorLonLat = new OpenLayers.LonLat(lonlat.lon, lonlat.lat);

                    WebMercatorLonLat.transform(WGS84PMercatorProjection, WebMercatorProjection);

                    var lonlat2=lonlat.transform(WGS84PMercatorProjection, WGS84Projection);

                    $("#localiza").html(lonlat.lat + "," + lonlat.lon + "<br/>"+
                    lonlat2.lat + "," + lonlat2.lon + "<br/>"+
                    WebMercatorLonLat.lat + ", " + WebMercatorLonLat.lon  );
                    vlat=lonlat.lat;
                    vlon=lonlat.lon;
                }

            });

function init() {


    map = new OpenLayers.Map('map', {
        projection: 'EPSG:3857',
        layers: [
            new OpenLayers.Layer.Google(
                "Mapa", // the default
                {numZoomLevels: 22}
            ),
            new OpenLayers.Layer.Google(
                "Satelite",
                {type: google.maps.MapTypeId.SATELLITE, numZoomLevels: 22}
            ),
            new OpenLayers.Layer.Google(
                "Hibrido",
                {type: google.maps.MapTypeId.HYBRID, numZoomLevels: 22}
            )
        ],
        center: new OpenLayers.LonLat(-79.5293791771, 8.9747225658)
            // Google.v3 uses web mercator as projection, so we have to
            // transform our coordinates
            .transform('EPSG:4326', 'EPSG:3857'),
        zoom: 14
    });
    map.addControl(new OpenLayers.Control.LayerSwitcher());

    map.addLayer(markers);
    marker=new OpenLayers.Marker(new OpenLayers.LonLat(0,0),icon2);
    markers.addMarker(marker);

    // add behavior to html
    /*var animate = document.getElementById("animate");
    animate.onclick = function() {
        for (var i=map.layers.length-1; i>=0; --i) {
            map.layers[i].animationEnabled = this.checked;
        }
    };*/

                var click = new OpenLayers.Control.Click();
                map.addControl(click);
                click.activate();

}


