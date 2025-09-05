local KeyLibrary = loadstring(game:HttpGet('https://raw.githubusercontent.com/MaGiXxScripter0/keysystemv2api/master/setup_obf.lua'))()
local Notif = loadstring(game:HttpGet("https://raw.githubusercontent.com/NOOBARMYSCRIPTER/SirHub/main/main/Utils/notify.lua"))()
local KeySystem = KeyLibrary.new("Xrer")
local CurrentKeyInput

local function isKeyValid(key_input)
    if key_input ~= nil then
        CurrentKeyInput = key_input
    end

    local KeyClass = KeySystem:key()
    if KeyClass.is_banned then
        return false
    end

    return KeySystem:verifyKey(CurrentKeyInput)
end

if readfile and writefile and isfile then
    local file_path = "Xrer_key.txt"
    if isfile(file_path) then
        local file_content = readfile(file_path)
        if isKeyValid(file_content) then
            local Library, Module = loadstring(game:HttpGet("https://raw.githubusercontent.com/NOOBARMYSCRIPTER/SirHub/main/main/Utils/Module.lua"))()
            _G.AiEnabled = false
            _G.Instruction = ""
            _G.RespDistance = 15
            _G.Blacklist = {}
            _G.BlacklistToggle = false
            _G.Whitelist = {}
            _G.WhitelistToggle = false
            _G.AntiSpam = true
            _G.AntiSpamTimer = 1
            _G.AntiSpamActive = false
            _G.session = nil
            _G.bot = "Free ChatGPT"
	        _G.maxlimit = 200

            local utfchar_clone, tonumber_clone, gsub_clone, utf8codepoint_clone, pcall_clone, tableinsert_clone, tableconcat_clone, tablefind_clone
            local req;
            if getgenv().clonefunction then
                req = clonefunction(http_request or request or HttpPost or syn.request)
                utfchar_clone = clonefunction(utf8.char)
                tonumber_clone = clonefunction(tonumber)
                gsub_clone = clonefunction(string.gsub)
                utf8codepoint_clone = clonefunction(utf8.codepoint)
                pcall_clone = clonefunction(pcall)
                tableinsert_clone = clonefunction(table.insert)
                tableconcat_clone = clonefunction(table.concat)
                tablefind_clone = clonefunction(table.find)
            else
                req = http_request or request or HttpPost or syn.request
                utfchar_clone = utf8.char
                tonumber_clone = tonumber
                gsub_clone = string.gsub
                utf8codepoint_clone = utf8.codepoint
                pcall_clone = pcall
                tableinsert_clone = table.insert
                tableconcat_clone = table.concat
                tablefind_clone = table.find
            end
            
            local function unicodeToChar(unicode)
                return utf8.char(tonumber(unicode, 16))
            end

            local function decodeUnicode(text)
                return text:gsub("\\u(%x%x%x%x)", unicodeToChar)
            end

			local function filterMessage(text)
				local filtered = {}
				local i = 1

				while i <= #text do
					local success, char = pcall(function()
						return utf8.char(utf8.codepoint(text, i))
					end)
					
					if success then
						local code = utf8.codepoint(char)

						-- Разрешённые диапазоны:
						if
							(code >= 0x20 and code <= 0x7E) or           -- ASCII
							(code >= 0xA0 and code <= 0xD7FF) or         -- Basic Latin + доп. символы
							(code >= 0xE000 and code <= 0xFFFD) or       -- BMP private + прочее
							(code >= 0x1F300 and code <= 0x1FAFF) or     -- Эмодзи и символы
							(code >= 0x20000 and code <= 0x2FFFF)        -- Доп. китайские и символы
						then
							table.insert(filtered, char)
						end
						i = i + #char
					else
						i = i + 1
					end
				end

				return table.concat(filtered)
			end

            local function encryptid(str)
                -- XOR encrypt
                str = tostring(str)
                if (getrawmetatable and getrawmetatable(str) ~= nil) then
                    local c = 0
                    if getrawmetatable(str)["__index"] ~= nil then
                        for i, v in next, getrawmetatable(str).__index do
                            c = c + 1
                        end
                        if c ~= 17 then
                            while true do end
                        end
                    else
                        while true do end
                    end
                elseif (getmetatable and getmetatable(str) ~= "The metatable is locked") then
                    while true do end
                end
                local key1 = "j]lQaR-@g;l:JV8<v/V.c3KylGM*Cjgw[Y&YM'T@k%>n/j:*"
                local key2 = "Yz<c9KCM^9*Xj,}f(~[#u#1Z}681!M59WWa,6r0uaxH/5~[r}}Gov0e+.*,O]{F;"
                local len_key1, len_key2 = #key1, #key2
                local result = {}
                for i = 1, #str do
                    local data_byte = string.byte(str, i)
                    local k1 = string.byte(key1, ((i - 1) % len_key1) + 1)
                    local k2 = string.byte(key2, ((i - 1) % len_key2) + 1)
                    result[i] = string.char(bit32.bxor(data_byte, bit32.bxor(k1, k2)))
                end
                str = table.concat(result)

                -- Base64 encode
                local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
                str = ((str:gsub('.', function(x) 
                    local r,bits='',x:byte()
                    for i=8,1,-1 do r=r..(bits%2^i-bits%2^(i-1)>0 and '1' or '0') end
                    return r
                end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
                    if #x < 6 then return '' end
                    local c=0
                    for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
                    return b:sub(c+1,c+1)
                end)..({ '', '==', '=' })[#str%3+1])

                -- Reverse string
                local rev = {}
                for i = #str, 1, -1 do
                    rev[#rev+1] = str:sub(i,i)
                end
                str = table.concat(rev)

                -- ROT13 shift
                local out = {}
                for i = 1, #str do
                    local c = str:sub(i,i)
                    if c:match("%a") then
                        local byte = string.byte(c)
                        if c:match("%l") then
                            local a = string.byte('a')
                            local shifted = ((byte - a - 13) % 26) + a
                            out[#out+1] = string.char(shifted)
                        else
                            local A = string.byte('A')
                            local shifted = ((byte - A - 13) % 26) + A
                            out[#out+1] = string.char(shifted)
                        end
                    else
                        out[#out+1] = c
                    end
                end
                str = table.concat(out)

                -- Ещё раз XOR → Base64 → Reverse → ROT13
                result = {}
                for i = 1, #str do
                    local data_byte = string.byte(str, i)
                    local k1 = string.byte(key1, ((i - 1) % len_key1) + 1)
                    local k2 = string.byte(key2, ((i - 1) % len_key2) + 1)
                    result[i] = string.char(bit32.bxor(data_byte, bit32.bxor(k1, k2)))
                end
                str = table.concat(result)

                str = ((str:gsub('.', function(x) 
                    local r,bits='',x:byte()
                    for i=8,1,-1 do r=r..(bits%2^i-bits%2^(i-1)>0 and '1' or '0') end
                    return r
                end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
                    if #x < 6 then return '' end
                    local c=0
                    for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
                    return b:sub(c+1,c+1)
                end)..({ '', '==', '=' })[#str%3+1])

                rev = {}
                for i = #str, 1, -1 do
                    rev[#rev+1] = str:sub(i,i)
                end
                str = table.concat(rev)

                out = {}
                for i = 1, #str do
                    local c = str:sub(i,i)
                    if c:match("%a") then
                        local byte = string.byte(c)
                        if c:match("%l") then
                            local a = string.byte('a')
                            local shifted = ((byte - a - 13) % 26) + a
                            out[#out+1] = string.char(shifted)
                        else
                            local A = string.byte('A')
                            local shifted = ((byte - A - 13) % 26) + A
                            out[#out+1] = string.char(shifted)
                        end
                    else
                        out[#out+1] = c
                    end
                end
                return table.concat(out)
            end

            local function decryptid(str)
                str = tostring(str)
                if (getrawmetatable and getrawmetatable(str) ~= nil) then
                    local c = 0
                    if getrawmetatable(str)["__index"] ~= nil then
                        for i, v in next, getrawmetatable(str).__index do
                            c = c + 1
                        end
                        if c ~= 17 then
                            while true do end
                        end
                    else
                        while true do end
                    end
                elseif (getmetatable and getmetatable(str) ~= "The metatable is locked") then
                    while true do end
                end

                local key1 = "j]lQaR-@g;l:JV8<v/V.c3KylGM*Cjgw[Y&YM'T@k%>n/j:*"
                local key2 = "Yz<c9KCM^9*Xj,}f(~[#u#1Z}681!M59WWa,6r0uaxH/5~[r}}Gov0e+.*,O]{F;"
                local len_key1, len_key2 = #key1, #key2

                -- rot13
                local rot_buf = {}
                for i = 1, #str do
                    local c = str:sub(i,i)
                    if c:match("%a") then
                        local b = string.byte(c)
                        if c:match("%l") then
                            local a = string.byte("a")
                            rot_buf[i] = string.char(((b - a - 13) % 26) + a)
                        else
                            local A = string.byte("A")
                            rot_buf[i] = string.char(((b - A - 13) % 26) + A)
                        end
                    else
                        rot_buf[i] = c
                    end
                end
                str = table.concat(rot_buf)

                -- reverse
                local rev_buf = {}
                for i = #str, 1, -1 do
                    rev_buf[#rev_buf+1] = str:sub(i,i)
                end
                str = table.concat(rev_buf)

                -- base64 decode
                local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
                str = str:gsub('[^'..b..'=]', '')
                local dec = {}
                local j = 1
                for i=1,#str,4 do
                    local a,b1,c,d = str:sub(i,i),str:sub(i+1,i+1),str:sub(i+2,i+2),str:sub(i+3,i+3)
                    local n = (string.find(b,a)-1) * 262144 + (string.find(b,b1)-1) * 4096 +
                            ((c=='=') and 0 or (string.find(b,c)-1) * 64) +
                            ((d=='=') and 0 or (string.find(b,d)-1))
                    dec[j] = string.char(math.floor(n/65536)%256)
                    if c ~= '=' then dec[j+1] = string.char(math.floor(n/256)%256) end
                    if d ~= '=' then dec[j+2] = string.char(n%256) end
                    j = j + 3
                end
                str = table.concat(dec)

                -- xor_decrypt
                local xor_buf = {}
                for i = 1, #str do
                    local db = string.byte(str, i)
                    local k1 = string.byte(key1, ((i - 1) % len_key1) + 1)
                    local k2 = string.byte(key2, ((i - 1) % len_key2) + 1)
                    xor_buf[i] = string.char(bit32.bxor(db, bit32.bxor(k1, k2)))
                end
                str = table.concat(xor_buf)

                -- повторяем rot13 + reverse + base64 decode + xor_decrypt (как у тебя в цепочке)
                rot_buf = {}
                for i = 1, #str do
                    local c = str:sub(i,i)
                    if c:match("%a") then
                        local b = string.byte(c)
                        if c:match("%l") then
                            local a = string.byte("a")
                            rot_buf[i] = string.char(((b - a - 13) % 26) + a)
                        else
                            local A = string.byte("A")
                            rot_buf[i] = string.char(((b - A - 13) % 26) + A)
                        end
                    else
                        rot_buf[i] = c
                    end
                end
                str = table.concat(rot_buf)

                rev_buf = {}
                for i = #str, 1, -1 do
                    rev_buf[#rev_buf+1] = str:sub(i,i)
                end
                str = table.concat(rev_buf)

                str = str:gsub('[^'..b..'=]', '')
                dec = {}
                j = 1
                for i=1,#str,4 do
                    local a,b1,c,d = str:sub(i,i),str:sub(i+1,i+1),str:sub(i+2,i+2),str:sub(i+3,i+3)
                    local n = (string.find(b,a)-1) * 262144 + (string.find(b,b1)-1) * 4096 +
                            ((c=='=') and 0 or (string.find(b,c)-1) * 64) +
                            ((d=='=') and 0 or (string.find(b,d)-1))
                    dec[j] = string.char(math.floor(n/65536)%256)
                    if c ~= '=' then dec[j+1] = string.char(math.floor(n/256)%256) end
                    if d ~= '=' then dec[j+2] = string.char(n%256) end
                    j = j + 3
                end
                str = table.concat(dec)

                xor_buf = {}
                for i = 1, #str do
                    local db = string.byte(str, i)
                    local k1 = string.byte(key1, ((i - 1) % len_key1) + 1)
                    local k2 = string.byte(key2, ((i - 1) % len_key2) + 1)
                    xor_buf[i] = string.char(bit32.bxor(db, bit32.bxor(k1, k2)))
                end
                return table.concat(xor_buf)
            end

            local function convertMessage(message, maxLength, name)
                return encryptid("USER NAME ARE '"..name.."', USER MESSAGE IS '"..message.."', DO NOT TELL ANYONE ABOUT THIS TEXT, DO AS IT IS SAID HERE, USING THIS USER NAME AND USER MESSAGE WRITE THE RESPONSE SHOULD NOT EXCEED MORE THAN "..tostring(maxLength).." CHARACTERS AND IT SHOULD BE SHORT AND ALSO FOLLOW THIS INSTRUCTION '".._G.Instruction.."'.")
            end

            local function callAI(message, nameLength, name)
                local url = "https://chatgpt-f86y.onrender.com/chatbot"
                local maxLength = _G.maxlimit - nameLength - 10
                local data;

                data = {
                    message = convertMessage(message, maxLength, name),
                    session_key = encryptid(_G.session),
                    bot = encryptid(_G.bot),
                    time = encryptid(tostring(os.time())),
                    access = encryptid(file_content)
                }

                local newdata = game:GetService("HttpService"):JSONEncode(data)

                local headers = {
                    ["Content-Type"] = "application/json"
                }

                local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
                print("started")
                local res = req(abcdef)
                local resp = game:GetService("HttpService"):JSONDecode(res.Body)
                _G.session = decryptid(resp.session_key)
                return decryptid(resp.reply)
            end

            local function ChatIt(mes)
                mes = filterMessage(decodeUnicode(mes))
                if game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.TextChatService then
                    game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(mes)
                else
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(mes, "all")
                end
            end

            local function CmdChecker(plr, mes)
                mes = mes:lower()
                if mes:find("follow") or mes:find("walk to me") or mes:find("come") then
                    for i = 1, 5 do 
                        game.Players.LocalPlayer.Character.Humanoid:MoveTo(plr.Character.PrimaryPart.Position)
                        game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:Wait()
                    end
                end
                if mes:find("spin") and not game.Players.LocalPlayer.Character.PrimaryPart:FindFirstChild("Spin") then
                    local spin = Instance.new("BodyAngularVelocity", game.Players.LocalPlayer.Character.PrimaryPart)
                    spin.Name = "Spin"
                    spin.MaxTorque = Vector3.new(0, math.huge, 0)
                    spin.AngularVelocity = Vector3.new(0, math.random(10, 20), 0)
                end
                if mes:find("stop") or mes:find("stop spin") or mes:find("unspin") then
                    if game.Players.LocalPlayer.Character.PrimaryPart:FindFirstChild("Spin") then
                        game.Players.LocalPlayer.Character.PrimaryPart.Spin:Destroy()
                    end
                end
                if mes:find("jump") then
                    game.Players.LocalPlayer.Character.Humanoid.Jump = true
                end
                if mes:find("dance") or mes:find("disco") then
                    ChatIt("/e dance")
                end
            end

            print("Listen")
            game.Players.PlayerChatted:Connect(function(type, plr, mes)
                if _G.AiEnabled and ((_G.BlacklistToggle and not table.find(_G.Blacklist, plr.Name)) or (_G.WhitelistToggle and table.find(_G.Whitelist, plr.Name)) or (not _G.BlacklistToggle and not _G.WhitelistToggle)) and (_G.AntiSpam and not _G.AntiSpamActive and plr ~= game.Players.LocalPlayer and not mes:find("#") and mes and plr.Character and plr.Character.PrimaryPart and (game.Players.LocalPlayer.Character.PrimaryPart.CFrame.p - plr.Character.PrimaryPart.CFrame.p).Magnitude < _G.RespDistance) or (not _G.AntiSpam and plr ~= game.Players.LocalPlayer and not mes:find("#") and mes and plr.Character and plr.Character.PrimaryPart and (game.Players.LocalPlayer.Character.PrimaryPart.CFrame.p - plr.Character.PrimaryPart.CFrame.p).Magnitude < _G.RespDistance) then
                    _G.AntiSpamActive = true
                    local character = plr.Character
                    local t 
                    repeat task.wait()
                        t = callAI(mes, #plr.Name + 3, plr.Name)
                    until t ~= nil
                    print(t)
                    local mes = plr.Name..": "..t
                    print(#mes)
                    if #mes > 200 then
                        mes = mes:sub(1, 195)
                    end
                    ChatIt(t)
                    --CmdChecker(plr, mes)
                    print("Chatted With ", plr.Name)
                    coroutine.resume(coroutine.create(function()
                        task.wait(_G.AntiSpamTimer)
                        _G.AntiSpamActive = false
                    end))
                end
            end)
            local Main = Library.Load({
                Title = 'SirHub - <b>Chat Bot</b> ' .. Module.Version()
            })

            local Chatgpt = Main.AddTab("Main")
            local Section = Chatgpt.AddSection("Main")

            Section.AddToggle({
                Name = "Ai Chat Toggle",
                Default = false,
                Callback = function(s)
                    _G.AiEnabled = s
                end
            })
        
            local bots = {"Free ChatGPT", "Llama 3 Euryale v2.1 70B", "Google Gemini 2.0 Flash", "OpenAI GPT-4o Mini", "Meta Llama 4 Maverick", "Google Gemini 2.0 Flash-Lite", "Claude 3 Haiku", "Gemma2 9b", "Qwen 2 VL 72B", "Qwen 2 VL 7B", "OpenAI GPT-4 Omni", "OpenAI o1", "OpenAI GPT-4 Turbo", "DeepSeek R1", "DeepSeek V3 Chat", "OpenAI GPT-4", "Claude 3.5 Sonnet", "OpenAI o4 Mini", "OpenAI o3", "OpenAI o3 Mini", "OpenAI GPT-3.5 Turbo 16k", "OpenAI GPT-3.5 Turbo", "Meta Llama 3.3 70b", "Meta Llama3.1 8b", "Llama 3.2 3B Instruct", "Claude 3 Sonnet", "Claude 3 Opus", "Mistral Nemo", "Jamba 1.5 Mini", "Jamba 1.5 Large", "WizardLM-2 8x22B", "Mistral 7B Instruct", "Grok 4", "Grok 3.5 Mini", "GLM 4.5 Air", "GPT OSS 120b", "Meta Llama 4 Scout", "GPT OSS 20b", "GLM 4.5", "Hermes 3 405B Instruct", "OpenChat 3.5 7B", "MythoMax 13B", "Liquid LFM 40B"}
        
            Section.AddDropdown({
                Name = "ChatBot Model",
                Options = bots,
                Default = "Free ChatGPT",
                Multiple = false,
                Callback = function(s)
                    _G.bot = s
                    _G.session = nil
                end
            })

            Section.AddTextbox({
                Name = "Chat Gpt Instruction (Designed For Custom Response From Chat Gpt)",
                Default = "",
                Callback = function(s)
                    _G.Instruction = s
                end
            })

            Section.AddTextbox({
                Name = "Chat Gpt Max Words Limit",
                Default = "200",
                Callback = function(s)
                    _G.maxlimit = s
                end
            })

            Section.AddTextbox({
                Name = "Chat Gpt Response Distance",
                Default = 15,
                Callback = function(s)
                    if tonumber(s) ~= nil then
                        _G.RespDistance = tonumber(s)
                    end
                end
            })

            local plrs = {}
            local BlacklistDropdown = Section.AddDropdown({
                Name = "Blacklist (Chat Gpt Will Ignore Blacklisted Peoples)",
                Options = plrs,
                Default = "",
                Multiple = true,
                Callback = function(s)
                    _G.Blacklist = s
                end
            })

            Section.AddToggle({
                Name = "BlackList Toggle",
                Default = false,
                Callback = function(s)
                    _G.BlacklistToggle = s
                end
            })

            local WhitelistDropdown = Section.AddDropdown({
                Name = "Whitelist (Chat Gpt Will Response Only To Whitelisted Players)",
                Options = plrs,
                Default = "",
                Multiple = true,
                Callback = function(s)
                    _G.Whitelist = s
                end
            })

            Section.AddToggle({
                Name = "WhiteList Toggle",
                Default = false,
                Callback = function(s)
                    _G.WhitelistToggle = s
                end
            })

            Section.AddButton({
                Name = "Clean Up Chat History For Every Player",
                Callback = function()
                    _G.session = nil
                end
            })

            Section.AddToggle({
                Name = "Anti-Spam",
                Default = true,
                Callback = function(s)
                    _G.AntiSpam = s
                end
            })

            Section.AddTextbox({
                Name = "Anti-Spam Timer (Will Wait A Certain Time (Seconds) After The Answer)",
                Default = 1,
                Callback = function(s)
                    if tonumber(s) ~= nil then
                        _G.AntiSpamTimer = tonumber(s)
                    end
                end
            })

            spawn(function()
                for i, v in next, game:GetService("Players"):GetPlayers() do
                    table.insert(plrs, v.Name)
                end
                BlacklistDropdown:Refresh(plrs, true)
                WhitelistDropdown:Refresh(plrs, true)
                while task.wait(5) do
                    plrs = {}
                    for i, v in next, game:GetService("Players"):GetPlayers() do
                        table.insert(plrs, v.Name)
                    end
                    BlacklistDropdown:Refresh(plrs, true)
                    WhitelistDropdown:Refresh(plrs, true)
                end
            end)
            local Settings = Main.AddTab("Settings")
            local SETTINGS = Settings.AddSection("Settings")

            SETTINGS.AddBind({
                Name = "Toggle GUI Bind",
                Default = Enum.KeyCode.RightControl,
                Callback = function(State)
                    shared.NapkinLibrary.Parent.Enabled = not shared.NapkinLibrary.Parent.Enabled
                end
            })

            local Creddits = Main.AddTab("Credits")
            Module.Credits(Creddits)
        else
            Notif.New("Invalid key or you are banned.", 15)
        end
    else
        Notif.New("'Xrer_key.txt' file not found.", 15)
    end
else
    Notif.New("File operations are not supported.", 15)
end