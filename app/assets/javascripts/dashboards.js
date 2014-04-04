//= require widget

// Dashboard Conditionals   #########################################################################
// Summary                  #########################################################################
if(gon.dashboard_type == "summary"){






}
// Analytics                #########################################################################
else if(gon.dashboard_type == "analytics") {


function scrollToTop(index)
{
  var container = $("#twitter-feed");
  var scrollTo = $('#twitter-widget-' + index.toString());
  // console.log(index)
  // console.log(scrollTo)
  container.animate({
    scrollTop: scrollTo.offset().top - container.offset().top + container.scrollTop()
    }, {
    duration: 400
    }
  );
}

$(function () {
        $('#dirty-word-chart').highcharts({
            chart: {
                type: 'scatter'
            },
            title: {
                text: 'All Dirty Tweets by Date'
            },
            xAxis: {
                title: {
                    enabled: true,
                    text: 'Date'
                },
                dateTimeLabelFormats: {
                  day: '%e %b'
                }
                // },
                // type: 'datetime',
                // dateTimeLabelFormats: {
                //   day: '%d-%m-%Y'
                // },
                // ordinal: false
            },
            yAxis: {
                title: {
                    text: 'Number of Tweets'
                },
                plotLines: [{
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                valueSuffix: ' Tweet'
            },

            plotOptions: {
                series: {
                    cursor: 'pointer',
                    point: {
                        events: {
                            click: function(e) {
                              scrollToTop(this.series.data.indexOf(this));
                            }
                        }
                    },
                    marker: {
                        lineWidth: 1
                    }
                }
            },
            series: [{
                showInLegend: false,
                name: "Tweets",
                data: gon.dirty_tweets,
                color: '#00aeed'
            }]
        });
    });

$(function () {
        $('#favorite-hashtags-chart').highcharts({
            chart: {
                type: 'column'
            },
            title: {
                text: 'Most prevalent Hashtags'
            },
            xAxis: {
                categories: gon.hashtag_text
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Times Used'
                },
                labels: {
                    overflow: 'justify'
                }
            },
            tooltip: {
                formatter: function() {
                    return '<b>'+ this.y +': </b>' + this.x;
                }
            },
            plotOptions: {
                bar: {
                    dataLabels: {
                        enabled: true
                    }
                }
            },
            credits: {
                enabled: false
            },
            series: [{
                showInLegend: false,
                data: gon.hashtag_values,
                color: '#00aeed'
            }]
        });
    });
    
$(function () {
        $('#most-mentioned-chart').highcharts({
            chart: {
                type: 'column'
            },
            title: {
                text: 'Most Often Mentioned Users'
            },
            xAxis: {
                categories: gon.mention_text
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Times Mentioned'
                },
                labels: {
                    overflow: 'justify'
                }
            },
            tooltip: {
                formatter: function() {
                    return '<b>'+ this.y +': </b>' + this.x;
                }
            },
            plotOptions: {
                bar: {
                    dataLabels: {
                        enabled: true
                    }
                }
            },
            credits: {
                enabled: false
            },
            series: [{
                showInLegend: false,
                data: gon.mention_values,
                color: '#00aeed'
            }]
        });
    });

}
// Locations                #########################################################################
else if(false && gon.dashboard_type == "locations" && gon.location_tweets.length > 0) {

jQuery(function($) {
    // Asynchronously Load the map API 
    var script = document.createElement('script');
    script.src = "http://maps.googleapis.com/maps/api/js?sensor=false&callback=initialize";
    document.body.appendChild(script);
});

function initialize() {
    var map;
    var bounds = new google.maps.LatLngBounds();
    var mapOptions = {
        mapTypeId: 'roadmap'
    };
                    
    // Display a map on the page
    map = new google.maps.Map(document.getElementById("google-map"), mapOptions);
    map.setTilt(45);
        
    // Multiple Markers
    var markers = gon.location_tweets;
    // console.log(gon.location_tweets)
                        
    // Info Window Content
    var infoWindowContent = [
        ['<div class="info_content">' +
        '<h3>London Eye</h3>' +
        '<p>The London Eye is a giant Ferris wheel situated on the banks of the River Thames. The entire structure is 135 metres (443 ft) tall and the wheel has a diameter of 120 metres (394 ft).</p>' +        '</div>'],
        ['<div class="info_content">' +
        '<h3>Palace of Westminster</h3>' +
        '<p>The Palace of Westminster is the meeting place of the House of Commons and the House of Lords, the two houses of the Parliament of the United Kingdom. Commonly known as the Houses of Parliament after its tenants.</p>' +
        '</div>']
    ];
        
    // Display multiple markers on a map
    var infoWindow = new google.maps.InfoWindow(), marker, i;
  
    // Loop through our array of markers & place each one on the map  
    for( i = 0; i < markers.length; i++ ) {
        var position = new google.maps.LatLng(markers[i][1], markers[i][2]);
        bounds.extend(position);
        marker = new google.maps.Marker({
            position: position,
            map: map,
            title: markers[i][0]
        });
        
        // Allow each marker to have an info window    
        // google.maps.event.addListener(marker, 'click', (function(marker, i) {
        //     return function() {
        //         infoWindow.setContent(infoWindowContent[i][0]);
        //         infoWindow.open(map, marker);
        //     }
        // })(marker, i));

        // Automatically center the map fitting all markers on the screen
        map.fitBounds(bounds);
    }
    // CP-Not needed from what I can tell
    // Override our map zoom level once our fitBounds function runs (Make sure it only runs once)
    // var boundsListener = google.maps.event.addListener((map), 'bounds_changed', function(event) {
    //     this.setZoom(14);
    //     google.maps.event.removeListener(boundsListener);
    // });
    
}

}
// Connections                #########################################################################
else if(gon.dashboard_type == "connections") {

function scrollToTop(index)
{
  var container = $("#twitter-feed");
  var scrollTo = $('#twitter-widget-' + index.toString());
  // console.log(index)
  // console.log(scrollTo)
  container.animate({
    scrollTop: scrollTo.offset().top - container.offset().top + container.scrollTop()
    }, {
    duration: 400
    }
  );
}

}

