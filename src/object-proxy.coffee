#### Object proxy
# Proxies all functions of an object through a function.

# Given an object and a function, this proxies all the object's
# functions through the given function. Example:
#
#       proxyFunc = (obj, originalFunc, funcName)->
#           ()->
#                console.log Array.prototype.slice.call(arguments)
#                return originalFunc.apply obj, arguments
#        
#       obj = { 
#            test: (a, b)->
#                a + b
#        }
#        
#        proxiedObj = proxy(obj, proxyFunc)
        
proxy = (object, func, namespace)->
    newObject = {}
    for all key, value of object
        name = if namespace then namespace+'.'+key else key
        if value instanceof Function
            newObject[key] = func(object, value, name)
        else if value instanceof Object
            newObject[key] = proxy(value, func, name)
    return newObject

# Given an object and a namespace, returns the attribute relating
# to the namespace. Example:
#
#       obj = {foo: {bar: {zip: {zap: 'Quux'}}}}
#       namespace = 'foo.bar.zip.zap'
#       resolved = resolve(obj, namespace)
#       console.log resolved
#       'Quux'

resolve = (object, namespace)->
    bits = namespace.split('.')
    bit = bits.shift()
    if bits.length > 0
        return resolve(object[bit], bits.join('.'))
    return object[bit]

# Adding CommonJS exports and a new namespace for the 
# browser.
try
    exports.proxy = proxy
    exports.resolve = resolve
catch err
    this.proxy = {}
    this.proxy.proxy = proxy
    this.proxy.resolve = resolve
