if game.GameId == 2160907981 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/NOOBARMYSCRIPTER/SirHub/refs/heads/main/main/Scripts/SprayPaintPreLoad.lua"))()
end
local KeySystemUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/MaGiXxScripter0/keysystemv2api/master/ui/xrer_mstudio45.lua"))()
KeySystemUI.New({
    ApplicationName = "Xrer",                                                                                            -- Your Key System
    Name = "SirHub",                                                                                                     -- Your Script name
    Info = "To use free version of SirHub you need a key.\nYou can get the key he in website by completing all stages.", -- Info text in the GUI, keep empty for default text.
    DiscordInvite = "r8SkmkqVeZ"                                                                                         -- Optional.
})
repeat task.wait() until KeySystemUI.Finished() or KeySystemUI.Closed
if KeySystemUI.Finished() and KeySystemUI.Closed == false then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/NOOBARMYSCRIPTER/SirHub/main/main/Scripts/"..game.GameId..".lua"))()
else
    warn("Player closed the GUI.")
end
