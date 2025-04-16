local combine = {}

local function icombn(tbl,i,n,t,l)
   t = t or {}
   l = l or table.getn(tbl)
   if n == 1 then
      local j = i
      return function()
	 if j > l then return nil end
	 t[n] = tbl[j]
	 j = j+1
	 return t[n]
      end
   end
   local j = i
   local v = icombn(tbl,j+1,n-1,t)
   return function()
      if j > l then return nil end
      local x = v()
      if x == nil then
	 j = j+1
	 v = icombn(tbl,j+1,n-1,t)
	 x = v()
      end
      if x == nil then return nil end
      t[n] = tbl[j]
      return unpack(t)
   end
end

local function icombn_many(n,params,t)
   t = t or {}
   if n < 1 then return nil end
   local o = params[n]
   local l = table.getn(o)
   if n == 1 then
      local i = 1
      return function()
	 if i > l then return nil end
	 t[n] = o[i]
	 i = i+1
	 return t[n]
      end
   end
   local i = 1
   local v = icombn_many(n-1, params,t)
   return function()
      if i > l then return nil end
      local x = v()
      if x == nil then
	 i = i+1
	 if i > l or n < 0 then return nil end
	 v = icombn_many(n-1,params,t)
	 x = v()
      end
      if x == nil then return nil end
      t[n] = o[i]
      return unpack(t)
   end
end

local function factorial(n)
   if n == 0 then return 1 end
   return n * factorial(n-1)
end

local function combn_no(n,r)
   return factorial(n)/(factorial(r)*factorial(n-r))
end

function ipermute(n)
   local function gen(p,n)
      if n == 0 then coroutine.yield(p)
      else
	 for i=1,n do
	    p[n],p[i] = p[i],p[n]
	    gen(p,n-1)
	    p[n],p[i] = p[i],p[n]
	 end
      end
   end
   local p = {}; for x=1,n do table.insert(p,x) end
   local c = coroutine.create(function() gen(p,n) end)
   return function()
      local _,r = coroutine.resume(c)
      return r
   end
end

function combine.combn(tbl,n)
   if n <= 0 or n > table.getn(tbl) then
      error("Need 0 < n <= tbl length.")
   end
   return icombn(tbl,1,n,nil,nil)
end

function combine.combn_many(...)
   local params = {...}
   local l = table.getn(params)
   if l == 0 then error("Need at least one array.") end
   return icombn_many(l,params,nil)
end

function combine.powerset(tbl)
   local l,i = table.getn(tbl),1
   local n,v = combn_no(l,i), icombn(tbl,1,i)
   return function()
      n = n-1
      if n < 0 then
	 i = i+1
	 if i > l then return nil end
	 n = combn_no(l,i) - 1
	 v = icombn(tbl,1,i)
      end
      return v()
   end
end

function combine.permute(tbl)
   local l = table.getn(tbl)
   if l == 0 then return tbl end
   local v = ipermute(l)
   local t = {}
   return function()
      local x = v()
      if x == nil then return nil end
      for i=1,#x do t[i] = tbl[x[i]] end
      return unpack(t)
   end
end

function combine.shuffle(t)
   for i = #t, 1, -1 do
      local j = math.random(i)
      t[i],t[j]=t[j],t[i]
   end
   return t
end

return combine