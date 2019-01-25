local raven = require "raven"

function init()

    --   http://pub:secret@127.0.0.1:8080/sentry/proj-id

    -- http://092b2e429b4c480e83c2e7f18890b8f2@127.0.0.1:9000/2
    --  http://092b2e429b4c480e83c2e7f18890b8f2:e41f2a264e5e47329d0026e99ae825b1@10.6.253.14:9000/2

local rvn = raven:new("http://092b2e429b4c480e83c2e7f18890b8f2:e41f2a264e5e47329d0026e99ae825b1@web:9000/2", {
    tags = { foo = "bar" },
 })
 
 -- Send a message to sentry
 local id, err = rvn:captureMessage(
   "Sentry is a realtime event logging and aggregation platform.",
   { tags = { abc = "def" } } -- optional
 )
 if not id then
    print(err)
 end
 
 -- Send an exception to sentry
 local exception = {{
    ["type"]= "SyntaxError",
    ["value"]= "Wattttt!",
    ["module"]= "__builtins__"
 }}
 local id, err = rvn:captureException(
    exception,
    { tags = { abc = "def" } } -- optional
 )
 if not id then
    print(err)
 end
 
 -- Catch an exception and send it to sentry
 function bad_func(n)
    return not_defined_func(n)
 end
 
 -- variable 'ok' should be false, and an exception will be sent to sentry
 local ok = rvn:call(bad_func, 1)
end

return init
