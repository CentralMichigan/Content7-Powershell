/********************************************************************************
	Name:			PS-INUser
	Author:			Roy Schalk - Central Michigan University
	Created:		10/8/2015
	Last Updated:	10/8/2015
	For Version:	7.1
---------------------------------------------------------------------------------
	Summary:		This Script is a powershell wrapper for INtool to make modifcations 
					to groups

					
	Mod Summary:	

	Business Use:	To make scripting for ImageNow More accessible

********************************************************************************/

// ********************* Include additional libraries *******************

#include "../script/STL/packages/Logging/iScriptDebug.js"
#include "../script/STL/packages/Object/toJSON.js"

// *********************         Configuration        *******************

#if defined(_UNIX_)
	#define PATH_CHAR '/'
#else
	#define PATH_CHAR '\\'
#endif

#define LOG_TO_FILE true
#define DEBUG_LEVEL 4
#define DRY_RUN false

// Get the script file name (removing the .inow)
var scriptFileName = SElib.splitFilename(_argv[0]).name.split('.')[0]

var EXECUTION_METHODS = ["INTOOL"] //Allowed script execution methods: WORKFLOW, INTOOL, TASK, EFORM, EMA
var debug

// Number of results to return and process at a time
var vslQueryResultLimit = 2000

var ARGPATH = "d:\\inserver\\script\\args.txt";

// *********************       End  Configuration     *******************

/**
 * Main body of script.
 * @return {Boolean} True on success, false on error.
 */
function main()
{
	debug = new iScriptDebug("USE SCRIPT FILE NAME", LOG_TO_FILE, DEBUG_LEVEL)
	var ArgArray = new Array();
	try
	{
		var args = Clib.fopen(ARGPATH,"r")
		var varstr = "";
		//var vars = Clib.fgets(args)
		if ( args == null )
		   printf("\aError opening file for reading.\n")
		else
			//printf("\aFile Opened.\n");
		    instr = Clib.fgets(args);
			while (instr != null) {
				varstr = varstr + instr;
				instr = Clib.fgets(args);
			}
			//printf(varstr + "\n");
			var vars =  varstr.split("^");
			//printf(vars[0] + "\n");
			//printf(vars[1] + "\n");
			//debug.log("INFO",vars)
		Clib.fclose(args)
		
		switch(vars[0]){
			case "getAllUsers":
				var users = INUser.getAllUsers();
				printf("Found %d users:\n", users.length);
				for (var x=0; x < users.length; x++)
				{
				   printf("%s\n", users[x]);
				}
				break;			
			case "addUser":
				var username = vars[1];
				var ret = INUser.addUser(username);
				if (!ret)
				  {
					 printf("Failed to add user (%s): %s.\n", userName, getErrMsg());
				  }
					else
					{
						printf("User Added %s - ID is: %s.\n", userName, ret);
					}
				break;
			case "deleteUser":
				var username = vars[1];
				var ret = INUser.deleteUser(username);
				if (!ret)
				  {
					 printf("Failed to delete user (%s): %s.\n", userName, getErrMsg());
				  }
					else
					{
						printf("User deleted %s - ID is: %s.\n", userName, ret);
					}
				break;
			case "getInfo":
				var username = vars[1];
				var user = new INUser(username);
				if (!user.getInfo())
				{
					printf("Error: %s.\n", getErrMsg());
				}
				else
				{
					printf("ID:" + user.id + "\n");
					printf("org:" + user.org + "\n");
					printf("orgUnit:" + user.orgUnit + "\n");
					printf("email:" + user.email + "\n");
					printf("lastName:" + user.lastName + "\n");
					printf("firstName:" + user.firstName + "\n");
					printf("title:" + user.title + "\n");
					printf("locality:" + user.locality + "\n");
					printf("phone:" + user.phone + "\n");
					printf("mobile:" + user.mobile + "\n");
					printf("pager:" + user.pager + "\n");
					printf("fax:" + user.fax + "\n");
					printf("state:" + user.state + "\n");
					printf("externId:" + user.externId + "\n");
					printf("suffix:" + user.externId + "\n");
					printf("prefix:" + user.externId + "\n");
				}
				break;
			case "setInfo":
				var username = vars[1];
				var newValuesStr = vars[2];
				
				var user = new INUser(username);
				var newvaluesarr = newValuesStr.split(",");
				//printf(username)
				//printf(newValuesStr)
				//printf(newvaluesarr)
				var newValues = new Object();
				for (var value in newvaluesarr){
					property = newvaluesarr[value].split("=");
					
					newValues[property[0]] = property[1];					
				}
				if(!user.setInfo(newValues))
				{
					printf("Error: %s.\n", getErrMsg());
				}
				break;
			
		}
		

	}
	catch(e)
	{
		debug.log("CRITICAL", "***********************************************\n")
		debug.log("CRITICAL", "***********************************************\n")
		debug.log("CRITICAL", "**                                           **\n")
		debug.log("CRITICAL", "**    ***    Fatal iScript Error!     ***    **\n")
		debug.log("CRITICAL", "**                                           **\n")
		debug.log("CRITICAL", "***********************************************\n")
		debug.log("CRITICAL", "***********************************************\n")
		debug.log("CRITICAL", "\n\n\n%s\n\n\n", e.toString())
		debug.log("CRITICAL", "\n\nThis script has failed in an unexpected way.  Please\ncontact Perceptive Software Customer Support at 800-941-7460 ext. 2\nAlternatively, you may wish to email support@imagenow.com\nPlease attach:\n - This log file\n - The associated script [%s]\n - Any supporting files that might be specific to this script\n\n", _argv[0])
		debug.log("CRITICAL", "***********************************************\n")
		debug.log("CRITICAL", "***********************************************\n")
	}
	finally
	{
		debug.log("INFO", "PS-INUser.js script finished.\n\n")
		debug.finish()
		return 0
	}
}