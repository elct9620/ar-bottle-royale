import consumer from "./consumer"
import BattleEvent from 'events/battle'

const throttle = (func, timeout = 250) => {
  let last;
  let timer;

  return function () {
    const context = this;
    const args = arguments;
    const now = +new Date();

    if (last && now < last + timeout) {
      clearTimeout(timer)
      timer = setTimeout(function () {
        last = now
        func.apply(context, args)
      }, timeout)
    } else {
      last = now
      func.apply(context, args)
    }
  }
}

consumer.subscriptions.create("BattleChannel", {
  connected() {
    const attack = throttle(() => this.perform('attack'), 1000)

    BattleEvent.$on('battle:created', () => this.perform('join_battle'))
    BattleEvent.$on('do:attack', () => attack())
  },

  disconnected() {
    BattleEvent.$off('battle:created')
    BattleEvent.$off('do:attack')
    // Called when the subscription has been terminated by the server
  },

  received({ action, payload }) {
    BattleEvent.$emit(action, payload)
  }
});
