print("GuildExport loaded")




-- Create the custom frame for the popup
local function CreateExportPopup()

    local frame = CreateFrame("Frame", "GuildExportPopupFrame", UIParent)
    frame:SetWidth(400)
    frame:SetHeight(200)  -- Size of the popup frame
    frame:SetPoint("CENTER", UIParent, "CENTER")  -- Position the frame in the center of the screen
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

    -- Create the title for the popup
    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    title:SetPoint("TOP", frame, "TOP", 0, -10)
    title:SetText("Guild Export JSON Data")

    -- Create the text box (input field)
    local textBox = CreateFrame("EditBox", nil, frame, "InputBoxTemplate")
    textBox:SetWidth(360)
    textBox:SetHeight(100)  -- Width and height of the text box
    textBox:SetPoint("TOP", title, "BOTTOM", 0, -10)
    textBox:SetMultiLine(false)  -- Allow multiple lines of text
    textBox:SetAutoFocus(false)  -- Don't auto-focus the box
    textBox:SetText("")  -- Set the initial text (empty)
    textBox:SetFontObject("ChatFontNormal")  -- Set the font
    textBox:SetScript("OnEscapePressed", function() frame:Hide() end)  -- Close on Escape

    -- Make the text box read-only so the user can copy the text but not edit it
    textBox:SetScript("OnMouseDown", function(self)
        self:HighlightText()  -- Highlight text for easy copying
    end)


    -- Return the frame and the textBox, so they can be shown later
    return frame, textBox
end

SLASH_GUILDEXPORT1 = "/gexport"

SlashCmdList.GUILDEXPORT = function()
    -- Example structure to hold guild data
    GuildExportDB = GuildExportDB or {}

    -- Get guild info (just an example, you will need the actual in-game data)
    local guildName = GetGuildInfo("player")  -- Gets the guild name of the player

    local members = {}

    -- Loop through the guild members and get their info (e.g., name, rank, level)
    for i = 1, GetNumGuildMembers() do
        local name, rank, _, level, class, _, note, officerNote = GetGuildRosterInfo(i)
        table.insert(members, { name = name, rank = rank, level = level, class = class, note = note, officerNote = officerNote})
    end

    -- Store the roster data in GuildExportDB
    GuildExportDB = members

    -- Print or log the JSON string if needed
    print("Guild data exported: ")

    -- Convert the GuildExportDB to JSON format
    local jsonString = json.encode(GuildExportDB)

    -- Create the popup frame and text box (if not already created)
    local popupFrame, textBox = CreateExportPopup()

    -- Set the text in the text box to the exported JSON data
    textBox:SetText(jsonString)
	textBox:HighlightText()  -- Select all text
	textBox:SetFocus()  
	textBox:SetHeight(100)

    -- Show the popup frame
    popupFrame:Show()
end
