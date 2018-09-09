<script>
      function initMap() {
        var pos = {lat:   <%= @post.latitude %>, lng: <%= @post.longitude %>};
        var map = new google.maps.Map(document.getElementById('map-canvas'), {
          zoom: 15,
          center: pos
        });
        var marker = new google.maps.Marker({
          position: pos,
          map: map
        });
      }
</script>
