(function() {
  var proxy, resolve;
  proxy = function(object, func, namespace) {
    var key, name, newObject, value;
    newObject = {};
    for (key in object) {
      value = object[key];
      name = namespace ? namespace + '.' + key : key;
      if (value instanceof Function) {
        newObject[key] = func(object, value, name);
      } else if (value instanceof Object) {
        newObject[key] = proxy(value, func, name);
      }
    }
    return newObject;
  };
  resolve = function(object, namespace) {
    var bit, bits;
    bits = namespace.split('.');
    bit = bits.shift();
    if (bits.length > 0) {
      return resolve(object[bit], bits.join('.'));
    }
    return object[bit];
  };
  try {
    exports.proxy = proxy;
    exports.resolve = resolve;
  } catch (err) {
    this.proxy = {};
    this.proxy.proxy = proxy;
    this.proxy.resolve = resolve;
  }
}).call(this);
