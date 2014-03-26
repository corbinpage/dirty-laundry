//= require widget

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
        console.log(gon.dirty_tweets)
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
                data: gon.dirty_tweets
            }]
        });
    });