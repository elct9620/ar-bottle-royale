import consumer from "./consumer"
import BattleEvent from 'events/battle'

consumer.subscriptions.create("BattleChannel", {
  connected() {
    BattleEvent.$on('do:attack', () => this.perform('attack'))
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
  }
});
