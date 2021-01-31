import consumer from "./consumer"
import PlayerEvent from 'events/player'
import MapEvent from 'events/map'

consumer.subscriptions.create("WorldMapChannel", {
  connected() {
    if ("geolocation" in navigator) {
      navigator.geolocation.watchPosition(position => {
        const { latitude, longitude } = position.coords
        this.perform('update_position', { position: {latitude, longitude} })
      })
    }

    PlayerEvent.$on('attack:player', avatar_id => this.perform('attack', { avatar_id }))
    MapEvent.$on('do:collect', ({ items }) => this.perform('collect', { items }))
  },

  disconnected() {
    PlayerEvent.$off('attack:player')
    MapEvent.$off('do:collect')
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
  }
});
