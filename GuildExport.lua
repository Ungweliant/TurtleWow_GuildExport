SLASH_GUILDEXPORT1="/gexport"
SlashCmdList.GUILDEXPORT=function()
  GuildExportDB={}
  for i=1,GetNumGuildMembers() do
    local n,r,x,l,c,y,nt,ont=GetGuildRosterInfo(i)
    GuildExportDB[i]={name=n,rank=r,level=l,class=c,note=nt,officernote=ont}
  end
  print("Guild roster saved. Reload or logout to write file.")
end


