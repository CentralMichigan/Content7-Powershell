/********************************************************************************
	Name:			PS-INDrawer
	Author:			Roy Schalk - Central Michigan University
	Created:		10/8/2015
	Last Updated:	10/8/2015
	For Version:	7.1
---------------------------------------------------------------------------------
	Summary:		This Script is a powershell wrapper for INtool to make modifcations 
					to Drawers

					
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
			case "addDrawer":
				var drawerName = vars[1];
			
				if (! INDrawer.add(drawerName))
				{
					printf("Fail to add drawer: %s\n.", getErrMsg());
				}
				else {
					printf("%s added successfully", drawerName)
				}
				break;

			case "updateDrawer":
				var drawerName = vars[1];
				var newDrawerName = vars[2];
				var description = vars[3];
				
			
				var drawer = new INDrawer(drawerName);
				drawer.getInfo()
				if (newDrawerName == ""){ newDrawerName = drawer.name}
				if (description == ""){ description = drawer.desc}
				if(!drawer.update(newDrawerName, description))
				{
					printf("Unable to update Drawer [%s]: %s.\n", drawerName, getErrMsg());
				}
				else
				{
					printf("Drawer [%s] has been updated.\n", drawerName);
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
		debug.log("INFO", "PS-INDrawer.js script finished.\n\n")
		debug.finish()
		return 0
	}
}