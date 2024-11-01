

public OnGameModeInit(){
	mysql_tquery(g_SQL, "SELECT * FROM `whitelist`", "whitelist_Load", "");

	print("[ NyDev ] Connect system Whitelist");
	return 1;
}
NutEyeWhitelistCheck(playerid){
	new query[100];
    mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `whitelist` WHERE `name` = '%e'", GetPlayerNameEx(playerid));
	mysql_tquery(g_SQL, query, "whitelist_Load", "d", playerid);
}
forward whitelist_Load(playerid);
public whitelist_Load(playerid){
	if(cache_num_rows() == 0){
		SendClientMessage(playerid, 0xFF0000, "[NutChat] {FF0000}No whitelist found !");
		DelayedKick(playerid);
		
	}
	else{
		SendClientMessage(playerid, 0x00FF00, "[NutChat] Welcome to the server !");
		
	}
	return 1;
}
public OnPlayerConnect(playerid) {
    SendClientMessage(playerid, 0xFF0000, "[NutChat] system Whitelist Start.......");
    NutEyeWhitelistCheck(playerid);
    return 1;
}

CMD:whitelist(playerid, params[]){
	new reason[128] = {
	"NyDevC"
	};
	new name[MAX_PLAYER_NAME], query[300];
	if(sscanf(params, "s[24]", name)) return SendClientMessage(playerid, COLOR_RED, "[NutChat] /whitelist [name]");
    mysql_format(g_SQL, query, sizeof(query), "INSERT INTO `whitelist` (`name`, `License`) VALUES ('%e', '%e')", name, reason);
    mysql_tquery(g_SQL, query);
	SendClientMessage(playerid, COLOR_GREEN, "[NutChat] Whitelist data added successfully");
	printf("[ Whitelist ] Give Whitelist To [ %s ]",name);
	return 1;
}
