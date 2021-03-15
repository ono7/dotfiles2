function Emitter() {
  this.events = {};
}

Emitter.prototype.on = function (type, listener) {
  // if events[type] exists great, if not make it a new array -> || []
  this.events[type] = this.events[type] || [];
  this.events[type].push(listener);
};

Emitter.prototype.emit = function (type) {
  if (this.events[type]) {
    this.events[type].forEach(function (listener) {
      listener();
    });
  }
};

module.exports = Emitter;
