/********************************************************************************
	Name:			PS-INPriv
	Author:			Roy Schalk - Central Michigan University
	Created:		10/8/2015
	Last Updated:	10/8/2015
	For Version:	7.1
---------------------------------------------------------------------------------
	Summary:		This Script is a powershell wrapper for INtool to make modifcations 
					to priviledges

					
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
			//printf(vars[2] + "\n");
			//debug.log("INFO",vars)
			//printf(varstr)
		Clib.fclose(args)
		
		switch(vars[0]){
			case "setDrawerPrivs":
				var user = vars[1];
				var drawer = vars[2];
				var privstr = vars[3];
				var privs = privstr.split(",")
				
				status = INPriv.setDrawerPrivs(user, drawer, privs);
				printf("Drawer Privileges set for %s: %i", user, status)
				break;
			case "setGlobalPrivs":
				var user = vars[1];
				var privstr = vars[2];
				var privs = privstr.split(",")
				//printf(privs)
				status = INPriv.setGlobalPrivs(user, privs);
				//status = INPriv.setGlobalPrivs(user, "UNLINKED_DOCS_PRINT_DOC=1");
				printf("Global Privileges set for %s: %i", user, status)
				
				break;
			case "setFolderTypePrivs":
				var user = vars[1];
				var folderType = vars[2];
				var privstr = vars[3];
				var privs = privstr.split(",");
				//printf(privs)
				status = INPriv.setFolderTypePrivs(user, folderType, privs);
				//status = INPriv.setFolderTypePrivs(user, "UNLINKED_DOCS_PRINT_DOC=1");
				printf("Folder Type Privileges set for %s: %i", user, status)
				
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
		debug.log("INFO", "PS-INPriv.js script finished.\n\n")
		debug.finish()
		return 0
	}
}