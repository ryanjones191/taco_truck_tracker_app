class @InfoBoxBuilder extends Gmaps.Google.Builders.Marker # inherit from base builder

create_infowindow: ->
  return null unless _.isString @args.infowindow
  boxText = document.createElement("div")
  boxText.setAttribute("class", 'yellow') #to customize
  boxText.innerHTML = @args.infowindow
  @infowindow = new InfoBox(@infobox(boxText))

infobox: (boxText)->
  content: boxText
  pixelOffset: new google.maps.Size(-140, 0)
  boxStyle:
  width: "280px"

handler = Gmaps.build 'Google', { builders: { Marker: InfoBoxBuilder} }