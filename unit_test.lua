--��������
require "ngx" --ngx��

local config = require "config"
local tools = require "tools"



function trim(s)
    return s:gsub("^%s*(.-)%s*$", "%1")
end


--����tools������
do
	local nowTs = tools.getNowTs()
	assert(type(nowTs) == type(1))
	assert(nowTs >= (os.time()-1))
	
	local toSharStr = ''
	local shaStr = tools.sha256()
	
	
	ngx.say('tools �������� OK')
end





do   --���Ͳ����ڵ�uri����

local res = ngx.location.capture("/api/Messages/SendSms123/",{})

local code = res.status
local data = trim(res.body)

ngx.say("code == 404 : "..tostring(assert(code==404)))
local str = '{"result":false,"request":"\\/api\\/Messages\\/SendSms123\\/","error_code":-10011,"error":"service not found"}'

ngx.log(ngx.ERR, data)

ngx.say('data == '.. str ..' : ' .. tostring(assert(data == str)))
ngx.say('���Ͳ����ڵ�uri���󣬲������')

end




do   --���Ͳ����ڵ�sign����

ngx.req.set_header("Content-Type", "application/x-www-form-urlencoded")
local res = ngx.location.capture(DEFAULT_URL,{method=ngx.HTTP_POST, body="aaa=111"})


local code = res.status
local data = trim(res.body)


--ngx.log(ngx.ERR, cjson.encode(res))


ngx.say("code == 400 : "..tostring(assert(code==400)))
local str = '{"result":false,"request":"\\/api\\/Messages\\/SendSms\\/","error_code":-10003,"error":"sign not given"}'
ngx.say('data == '.. str ..' : ' .. tostring(assert(data == str)))
ngx.say('���Ͳ����ڵ�sign���󣬲������')


end




do   --���Ͳ����ڵ�client_id����
ngx.req.set_header("Content-Type", "application/x-www-form-urlencoded")

local res = ngx.location.capture(DEFAULT_URL,{method=ngx.HTTP_POST, body="sign=111"})


local code = res.status
local data = trim(res.body)

ngx.say("code == 400 : "..tostring(assert(code==400)))
local str = '{"result":false,"request":"\\/api\\/Messages\\/SendSms\\/","error_code":-10005,"error":"client_id not given"}'
ngx.say('data == '.. str ..' : ' .. tostring(assert(data == str)))
ngx.say('���Ͳ����ڵ�client_id���󣬲������')

end





do   --������Ч��client_id����

ngx.req.set_header("Content-Type", "application/x-www-form-urlencoded")

local res = ngx.location.capture(DEFAULT_URL,{method=ngx.HTTP_POST, body="sign=111&client_id=aaa"})

local code = res.status
local data = trim(res.body)


ngx.say("code == 401 : "..tostring(assert(code==401)))
local str = '{"result":false,"request":"\\/api\\/Messages\\/SendSms\\/","error_code":-10006,"error":"client_id not Authorize"}'

ngx.say('data == '.. str ..' : ' .. tostring(assert(data == str)))
ngx.say('������Ч��client_id���󣬲������')


end



do   --ʹ��GET��ʽ����


ngx.req.set_header("Content-Type", "application/x-www-form-urlencoded")
local res = ngx.location.capture(DEFAULT_URL,{method=ngx.HTTP_GET})

local code = res.status
local data = trim(res.body)

ngx.say("code == 400 : "..tostring(assert(code==400)))
local str = '{"result":false,"request":"\\/api\\/Messages\\/SendSms\\/","error_code":-10010,"error":"method not allowed"}'
ngx.say('data == '.. str ..' : ' .. tostring(assert(data == str)))
ngx.say('ʹ��GET��ʽ���ͣ��������')



end



do   --���ʹ����signǩ��

ngx.req.set_header("Content-Type", "application/x-www-form-urlencoded")

local res = ngx.location.capture(DEFAULT_URL,{method=ngx.HTTP_POST, body="sign=111&client_id=test1"})

local code = res.status
local data = trim(res.body)


ngx.say("code == 401 : "..tostring(assert(code==401)))
local str = '{"result":false,"request":"\\/api\\/Messages\\/SendSms\\/","error_code":-10004,"error":"invalid sign"}'
ngx.say('data == '.. str ..' : ' .. tostring(assert(data == str)))
ngx.say('���ʹ����signǩ�����������')


end


do   --ת��ip��ַ
ngx.req.set_header("Content-Type", "application/x-www-form-urlencoded")
local res = ngx.location.capture(DEFAULT_URL,{method=ngx.HTTP_POST, body=DEFAULT_FORM_STR})

local code = res.status
local data = trim(res.body)

ngx.say("code == 503 or 200 : "..tostring(assert(code==503 or code==200)))
ngx.say('ת��ip��ַ���������')

end



do   --ʹ��json��������
ngx.req.set_header("Content-Type", "application/json")
local res = ngx.location.capture(DEFAULT_URL,{method=ngx.HTTP_POST, body=DEFAULT_JSON_STR})

local code = res.status
local data = trim(res.body)

--ngx.log(ngx.ERR, cjson.encode(res))

ngx.say("code == 503 or 200 : "..tostring(assert(code==503 or code==200)))
ngx.say('ʹ��json�������ݣ��������')

end


do   --�����json��������

ngx.req.set_header("Content-Type", "application/json")
local res = ngx.location.capture(DEFAULT_URL,{method=ngx.HTTP_POST, body=DEFAULT_JSON_STR.."12312312"})

local code = res.status
local data = trim(res.body)

ngx.log(ngx.ERR, cjson.encode(res))


ngx.say("code == 400 : "..tostring(assert(code==400)))
local str = '{"result":false,"request":"\\/api\\/Messages\\/SendSms\\/","error_code":-10013,"error":"param error"}'
ngx.say('data == '.. str ..' : ' .. tostring(assert(data == str)))
ngx.say('�����json�������ݣ��������')

end



do   --�����x-www-form��������

ngx.req.set_header("Content-Type", "application/x-www-form-urlencoded")
local res = ngx.location.capture(DEFAULT_URL,{method=ngx.HTTP_POST, body=DEFAULT_JSON_STR})

local code = res.status
local data = trim(res.body)

ngx.log(ngx.ERR, cjson.encode(res))


ngx.say("code == 400 : "..tostring(assert(code==400)))
local str = '{"result":false,"request":"\\/api\\/Messages\\/SendSms\\/","error_code":-10003,"error":"sign not given"}'
ngx.say('data == '.. str ..' : ' .. tostring(assert(data == str)))
ngx.say('�����x-www-form�������ݣ��������')

end


do   --�ؽ�����

ngx.req.set_header("Content-Type", "application/x-www-form-urlencoded")
local res = ngx.location.capture("/rebuild",{method=ngx.HTTP_GET})

local code = res.status
local data = trim(res.body)


ngx.say("code == 200 : "..tostring(assert(code==200)))
local str = 'rebuild cache success'
ngx.say('data == '.. str ..' : ' .. tostring(assert(data == str)))
ngx.say('�ؽ����棬�������')

end


do   --��˷�����

ngx.req.set_header("Content-Type", "application/x-www-form-urlencoded")
local res = ngx.location.capture("/status",{method=ngx.HTTP_GET})

local code = res.status
local data = trim(res.body)


ngx.say("code == 200 : "..tostring(assert(code==200)))
assert(data ~= "")
ngx.say('��˷�����״̬���������')

end

ngx.say('���в������')
ngx.exit(ngx.HTTP_OK)