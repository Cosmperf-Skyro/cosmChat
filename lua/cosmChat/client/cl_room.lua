local isOpen = false
cosmChat.rtbox = nil
local messages = ""

sSubtitleFont = ( sSubtitleFont or "TLib.Standard" )

net.Receive("receiveMessage", function()
    local message = net.ReadString()
    local sender = net.ReadEntity()

    messages = messages.."\n"..sender:Name().." : "..message

    if isOpen then
    cosmChat.rtbox:SetText(messages)
    cosmChat.rtbox:SetFontInternal(sSubtitleFont)
    end
end)




hook.Add( "PlayerBindPress", "overrideChatbind", function( ply, bind, pressed )
    local bTeam = false
    if bind == "messagemode" then
        print( "global chat" )
    elseif bind == "messagemode2" then
        print( "team chat" )
        bTeam = true
    else
        return
    end

if not IsValid(cosmChat.frame) then
    isOpen = true
    cosmChat.frame = vgui.Create("TLFrame")
    cosmChat.frame:SetSize(respW(800), respH(500))
    cosmChat.frame:Center()
    cosmChat.frame:MakePopup()
    cosmChat.frame:SetHeader(cosmChat.lang.Title)
    cosmChat.frame.OnClose = function(s)
        isOpen = false
    end

    cosmChat.Entry = vgui.Create("TLTextEntry", cosmChat.frame)
    cosmChat.Entry:SetSize(respW(600), respH(30))
    cosmChat.Entry:SetPos(respW(10), respH(460))
    cosmChat.Entry:SetMultiline(true)
    cosmChat.Entry:SetPlaceholderText("Veuillez écrire votre message")


    cosmChat.rtbox = vgui.Create("RichText", cosmChat.frame)
    cosmChat.rtbox:SetSize(respW(780), respH(400))
    cosmChat.rtbox:SetPos(respW(10), respH(60))
    cosmChat.rtbox:SetText(messages)

    cosmChat.Button = vgui.Create("TLButton", cosmChat.frame)
    cosmChat.Button:SetSize(respW(150), respH(30))
    cosmChat.Button:SetPos(respW(620), respH(460))
    cosmChat.Button:SetText(cosmChat.lang.Button)
    function cosmChat.Button:DoClick()
    net.Start("sendMessage")
        net.WriteString(cosmChat.Entry:GetText())
    net.SendToServer()  
    cosmChat.Entry:SetText("")
    cosmChat.Entry:RequestFocus()  
    end

end
    
    return true -- Doesn't allow any functions to be called for this bind
end )

