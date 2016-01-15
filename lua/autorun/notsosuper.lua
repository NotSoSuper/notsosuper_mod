if SERVER then
	require("mysqloo")
	resource.AddFile("sound/common/talk.wav")
	AddCSLuaFile("sh_netwrapper.lua")
	include("sh_netwrapper.lua")
	
	util.AddNetworkString("notsosuper_MSG_PLY")
	util.AddNetworkString("notsosuper_MSG_ALL")
	util.AddNetworkString("notsosuper_MSG_ADMINS")
	util.AddNetworkString("notsosuper_MSG_ADMINSAY")
	util.AddNetworkString("notsosuper_MSG_ADMINPSAY")
	util.AddNetworkString("notsosuper_MSG_ADMINCHAT")
	
	util.AddNetworkString("notsosuper_MSG_CONNECTED")
	util.AddNetworkString("notsosuper_MSG_DISCONNECTED")
	
	util.AddNetworkString("notsosuper_NET_ADDSPRAY")
	
	util.AddNetworkString("notsosuper_NET_REQUESTSCREEN")
	util.AddNetworkString("notsosuper_NET_GETSCREEN")
	util.AddNetworkString("notsosuper_NET_SENDTOCALLER")
	
	util.AddNetworkString("AddText")
	include("sv_chat.lua")
	
	include("sv_init.lua")
	AddCSLuaFile("cl_init.lua")
	include("sv_getuser.lua")
	
	include("sh_admin.lua")
	AddCSLuaFile("sh_admin.lua")
	
	include('sv_screenshot.lua')
	AddCSLuaFile("cl_screenshot.lua")
	
	include('sv_spraytracker.lua')
	AddCSLuaFile("cl_spraytracker.lua")
	
	AddCSLuaFile("cl_chat.lua")
	AddCSLuaFile("cl_motd.lua")
	
	include('commands/sv_chat.lua')
	include('commands/sv_motd.lua')
	
	include('commands/sv_say.lua')
	include('commands/sv_psay.lua')
	include('commands/sv_gag.lua')
	
	include('commands/sv_up.lua')
	include('commands/sv_down.lua')
	
	include('commands/sh_menu.lua')
	AddCSLuaFile('commands/sh_menu.lua')
	
	include('commands/sv_mute.lua')
	include('commands/sh_mute.lua')
	AddCSLuaFile('commands/sh_mute.lua')
	
	include('commands/sv_kick.lua')
	include('commands/sv_ban.lua')
	include('commands/sv_screenshot.lua')
	
	include('commands/sv_burn.lua')
	include('commands/sv_extinguish.lua')
	include('commands/sv_slap.lua')
	include('commands/sv_slay.lua')
	include('commands/sv_respawn.lua')
	include('commands/sv_teleport.lua')
	include('commands/sv_god.lua')
	include('commands/sv_noclip.lua')
	include('commands/sv_freeze.lua')
elseif (CLIENT) then
	include("sh_netwrapper.lua")
	include("cl_init.lua")
	include("sh_admin.lua")
	include("cl_screenshot.lua")
	include("cl_spraytracker.lua")
	include("cl_chat.lua")
	include("cl_motd.lua")
	include('commands/sh_menu.lua')
	include('commands/sh_mute.lua')
end
