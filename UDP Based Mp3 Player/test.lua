local PL
do
---
function ply(InCMD)
a = {} 
i=0
for word in string.gmatch(InCMD, '([^,]+)') do
i= i+1
a[i]=word
end

if a[2]~=nil then
else
a[2]=0x00
end 

if a[3]~=nil then
else
a[3]=0x00
end 

print(a[1])
print(a[2])
print(a[3])

print(tonumber(a[1])+tonumber(a[2])+tonumber(a[3]))
end

PL={
ply=ply,
}
end
return PL