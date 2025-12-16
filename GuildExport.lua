print("GuildExport loaded")

SLASH_GUILDEXPORT1 = "/gexport"

SlashCmdList.GUILDEXPORT = function()
  GuildExportDB = {}
  GuildExportCSV = nil

  local lines
  lines = {}

  lines[0] = "Name,Rank,Level,Class,Note,OfficerNote"

  for i = 1, GetNumGuildMembers() do
    local n,r,_,l,c,_,nt,ont = GetGuildRosterInfo(i)

    n   = n or ""
    r   = r or ""
    l   = l or 0
    c   = c or ""
    nt  = nt or ""
    ont = ont or ""

    GuildExportDB[i] = {
      name = n,
      rank = r,
      level = l,
      class = c,
      note = nt,
      officernote = ont
    }
    lines[i] =  n .. "," .. r .. "," .. l .. "," .. c .. "," .. nt .. "," .. ont .. "\n"
  end

  GuildExportCSV = table.concat(lines, ";")
  print("Guild roster exported to CSV. Reload or logout to write file.")
end
