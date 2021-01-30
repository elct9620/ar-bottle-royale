import consumer from "./consumer"
import BattleEvent from 'events/battle'

consumer.subscriptions.create("BattleChannel", {
  connected() {
    BattleEvent.$on('battle:created', () => this.perform('join_battle'))
    BattleEvent.$on('do:attack', () => this.perform('attack'))
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received({ action, payload }) {
    console.log(action, payload)
    BattleEvent.$emit(action, payload)
  }
});
