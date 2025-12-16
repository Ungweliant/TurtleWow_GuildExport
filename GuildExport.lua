SLASH_GUILDEXPORT1="/gexport"
SlashCmdList.GUILDEXPORT=function()
  GuildExportDB={}
  local lines = {}
  lines[#lines+1] = "Name,Rank,Level,Class,Note,OfficerNote"
  
  for i=1,GetNumGuildMembers() do
    local n,r,x,l,c,y,nt,ont=GetGuildRosterInfo(i)
    GuildExportDB[i]={name=n,rank=r,level=l,class=c,note=nt,officernote=ont}
    lines[#lines+1] = string.format("%s,%s,%d,%s,%s", n, r, l, c, nt, ont and "TRUE" or "FALSE")
  end
  GuildExportCSV = table.concat(lines, "\n")
  print("Guild roster saved. Reload or logout to write file.")
end


