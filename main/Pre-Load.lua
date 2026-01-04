if game.GameId == 2160907981 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/NOOBARMYSCRIPTER/SirHub/refs/heads/main/main/Scripts/SprayPaintPreLoad.lua"))()
end
local KeySystemUI = loadstring(game:HttpGet("https://github.com/NOOBARMYSCRIPTER/SirHub/raw/refs/heads/main/main/Utils/keysystem.lua"))()
KeySystemUI.New()
repeat task.wait() until KeySystemUI.Finished() or KeySystemUI.Closed
if KeySystemUI.Finished() and KeySystemUI.Closed == false then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/NOOBARMYSCRIPTER/SirHub/main/main/Scripts/"..game.GameId..".lua"))()
else
    warn("Player closed the GUI.")
end
