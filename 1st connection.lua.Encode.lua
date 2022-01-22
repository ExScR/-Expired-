--block Antilogv1
for ANT = 1,5 do
gg.toast("ꜰɪʟᴇ ɪɴᴛᴇɢʀɪᴛʏ ᴄʜᴇᴄᴋ... 🔍")
gg.searchNumber(string.char(4,17,39,0,0,4,255,255,1,0)
:rep(999)
:rep(999), 5)
gg.searchNumber(string.char(4,255,255,1,0,0,0,0,236,0,0,0)
:rep(999)
:rep(999), 5)
debug.traceback(5, nil, string.char(4,17,39,0,0,4,255,255,1,0)
:rep(999)
:rep(999)
:rep(10))
debug.traceback(5, nil, string.char(4,255,255,1,0,0,0,0,236,0,0,0)
:rep(999)
:rep(999)
:rep(10))
end

gg.sleep(2000)

--------Lasm Error :v---------
func = {}
function dzsh(Text)
    Text = Text:gsub(" ", "")
    return (Text:gsub(
        "..",
        function(jie)
            return string.char((tonumber(jie, 16)) % 256)
        end
    ))
end

function escapeOpcode(str,repl)
	if (repl==true) then 
	magic_character = {37}
	else
	magic_character = {40,41,46,37,43,45,42,63,91,93,94,36}
	end
	invi = {}
	txt = ""
	string.gsub(str,".",function(w) w= string.byte(w) invi[#invi+1]=w end)
	for i, v in ipairs(invi) do 
		if string.len(v)== 1 then invi[i] = "【0"..v.."】" 
		else invi[i] = "【"..v.."】"end
	end
	for i = 1,#invi do
		for m, k in ipairs(magic_character)do
			if(invi[i])~=	"【"..k.."】" then
				else invi[i] = "【37】"..invi[i]..""
			end
		end
		txt = txt .. invi[i]
	end
	txt = string.gsub(txt,"【(.-)】",function(w) return string.char(w) end)
	return txt
:rep(999)
end

function numToHex(txt,skip)
    local ss = {}
    txt = string.format("%x", txt)
    len = string.len(txt)
    if string.len(txt) % 2 == 0 then
        txt:gsub("..?",function(n) ss[#ss + 1] = n end)
    else
        ss[1] = string.sub(txt, 1, 1)
        txt = string.sub(txt, 2)
        txt:gsub( "..?",function(n)ss[#ss + 1] = n end)
    end
    for i = 1, #ss do
        if string.len(ss[i]) == 1 then
            ss[i] = "0" .. ss[i]
        end
    end
    str = ""
    for i = #ss, 1, -1 do
        str = str .. ss[i]
    end
    if string.len(str) == 1 then
        str = str .. "0000000"
    elseif string.len(str) == 2 then
        str = str .. "000000"
    elseif string.len(str) == 3 then
        str = str .. "00000"
    elseif string.len(str) == 4 then
        str = str .. "0000"
    elseif string.len(str) == 5 then
        str = str .. "000"
    elseif string.len(str) == 6 then
        str = str .. "00"
    elseif string.len(str) == 7 then
        str = str .. "0"
    end
    return str
:rep(999)
end

function formatTwo(str)
	if string.len(str)~=2 then str = "0"..str end
	return str
:rep(999)
end

function getSources(source)
    io.open("/sdcard/readSources", "w"):write(source)
    file = io.open("/sdcard/readSources")
    s = 0
    n = 0
    local determinant = ""
    repeat
        s = s + 1
        text = file:read("*l")
        if text == nil then
            break
        end
        if text ~= nil then
            local lineDefine = string.match(text, "%.linedefined [-]?(%d+)")
            local lastLineDefine = string.match(text, "%.lastlinedefined [-]?(%d+)")
            local numparams = string.match(text, "%.numparams [-]?(%d+)")
            local isVararg = string.match(text, "%.is_vararg [-]?(%d+)")
            local maxStack = string.match(text, "%.maxstacksize [-]?(%d+)")
            if lineDefine ~= nil then
                n = n + 1
                func[n] = {[1] = numToHex(lineDefine)}
            end
            if lastLineDefine ~= nil then
                func[n] = {[1] = func[n][1], [2] = numToHex(lastLineDefine)}
            end
            if numparams ~= nil then
                numparams = string.format("%x", numparams)
                func[n] = {[1] = func[n][1], [2] = func[n][2], [3] = formatTwo(numparams)}
            end
            if isVararg ~= nil then
				isVararg = string.format("%x", isVararg)
                func[n] = {
                    [1] = func[n][1],
                    [2] = func[n][2],
                    [3] = func[n][3],
                    [4] = formatTwo(isVararg)
                }
            end
            if maxStack ~= nil then
				maxStack = string.format("%x", maxStack)
                func[n] = {
                    ["LineStarted"] = func[n][1],
                    ["LineEnded"] = func[n][2],
                    ["Parameter"] = func[n][3],
                    ["isVararg"] = func[n][4],
                    ["maxStack"] = formatTwo(maxStack)
                }
            end
        end
    until text == nil
    os.remove("/sdcard/readSources")
    return func
:rep(999)
end

function antiLasm(source)
    Instruction = {}
    for i = 1, #func do
        indicator = dzsh(func[i]["LineStarted"] ..func[i]["LineEnded"] .. func[i]["Parameter"] .. func[i]["isVararg"] .. func[i]["maxStack"])
        indicator = escapeOpcode(indicator)
		
        replacement = dzsh(numToHex(math.random(2447483649, 3294967296)) .. numToHex(math.random(2447483649, 3294967296))) .. dzsh("FA01FA")
        replacement = escapeOpcode(replacement, true)
        ins = string.match(source, indicator .. "[^\20-\7e][^\20-\7e][^\20-\7e][^\20-\7e]") -- 提取后一个空白Byte (Number of Instructions)
		if(Instruction[2]==nil)then 
			if ins ~= nil then
				ins = string.sub(ins, string.len(ins) - 3, string.len(ins))
			end
			Instruction[#Instruction + 1] = table.concat({ins:byte(1, -1)}, ",")
		end
        source = string.gsub(source, indicator, replacement)
    end
    return source
:rep(999)
end
--------GG CHECK----------
gg.setVisible(false)
gg.toast("ᴄʜᴇᴄᴋɪɴɢ ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ sɪɢɴᴀᴛᴜʀᴇ... 🔍")
gg.sleep(3000)

if gg.PACKAGE == "com.externalgg" then 
else
gg.toast("ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ sɪɢɴᴀᴛᴜʀᴇ ᴇʀʀᴏʀ! ❌")
gg.sleep(1500)
gg.copyText('t.me/u9RJbX1YNrdkZjBi')
gg.setVisible(true)
os.exit(print(" ⚠️ ʏᴏᴜ ɴᴇᴇᴅ sᴘᴇᴄɪᴀʟ ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴛᴏ ʀᴜɴ ᴛʜɪs sᴄʀɪᴘᴛ. ɪᴛ ᴡᴏɴ'ᴛ ʀᴜɴ ᴡɪᴛʜᴏᴜᴛ ɪᴛ! \n ᴛᴏ ᴅᴏᴡɴʟᴏᴀᴅ ɪᴛ ᴘʟᴇᴀsᴇ ᴊᴏɪɴ ᴏᴜʀ ᴛᴇʟᴇɢʀᴀᴍ ᴄʜᴀɴɴᴇʟ! ᴛ.ᴍᴇ/ᴜ9ʀᴊʙx1ʏɴʀᴅᴋᴢᴊʙɪ \n ᴏᴜʀ ᴛᴇʟᴇɢʀᴀᴍ ʟɪɴᴋ ᴀʟsᴏ ᴄᴏᴘɪᴇᴅ ᴛᴏ ʏᴏᴜʀ ᴄʟɪᴘʙᴏᴀʀᴅ!"))
gg.toast("Successfully copied to clipboad!")
end

if gg.VERSION == "101.1" then
else
gg.toast("ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ sɪɢɴᴀᴛᴜʀᴇ ᴇʀʀᴏʀ! ❌")
gg.sleep(1500)
gg.copyText('t.me/u9RJbX1YNrdkZjBi')
gg.setVisible(true)
os.exit(print(" ⚠️ ʏᴏᴜ ɴᴇᴇᴅ sᴘᴇᴄɪᴀʟ ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴛᴏ ʀᴜɴ ᴛʜɪs sᴄʀɪᴘᴛ. ɪᴛ ᴡᴏɴ'ᴛ ʀᴜɴ ᴡɪᴛʜᴏᴜᴛ ɪᴛ! \n ᴛᴏ ᴅᴏᴡɴʟᴏᴀᴅ ɪᴛ ᴘʟᴇᴀsᴇ ᴊᴏɪɴ ᴏᴜʀ ᴛᴇʟᴇɢʀᴀᴍ ᴄʜᴀɴɴᴇʟ! ᴛ.ᴍᴇ/ᴜ9ʀᴊʙx1ʏɴʀᴅᴋᴢᴊʙɪ \n ᴏᴜʀ ᴛᴇʟᴇɢʀᴀᴍ ʟɪɴᴋ ᴀʟsᴏ ᴄᴏᴘɪᴇᴅ ᴛᴏ ʏᴏᴜʀ ᴄʟɪᴘʙᴏᴀʀᴅ!"))
gg.toast("Successfully copied to clipboad!")
end

if gg.BUILD == "16142" then
gg.toast("ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ sɪɢɴᴀᴛᴜʀᴇ sᴜᴄᴄᴇssꜰᴜʟʟʏ ᴄʜᴇᴄᴋᴇᴅ! ✅")
gg.sleep(2000)
else
gg.toast("ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ sɪɢɴᴀᴛᴜʀᴇ ᴇʀʀᴏʀ! ❌")
gg.sleep(1500)
gg.copyText('t.me/u9RJbX1YNrdkZjBi')
gg.setVisible(true)
os.exit(print(" ⚠️ ʏᴏᴜ ɴᴇᴇᴅ sᴘᴇᴄɪᴀʟ ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴛᴏ ʀᴜɴ ᴛʜɪs sᴄʀɪᴘᴛ. ɪᴛ ᴡᴏɴ'ᴛ ʀᴜɴ ᴡɪᴛʜᴏᴜᴛ ɪᴛ! \n ᴛᴏ ᴅᴏᴡɴʟᴏᴀᴅ ɪᴛ ᴘʟᴇᴀsᴇ ᴊᴏɪɴ ᴏᴜʀ ᴛᴇʟᴇɢʀᴀᴍ ᴄʜᴀɴɴᴇʟ! ᴛ.ᴍᴇ/ᴜ9ʀᴊʙx1ʏɴʀᴅᴋᴢᴊʙɪ \n ᴏᴜʀ ᴛᴇʟᴇɢʀᴀᴍ ʟɪɴᴋ ᴀʟsᴏ ᴄᴏᴘɪᴇᴅ ᴛᴏ ʏᴏᴜʀ ᴄʟɪᴘʙᴏᴀʀᴅ!"))
gg.toast("Successfully copied to clipboad!")
end

-----------------------------

----Block ss tool
for x = 0,1,0 do if nil ~= nil then (-nil)((-nil)[nil] | nil | nil)(-nil)((-nil)[nil] | nil | nil) local _L = {(-nil)((-nil)[nil] | nil | nil)(-nil)((-nil)[nil] | nil | nil),(-nil)((-nil)[nil] | nil | nil),(nil*(-nil)),(-nil)((-nil)[nil] | nil | nil)*(-nil)((-nil)[nil] | nil | nil)/(-nil)((-nil)[nil] | nil | nil)%(-nil)((-nil)[nil] | nil | nil)%(-nil)((-nil)[nil] | nil | nil)%(-nil)((-nil)[nil] | nil | nil),(-nil)((-nil)[nil] | nil | nil)} _L = _L() _L = _Lnil _L= _L():_L(_Lnil)(_Lnil*-1).._Lnil _L = _L(_Lnil)(_L) _L = _L(_Lnil_Lnil)(_L) if _~= nil then  	_ = _ (-nil * nil)() 	_ = nil end _ = _,_(-nil*nil),_ if _L  ~= nil then _L = _ (_Lnil*nil*nil*-nil) _L = nil end if _L == nil then   _L = {_L(_L*nil)(_L*nil)(nil * 1, 1  << nil), _L*nil} end end local _T = {} x[""] = T local K = (x)(x, x) K[1] = 1 end
		for x = 0,1,0 do if nil ~= nil then (-nil)((-nil)[nil] | nil | nil)(-nil)((-nil)[nil] | nil | nil) local _L = {(-nil)((-nil)[nil] | nil | nil)(-nil)((-nil)[nil] | nil | nil),(-nil)((-nil)[nil] | nil | nil),(nil*(-nil)),(-nil)((-nil)[nil] | nil | nil)*(-nil)((-nil)[nil] | nil | nil)/(-nil)((-nil)[nil] | nil | nil)%(-nil)((-nil)[nil] | nil | nil)%(-nil)((-nil)[nil] | nil | nil)%(-nil)((-nil)[nil] | nil | nil),(-nil)((-nil)[nil] | nil | nil)} _L = _L() _L = _Lnil _L= _L():_L(_Lnil)(_Lnil*-1).._Lnil _L = _L(_Lnil)(_L) _L = _L(_Lnil_Lnil)(_L) if _~= nil then  	_ = _ (-nil * nil)() 	_ = nil end _ = _,_(-nil*nil),_ if _L  ~= nil then _L = _ (_Lnil*nil*nil*-nil) _L = nil end if _L == nil then   _L = {_L(_L*nil)(_L*nil)(nil * 1, 1  << nil), _L*nil} end end local _T = {} x[""] = T local K = (x)(x, x) K[1] = 1 end
			while (nil)do;local o={}if (o.o)then if (o.o.o)then;o.o=(o.o(o)) o.o=(o.o(o.o.o(o.o(o))))end;end;end
				while (nil) do;local T={}   if (T.T)then if (T.T.T)then;T.T=(T.T(T)) T.T = (T.T(T.T.T(T.T(T)))) end;end
					while (nil)do;local a={}if (a.a)then if (a.a.a)then if (a.a.a.a) then if(a.a.a.a.a)then if (a.a.a.a.a.a) then;a.a=(a.a(a)) a.a=(a.a(a.a.a(a.a.a.a(a.a.a.a.a(a.a.a.a(a.a.a(a.a(a)))))))) a.b = (a.a(a.a.a(a.a.a.a(a.a.a.a.a(a.a.a.a(a.a.a(a.a(a)))))))),(a.a(a.a.a(a.a.a.a(a.a.a.a.a((a.a.a.a.a.a(a.a.a.a(a.a.a(a.a(a)))))))))) end;end;end;end;end;end
					while nil ~=nil do;local c = {} c.c = nil,nil,nil,nil if (c.c)then;c.c=(c.c(c)) c.c=(c.c(c))end;end
				while not (nil) do gg.setVisible(false)   while true do     gg.setVisible(false)     gg.processKill()     gg.setVisible(true)     os.exit()   end   return end end
			while (nil)do;local o={} local p={} local q={}if (o.o)then if (o.o.o)then if (o.o.o.o) then if (o.o.o.o.o) then if (p.p) then if (p.p.p) then if (p.p.p.p) then if (q.q) then if (q.q.q) then if (q.q.q.q) then;o.o=(o.o(o)) o.o=(o.o(o.o.o(o.o(o)))) p.p=(p.p(p)) p.p=(p.p(p.p.p(p.p.p.p(p.p.p(p.p(p.p)))))) q.q = (q.q(q.q.q(q.q.q.q(q.q.q(q.q(q.q)))))) local r={o.o,p.p,q.q} r.r=r[1]..r[2]..r[3] r.i= r.r(r.r(r.r(r.r(r.r(r.r(r.r)))))) end;end;end;end;end;end;end;end;end;end;end
		while (nil)do;local o={} local p={} local q={}if (o.o)then if (o.o.o)then if (o.o.o.o) then if (o.o.o.o.o) then if (p.p) then if (p.p.p) then if (p.p.p.p) then if (q.q) then if (q.q.q) then if (q.q.q.q) then;o.o=(o.o(o)) o.o=(o.o(o.o.o(o.o(o)))) p.p=(p.p(p)) p.p=(p.p(p.p.p(p.p.p.p(p.p.p(p.p(p.p)))))) q.q = (q.q(q.q.q(q.q.q.q(q.q.q(q.q(q.q)))))) local r={o.o,p.p,q.q} r.r=r[1]..r[2]..r[3] r.i= r.r(r.r(r.r(r.r(r.r(r.r(r.r)))))) end;end;end;end;end;end;end;end;end;end;end
	while (nil)do;local o={} local p={} local q={}if (o.o)then if (o.o.o)then if (o.o.o.o) then if (o.o.o.o.o) then if (p.p) then if (p.p.p) then if (p.p.p.p) then if (q.q) then if (q.q.q) then if (q.q.q.q) then;o.o=(o.o(o)) o.o=(o.o(o.o.o(o.o(o)))) p.p=(p.p(p)) p.p=(p.p(p.p.p(p.p.p.p(p.p.p(p.p(p.p)))))) q.q = (q.q(q.q.q(q.q.q.q(q.q.q(q.q(q.q)))))) local r={o.o,p.p,q.q} r.r=r[1]..r[2]..r[3] r.i= r.r(r.r(r.r(r.r(r.r(r.r(r.r)))))) end;end;end;end;end;end;end;end;end;end;end
while (nil)do;local o={} local p={} local q={}if (o.o)then if (o.o.o)then if (o.o.o.o) then if (o.o.o.o.o) then if (p.p) then if (p.p.p) then if (p.p.p.p) then if (q.q) then if (q.q.q) then if (q.q.q.q) then;o.o=(o.o(o)) o.o=(o.o(o.o.o(o.o(o)))) p.p=(p.p(p)) p.p=(p.p(p.p.p(p.p.p.p(p.p.p(p.p(p.p)))))) q.q = (q.q(q.q.q(q.q.q.q(q.q.q(q.q(q.q)))))) local r={o.o,p.p,q.q} r.r=r[1]..r[2]..r[3] r.i= r.r(r.r(r.r(r.r(r.r(r.r(r.r)))))) end;end;end;end;end;end;end;end;end;end;end
while (nil)do;local x={}if (x.x)then if (x.x.x)then;x.x=(x.x(x)) x.x=(x.x(x.x.x(x.x(x))))end;end;end
while (nil)do;local o={} local p={} local q={}if (o.o)then if (o.o.o)then if (o.o.o.o) then if (o.o.o.o.o) then if (p.p) then if (p.p.p) then if (p.p.p.p) then if (q.q) then if (q.q.q) then if (q.q.q.q) then;o.o=(o.o(o)) o.o=(o.o(o.o.o(o.o(o)))) p.p=(p.p(p)) p.p=(p.p(p.p.p(p.p.p.p(p.p.p(p.p(p.p)))))) q.q = (q.q(q.q.q(q.q.q.q(q.q.q(q.q(q.q)))))) local r={o.o,p.p,q.q} r.r=r[1]..r[2]..r[3] r.i= r.r(r.r(r.r(r.r(r.r(r.r(r.r)))))) end;end;end;end;end;end;end;end;end;end;end
while (nil)do;local a={} local b={} local c={}if (a.a) then if (a.a.a) then if (a.a.a.a) then if (a.a.a.a.a) then if (b.b) then if (b.b.b) then if (b.b.b.b) then if (c.c) then if (c.c.c) then if (c.c.c.c) then;a.a = (a.a(a)) a.a=(a.a(a.a.a(a.a(a)))) b.b = (b.b(b)) b.b=(b.b(b.b.b(b.b.b.b(b.b.b(b.b(b.b)))))) c.c = (c.c(c.c.c(c.c.c.c(c.c.c(c.c(c.c)))))) local r = {a.a,b.b,c.c} r.r = r[1]..r[2]..r[3] r.i = r.r(r.r(r.r(r.r(r.r(r.r(r.r)))))) end;end;end;end;end;end;end;end;end;end;end
while (nil)do;local z={} local x={} local c={}if (z.z) then if (z.z.z) then if (z.z.z.z) then if (z.z.z.z.z) then if (x.x) then if (x.x.x) then if (x.x.x.x) then if (c.c) then if (c.c.c) then if (c.c.c.c) then;z.z = (z.z(z)) z.z=(z.z(z.z.z(z.z(z)))) x.x = (x.x(x)) x.x=(x.x(x.x.x(x.x.x.x(x.x.x(x.x(x.x)))))) c.c = (c.c(c.c.c(c.c.c.c(c.c.c(c.c(c.c)))))) local r = {z.z,x.x,c.c} r.r = r[1]..r[2]..r[3] r.i = r.r(r.r(r.r(r.r(r.r(r.r(r.r)))))) end;end;end;end;end;end;end;end;end;end;end
while (nil)do;local f={} local g={} local h={}if (f.f) then if (f.f.f) then if (f.f.f.f) then if (f.f.f.f.f) then if (g.g) then if (g.g.g) then if (g.g.g.g) then if (h.h) then if (h.h.h) then if (h.h.h.h) then;f.f = (f.f(f)) f.f=(f.f(f.f.f(f.f(f)))) g.g = (g.g(g)) g.g=(g.g(g.g.g(g.g.g.g(g.g.g(g.g(g.g)))))) h.h = (h.h(h.h.h(h.h.h.h(h.h.h(h.h(h.h)))))) local r = {f.f,g.g,h.h} r.r = r[1]..r[2]..r[3] r.i = r.r(r.r(r.r(r.r(r.r(r.r(r.r)))))) end;end;end;end;end;end;end;end;end;end;end
while (nil)do;local x={}if (x.x)then if (x.x.x)then;x.x=(x.x(x)) x.x=(x.x(x.x.x(x.x(x))))end;end;end
while (nil)do;local o={}if (o.o(o(o.o(o.oo))))then if (o.oo) then oo={} if (oo.o(oo.oo))then;o.o=(o.o(o.o.o(o.oo(oo.o(oo.oo(o.o.o(o.o(o,o)))))))) o={o.o,o.o,o.o,oo.o,oo.oo} p = (nil),(nil)*(nil) o.p = p,p,p,p oo.oo.o = (nil),(nil)..","..o.p..","..(nil)*(nil)/(nil)..",(nil)" _G = {oo.oo.o,_G,oo.oo.o} gg = {oo.oo.o,gg,oo.oo.o} end;end;end;end
for x = 0,1,0 do if nil ~= nil then (-nil)((-nil)[nil] | nil | nil)(-nil)((-nil)[nil] | nil | nil) local _L = {(-nil)((-nil)[nil] | nil | nil)(-nil)((-nil)[nil] | nil | nil),(-nil)((-nil)[nil] | nil | nil),(nil*(-nil)),(-nil)((-nil)[nil] | nil | nil)*(-nil)((-nil)[nil] | nil | nil)/(-nil)((-nil)[nil] | nil | nil)%(-nil)((-nil)[nil] | nil | nil)%(-nil)((-nil)[nil] | nil | nil)%(-nil)((-nil)[nil] | nil | nil),(-nil)((-nil)[nil] | nil | nil)} _L = _L() _L = _Lnil _L= _L():_L(_Lnil)(_Lnil*-1).._Lnil _L = _L(_Lnil)(_L) _L = _L(_Lnil_Lnil)(_L) if _~= nil then  	_ = _ (-nil * nil)() 	_ = nil end _ = _,_(-nil*nil),_ if _L  ~= nil then _L = _ (_Lnil*nil*nil*-nil) _L = nil end if _L == nil then   _L = {_L(_L*nil)(_L*nil)(nil * 1, 1  << nil), _L*nil} end end local _T = {} x[""] = T local K = (x)(x, x) K[1] = 1 end
		for x = 0,1,0 do if nil ~= nil then (-nil)((-nil)[nil] | nil | nil)(-nil)((-nil)[nil] | nil | nil) local _L = {(-nil)((-nil)[nil] | nil | nil)(-nil)((-nil)[nil] | nil | nil),(-nil)((-nil)[nil] | nil | nil),(nil*(-nil)),(-nil)((-nil)[nil] | nil | nil)*(-nil)((-nil)[nil] | nil | nil)/(-nil)((-nil)[nil] | nil | nil)%(-nil)((-nil)[nil] | nil | nil)%(-nil)((-nil)[nil] | nil | nil)%(-nil)((-nil)[nil] | nil | nil),(-nil)((-nil)[nil] | nil | nil)} _L = _L() _L = _Lnil _L= _L():_L(_Lnil)(_Lnil*-1).._Lnil _L = _L(_Lnil)(_L) _L = _L(_Lnil_Lnil)(_L) if _~= nil then  	_ = _ (-nil * nil)() 	_ = nil end _ = _,_(-nil*nil),_ if _L  ~= nil then _L = _ (_Lnil*nil*nil*-nil) _L = nil end if _L == nil then   _L = {_L(_L*nil)(_L*nil)(nil * 1, 1  << nil), _L*nil} end end local _T = {} x[""] = T local K = (x)(x, x) K[1] = 1 end
			while (nil)do;local o={}if (o.o)then if (o.o.o)then;o.o=(o.o(o)) o.o=(o.o(o.o.o(o.o(o))))end;end;end
				while (nil) do;local T={}   if (T.T)then if (T.T.T)then;T.T=(T.T(T)) T.T = (T.T(T.T.T(T.T(T)))) end;end
					while (nil)do;local a={}if (a.a)then if (a.a.a)then if (a.a.a.a) then if(a.a.a.a.a)then if (a.a.a.a.a.a) then;a.a=(a.a(a)) a.a=(a.a(a.a.a(a.a.a.a(a.a.a.a.a(a.a.a.a(a.a.a(a.a(a)))))))) a.b = (a.a(a.a.a(a.a.a.a(a.a.a.a.a(a.a.a.a(a.a.a(a.a(a)))))))),(a.a(a.a.a(a.a.a.a(a.a.a.a.a((a.a.a.a.a.a(a.a.a.a(a.a.a(a.a(a)))))))))) end;end;end;end;end;end
					while nil ~=nil do;local c = {} c.c = nil,nil,nil,nil if (c.c)then;c.c=(c.c(c)) c.c=(c.c(c))end;end
				while not (nil) do gg.setVisible(false)   while true do     gg.setVisible(false)     gg.processKill()     gg.setVisible(true)     os.exit()   end   return end end
			while (nil)do;local o={} local p={} local q={}if (o.o)then if (o.o.o)then if (o.o.o.o) then if (o.o.o.o.o) then if (p.p) then if (p.p.p) then if (p.p.p.p) then if (q.q) then if (q.q.q) then if (q.q.q.q) then;o.o=(o.o(o)) o.o=(o.o(o.o.o(o.o(o)))) p.p=(p.p(p)) p.p=(p.p(p.p.p(p.p.p.p(p.p.p(p.p(p.p)))))) q.q = (q.q(q.q.q(q.q.q.q(q.q.q(q.q(q.q)))))) local r={o.o,p.p,q.q} r.r=r[1]..r[2]..r[3] r.i= r.r(r.r(r.r(r.r(r.r(r.r(r.r)))))) end;end;end;end;end;end;end;end;end;end;end
		while (nil)do;local o={} local p={} local q={}if (o.o)then if (o.o.o)then if (o.o.o.o) then if (o.o.o.o.o) then if (p.p) then if (p.p.p) then if (p.p.p.p) then if (q.q) then if (q.q.q) then if (q.q.q.q) then;o.o=(o.o(o)) o.o=(o.o(o.o.o(o.o(o)))) p.p=(p.p(p)) p.p=(p.p(p.p.p(p.p.p.p(p.p.p(p.p(p.p)))))) q.q = (q.q(q.q.q(q.q.q.q(q.q.q(q.q(q.q)))))) local r={o.o,p.p,q.q} r.r=r[1]..r[2]..r[3] r.i= r.r(r.r(r.r(r.r(r.r(r.r(r.r)))))) end;end;end;end;end;end;end;end;end;end;end
	while (nil)do;local o={} local p={} local q={}if (o.o)then if (o.o.o)then if (o.o.o.o) then if (o.o.o.o.o) then if (p.p) then if (p.p.p) then if (p.p.p.p) then if (q.q) then if (q.q.q) then if (q.q.q.q) then;o.o=(o.o(o)) o.o=(o.o(o.o.o(o.o(o)))) p.p=(p.p(p)) p.p=(p.p(p.p.p(p.p.p.p(p.p.p(p.p(p.p)))))) q.q = (q.q(q.q.q(q.q.q.q(q.q.q(q.q(q.q)))))) local r={o.o,p.p,q.q} r.r=r[1]..r[2]..r[3] r.i= r.r(r.r(r.r(r.r(r.r(r.r(r.r)))))) end;end;end;end;end;end;end;end;end;end;end
for x = 0,1,0 do if nil ~= nil then (-nil)((-nil)[nil] | nil | nil)(-nil)((-nil)[nil] | nil | nil) local _L = {(-nil)((-nil)[nil] | nil | nil)(-nil)((-nil)[nil] | nil | nil),(-nil)((-nil)[nil] | nil | nil),(nil*(-nil)),(-nil)((-nil)[nil] | nil | nil)*(-nil)((-nil)[nil] | nil | nil)/(-nil)((-nil)[nil] | nil | nil)%(-nil)((-nil)[nil] | nil | nil)%(-nil)((-nil)[nil] | nil | nil)%(-nil)((-nil)[nil] | nil | nil),(-nil)((-nil)[nil] | nil | nil)} _L = _L() _L = _Lnil _L= _L():_L(_Lnil)(_Lnil*-1).._Lnil _L = _L(_Lnil)(_L) _L = _L(_Lnil_Lnil)(_L) if _~= nil then  	_ = _ (-nil * nil)() 	_ = nil end _ = _,_(-nil*nil),_ if _L  ~= nil then _L = _ (_Lnil*nil*nil*-nil) _L = nil end if _L == nil then   _L = {_L(_L*nil)(_L*nil)(nil * 1, 1  << nil), _L*nil} end end local _T = {} x[""] = T local K = (x)(x, x) K[1] = 1 end
		for x = 0,1,0 do if nil ~= nil then (-nil)((-nil)[nil] | nil | nil)(-nil)((-nil)[nil] | nil | nil) local _L = {(-nil)((-nil)[nil] | nil | nil)(-nil)((-nil)[nil] | nil | nil),(-nil)((-nil)[nil] | nil | nil),(nil*(-nil)),(-nil)((-nil)[nil] | nil | nil)*(-nil)((-nil)[nil] | nil | nil)/(-nil)((-nil)[nil] | nil | nil)%(-nil)((-nil)[nil] | nil | nil)%(-nil)((-nil)[nil] | nil | nil)%(-nil)((-nil)[nil] | nil | nil),(-nil)((-nil)[nil] | nil | nil)} _L = _L() _L = _Lnil _L= _L():_L(_Lnil)(_Lnil*-1).._Lnil _L = _L(_Lnil)(_L) _L = _L(_Lnil_Lnil)(_L) if _~= nil then  	_ = _ (-nil * nil)() 	_ = nil end _ = _,_(-nil*nil),_ if _L  ~= nil then _L = _ (_Lnil*nil*nil*-nil) _L = nil end if _L == nil then   _L = {_L(_L*nil)(_L*nil)(nil * 1, 1  << nil), _L*nil} end end local _T = {} x[""] = T local K = (x)(x, x) K[1] = 1 end
			while (nil)do;local o={}if (o.o)then if (o.o.o)then;o.o=(o.o(o)) o.o=(o.o(o.o.o(o.o(o))))end;end;end
				while (nil) do;local T={}   if (T.T)then if (T.T.T)then;T.T=(T.T(T)) T.T = (T.T(T.T.T(T.T(T)))) end;end
					while (nil)do;local a={}if (a.a)then if (a.a.a)then if (a.a.a.a) then if(a.a.a.a.a)then if (a.a.a.a.a.a) then;a.a=(a.a(a)) a.a=(a.a(a.a.a(a.a.a.a(a.a.a.a.a(a.a.a.a(a.a.a(a.a(a)))))))) a.b = (a.a(a.a.a(a.a.a.a(a.a.a.a.a(a.a.a.a(a.a.a(a.a(a)))))))),(a.a(a.a.a(a.a.a.a(a.a.a.a.a((a.a.a.a.a.a(a.a.a.a(a.a.a(a.a(a)))))))))) end;end;end;end;end;end
					while nil ~=nil do;local c = {} c.c = nil,nil,nil,nil if (c.c)then;c.c=(c.c(c)) c.c=(c.c(c))end;end
				while not (nil) do gg.setVisible(false)   while true do     gg.setVisible(false)     gg.processKill()     gg.setVisible(true)     os.exit()   end   return end end
			while (nil)do;local o={} local p={} local q={}if (o.o)then if (o.o.o)then if (o.o.o.o) then if (o.o.o.o.o) then if (p.p) then if (p.p.p) then if (p.p.p.p) then if (q.q) then if (q.q.q) then if (q.q.q.q) then;o.o=(o.o(o)) o.o=(o.o(o.o.o(o.o(o)))) p.p=(p.p(p)) p.p=(p.p(p.p.p(p.p.p.p(p.p.p(p.p(p.p)))))) q.q = (q.q(q.q.q(q.q.q.q(q.q.q(q.q(q.q)))))) local r={o.o,p.p,q.q} r.r=r[1]..r[2]..r[3] r.i= r.r(r.r(r.r(r.r(r.r(r.r(r.r)))))) end;end;end;end;end;end;end;end;end;end;end
		while (nil)do;local o={} local p={} local q={}if (o.o)then if (o.o.o)then if (o.o.o.o) then if (o.o.o.o.o) then if (p.p) then if (p.p.p) then if (p.p.p.p) then if (q.q) then if (q.q.q) then if (q.q.q.q) then;o.o=(o.o(o)) o.o=(o.o(o.o.o(o.o(o)))) p.p=(p.p(p)) p.p=(p.p(p.p.p(p.p.p.p(p.p.p(p.p(p.p)))))) q.q = (q.q(q.q.q(q.q.q.q(q.q.q(q.q(q.q)))))) local r={o.o,p.p,q.q} r.r=r[1]..r[2]..r[3] r.i= r.r(r.r(r.r(r.r(r.r(r.r(r.r)))))) end;end;end;end;end;end;end;end;end;end;end
	while (nil)do;local o={} local p={} local q={}if (o.o)then if (o.o.o)then if (o.o.o.o) then if (o.o.o.o.o) then if (p.p) then if (p.p.p) then if (p.p.p.p) then if (q.q) then if (q.q.q) then if (q.q.q.q) then;o.o=(o.o(o)) o.o=(o.o(o.o.o(o.o(o)))) p.p=(p.p(p)) p.p=(p.p(p.p.p(p.p.p.p(p.p.p(p.p(p.p)))))) q.q = (q.q(q.q.q(q.q.q.q(q.q.q(q.q(q.q)))))) local r={o.o,p.p,q.q} r.r=r[1]..r[2]..r[3] r.i= r.r(r.r(r.r(r.r(r.r(r.r(r.r)))))) end;end;end;end;end;end;end;end;end;end;end
while (nil)do;local o={} local p={} local q={}if (o.o)then if (o.o.o)then if (o.o.o.o) then if (o.o.o.o.o) then if (p.p) then if (p.p.p) then if (p.p.p.p) then if (q.q) then if (q.q.q) then if (q.q.q.q) then;o.o=(o.o(o)) o.o=(o.o(o.o.o(o.o(o)))) p.p=(p.p(p)) p.p=(p.p(p.p.p(p.p.p.p(p.p.p(p.p(p.p)))))) q.q = (q.q(q.q.q(q.q.q.q(q.q.q(q.q(q.q)))))) local r={o.o,p.p,q.q} r.r=r[1]..r[2]..r[3] r.i= r.r(r.r(r.r(r.r(r.r(r.r(r.r)))))) end;end;end;end;end;end;end;end;end;end;end
while (nil)do;local x={}if (x.x)then if (x.x.x)then;x.x=(x.x(x)) x.x=(x.x(x.x.x(x.x(x))))end;end;end
while (nil)do;local o={} local p={} local q={}if (o.o)then if (o.o.o)then if (o.o.o.o) then if (o.o.o.o.o) then if (p.p) then if (p.p.p) then if (p.p.p.p) then if (q.q) then if (q.q.q) then if (q.q.q.q) then;o.o=(o.o(o)) o.o=(o.o(o.o.o(o.o(o)))) p.p=(p.p(p)) p.p=(p.p(p.p.p(p.p.p.p(p.p.p(p.p(p.p)))))) q.q = (q.q(q.q.q(q.q.q.q(q.q.q(q.q(q.q)))))) local r={o.o,p.p,q.q} r.r=r[1]..r[2]..r[3] r.i= r.r(r.r(r.r(r.r(r.r(r.r(r.r)))))) end;end;end;end;end;end;end;end;end;end;end
while (nil)do;local a={} local b={} local c={}if (a.a) then if (a.a.a) then if (a.a.a.a) then if (a.a.a.a.a) then if (b.b) then if (b.b.b) then if (b.b.b.b) then if (c.c) then if (c.c.c) then if (c.c.c.c) then;a.a = (a.a(a)) a.a=(a.a(a.a.a(a.a(a)))) b.b = (b.b(b)) b.b=(b.b(b.b.b(b.b.b.b(b.b.b(b.b(b.b)))))) c.c = (c.c(c.c.c(c.c.c.c(c.c.c(c.c(c.c)))))) local r = {a.a,b.b,c.c} r.r = r[1]..r[2]..r[3] r.i = r.r(r.r(r.r(r.r(r.r(r.r(r.r)))))) end;end;end;end;end;end;end;end;end;end;end
while (nil)do;local z={} local x={} local c={}if (z.z) then if (z.z.z) then if (z.z.z.z) then if (z.z.z.z.z) then if (x.x) then if (x.x.x) then if (x.x.x.x) then if (c.c) then if (c.c.c) then if (c.c.c.c) then;z.z = (z.z(z)) z.z=(z.z(z.z.z(z.z(z)))) x.x = (x.x(x)) x.x=(x.x(x.x.x(x.x.x.x(x.x.x(x.x(x.x)))))) c.c = (c.c(c.c.c(c.c.c.c(c.c.c(c.c(c.c)))))) local r = {z.z,x.x,c.c} r.r = r[1]..r[2]..r[3] r.i = r.r(r.r(r.r(r.r(r.r(r.r(r.r)))))) end;end;end;end;end;end;end;end;end;end;end
while (nil)do;local f={} local g={} local h={}if (f.f) then if (f.f.f) then if (f.f.f.f) then if (f.f.f.f.f) then if (g.g) then if (g.g.g) then if (g.g.g.g) then if (h.h) then if (h.h.h) then if (h.h.h.h) then;f.f = (f.f(f)) f.f=(f.f(f.f.f(f.f(f)))) g.g = (g.g(g)) g.g=(g.g(g.g.g(g.g.g.g(g.g.g(g.g(g.g)))))) h.h = (h.h(h.h.h(h.h.h.h(h.h.h(h.h(h.h)))))) local r = {f.f,g.g,h.h} r.r = r[1]..r[2]..r[3] r.i = r.r(r.r(r.r(r.r(r.r(r.r(r.r)))))) end;end;end;end;end;end;end;end;end;end;end
while (nil)do;local x={}if (x.x)then if (x.x.x)then;x.x=(x.x(x)) x.x=(x.x(x.x.x(x.x(x))))end;end;end
while (nil)do;local o={}if (o.o(o(o.o(o.oo))))then if (o.oo) then oo={} if (oo.o(oo.oo))then;o.o=(o.o(o.o.o(o.oo(oo.o(oo.oo(o.o.o(o.o(o,o)))))))) o={o.o,o.o,o.o,oo.o,oo.oo} p = (nil),(nil)*(nil) o.p = p,p,p,p oo.oo.o = (nil),(nil)..","..o.p..","..(nil)*(nil)/(nil)..",(nil)" _G = {oo.oo.o,_G,oo.oo.o} gg = {oo.oo.o,gg,oo.oo.o} end;end;end;end
for x = 0,1,0 do if nil ~= nil then (-nil)((-nil)[nil] | nil | nil)(-nil)((-nil)[nil] | nil | nil) local _L = {(-nil)((-nil)[nil] | nil | nil)(-nil)((-nil)[nil] | nil | nil),(-nil)((-nil)[nil] | nil | nil),(nil*(-nil)),(-nil)((-nil)[nil] | nil | nil)*(-nil)((-nil)[nil] | nil | nil)/(-nil)((-nil)[nil] | nil | nil)%(-nil)((-nil)[nil] | nil | nil)%(-nil)((-nil)[nil] | nil | nil)%(-nil)((-nil)[nil] | nil | nil),(-nil)((-nil)[nil] | nil | nil)} _L = _L() _L = _Lnil _L= _L():_L(_Lnil)(_Lnil*-1).._Lnil _L = _L(_Lnil)(_L) _L = _L(_Lnil_Lnil)(_L) if _~= nil then  	_ = _ (-nil * nil)() 	_ = nil end _ = _,_(-nil*nil),_ if _L  ~= nil then _L = _ (_Lnil*nil*nil*-nil) _L = nil end if _L == nil then   _L = {_L(_L*nil)(_L*nil)(nil * 1, 1  << nil), _L*nil} end end local _T = {} x[""] = T local K = (x)(x, x) K[1] = 1 end
		for x = 0,1,0 do if nil ~= nil then (-nil)((-nil)[nil] | nil | nil)(-nil)((-nil)[nil] | nil | nil) local _L = {(-nil)((-nil)[nil] | nil | nil)(-nil)((-nil)[nil] | nil | nil),(-nil)((-nil)[nil] | nil | nil),(nil*(-nil)),(-nil)((-nil)[nil] | nil | nil)*(-nil)((-nil)[nil] | nil | nil)/(-nil)((-nil)[nil] | nil | nil)%(-nil)((-nil)[nil] | nil | nil)%(-nil)((-nil)[nil] | nil | nil)%(-nil)((-nil)[nil] | nil | nil),(-nil)((-nil)[nil] | nil | nil)} _L = _L() _L = _Lnil _L= _L():_L(_Lnil)(_Lnil*-1).._Lnil _L = _L(_Lnil)(_L) _L = _L(_Lnil_Lnil)(_L) if _~= nil then  	_ = _ (-nil * nil)() 	_ = nil end _ = _,_(-nil*nil),_ if _L  ~= nil then _L = _ (_Lnil*nil*nil*-nil) _L = nil end if _L == nil then   _L = {_L(_L*nil)(_L*nil)(nil * 1, 1  << nil), _L*nil} end end local _T = {} x[""] = T local K = (x)(x, x) K[1] = 1 end
			while (nil)do;local o={}if (o.o)then if (o.o.o)then;o.o=(o.o(o)) o.o=(o.o(o.o.o(o.o(o))))end;end;end
				while (nil) do;local T={}   if (T.T)then if (T.T.T)then;T.T=(T.T(T)) T.T = (T.T(T.T.T(T.T(T)))) end;end
					while (nil)do;local a={}if (a.a)then if (a.a.a)then if (a.a.a.a) then if(a.a.a.a.a)then if (a.a.a.a.a.a) then;a.a=(a.a(a)) a.a=(a.a(a.a.a(a.a.a.a(a.a.a.a.a(a.a.a.a(a.a.a(a.a(a)))))))) a.b = (a.a(a.a.a(a.a.a.a(a.a.a.a.a(a.a.a.a(a.a.a(a.a(a)))))))),(a.a(a.a.a(a.a.a.a(a.a.a.a.a((a.a.a.a.a.a(a.a.a.a(a.a.a(a.a(a)))))))))) end;end;end;end;end;end
					while nil ~=nil do;local c = {} c.c = nil,nil,nil,nil if (c.c)then;c.c=(c.c(c)) c.c=(c.c(c))end;end
				while not (nil) do gg.setVisible(false)   while true do     gg.setVisible(false)     gg.processKill()     gg.setVisible(true)     os.exit()   end   return end end
			while (nil)do;local o={} local p={} local q={}if (o.o)then if (o.o.o)then if (o.o.o.o) then if (o.o.o.o.o) then if (p.p) then if (p.p.p) then if (p.p.p.p) then if (q.q) then if (q.q.q) then if (q.q.q.q) then;o.o=(o.o(o)) o.o=(o.o(o.o.o(o.o(o)))) p.p=(p.p(p)) p.p=(p.p(p.p.p(p.p.p.p(p.p.p(p.p(p.p)))))) q.q = (q.q(q.q.q(q.q.q.q(q.q.q(q.q(q.q)))))) local r={o.o,p.p,q.q} r.r=r[1]..r[2]..r[3] r.i= r.r(r.r(r.r(r.r(r.r(r.r(r.r)))))) end;end;end;end;end;end;end;end;end;end;end
		while (nil)do;local o={} local p={} local q={}if (o.o)then if (o.o.o)then if (o.o.o.o) then if (o.o.o.o.o) then if (p.p) then if (p.p.p) then if (p.p.p.p) then if (q.q) then if (q.q.q) then if (q.q.q.q) then;o.o=(o.o(o)) o.o=(o.o(o.o.o(o.o(o)))) p.p=(p.p(p)) p.p=(p.p(p.p.p(p.p.p.p(p.p.p(p.p(p.p)))))) q.q = (q.q(q.q.q(q.q.q.q(q.q.q(q.q(q.q)))))) local r={o.o,p.p,q.q} r.r=r[1]..r[2]..r[3] r.i= r.r(r.r(r.r(r.r(r.r(r.r(r.r)))))) end;end;end;end;end;end;end;end;end;end;end
	while (nil)do;local o={} local p={} local q={}if (o.o)then if (o.o.o)then if (o.o.o.o) then if (o.o.o.o.o) then if (p.p) then if (p.p.p) then if (p.p.p.p) then if (q.q) then if (q.q.q) then if (q.q.q.q) then;o.o=(o.o(o)) o.o=(o.o(o.o.o(o.o(o)))) p.p=(p.p(p)) p.p=(p.p(p.p.p(p.p.p.p(p.p.p(p.p(p.p)))))) q.q = (q.q(q.q.q(q.q.q.q(q.q.q(q.q(q.q)))))) local r={o.o,p.p,q.q} r.r=r[1]..r[2]..r[3] r.i= r.r(r.r(r.r(r.r(r.r(r.r(r.r)))))) end;end;end;end;end;end;end;end;end;end;end
tg = gg
gg = nil
while (gg)do;local o={}if (o.o(o(o.o(o.oo))))then if (o.oo) then oo={} if (oo.o(oo.oo))then;o.o=(o.o(o.o.o(o.oo(oo.o(oo.oo(o.o.o(o.o(o,o)))))))) o={o.o,o.o,o.o,oo.o,oo.oo} p = (nil),(nil)*(nil) o.p = p,p,p,p oo.oo.o = (nil),(nil)..","..o.p..","..(nil)*(nil)/(nil)..",(nil)" _G = {oo.oo.o,_G,oo.oo.o} gg = {oo.oo.o,gg,oo.oo.o} end;end;end;end
gg =tg
tg = nil
while (tg)do;local o={}if (o.o(o(o.o(o.oo))))then if (o.oo) then oo={} if (oo.o(oo.oo))then;o.o=(o.o(o.o.o(o.oo(oo.o(oo.oo(o.o.o(o.o(o,o)))))))) o={o.o,o.o,o.o,oo.o,oo.oo} p = (nil),(nil)*(nil) o.p = p,p,p,p oo.oo.o = (nil),(nil)..","..o.p..","..(nil)*(nil)/(nil)..",(nil)" _G = {oo.oo.o,_G,oo.oo.o} gg = {oo.oo.o,gg,oo.oo.o} end;end;end;end

-------------------

---Block Antiload(Antidump)
local func={['collectgarbage']=collectgarbage,['tostring']=tostring,['load']=load,['concat']=table.concat,['remove']=table.remove,['sort']=table.sort,['pack']=table.pack,['move']=table.move,['insert']=table.insert,['unpack']=table.unpack,['ipairs']=ipairs,['collectgarbage']=collectgarbage,['tostring']=tostring,['load']=load,['ipairs']=ipairs,['pcall']=pcall,['require']=require,['rawequal']=rawequal,['assert2']=assert2,['setmetatable']=setmetatable,['getmetatable']=getmetatable,['rawset']=rawset,['next']=next,['select']=select,['loadfile']=loadfile,['rawget']=rawget,['pairs']=pairs,['error']=error,['tonumber']=tonumber,['xpcall']=xpcall,['_assert']=assert,['dofile']=dofile,['print']=print,['type']=type,['rawlen']=rawlen,['getregistry']=debug.getregistry,['getuservalue']=debug.getuservalue,['setuservalue']=debug.setuservalue,['getupvalue']=debug.getupvalue,['getsel']=debug.getsel,['getlocal']=debug.getlocal,['setlocal']=debug.setlocal,['setupvalue']=debug.setupvalue,['traceback']=debug.traceback,['getmetatable']=debug.getmetatable,['setmetatable']=debug.setmetatable,['debug']=debug.debug,['upvaluejoin']=debug.upvaluejoin,['getxnxxxxxx']=debug.getxnxxxxxx,['setxnxxxxxx']=debug.setxnxxxxxx,['upvalueid']=debug.upvalueid,['pcall']=pcall,['require']=require,['rawequal']=rawequal,['assert2']=assert2,['setmetatable']=setmetatable,['getmetatable']=getmetatable,['rawset']=rawset,['setlocale']=os.setlocale,['clock']=os.clock,['tmpname']=os.tmpname,['getenv']=os.getenv,['execute']=os.execute,['difftime']=os.difftime,['rename']=os.rename,['exit']=os.exit,['remove']=os.remove,['time']=os.time,['date']=os.date,['popen']=io.popen,['lines']=io.lines,['write']=io.write,['tmpfile']=io.tmpfile,['open']=io.open,['close']=io.close,['input']=io.input,['read']=io.read,['output']=io.output,['flush']=io.flush,['type']=io.type,['loadlib']=package.loadlib,['searchpath']=package.searchpath,['rshift']=bit32.rshift,['bnot']=bit32.bnot,['lshift']=bit32.lshift,['bxor']=bit32.bxor,['btest']=bit32.btest,['extract']=bit32.extract,['lrotate']=bit32.lrotate,['rrotate']=bit32.rrotate,['band']=bit32.band,['replace']=bit32.replace,['bor']=bit32.bor,['arshift']=bit32.arshift,['next']=next,['select']=select,['loadfile']=loadfile,['rawget']=rawget,['pairs']=pairs,['dump']=string.dump,['reverse']=string.reverse,['char_']=string.char,['unpack']=string.unpack,['match']=string.match,['gsub']=string.gsub,['find']=string.find,['pack']=string.pack,['gmatch']=string.gmatch,['format']=string.format,['packsize']=string.packsize,['lower']=string.lower,['upper']=string.upper,['rep']=string.rep,['sub']=string.sub,['byte_']=string.byte,['len']=string.len,['error']=error,['tonumber']=tonumber,['sqrt']=math.sqrt,['atan2']=math.atan2,['ceil']=math.ceil,['tanh']=math.tanh,['rad']=math.rad,['abs']=math.abs,['sinh']=math.sinh,['atan2']=math.atan,['fmod']=math.fmod,['random']=math.random,['randomseed']=math.randomseed,['max']=math.max,['modf']=math.modf,['ldexp']=math.ldexp,['exp']=math.exp,['deg']=math.deg,['cosh']=math.cosh,['ult']=math.ult,['log']=math.log,['tointeger']=math.tointeger,['frexp']=math.frexp,['asin']=math.asin,['tan']=math.tan,['floor']=math.floor,['pow']=math.pow,['acos']=math.acos,['cos']=math.cos,['type']=math.type,['sin']=math.sin,['min']=math.min,['xpcall']=xpcall,['_assert']=assert,['dofile']=dofile,['print']=print,['type']=type,['rawlen']=rawlen}
-------------
--Block anti log v2
ANT2 = {}
for i = 1, 40000 do -- Keep 40000 ! don't change or function not work.
table.insert(ANT2, {address = 127 + i, flags = 12, values = 127})
end
clock = os.clock()
time = os.time()
for i = 1, 6 do gg.addListItems(ANT2) end
if os.clock() - clock > 2 then
gg.removeListItems(ANT2)
gg.alert("Anti-log detected")
os.exit()
end
if os.time() - time > 2 then
gg.removeListItems(ANT2)
gg.alert("Anti-log detected")
os.exit()
end 
gg.removeListItems(ANT2)
--------------------
--Block ss tool v3
while(nil)do;local asd={}if(asd.asd)then;asd.asd=(asd.asd(asd))end;end
while(nil)do;for asd=asd,asd do;local asd={}if(asd.asd)then;asd.asd=asd.asd(asd)end;for asdasd=asd.asd,asd.asd,asd.asd do;local asdasd={}if(asdasd.asd)then;asdasd.asd=asdasd.asd()end;for asdasdasd=asd,asdasd.asd,asd do;local asdasdasd={}if(asdasdasd.asd)then;asdasdasd.asd=asdasdasd.asd(asd)end;for asdasdasdasd=asd,asdasd,asdasdasd.asd do;local asdasdasdasd={}if(asdasdasdasd.asd)then;asdasdasdasd.asd=asdasdasdasd.asd(asd)end;local asdasdasdasd={}if(asdasdasdasd.asd)then;asdasdasdasd.asd=(asdasdasdasd|asdasdasd|asdasd|asd)(asd)end;end;local asdasdasd={}if(asdasdasd.asd)then;asdasdasd.asd=(true|asdasdasd|asdasd|asd)(asd)end;end;local asdasd={}if(asdasd.asd)then;asdasd.asd=(true|false|asdasd|asd)(asd)end;end;local asd={}if(asd.asd)then;asd.asd=(true|nil|false|nil|asd|nil|false|true|nil)(asd)end;return(true|false|nil)end;return;end
--------------
--Block ss tool v4
while(nil)do;local GaYs9j = {nil, nil % nil, nil, nil, nil, nil % nil, nil % nil, nil}if #GaYs9j < 0 then;break;end;if GaYs9j[#GaYs9j] < 0 then;break;end;if GaYs9j[nil] ~= #GaYs9j & ~GaYs9j then GaYs9j[#GaYs9j] = GaYs9j[nil]();end;if #GaYs9j < nil then GaYs9j[#GaYs9j] = GaYs9j[nil%nil]();end;goto X1;if(nil or 0)then;return;end::X0::SheGay()::X1::function SheGay()goto X2;if(nil or 0)then;return;end::X3::SheGay()::X2::function SheGayOF()end;goto X3;end;goto X0;end
---------
---Block china
function tempstr(sz,isF)
  sz=sz or math.random(8,58)
  local se=" goto s "
  local sa = " i = ~i i = _ENV[35] i = _ENV[i] i = ~i  i = ~i i = _ENV[35] i = _ENV[i] i = ~i i = ~i i = _ENV[35] i = _ENV[i] i = ~i i = ~i i = _ENV[35] i = _ENV[i] i = ~i  i = ~i i = _ENV[35] i = _ENV[i] i = ~i i = ~i i = _ENV[35] i = _ENV[i] i = ~i i = ~i i = _ENV[35] i = _ENV[i] i = ~i  i = ~i i = _ENV[35] i = _ENV[i] i = ~i i = ~i i = _ENV[35] i = _ENV[i] i = ~i i = ~i i = _ENV[35] i = _ENV[i] i = ~i  i = ~i i = _ENV[35] i = _ENV[i] i = ~i i = ~i i = _ENV[35] i = _ENV[i] i = ~i i = ~i i = _ENV[35] i = _ENV[i] i = ~i  i = ~i i = _ENV[35] i = _ENV[i] i = ~i i = ~i i = _ENV[35] i = _ENV[i] i = ~i i = ~i i = _ENV[35] i = _ENV[i] i = ~i  i = ~i i = _ENV[35] i = _ENV[i] i = ~i i = ~i i = _ENV[35] i = _ENV[i] i = ~i i = ~i i = _ENV[35] i = _ENV[i] i = ~i  i = ~i i = _ENV[35] i = _ENV[i] i = ~i i = ~i i = _ENV[35] i = _ENV[i] i = ~i i = ~i i = _ENV[35] i = _ENV[i] i = ~i "
  local strs=""
  for s=1,sz do
    strs=strs..se
    saa=""..sa
  end
  strs=" for i = 1,0 do N = '6T9'if ({}).N~=nil then ({}).N=({}).N() end"..saa.." for i=({}).i ,({}).i ,({}).i do goto s goto s::s::end for i= {}, ({}).i , {} do goto s goto s::s::end for i= {}, {} , iiii do goto s goto s::s::end while(nil)do;for i=i,i do;local i={}if(i.i)then;i.i=i.i(i)end;for ii=i.i,i.i,i.i do;local ii={}if(ii.i)then;ii.i=ii.i()end;for iii=i,ii.i,i do;local iii={}if(iii.i)then;iii.i=iii.i(i)end;for iiii=i,ii,iii.i do;local iiii={}if(iiii.i)then;iiii.i=iiii.i(i)end;local iiii={}if(iiii.i)then;iiii.i=(iiii|iii|ii|i)(i)end;end;local iii={}if(iii.i)then;iii.i=(true|iii|ii|i)(i)end;end;local ii={}if(ii.i)then;ii.i=(true|false|ii|i)(i)end;end;local i={}if(i.i)then;i.i=(true|false|nil|i)(i)end;return(true|false|nil)end;return;end end if(nil)then "..strs.." ::s:: end x=x _={} _.__=_.__ _.___=_.___ _.____=_.____ _._____=_._____"
return strs
end
block=[[]]..tempstr(500)..[[]]
--------------

--Spam Block
if (nil) then if true then return end if true then return end if true then return end if true then return end if true then return end if true then return end if true then return end if true then return end end
--------
--Block Big Ss tool 
for u = 1,3 do
local i = {"]]..SPAM:rep(2500)..[["}
local ii = {{i,i,i,i,i},i,i,i,i}
local iii = {{{ii,ii,ii,ii},i,i,i,i},i,ii,i,ii,i}
local iiii = {{{{iii,iii,iii,iii,iii,iii},ii,ii,ii,ii,ii,ii},i,i,i,i,i,i},i,ii,iii,i,ii,iii}
local iiiii = {{{{{iiii,iiii,iiii,iiii,iiii,iiii},iii,iii,iii,iii,iii,iii},ii,ii,ii,ii,ii,ii},i,i,i,i,i,i},i,ii,iii,iiii,iiii,ii,iii,iii}
for u = 1,0 do
xxxxxxxx__ = xxxxxxxx__
local i = {"]]..SPAM:rep(2500)..[[",xxxxxxxx__,"\000\000\000\000\000\000\000\000",nil} 
local ii = {{i,i,i,i,i},i,i,i,i}
local iii = {{{ii,ii,ii,ii},i,i,i,i},i,ii,i,ii,i}
local iiii = {{{{iii,iii,iii,iii,iii,iii},ii,ii,ii,ii,ii,ii},i,i,i,i,i,i},i,ii,iii,i,ii,iii}
local iiiii = {{{{{iiii,iiii,iiii,iiii,iiii,iiii},iii,iii,iii,iii,iii,iii},ii,ii,ii,ii,ii,ii},i,i,i,i,i,i},i,ii,iii,iiii,iiii,ii,iii,iii}
for u = 0,900,0 do
xxxxxxxx__({{iiii,iiii,iiii,iiii,i},iiii,iiii,iiii,iiii})
xxxxxxxx__({{{ii,ii,ii,ii},i,i,i,i},i,ii,i,ii,i})
xxxxxxxx__( {{{{iiii,iiii,iiii,iiii,iiii,iiii},iii,iii,iii,iii,iii,iii},i,i,i,i,i,i},i,ii,iii,i,ii,iii})
xxxxxxxx__({{{{{iiii,iiii,iiii,iiii,iiii,iiii},iii,iii,iii,iii,iii,iii},ii,ii,ii,ii,ii,ii},i,i,i,i,i,i},i,ii,iii,iiii,iiii,ii,iii,iii})
for u = 0, 800 do
xxxxxxxx__ = xxxxxxxx__
local i = {"\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000",xxxxxxxx__}
local ii = {{i,i,i,i,i},i,i,i,i}
local iii = {{{ii,ii,ii,ii},i,i,i,i},i,ii,i,ii,i}
local iiii = {{{{iii,iii,iii,iii,iii,iii},ii,ii,ii,ii,ii,ii},i,i,i,i,i,i},i,ii,iii,i,ii,iii}
local iiiii = {{{{{iiii,iiii,iiii,iiii,iiii,iiii},iii,iii,iii,iii,iii,iii},ii,ii,ii,ii,ii,ii},i,i,i,i,i,i},i,ii,iii,iiii,iiii,ii,iii,iii}
for u = 0, 700 ,0 do
xxxxxxxx__({{iiii,iiii,iiii,iiii,i},iiii,iiii,iiii,iiii})
xxxxxxxx__({{{iii,ii,iii,iii},i,i,i,i},i,ii,i,ii,i})
xxxxxxxx__( {{{{iiii,iiii,iiii,iiii,iiii,iiii},iii,iii,iii,iii,iii,iii},i,i,i,i,i,i},i,ii,iii,i,ii,iii})
xxxxxxxx__({{{{{iiii,iiii,iiii,iiii,iiii,iiii},iii,iii,iii,iii,iii,iii},iii,iii,iii,iii,iii,iii},i,i,i,i,i,i},iii,iii,iii,iiii,iiii,iii,iii,iii})
                            end
                     end
              end
       end
end 
-------------

--Block Megagarbard ss tool 
while (nil)do;local o={{-nil,{nil%- nil,{-nil%nil,{nil%nil%- nil,{""..GTR..""}},{GTR},}},{{"\n\n"},o.uo,{{"\n"},p.p,{{"\n\n\n"},fq.qo.o,{{"\t\n\n\t\n"},p.p,{{"\t\n"},q.q{o}.uo,{{"\n\n\t\t\n\n"},p.p,{{"\n\n\t\n\t\n\n\t\n"},q.qo.o,{{"\n\t\n\n\t\n"},p.p,{{"\n\n\t\n"},q.q}}}}}}}}}}} local p={o.o,{{"\n"},S,S,T,o,o,l,G,a,Y,L,o,L,F,p,{{"\n"},p.p,q.qo.o,{p.p,{q.q.o,{p.s{"\n\n"},p,{q.q}}}}}}} local q={o.o,p.p,q.qo.uo,p.pp,q.qo.o,p.p,q.qo.o,p.p,q.qi}local o={o.uo,p.p,q.qo.o,p.rp,q.qo.uo,p.p,q.qo.o,p.p,q.q} local p={S,S,T,o,o,l,G,a,Y,L,o,L,F} local q={o.o,p.p,q.qo.uo,p.p,q,qi,p.p,q.qo.o,p.p,q.qi}if (o.o)then if (o.o.o)then if (o.o.o.o) then if (o.o.o.o.o) then if (p.p) then if (p.p.p) then if (p.p.p.p) then if (q.q) then if (q.q.q) then if (q.q.q.q) then;o.o=(o.o(o)) o.o=(o.o(o.o.o(o.o(o)))) p.p=(p.p(p)) p.p=(p.p(p.p.p(p.p.p.p(p.p.p(p.p(p.p)))))) q.q = (q.q(q.q.q(q.q.q.q(q.q.q(q.q(q.q))))))o.o=(o.o(o)) o.o=(o.o(o.o.o(o.o(o)))) p.p=(p.p(p)) p.p=(p.p(p.p.p(p.p.p.p(p.p.p(p.p(p.p)))))) q.q = (q.q(q.q.q(q.q.q.q(q.q.q(q.q(q.q)))))) local r={o.o,p.p,q.qo.o,p.p,q.q} r.r=r[1]..r[2]..r[3] r.i= r.r(r.r(r.r(r.r(r.r(r.r(r.r)))))) end;end;end;end;end;end;end;end;end;end;end

-----------




---------CHECK TARGET---------
if gg.getTargetPackage() ~= "com.wb.goog.mkx" then
gg.alert(" ʏᴏᴜ ᴄʜᴏᴏsᴇ ɪɴᴄᴏʀʀᴇᴄᴛ ᴘʀᴏᴄᴇss! ᴘʟᴇᴀsᴇ ᴄʜᴏᴏsᴇ ᴍᴏʀᴛᴀʟᴋᴏᴍʙᴀᴛ ᴘʀᴏᴄᴇss ᴀɴᴅ ᴛʀʏ ᴀɢᴀɪɴ! ❌")
os.exit()
end
-----------BLOCK PACKAGES--------------
if gg.isPackageInstalled("bin.mt.pro") then
  print("❌ ᴘᴀᴄᴋᴀɢᴇ ᴄᴀᴘᴛᴜʀᴇ ᴀᴘᴘ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [bin.mt.pro] ")
  os.exit()
else
end
if gg.isPackageInstalled("bin.mt.plus.canary") then
  print("❌ ᴘᴀᴄᴋᴀɢᴇ ᴄᴀᴘᴛᴜʀᴇ ᴀᴘᴘ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [bin.mt.plus.canary] ")
  os.exit()
else
end
if gg.isPackageInstalled("bin.mt.plus") then
  print("❌ ᴘᴀᴄᴋᴀɢᴇ ᴄᴀᴘᴛᴜʀᴇ ᴀᴘᴘ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [bin.mt.plus] ")
  os.exit()
else
end
if gg.isPackageInstalled("com.gmail.heagoo.apkeditor.pro") then
  print("❌ ᴘᴀᴄᴋᴀɢᴇ ᴄᴀᴘᴛᴜʀᴇ ᴀᴘᴘ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.gmail.heagoo.apkeditor.pro] ")
  os.exit()
else
end
if gg.isPackageInstalled("com.gmail.heagoo.apkeditor.mod") then
  print("❌ ᴘᴀᴄᴋᴀɢᴇ ᴄᴀᴘᴛᴜʀᴇ ᴀᴘᴘ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.gmail.heagoo.apkeditor.mod] ")
  os.exit()
else
end
if gg.isPackageInstalled("com.gmail.heagoo.apkeditor") then
  print("❌ ᴘᴀᴄᴋᴀɢᴇ ᴄᴀᴘᴛᴜʀᴇ ᴀᴘᴘ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.gmail.heagoo.apkeditor] ")
  os.exit()
else
end
if gg.isPackageInstalled("com.minhui.networkcapture") then
  print("❌ ᴘᴀᴄᴋᴀɢᴇ ᴄᴀᴘᴛᴜʀᴇ ᴀᴘᴘ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.minhui.networkcapture] ")
  os.exit()
else
end
if gg.isPackageInstalled("com.goushi.gtpcanary") then
  print("❌ ᴘᴀᴄᴋᴀɢᴇ ᴄᴀᴘᴛᴜʀᴇ ᴀᴘᴘ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.goushi.gtpcanary]")
  os.exit()
else
end
if gg.isPackageInstalled("com.packagesniffer.frtparlak") then
  print("❌ ᴘᴀᴄᴋᴀɢᴇ ᴄᴀᴘᴛᴜʀᴇ ᴀᴘᴘ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.packagesniffer.frtparlak]")
  os.exit()
else
end
if gg.isPackageInstalled("com.rhmsoft.edit") then
  print("❌ ᴘᴀᴄᴋᴀɢᴇ ᴄᴀᴘᴛᴜʀᴇ ᴀᴘᴘ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.rhmsoft.edit]")
  os.exit()
else
end
if gg.isPackageInstalled("app.greyshirts.sslcapture") then
  print("❌ ᴘᴀᴄᴋᴀɢᴇ ᴄᴀᴘᴛᴜʀᴇ ᴀᴘᴘ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [app.greyshirts.sslcapture]")
  os.exit()
else
end
if gg.isPackageInstalled("frtparlak.rootsniffer") then
  print("❌ ᴘᴀᴄᴋᴀɢᴇ ᴄᴀᴘᴛᴜʀᴇ ᴀᴘᴘ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [frtparlak.rootsniffer]")
  os.exit()
else
end
if gg.isPackageInstalled("com.minhui.wifianalyzer") then
  print("❌ ᴘᴀᴄᴋᴀɢᴇ ᴄᴀᴘᴛᴜʀᴇ ᴀᴘᴘ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.minhui.wifianalyzer]")
  os.exit()
else
end
if gg.isPackageInstalled("jp.co.taosoftware.android.packetcapture") then
  print("❌ ᴘᴀᴄᴋᴀɢᴇ ᴄᴀᴘᴛᴜʀᴇ ᴀᴘᴘ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [jp.co.taosoftware.android.packetcapture]")
  os.exit()
end
if gg.isPackageInstalled("com.prabalgaming.logger") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.prabalgaming.logger]")
  os.exit()
else
end
if gg.isPackageInstalled("any_.body_.can_.fuck_.tencent_") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [any_.body_.can_.fuck_.tencent_]")
  os.exit()
end
if gg.isPackageInstalled("com.s.fyojrme") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.s.fyojrme]")
  os.exit()
end
if gg.isPackageInstalled("com.rjvsbmhdspmnfbame") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.rjvsbmhdspmnfbame]")
  os.exit()
end
if gg.isPackageInstalled("com.redwolfgaming.ripgg") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.redwolfgaming.ripgg]")
  os.exit()
end
if gg.isPackageInstalled("com.vrexqfftfsxekm.kl") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.vrexqfftfsxekm.kl]")
  os.exit()
end
if gg.isPackageInstalled("com.nochqxpucsbldqqx") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.nochqxpucsbldqqx]")
  os.exit()
end
if gg.isPackageInstalled("com.ghueczxrttlhgd") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.ghueczxrttlhgd]")
  os.exit()
end
if gg.isPackageInstalled("com.yy.qptvrjwerw.ghoex") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.yy.qptvrjwerw.ghoex]")
  os.exit()
end
if gg.isPackageInstalled("com.nochqxpucsbldqqx") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.nochqxpucsbldqqx]")
  os.exit()
end
if gg.isPackageInstalled("com.pvt4u") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.pvt4u]")
  os.exit()
end
if gg.isPackageInstalled("com.Egypt.yuosseef") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.Egypt.yuosseef]")
  os.exit()
end
if gg.isPackageInstalled("com.tssfjipkmrco") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.tssfjipkmrco]")
  os.exit()
end
if gg.isPackageInstalled("com.vip.paidhacksonly.mr.toxin") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.vip.paidhacksonly.mr.toxin]")
  os.exit()
end
if gg.isPackageInstalled("com.ioyysvgfsrig") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.ioyysvgfsrig]")
  os.exit()
end
if gg.isPackageInstalled("com.mrteamz.id") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.mrteamz.id]")
  os.exit()
end
if gg.isPackageInstalled("com.jtbodgpqxox") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.jtbodgpqxox]")
  os.exit()
end
if gg.isPackageInstalled("com.eidymumcghpfeeeavps") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.eidymumcghpfeeeavps]")
  os.exit()
end
if gg.isPackageInstalled("com.mod.iraq") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.mod.iraq]")
  os.exit()
end
if gg.isPackageInstalled("com.dzelttwyuyyes") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.dzelttwyuyyes]")
  os.exit()
end
if gg.isPackageInstalled("com.sxqa") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.sxqa]")
  os.exit()
end
if gg.isPackageInstalled("com.xyyxgxfn") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.xyyxgxfn]")
  os.exit()
end
if gg.isPackageInstalled("com.zgb") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.zgb]")
  os.exit()
end
if gg.isPackageInstalled("com.tssfjipkmrco") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.tssfjipkmrco]")
  os.exit()
end
if gg.isPackageInstalled("com.vnpqk") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.vnpqk]")
  os.exit()
end
if gg.isPackageInstalled("com.mwjvnwesbghkxbjznbwo") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.mwjvnwesbghkxbjznbwo]")
  os.exit()
end
if gg.isPackageInstalled("com.blackduty.gc") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.blackduty.gc]")
  os.exit()
end
if gg.isPackageInstalled("com.s.fyojrme") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.s.fyojrme]")
  os.exit()
end
if gg.isPackageInstalled("com.roxmemek") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.roxmemek]")
  os.exit()
end
if gg.isPackageInstalled("com.fhshwhpvqvruvjtu") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.fhshwhpvqvruvjtu]")
  os.exit()
end
if gg.isPackageInstalled("com.fireongaming.fog") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.fireongaming.fog]")
  os.exit()
end
if gg.isPackageInstalled("com.paranoiaworks.unicus.android.sse") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.paranoiaworks.unicus.android.sse]")
  os.exit()
end
if gg.isPackageInstalled("com.raincitygaming.ggmod") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.raincitygaming.ggmod]")
  os.exit()
end
if gg.isPackageInstalled("com.pvt4u") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.pvt4u]")
  os.exit()
end
if gg.isPackageInstalled("com.nydpvsb.z.r.pkgh") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.nydpvsb.z.r.pkgh]")
  os.exit()
end
if gg.isPackageInstalled("com.ioyysvgfsrig") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.ioyysvgfsrig]")
  os.exit()
end
if gg.isPackageInstalled("com.gmsm") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.gmsm]")
  os.exit()
end
if gg.isPackageInstalled("com.sudsjcqvvcmgutdjeg") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.sudsjcqvvcmgutdjeg]")
  os.exit()
end
if gg.isPackageInstalled("com.redwolfgaming.ripgg") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.redwolfgaming.ripgg]")
  os.exit()
end
if gg.isPackageInstalled("com.coolfoolggfuckscript.tm") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.rhmsoft.edit]")
  os.exit()
end
if gg.isPackageInstalled("com.eidymumcghpfeeeavps") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.coolfoolggfuckscript.tm]")
  os.exit()
end
if gg.isPackageInstalled("com.dzelttwyuyyes") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.dzelttwyuyyes]")
  os.exit()
end
if gg.isPackageInstalled("com.foxcyber.gg") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.foxcyber.gg]")
  os.exit()
end
if gg.isPackageInstalled("com.sxqa") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.sxqa]")
  os.exit()
end
if gg.isPackageInstalled("com.zgb") then
  print("❌ ᴅᴀɴɢᴇʀᴏᴜs ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [com.zgb]")
  os.exit()
end
if gg.isPackageInstalled("sstool.only.com.sstool") then
  print("❌ ssᴛᴏᴏʟ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [sstool.only.com.sstool]")
  os.exit()
end
if gg.isPackageInstalled("sstool.only.com.sstool") then
  print("❌ ssᴛᴏᴏʟ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [sstool.only.com.sstool]")
  os.exit()
end
if gg.isPackageInstalled("catch_.me_.if_.you_.can_") then
  print("❌ ᴏʀɪɢɪɴᴀʟ ɢᴀᴍᴇɢᴜᴀʀᴅɪᴀɴ ᴅᴇᴛᴇᴄᴛᴇᴅ ᴏɴ ᴛʜɪs ᴅᴇᴠɪᴄᴇ! ᴘʟᴇᴀsᴇ ᴜɴɪɴsᴛᴀʟʟ ɪᴛ! ᴀɴᴅ ᴅᴏ ɴᴏᴛ ᴛʀʏ ᴛᴏ ᴅᴇᴄʀʏᴘᴛ ᴏʀ ʟᴏɢ ᴍʏ sᴄʀɪᴘᴛ... ❌ \n ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤᴅᴇᴛᴇᴄᴛᴇᴅ ᴘᴀᴄᴋᴀɢᴇ: [catch_.me_.if_.you_.can_]")
  os.exit()
end
----------------------------------------------------

-----------2nd CONNECTION------------
API = gg.makeRequest('https://raw.githubusercontent.com/ExScR/FCDNTTL-1st-connect-/main/2nd.lua.Encode.lua?token=GHSAT0AAAAAABQ2XNZBRWEWYQEASIMTU2VOYPMCPFA').content
if not API then
gg.alert('ʏᴏᴜ ᴀʀᴇ ᴏꜰꜰʟɪɴᴇ ᴏʀ ʏᴏᴜ ᴅɪᴅ ɴᴏᴛ ɢɪᴠᴇ ɪɴᴛᴇʀɴᴇᴛ ᴀᴄᴄᴇss! ᴘʟᴇᴀsᴇ ᴛʀʏ ᴀɢᴀɪɴ! \n ɪꜰ sᴛɪʟʟ ɴᴏᴛ ᴡᴏʀᴋɪɴɢ ᴄᴏɴᴛᴀᴄᴛ ᴛʜᴇ ᴅᴇᴠᴇʟᴏᴘᴇʀ ᴏꜰ ᴛʜɪs sᴄʀɪᴘᴛ... ❌')
noselect()
else
pcall(load(API))
end
