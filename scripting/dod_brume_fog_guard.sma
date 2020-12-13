#include <amxmodx>

new szLogFile[128]

public plugin_precache()
{
	register_plugin("dod_brume Fog Guard", "0.1", "Fysiks")
	force_unmodified(force_exactfile,{0,0,0},{0,0,0},"sprites/fog1.spr")
	force_unmodified(force_exactfile,{0,0,0},{0,0,0},"sprites/fog6.spr")

	get_localinfo("amxx_basedir",szLogFile,charsmax(szLogFile))
	// format(szLogFile, charsmax(szLogFile), "%s/logs/dod_brume.log", szLogFile)
	add(szLogFile, charsmax(szLogFile), "/logs/dod_brume.log")
}

public inconsistent_file(id, const filename[], reason[64])
{
	if( contain(filename, "fog") )
	{
		new szAuthID[32], szName[32]
		get_user_authid(id, szAuthID, charsmax(szAuthID))
		get_user_name(id, szName, charsmax(szName))
		server_print("%s (%s): %s", szName, szAuthID, filename)
		log_to_file(szLogFile, "%s (%s) tried to join using a modified version of: %s", szName, szAuthID, filename)
		format(reason, charsmax(reason), "%s, please delete it to play here.", filename)
	}
}
