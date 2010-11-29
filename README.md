#### node-object-proxy

### Synopsis

## Browser
    
    obj = {
        fancyFunction : (arg1, arg2, arg3)->
            do(fancy(operation(arg3), arg2), arg1)
    }
    
    # Create a function that intercepts a call and does 
    # something
    
    remote = (obj, func, funcName)->
        ()->
            args = Array.prototype.slice.call arguments
            
            # Run the function remotely
            jsonRPC(funcName, args)
            
            # But also locally
            func.apply obj, args
    
    # Decorate all of obj's methods with the function above
    
    proxiedObj = proxy.proxy(obj, remote)
    

## Server

    proxy = require 'object-proxy'
    
    obj = {
        fancyFunction : (arg1, arg2, arg3)->
            do(fancy(operation(arg3), arg2), arg1)
    }
    
    call = (name, args)->
        func = proxy.resolve(obj, name)
        func.apply obj, args


