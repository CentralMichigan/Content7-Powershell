$GLOBAL:INTOOLPATH = "D:\inserver\bin64\"
$GLOBAL:SCRIPTPATH = "D:\Inserver\script\"
$GLOBAL:ARGFULLPATH = "D:\Inserver\script\args.txt"

#region INGroup
<#
.Synopsis
   Adds an ImageNow group
.DESCRIPTION
   Uses INTool to create a group within ImageNow
#>
function Add-INowGroup
{
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  HelpUri = 'http://www.microsoft.com/',
                  ConfirmImpact='Medium')]
    [OutputType([String])]
    Param
    (
        # Name of the group to be created
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true, ValueFromRemainingArguments=$false, Position=0, ParameterSetName='Parameter Set 1')] $GroupName
    )
    Process
    {
        if ($pscmdlet.ShouldProcess("Target", "Operation"))
        {
            $argStr = "addGroup^" + $GroupName+"^"
            $argStr | out-file -FilePath $GLOBAL:ARGFULLPATH
            Set-Location $GLOBAL:INTOOLPATH
            $ScriptName = $GLOBAL:SCRIPTPATH + "PS-INGroup.js"
            .\intool.exe --cmd run-iscript --file $ScriptName
        }
    }

}
<#
.Synopsis
   Removes an ImageNow group
.DESCRIPTION
   Uses INTool to remove a group from within ImageNow
#>
function Remove-INowGroup
{
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  HelpUri = 'http://www.microsoft.com/',
                  ConfirmImpact='Medium')]
    [OutputType([String])]
    Param
    (
        # Name of the Group to remove
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true, ValueFromRemainingArguments=$false, Position=0, ParameterSetName='Parameter Set 1')] $GroupName
    )
    Process
    {
        if ($pscmdlet.ShouldProcess("Target", "Operation"))
        {
            $argStr = "deleteGroup^" + $GroupName+"^"
            $argStr | out-file -FilePath $GLOBAL:ARGFULLPATH
            Set-Location $GLOBAL:INTOOLPATH
            $ScriptName = $GLOBAL:SCRIPTPATH + "PS-INGroup.js"
            .\intool.exe --cmd run-iscript --file $ScriptName
        }
    }

}
<#
.Synopsis
   Adds a user to an ImageNow group
.DESCRIPTION
   Uses INTool to lookup a group and add a user to it
.EXAMPLE
   Add-UserstoGroup -Group "SET-Past Student-Scan" -UserName "Schal1r"
   Adds schal1r to the SET-Past Student-Scan group
#>
function Add-INowUserToGroup
{
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  HelpUri = 'http://www.microsoft.com/',
                  ConfirmImpact='Medium')]
    [OutputType([String])]
    Param
    (
        # Name of the Group to add the user to.
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0,
                   ParameterSetName='Parameter Set 1')]
        $Group,

        # Name of the user to add
        [Parameter( Mandatory=$true,
                    ParameterSetName='Parameter Set 1')]

        $UserName
    )

    Begin
    {
        
    }
    Process
    {
        if ($pscmdlet.ShouldProcess("Target", "Operation"))
        {
            $argStr = "addUserToGroup^" + $Group +"^"+ $UserName+"^"
            $argStr | out-file -FilePath $GLOBAL:ARGFULLPATH 
            Set-Location $GLOBAL:INTOOLPATH
            $ScriptName = $GLOBAL:SCRIPTPATH + "PS-INGroup.js"
            .\intool.exe --cmd run-iscript --file $ScriptName

        }
    }
    End
    {
    }
}

<#
.Synopsis
   Removes a user to an ImageNow group
.DESCRIPTION
   Uses INTool to lookup a group and remove a user to it
.EXAMPLE
   remove-UserstoGroup -Group "SET-Past Student-Scan" -UserName "Schal1r"
   removes schal1r from the SET-Past Student-Scan group
#>
function Remove-INowUserFromGroup
{
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  HelpUri = 'http://www.microsoft.com/',
                  ConfirmImpact='Medium')]
    [OutputType([String])]
    Param
    (
        # Name of the Group to remove the user from.
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0,
                   ParameterSetName='Parameter Set 1')]
        $Group,

        # Name of the user to remove.
        [Parameter( Mandatory=$true,
                    ParameterSetName='Parameter Set 1')]

        $UserName
    )

    Begin
    {
        
    }
    Process
    {
        if ($pscmdlet.ShouldProcess("Target", "Operation"))
        {
            $argStr = "removeUserFromGroup^" + $Group +"^"+ $UserName+"^"
            $argStr | out-file -FilePath $GLOBAL:ARGFULLPATH
            Set-Location $GLOBAL:INTOOLPATH
            $ScriptName = $GLOBAL:SCRIPTPATH + "PS-INGroup.js"
            .\intool.exe --cmd run-iscript --file $ScriptName

        }
    }
    End
    {
    }
}
#endregion
#region INPriv
<#
.Synopsis
   Sets permission on a drawer for a user or group
.DESCRIPTION
   Sets permission on a drawer for a user or group.  
   Permisions values 0-2; 0 = unchecked, 1 = allow, 2 = deny
.EXAMPLE
   Set-DrawerPrivs -Drawer "SET-Past Student" -User "SET-Past Student-update" -ContentDelete 0 -contentModifyDrawer 1 
   Sets the Content_Delete permission to unchecked and the Content_Modify_Drawer permission to allow
#>
function Set-INowDrawerPrivs
{
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  HelpUri = 'http://www.microsoft.com/',
                  ConfirmImpact='Medium')]
    [OutputType([String])]
    Param
    (
        # Name of the Drawer to effect permissions on.
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0,
                   ParameterSetName='Parameter Set 1')] $Drawer,
        # Name of the user or group to modify permissions of.
        [Parameter( Mandatory=$true, ParameterSetName='Parameter Set 1')] $User,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ContentDelete,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $contentModifyDrawer,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $contentModifyType,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $CustomPropModify,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $DocSign,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $DocModifyKeys,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $DocDeleteSignRep,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $DocPageDelete,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $DocPageReorder,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $DocMerge,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $DocModifyNotes,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $DocMoveSignRep,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $DocPageMove,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $DocSignVoid,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $DocDeleteSigned,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $DocView,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $DocCopyToClipboard,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $DocListExportDoc,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $DocListPrintDoc,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $DocListLaunchAssociatedApp,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $DocListMailAttachment,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $DocListMailImageLink,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $DocListMailWebLink,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $DocListFaxDoc,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $DocListSendDocToUser,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $VersionCtrlUse,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $VersionCtrlRemove,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $VersionCtrlDeleteHistory,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $VersionCtrlUndo3rdParty,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ViewerPrintDoc,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ViewerMailImageLink,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ViewerMailWebLink,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ViewerMailAttachment,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ViewerExportDoc,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ViewerLaunchAssociatedApp,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ViewerFaxDoc,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ViewerSendDocToUser,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $BatchProcess,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ContentCreate,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ContentCreateShortcut,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ContentRemoveShortcut,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ContentMove,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ContentRename,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $FolderModifyStatus,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $SearchDoc
    )

    Begin
    {
        
    }
    Process
    {
        if ($pscmdlet.ShouldProcess("Target", "Operation"))
        {
            $privs = ""

            if($ContentDelete -in (0,1,2)){$privs = $privs + "CONTENT_DELETE=" + $ContentDelete+","}
            if($contentModifyDrawer -in (0,1,2)){$privs = $privs + "CONTENT_MODIFY_DRAWER=" + $contentModifyDrawer+","}
            if($contentModifyType -in (0,1,2)){$privs = $privs + "CONTENT_MODIFY_TYPE=" + $contentModifyType + ","}
            if($CustomPropModify -in (0,1,2)){$privs = $privs + "CUSTOM_PROP_MODIFY=" + $CustomPropModify + ","}
            if($DocSign -in (0,1,2)){$privs = $privs + "DOC_SIGN=" + $DocSign + ","}
            if($DocModifyKeys -in (0,1,2)){$privs = $privs + "DOC_MODIFY_KEYS=" + $DocModifyKeys +","}
            if($DocDeleteSignRep -in (0,1,2)){$privs = $privs + "DOC_DELETE_SIGN_REP=" + $DocDeleteSignRep +","}
            if($DocPageDelete -in (0,1,2)){$privs = $privs + "DOC_PAGE_DELETE=" + $DocPageDelete +  ","}
            if($DocPageReorder -in (0,1,2)){$privs = $privs + "DOC_PAGE_REORDER=" + $DocPageReorder +","}
            if($DocMerge -in (0,1,2)){$privs = $privs + "DOC_MERGE=" + $DocMerge +","}
            if($DocModifyNotes -in (0,1,2)){$privs = $privs + "DOC_MODIFY_NOTES=" + $DocModifyNotes +","}
            if($DocMoveSignRep -in (0,1,2)){$privs = $privs + "DOC_MOVE_SIGN_REP="  +$DocMoveSignRep +","}
            if($DocPageMove -in (0,1,2)){$privs = $privs + "DOC_PAGE_MOVE=" + $DocPageMove +","}
            if($DocSignVoid -in (0,1,2)){$privs = $privs + "DOC_SIGN_VOID=" + $DocSignVoid +","}
            if($DocDeleteSigned -in (0,1,2)){$privs = $privs + "DOC_DELETE_SIGNED=" + $DocDeleteSigned +","}
            if($DocView -in (0,1,2)){$privs = $privs + "DOC_VIEW=" + $DocView +","}
            if($DocCopyToClipboard -in (0,1,2)){$privs = $privs + "DOC_COPY_TO_CLIPBOARD=" + $DocCopyToClipboard +","}
            if($DocListExportDoc -in (0,1,2)){$privs = $privs + "DOC_LIST_EXPORT_DOC=" + $DocListExportDoc +","}
            if($DocListPrintDoc -in (0,1,2)){$privs = $privs + "DOC_LIST_PRINT_DOC=" + $DocListPrintDoc +","}
            if($DocListLaunchAssociatedApp -in (0,1,2)){$privs = $privs + "DOC_LIST_LAUNCH_ASSOCIATED_APP=" + $DocListLaunchAssociatedApp +","}
            if($DocListMailAttachment -in (0,1,2)){$privs = $privs + "DOC_LIST_MAIL_ATTACHMENT=" + $DocListMailAttachment +","}
            if($DocListMailImageLink -in (0,1,2)){$privs = $privs + "DOC_LIST_MAIL_IMAGELINK=" + $DocListMailImageLink +","}
            if($DocListMailWebLink -in (0,1,2)){$privs = $privs + "DOC_LIST_MAIL_WEBLINK=" + $DocListMailWebLink  +","}
            if($DocListFaxDoc -in (0,1,2)){$privs = $privs + "DOC_LIST_FAX_DOC=" + $DocListFaxDoc +","}
            if($DocListSendDocToUser -in (0,1,2)){$privs = $privs + "DOC_LIST_SEND_DOC=" + $DocListSendDocToUser +","}
            if($VersionCtrlUse -in (0,1,2)){$privs = $privs + "VERSION_CTRL_USE=" + $VersionCtrlUse  +","}
            if($VersionCtrlRemove -in (0,1,2)){$privs = $privs + "VERSION_CTRL_REMOVE=" + $VersionCtrlRemove +","}
            if($VersionCtrlDeleteHistory -in (0,1,2)){$privs = $privs + "VERSION_CTRL_DELETE_HISTORY=" + $VersionCtrlDeleteHistory +","}
            if($VersionCtrlUndo3rdParty -in (0,1,2)){$privs = $privs + "VERSION_CRTL_UNDO_3RD_PARTY=" + $VersionCtrlUndo3rdParty +","}
            if($ViewerPrintDoc -in (0,1,2)){$privs = $privs + "VIEWER_PRINT_DOC=" + $ViewerPrintDoc +","}
            if($ViewerMailImageLink -in (0,1,2)){$privs = $privs + "VIEWER_MAIL_IMAGELINK=" + $ViewerMailImageLink +","}
            if($ViewerMailWebLink -in (0,1,2)){$privs = $privs + "VIEWER_MAIL_WEBLINK=" + $ViewerMailWebLink +","}
            if($ViewerMailAttachment -in (0,1,2)){$privs = $privs + "VIEWER_MAIL_ATTACHMENT=" + $ViewerMailAttachment +","}
            if($ViewerExportDoc -in (0,1,2)){$privs = $privs + "VIEWER_EXPORT_DOC=" + $ViewerExportDoc   +","} 
            if($ViewerLaunchAssociatedApp -in (0,1,2)){$privs = $privs + "VIEWER_LAUNCH_ASSOCIATED_APP=" + $ViewerLaunchAssociatedApp +","} 
            if($ViewerFaxDoc -in (0,1,2)){$privs = $privs + "VIEWER_FAX_DOC=" + $ViewerFaxDoc +","} 
            if($ViewerSendDocToUser -in (0,1,2)){$privs = $privs + "VIEWER_SEND_DOC=" + $ViewerSendDocToUser +","} 
            if($BatchProcess -in (0,1,2)){$privs = $privs + "BATCH_PROCESS=" + $BatchProcess+","} 
            if($ContentCreate -in (0,1,2)){$privs = $privs + "CONTENT_CREATE=" + $ContentCreate +","} 
            if($ContentCreateShortcut -in (0,1,2)){$privs = $privs + "CONTENT_CREATE_SHORTCUT=" + $ContentCreateShortcut +","} 
            if($ContentRemoveShortcut -in (0,1,2)){$privs = $privs + "CONTENT_DELETE_SHORTCUT=" + $ContentRemoveShortcut +","} 
            if($ContentMove -in (0,1,2)){$privs = $privs + "CONTENT_MOVE=" + $ContentMove +","} 
            if($ContentRename -in (0,1,2)){$privs = $privs + "CONTENT_RENAME=" + $ContentRename +","} 
            if($FolderModifyStatus -in (0,1,2)){$privs = $privs + "FOLDER_MODIFY_STATUS=" + $FolderModifyStatus +","} 
            if($SearchDoc -in (0,1,2)){$privs = $privs + "SEARCH_CONTENTS=" + $SearchDoc +","} 

            if($privs.Length -gt 0){$privs = $privs.TrimEnd(',')}
            else{ 
                write-verbose "No Privs set."
                return;
            }
            
            $argStr = "setDrawerPrivs^$User^$Drawer^$privs^"
            $argStr | out-file -FilePath $GLOBAL:ARGFULLPATH
            Set-Location $GLOBAL:INTOOLPATH
            $ScriptName = $GLOBAL:SCRIPTPATH + "PS-INPriv.js"
            .\intool.exe --cmd run-iscript --file $ScriptName

        }
    }
    End
    {
    }
}


<#
.Synopsis
   Sets global permission for a user or group
.DESCRIPTION
   Sets global permission for a user or group.  
   Permisions values 0-2; 0 = unchecked, 1 = allow, 2 = deny
.EXAMPLE
   Set-InowGlobalPrivs -User "SET-Past Student-update" -ManageAuditTemplates 0 -AssignAuditTemplates 1 
   Sets the ManageAuditTemplates permission to unchecked and the AssignAuditTemplates permission to allow
#>
function Set-INowGlobalPrivs
{
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  HelpUri = 'http://www.microsoft.com/',
                  ConfirmImpact='Medium')]
    [OutputType([String])]
    Param
    (
        # Name of the User or Group to modify the permission of.
        [Parameter( Mandatory=$true, ParameterSetName='Parameter Set 1')] $User,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ManageAuditTemplates = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $AssignAuditTemplates = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $CaptureBatchCreate = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $CaptureBatchDelete = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $CaptureBatchLink = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $CaptureBatchModifyNotes = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $CaptureBatchResubmit = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $CaptureBatchQa = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $CaptureBatchStepState = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $CaptureBatchBypassQa = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $CaptureSingleCreate = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $CapturePackageCreate = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ManageBasketGroups = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ManageBatchUploadSetting = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ManageClientCaptureProfiles = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ManageDevices = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ManageDigSig = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ManageDigSigIDs = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ManageLearnModeOptions = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ManageReports = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ViewReports = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ManageScannerProfiles = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ManageScanPromptRules = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ManageServer = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ManageTaskViews = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ManageUserProfiles = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ManageUserSecurityERM = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ManageGroupSecurityERM = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ManageUserSecurityInteractSearch = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ManageGroupSecurityInteractSearch = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ManageUserSecurityCapture = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ManageUserSecurityBatchCreationUsers = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $ManageGroupSecurityBatchCreationUsers = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $SearchSimple = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $SearchFolder = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $SearchFullText = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $SearchErm = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $SearchLoadLocalQuery = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $SearchLoadServerQuery = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $SearchManageLocalQuery = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $SearchManageServerQuery = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $UnlinkedDocsPrintDoc = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $UnlinkedDocsExportDoc = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $UnlinkedDocsLaunchAssociatedApp = $null,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $UnlinkedDocsMailAttachment = $null

    )

    Begin
    {
        
    }
    Process
    {
        if ($pscmdlet.ShouldProcess("Target", "Operation"))
        {
            $privs = $null

            if($AssignAuditTemplates -in (0,1,2)){$privs = $privs + "ASSIGN_AUDIT_TEMPLATES="  + $AssignAuditTemplates+ ","}
            if($CaptureBatchCreate -in (0,1,2)){$privs = $privs + "CAPTURE_BATCH_CREATE="  + $CaptureBatchCreate+ ","}
            if($CaptureBatchDelete -in (0,1,2)){$privs = $privs + "CAPTURE_BATCH_DELETE="  + $CaptureBatchDelete+ ","}
            if($CaptureBatchLink -in (0,1,2)){$privs = $privs + "CAPTURE_BATCH_LINK="  + $CaptureBatchLink+ ","}
            if($CaptureBatchModifyNotes -in (0,1,2)){$privs = $privs + "CAPTURE_BATCH_MODIFY_NOTES="  + $CaptureBatchModifyNotes+ ","}
            if($CaptureBatchResubmit -in (0,1,2)){$privs = $privs + "CAPTURE_BATCH_RESUBMIT="  + $CaptureBatchResubmit+ ","}
            if($CaptureBatchQa -in (0,1,2)){$privs = $privs + "CAPTURE_BATCH_QA="  + $CaptureBatchQa+ ","}
            if($CaptureBatchStepState -in (0,1,2)){$privs = $privs + "CAPTURE_BATCH_MODIFY_STEP_STATE="  + $CaptureBatchStepState+ ","}
            if($CaptureBatchBypassQa -in (0,1,2)){$privs = $privs + "CAPTURE_BATCH_BYPASS_QA="  + $CaptureBatchBypassQa+ ","}
            if($CaptureSingleCreate -in (0,1,2)){$privs = $privs + "CAPTURE_SINGLE_CREATE="  + $CaptureSingleCreate+ ","}
            if($CapturePackageCreate -in (0,1,2)){$privs = $privs + "CAPTURE_PACKAGE_CREATE="  + $CapturePackageCreate+ ","}
            if($ManageBasketGroups -in (0,1,2)){$privs = $privs + "MANAGE_BASKET_GROUPS="  + $ManageBasketGroups+ ","}
            if($ManageBatchUploadSetting -in (0,1,2)){$privs = $privs + "MANAGE_BATCH_UPLOAD_SETTINGS="  + $ManageBatchUploadSetting+ ","}
            if($ManageClientCaptureProfiles -in (0,1,2)){$privs = $privs + "MANAGE_CLIENT_CAPTURE_PROFILES="  + $ManageClientCaptureProfiles+ ","}
            if($ManageDevices -in (0,1,2)){$privs = $privs + "MANAGE_DEVICES="  + $ManageDevices+ ","}
            if($ManageDigSig -in (0,1,2)){$privs = $privs + "MANAGE_DIG_SIG="  + $ManageDigSig+ ","}
            if($ManageDigSigIDs -in (0,1,2)){$privs = $privs + "MANAGE_DIG_SIG_IDS="  + $ManageDigSigIDs+ ","}
            if($ManageLearnModeOptions -in (0,1,2)){$privs = $privs + "MANAGE_LEARN_MODE_OPTIONS="  + $ManageLearnModeOptions+ ","}
            if($ManageReports -in (0,1,2)){$privs = $privs + "BI_MANAGE_REPORTS="  + $ManageReports+ ","}
            if($ViewReports -in (0,1,2)){$privs = $privs + "BI_VIEW_REPORTS="  + $ViewReports+ ","}
            if($ManageScannerProfiles -in (0,1,2)){$privs = $privs + "MANAGE_SCANNER_PROFILES="  + $ManageScannerProfiles+ ","}
            if($ManageScanPromptRules -in (0,1,2)){$privs = $privs + "MANAGE_SCAN_PROMPT_RULES="  + $ManageScanPromptRules+ ","}
            if($ManageServer -in (0,1,2)){$privs = $privs + "MANAGE_SERVER="  + $ManageServer+ ","}
            if($ManageTaskViews -in (0,1,2)){$privs = $privs + "MANAGE_TASK_VIEWS="  + $ManageTaskViews+ ","}
            if($ManageUserProfiles -in (0,1,2)){$privs = $privs + "MANAGE_USER_PROFILES="  + $ManageUserProfiles+ ","}
            if($ManageUserSecurityERM -in (0,1,2)){$privs = $privs + "MANAGE_USER_SECURITY_ERM="  + $ManageUserSecurityERM+ ","}
            if($ManageGroupSecurityERM -in (0,1,2)){$privs = $privs + "MANAGE_GROUP_SECURITY_ERM="  + $ManageGroupSecurityERM+ ","}
            if($ManageUserSecurityInteractSearch -in (0,1,2)){$privs = $privs + "MANAGE_USER_SECURITY_INTERACT_SEARCH="  + $ManageUserSecurityInteractSearch+ ","}
            if($ManageGroupSecurityInteractSearch -in (0,1,2)){$privs = $privs + "MANAGE_GROUP_SECURITY_INTERACT_SEARCH="  + $ManageGroupSecurityInteractSearch+ ","}
            if($ManageUserSecurityCapture -in (0,1,2)){$privs = $privs + "MANAGE_USER_SECURITY_CAPTURE="  + $ManageUserSecurityCapture+ ","}
            if($ManageGroupSecurityCapture -in (0,1,2)){$privs = $privs + "MANAGE_GROUP_SECURITY_CAPTURE="  + $ManageUserSecurityCapture+ ","}
            if($ManageUserSecurityBatchCreationUsers -in (0,1,2)){$privs = $privs + "MANAGE_USER_SECURITY_BATCH_CREATION_USERS="  + $ManageUserSecurityBatchCreationUsers+ ","}
            if($ManageGroupSecurityBatchCreationUsers -in (0,1,2)){$privs = $privs + "MANAGE_GROUP_SECURITY_BATCH_CREATION_USERS="  + $ManageGroupSecurityBatchCreationUsers+ ","}
            if($SearchSimple -in (0,1,2)){$privs = $privs + "SEARCH_SIMPLE="  + $SearchSimple+ ","}
            if($SearchFolder -in (0,1,2)){$privs = $privs + "SEARCH_PROJECT="  + $SearchFolder+ ","}
            if($SearchFullText -in (0,1,2)){$privs = $privs + "SEARCH_CONTENT="  + $SearchFullText+ ","}
            if($SearchErm -in (0,1,2)){$privs = $privs + "SEARCH_ERM="  + $SearchErm+ ","}
            if($SearchLoadLocalQuery -in (0,1,2)){$privs = $privs + "SEARCH_LOAD_LOCAL_QUERY="  + $SearchLoadLocalQuery+ ","}
            if($SearchLoadServerQuery -in (0,1,2)){$privs = $privs + "SEARCH_LOAD_SERVER_QUERY="  + $SearchLoadServerQuery+ ","}
            if($SearchManageLocalQuery -in (0,1,2)){$privs = $privs + "SEARCH_MANAGE_LOCAL_QUERY="  + $SearchManageLocalQuery+ ","}
            if($SearchManageServerQuery -in (0,1,2)){$privs = $privs + "SEARCH_MANAGE_SERVER_QUERY="  + $SearchManageServerQuery+ ","}
            if($UnlinkedDocsPrintDoc -in (0,1,2)){$privs = $privs + "UNLINKED_DOCS_PRINT_DOC="  + $UnlinkedDocsPrintDoc+ ","}
            if($UnlinkedDocsExportDoc -in (0,1,2)){$privs = $privs + "UNLINKED_DOCS_EXPORT_DOC="  + $UnlinkedDocsExportDoc+ ","}
            if($UnlinkedDocsLaunchAssociatedApp -in (0,1,2)){$privs = $privs + "UNLINKED_DOCS_LAUNCH_ASSOCIATED_APP="  + $UnlinkedDocsLaunchAssociatedApp+ ","}
            if($UnlinkedDocsMailAttachment -in (0,1,2)){$privs = $privs + "UNLINKED_DOCS_MAIL_ATTACHMENT="  + $UnlinkedDocsMailAttachment+ ","}



            if($privs.Length -gt 0){$privs = $privs.TrimEnd(',')}
            else{ 
                write-verbose "No Privs set."
                return;
            }
            
            $argStr = "setGlobalPrivs^$User^$privs^"
            $argStr | out-file -FilePath $GLOBAL:ARGFULLPATH
            Set-Location $GLOBAL:INTOOLPATH
            $ScriptName = $GLOBAL:SCRIPTPATH + "PS-INPriv.js"
            .\intool.exe --cmd run-iscript --file $ScriptName

        }
    }
    End
    {
    }
}

<#
.Synopsis
   Sets Folder Type permission for a user or group
.DESCRIPTION
   Sets Folder Type permission for a user or group.  
   Permisions values 0-2; 0 = unchecked, 1 = allow, 2 = deny
.EXAMPLE
   Set-InowFolderTypePrivs -User "SET-Past Student-update" -ManageAuditTemplates 0 -AssignAuditTemplates 1 
   Sets the ManageAuditTemplates permission to unchecked and the AssignAuditTemplates permission to allow
#>
function Set-INowFolderTypePrivs
{
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  HelpUri = 'http://www.microsoft.com/',
                  ConfirmImpact='Medium')]
    [OutputType([String])]
    Param
    (
        # Name of the User or Group to modify the permission of.
        [Parameter( Mandatory=$true, ParameterSetName='Parameter Set 1')] $User,
        [Parameter( Mandatory=$true, ParameterSetName='Parameter Set 1')] $FolderType,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $FolderTypeManage,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateRange(0,2)] $FolderTypeUse
    )

    Begin
    {
        
    }
    Process
    {
        if ($pscmdlet.ShouldProcess("Target", "Operation"))
        {
            $privs = $null

            if($FolderTypeManage -in (0,1,2)){$privs = $privs + "FOLDER_TYPE_MANAGE="  + $FolderTypeManage+ ","}
            if($FolderTypeUse -in (0,1,2)){$privs = $privs + "PROJECT_TYPE_USE="  + $FolderTypeUse+ ","}
            
            if($privs.Length -gt 0){$privs = $privs.TrimEnd(',')}
            else{ 
                write-verbose "No Privs set."
                return;
            }
            
            $argStr = "setFolderTypePrivs^$User^$FolderType^$privs^"
            $argStr | out-file -FilePath $GLOBAL:ARGFULLPATH
            Set-Location $GLOBAL:INTOOLPATH
            $ScriptName = $GLOBAL:SCRIPTPATH + "PS-INPriv.js"
            .\intool.exe --cmd run-iscript --file $ScriptName

        }
    }
    End {}
}
#endregion
#region INDrawer
<#
.Synopsis
   Adds an ImageNow drawer
.DESCRIPTION
   Uses INTool to create a drawer
#>
function Add-INowDrawer
{
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  HelpUri = 'http://www.microsoft.com/',
                  ConfirmImpact='Medium')]
    [OutputType([String])]
    Param
    (
        # Name of the Drawer to add
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true, ValueFromRemainingArguments=$false, Position=0, ParameterSetName='Parameter Set 1')] $DrawerName
    )
    Process
    {
        if ($pscmdlet.ShouldProcess("Target", "Operation"))
        {
            $argStr = "addDrawer^" + $DrawerName+"^"
            $argStr | out-file -FilePath $GLOBAL:ARGFULLPATH
            Set-Location $GLOBAL:INTOOLPATH
            $ScriptName = $GLOBAL:SCRIPTPATH + "PS-INDrawer.js"
            .\intool.exe --cmd run-iscript --file $ScriptName
        }
    }

}

<#
.Synopsis
   Updates an ImageNow Drawer
.DESCRIPTION
   Uses INTool to update a drawer
#>
function Update-INowDrawer
{
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  HelpUri = 'http://www.microsoft.com/',
                  ConfirmImpact='Medium')]
    [OutputType([String])]
    Param
    (
        # Name of the Drawer to modify
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true, ValueFromRemainingArguments=$false, Position=0, ParameterSetName='Parameter Set 1')] $DrawerName,
        [Parameter(ParameterSetName='Parameter Set 1')] $NewDrawerName,
        [Parameter(ParameterSetName='Parameter Set 1')] $Description
    )
    Process
    {
        if ($pscmdlet.ShouldProcess("Target", "Operation"))
        {
            $argStr = "updateDrawer^" + $DrawerName+"^"+ $NewDrawerName+"^"+ $Description+"^"
            $argStr | out-file -FilePath $GLOBAL:ARGFULLPATH
            Set-Location $GLOBAL:INTOOLPATH
            $ScriptName = $GLOBAL:SCRIPTPATH + "PS-INDrawer.js"
            .\intool.exe --cmd run-iscript --file $ScriptName
        }
    }

}
#endregion
#region INUser
<#
.Synopsis
   Sets information on an ImageNow User
.DESCRIPTION
   Sets information on an ImageNow User
#>
function Set-InowUser
{
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  HelpUri = 'http://www.microsoft.com/',
                  ConfirmImpact='Medium')]
    [OutputType([String])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true, ValueFromRemainingArguments=$false, Position=0, ParameterSetName='Parameter Set 1')] $UserName,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] $FirstName,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] $LastName,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] $ID,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] $Org,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] $OrgUnit,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] $Email,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] $Prefix,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] $Suffix,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] $Title,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] $Locality,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] $Phone,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] $Mobile,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] $Pager,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] $Fax,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] $ExternID,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] [ValidateSet("ACTIVE","INACTIVE")] $State
    )
    Process
    {
        if ($pscmdlet.ShouldProcess("Target", "Operation"))
        {
            $InfoStr = $null

            if($FirstName -ne $null){$InfoStr = $InfoStr + "first.name="  + $FirstName+ ","}
            if($LastName  -ne $null){$InfoStr = $InfoStr + "last.name="  + $LastName+ ","}
            if($ID        -ne $null){$InfoStr = $InfoStr + "id="  +$ID      + ","}
            if($Org       -ne $null){$InfoStr = $InfoStr + "org="  +$Org     + ","}
            if($OrgUnit   -ne $null){$InfoStr = $InfoStr + "org.unit ="  +$OrgUnit + ","}
            if($Email     -ne $null){$InfoStr = $InfoStr + "email="  +$Email   + ","}
            if($Prefix    -ne $null){$InfoStr = $InfoStr + "prefix="  +$Prefix  + ","}
            if($Suffix    -ne $null){$InfoStr = $InfoStr + "suffix="  +$Suffix  + ","}
            if($Title     -ne $null){$InfoStr = $InfoStr + "title="  +$Title   + ","}
            if($Locality  -ne $null){$InfoStr = $InfoStr + "locality="  +$Locality+ ","}
            if($Phone     -ne $null){$InfoStr = $InfoStr + "phone="  +$Phone   + ","}
            if($Mobile    -ne $null){$InfoStr = $InfoStr + "mobile="  +$Mobile  + ","}
            if($Pager     -ne $null){$InfoStr = $InfoStr + "pager="  +$Pager   + ","}
            if($Fax       -ne $null){$InfoStr = $InfoStr + "fax="  +$Fax     + ","}
            if($ExternID  -ne $null){$InfoStr = $InfoStr + "externid="  +$ExternID+ ","}
            if($State     -ne $null){$InfoStr = $InfoStr + "state="  +$State   + ","}
            

            if($InfoStr.Length -gt 0){$InfoStr = $InfoStr.TrimEnd(',')}
            $argStr = "setInfo^" + $UserName +"^"+ $InfoStr +"^"
            $argStr | out-file -FilePath $GLOBAL:ARGFULLPATH
            Set-Location $GLOBAL:INTOOLPATH
            $ScriptName = $GLOBAL:SCRIPTPATH + "PS-INUser.js"
            .\intool.exe --cmd run-iscript --file $ScriptName
        }
    }

}

<#
.Synopsis
   Gets information on an ImageNow User
.DESCRIPTION
   Gets information on an ImageNow User
#>
function Get-INowUser
{
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  HelpUri = 'http://www.microsoft.com/',
                  ConfirmImpact='Medium')]
    [OutputType([String])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true, ValueFromRemainingArguments=$false, Position=0, ParameterSetName='Parameter Set 1')] $UserName
    )
    Process
    {
        if ($pscmdlet.ShouldProcess("Target", "Operation"))
        {
            
            $argStr = "getInfo^" + $UserName +"^"
            $argStr | out-file -FilePath $GLOBAL:ARGFULLPATH
            Set-Location $GLOBAL:INTOOLPATH
            $ScriptName = $GLOBAL:SCRIPTPATH + "PS-INUser.js"
            $inowuser = .\intool.exe --cmd run-iscript --file $ScriptName
            New-Object -TypeName psobject -Property @{
                ID = $inowuser[0].Split(':')[1]
                org = $inowuser[1].Split(':')[1]
                orgUnit =$inowuser[2].Split(':')[1]
                email = $inowuser[3].Split(':')[1]
                lastName = $inowuser[4].Split(':')[1]
                firstName = $inowuser[5].Split(':')[1]
                title = $inowuser[6].Split(':')[1]
                locality = $inowuser[7].Split(':')[1]
                phone = $inowuser[8].Split(':')[1]
                mobile = $inowuser[9].Split(':')[1]
                pager = $inowuser[10].Split(':')[1]
                fax = $inowuser[11].Split(':')[1]
                state = $inowuser[12].Split(':')[1] 
                externId = $inowuser[13].Split(':')[1]
                suffix = $inowuser[14].Split(':')[1]
                prefix = $inowuser[15].Split(':')[1]
            }
        }
    }

}

<#
.Synopsis
   Adds an ImageNow User
.DESCRIPTION
   Adds an ImageNow User
#>
function Add-INowUser
{
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  HelpUri = 'http://www.microsoft.com/',
                  ConfirmImpact='Medium')]
    [OutputType([String])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true, ValueFromRemainingArguments=$false, Position=0, ParameterSetName='Parameter Set 1')] $UserName
    )
    Process
    {
        if ($pscmdlet.ShouldProcess("Target", "Operation"))
        {
            
            $argStr = "addUser^" + $UserName +"^"
            $argStr | out-file -FilePath $GLOBAL:ARGFULLPATH
            Set-Location $GLOBAL:INTOOLPATH
            $ScriptName = $GLOBAL:SCRIPTPATH + "PS-INUser.js"
            .\intool.exe --cmd run-iscript --file $ScriptName
        }
    }

}

<#
.Synopsis
   removes an ImageNow User
.DESCRIPTION
   removes an ImageNow User
#>
function Remove-INowUser
{
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  HelpUri = 'http://www.microsoft.com/',
                  ConfirmImpact='Medium')]
    [OutputType([String])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true, ValueFromRemainingArguments=$false, Position=0, ParameterSetName='Parameter Set 1')] $UserName
    )
    Process
    {
        if ($pscmdlet.ShouldProcess("Target", "Operation"))
        {
            
            $argStr = "deleteUser^" + $UserName +"^"
            $argStr | out-file -FilePath $GLOBAL:ARGFULLPATH
            Set-Location $GLOBAL:INTOOLPATH
            $ScriptName = $GLOBAL:SCRIPTPATH + "PS-INUser.js"
            .\intool.exe --cmd run-iscript --file $ScriptName
        }
    }

}

<#
.Synopsis
   Get all ImageNow Users
.DESCRIPTION
   Get all ImageNow Users
#>
function Get-INowUsers
{
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  HelpUri = 'http://www.microsoft.com/',
                  ConfirmImpact='Medium')]
    [OutputType([String])]
    Param()
    Process
    {
        if ($pscmdlet.ShouldProcess("Target", "Operation"))
        {
            
            $argStr = "getAllUsers^"
            $argStr | out-file -FilePath $GLOBAL:ARGFULLPATH
            Set-Location $GLOBAL:INTOOLPATH
            $ScriptName = $GLOBAL:SCRIPTPATH + "PS-INUser.js"
            .\intool.exe --cmd run-iscript --file $ScriptName
        }
    }

}

#endregion
#region INTool Functions
<#
.Synopsis
   Remove Content 7 License token from a machine
.DESCRIPTION
   Link to Perceptive Document: http://google.com
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Revoke-INowToken
{
    Param
    (
        $clientName,
		[ValidateSet("CaptureNow - TWAIN","CaptureNow - Adrenaline","CaptureNow - ISIS Level 2","Message Agent Server","Recognition Agent - OCR","CaptureNow - ISIS Level 1")] 
        $lictype
    )

    Begin
    {
		$command =" --cmd license-tokens --release --machine-name $clientName --lictype '$lictype'"
        $intoolLocation= $GLOBAL:INTOOLPATH + "intool.exe"
    }
    Process
    {
        if ($pscmdlet.ShouldProcess("Target", "Operation"))
        {
			Invoke-Expression -Command "$intoolLocation $getLicense"
		}
    }
    End {}
}
<#
.Synopsis
   Gets the current license token report.
.DESCRIPTION
   Link to Perceptive Document: https://google.com
.EXAMPLE
   Get-InowTokenReport
#>
function Get-InowTokenReport{
	begin{
        $intoolLocation = $GLOBAL:INTOOLPATH + "intool.exe"
		}
	process{
        $getLicense=" --cmd license-tokens --report"
		Invoke-Expression -Command "$intoolLocation $getLicense"
		}
	end{}

}
<#
.Synopsis
   Gets the current database version
.DESCRIPTION
   Link to Perceptive Document: https://google.com
.EXAMPLE
   Get-INowDatabaseVersion
#>
function Get-INowDatabaseVersion{
	begin{
        $intoolLocation = $GLOBAL:INTOOLPATH + "intool.exe"
		}
	process{
        $getLicense=" --cmd get-db-version"
		Invoke-Expression -Command "$intoolLocation $getLicense"
		}
	end{}

}
<#
.Synopsis
   Tests the database schema
.DESCRIPTION
   Tests the database schema and returns what has changed.
.EXAMPLE
   Test-INowDatabaseSchema
#>
function Test-INowDatabaseSchema{
	begin{
        $intoolLocation = $GLOBAL:INTOOLPATH + "intool.exe"
		}
	process{
        $getLicense=" --cmd db-schema-validation"
		Invoke-Expression -Command "$intoolLocation $getLicense"
		}
	end{}

}
<#
.Synopsis
   Grants manager role to a user
.DESCRIPTION
   Grants manager role to a user.
.EXAMPLE
   Grant-INowManager -Username 'ryan.mcvicar' -credential $(get-credential)
#>
Function Grant-INowManager {
    Param(
        [String]$Username,
        [Parameter()]
        [ValidateNotNull()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential = [System.Management.Automation.PSCredential]::Empty
    )
    begin{
		$intoolLocation = $GLOBAL:INTOOLPATH + "intool.exe"
        $command=" --cmd promote-perceptive-manager --username $username --login-user $($Credential.GetNetworkCredential().UserName) --login-password $($Credential.GetNetworkCredential().Password)"        
    }
    process{
		Invoke-Expression -Command "$intoolLocation $command"
    }
    end{}
}
<#
.Synopsis
   Revokes Content 7 manager role from a user
.DESCRIPTION
   Revokes Content 7 manager role from a user
.EXAMPLE
   Revoke-INowManager -Username 'ryan.mcvicar' -credential $(get-credential)
#>
Function Revoke-INowManager {
    Param(
        [String]$Username,
        [Parameter()]
        [ValidateNotNull()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential = [System.Management.Automation.PSCredential]::Empty
    )
    begin{
		$intoolLocation = $GLOBAL:INTOOLPATH + "intool.exe"
        $command=" --cmd demote-perceptive-manager --username $username --login-user $($Credential.GetNetworkCredential().UserName) --login-password $($Credential.GetNetworkCredential().Password)"        
    }
    process{
		Invoke-Expression -Command "$intoolLocation $command"
    }
    end{}
}
<#
.Synopsis
   Disconnects Content 7  user
.DESCRIPTION
   Disconnects Content 7  user
.EXAMPLE
   Disconnect-INowUser -Username 'ryan.mcvicar' 
#>
Function Disconnect-INowUser {
    Param(
        [String]$Username
    )
    begin{
		$intoolLocation = $GLOBAL:INTOOLPATH + "intool.exe"
        $command=" --cmd logoff --username $username"        
    }
    process{
		Invoke-Expression -Command "$intoolLocation $command"
    }
    end{}
}
<#
.Synopsis
   Runs an iScript
.DESCRIPTION
   Runs an iScript
.EXAMPLE
   Invoke-iScript -iScriptLocation 'c:\path\to\iscript\iscript.js
#>
Function Invoke-iScript {
    Param(
        [String]$iScriptLocation
    )
    begin{
		$intoolLocation = $GLOBAL:INTOOLPATH + "intool.exe"
        $command=" --cmd run-iscript --file $iScriptLocation"        
    }
    process{
		Invoke-Expression -Command "$intoolLocation $command"
    }
    end{}
}

Function Enable-INowLogin {
    Param(
        [String]$Message,
        [String]$Instance='primary'
    )
    begin{
		$intoolLocation = $GLOBAL:INTOOLPATH + "intool.exe"
        if($Message){
            $command=" --cmd control-logins --enable --instance $Instance --message $Message"
        }
        else{
            $command=" --cmd control-logins $ControlLogins --instance $Instance"
        }      
    }
    process{
		Invoke-Expression -Command "$intoolLocation $command"
    }
    end{}
}
Function Disable-INowLogin {
    Param(
        [String]$Message,
        [String]$Instance='primary'
    )
    begin{
		$intoolLocation = $GLOBAL:INTOOLPATH + "intool.exe"
        if($Message){
            $command=" --cmd control-logins --disable --instance $Instance --message $Message"
        }
        else{
            $command=" --cmd control-logins $ControlLogins --instance $Instance"
        }      
    }
    process{
		Invoke-Expression -Command "$intoolLocation $command"
    }
    end{}
}
#endregion
#region CMU Functions
<#
.Synopsis
   Creates a default CMU Group for a drawer
.DESCRIPTION
   Creates a default CMU Group for a drawer
#>
function New-INowCMUGroups
{
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  HelpUri = 'http://www.microsoft.com/',
                  ConfirmImpact='Medium')]
    [OutputType([String])]
    Param
    (
        # Param1 help description
        [Parameter( Mandatory=$true, ParameterSetName='Parameter Set 1')] $DrawerName,
        [Parameter(ParameterSetName='Parameter Set 1')] $FolderTypeName,
        [Parameter( Mandatory=$true, ParameterSetName='Parameter Set 1')][ValidateSet("Scan","Full","View","Update","Print")] $Groups
    )
    Process
    {
        if ($pscmdlet.ShouldProcess("Target", "Operation"))
        {
            foreach ($group in $Groups){
                switch ($group) {
                    Scan {
                        $groupName = $DrawerName + "-Scan"
                        Add-InowGroup -GroupName $groupName
                        Set-InowDrawerPrivs -Drawer $DrawerName -User $groupName -SearchDoc 1 -ViewerMailImageLink 1 -ViewerMailWebLink 1 -ViewerLaunchAssociatedApp 1 -DocView 1 -DocListLaunchAssociatedApp 1 -DocListMailWebLink 1 -DocListMailImageLink 1 -ContentCreate 1 -ContentCreateShortcut 1 -ContentRemoveShortcut 1 -BatchProcess 1
                        Set-InowDrawerPrivs -Drawer "Folders_" -User $groupName -SearchDoc 1 -DocView 1 -ContentCreate 1 -ContentCreateShortcut 1
                         if($FolderTypeName -ne $null) {Set-INowFolderTypePrivs -FolderType $FolderTypeName -User $groupName -FolderTypeUse 1}
                        Set-InowGlobalPrivs -User $GroupName -CaptureBatchCreate 1 -CaptureSingleCreate 1 -CaptureBatchQa 1 -CaptureBatchLink 1 -CaptureBatchDelete 1 -CaptureBatchModifyNotes 1 -CaptureBatchStepState 1 -CaptureBatchResubmit 1
                    }
                    Full {
                        $groupName = $DrawerName + "-Full"
                        Add-InowGroup -GroupName $groupName
                        Set-InowDrawerPrivs -Drawer $DrawerName -User $groupName -SearchDoc 1 -ViewerMailImageLink 1 -ViewerMailWebLink 1 -ViewerLaunchAssociatedApp 1 -DocView 1 -DocListLaunchAssociatedApp 1 -DocListMailWebLink 1 -DocListMailImageLink 1 -ContentCreate 1 -ContentCreateShortcut 1 -ContentRemoveShortcut 1 -BatchProcess 1 -ContentDelete 1 -CustomPropModify 1 -contentModifyType 1 -DocModifyKeys 1 -DocModifyNotes 1 -DocMerge 1 -DocPageDelete 1 -DocPageReorder 1 -ViewerPrintDoc 1 -DocListPrintDoc 1 -ContentMove 1 -ContentRename 1 -DocSign 1 -DocSignVoid 1 -DocPageMove 1 -DocDeleteSigned 1 -DocMoveSignRep 1 -DocDeleteSignRep 1 -DocCopyToClipboard 1 -FolderModifyStatus 1 -ViewerMailAttachment 1 -ViewerFaxDoc 1 -DocListFaxDoc 1 -DocListMailAttachment 1 -VersionCtrlUse 1 -VersionCtrlRemove 1 -VersionCtrlDeleteHistory 1 -VersionCtrlUndo3rdParty 1 -DocListExportDoc 1 -ViewerExportDoc 1
                        Set-InowDrawerPrivs -Drawer "Folders_" -User $groupName -SearchDoc 1 -DocView 1 -ContentCreate 1 -ContentCreateShortcut 1 -ContentMove 1 -ContentRename 1 -ContentDelete 1 -CustomPropModify 1 -contentModifyType 1 -ContentRemoveShortcut 1 -FolderModifyStatus 1
                         if($FolderTypeName -ne $null) {Set-INowFolderTypePrivs -FolderType $FolderTypeName -User $groupName -FolderTypeUse 1}
                        Set-InowGlobalPrivs -User $GroupName -CaptureBatchCreate 1 -CaptureSingleCreate 1 -CaptureBatchQa 1 -CaptureBatchLink 1 -CaptureBatchDelete 1 -CaptureBatchModifyNotes 1 -CaptureBatchStepState 1 -CaptureBatchResubmit 1 -UnlinkedDocsPrintDoc 1
                    }
                    View {
                        $groupName = $DrawerName + "-View"
                        Add-InowGroup -GroupName $groupName
                        Set-InowDrawerPrivs -Drawer $DrawerName -User $groupName -SearchDoc 1 -ViewerMailImageLink 1 -ViewerMailWebLink 1 -ViewerLaunchAssociatedApp 1 -DocView 1 -DocListLaunchAssociatedApp 1 -DocListMailWebLink 1 -DocListMailImageLink 1
                         if($FolderTypeName -ne $null) {Set-INowFolderTypePrivs -FolderType $FolderTypeName -User $groupName -FolderTypeUse 1}
                        Set-InowDrawerPrivs -Drawer "Folders_" -User $groupName -SearchDoc 1 -DocView 1
                    }
                    Update {
                        $groupName = $DrawerName + "-Update"
                        Add-InowGroup -GroupName $groupName
                        Set-InowDrawerPrivs -Drawer $DrawerName -User $groupName -SearchDoc 1 -ViewerMailImageLink 1 -ViewerMailWebLink 1 -ViewerLaunchAssociatedApp 1 -DocView 1 -DocListLaunchAssociatedApp 1 -DocListMailWebLink 1 -DocListMailImageLink 1 -ContentCreate 1 -ContentCreateShortcut 1 -ContentRemoveShortcut 1 -BatchProcess 1 -ContentDelete 1 -CustomPropModify 1 -contentModifyType 1 -DocModifyKeys 1 -DocModifyNotes 1 -DocMerge 1 -DocPageDelete 1 -DocPageReorder 1 -ViewerPrintDoc 1 -DocListPrintDoc 1
                        Set-InowDrawerPrivs -Drawer "Folders_" -User $groupName -SearchDoc 1 -DocView 1 -ContentCreate 1 -ContentCreateShortcut 1 -ContentRename 1 -CustomPropModify 1 -contentModifyType 1 -ContentRemoveShortcut 1 -FolderModifyStatus 1
                         if($FolderTypeName -ne $null) {Set-INowFolderTypePrivs -FolderType $FolderTypeName -User $groupName -FolderTypeUse 1}
                        Set-InowGlobalPrivs -User $groupName -CaptureBatchCreate 1 -CaptureSingleCreate 1 -CaptureBatchQa 1 -CaptureBatchLink 1 -CaptureBatchDelete 1 -CaptureBatchModifyNotes 1 -CaptureBatchStepState 1 -CaptureBatchResubmit 1 -UnlinkedDocsPrintDoc 1
                    }
                    Print {
                        $groupName = $DrawerName + "-Print"
                        Add-InowGroup -GroupName $groupName
                        Set-InowDrawerPrivs -Drawer $DrawerName -User $groupName -ViewerPrintDoc 1 -DocListPrintDoc 1
                         if($FolderTypeName -ne $null) {Set-INowFolderTypePrivs -FolderType $FolderTypeName -User $groupName -FolderTypeUse 1}
                        Set-InowGlobalPrivs -User $groupName -UnlinkedDocsPrintDoc 1
                    }
                }
            }
        }
    }

}

<#
.Synopsis
   Sets a default CMU Group privileges for a drawer
.DESCRIPTION
   Sets a default CMU Group privileges for a drawer
#>
function Set-INowCMUGroupPrivs
{
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  HelpUri = 'http://www.microsoft.com/',
                  ConfirmImpact='Medium')]
    [OutputType([String])]
    Param
    (
        # Param1 help description
        [Parameter(ParameterSetName='Parameter Set 1')] $DrawerName,
        [Parameter(ParameterSetName='Parameter Set 1')] [AllowNull()] $FolderTypeName,
        [Parameter(ParameterSetName='Parameter Set 1')] $GroupName,
        [Parameter(ParameterSetName='Parameter Set 1')][ValidateSet("Scan","Full","View","Update","Print")] $GroupType
    )
    Process
    {
        if ($pscmdlet.ShouldProcess("Target", "Operation"))
        {
            switch ($GroupType) {
                Scan {
                    Set-InowDrawerPrivs -Drawer $DrawerName -User $GroupName -SearchDoc 1 -ViewerMailImageLink 1 -ViewerMailWebLink 1 -ViewerLaunchAssociatedApp 1 -DocView 1 -DocListLaunchAssociatedApp 1 -DocListMailWebLink 1 -DocListMailImageLink 1 -ContentCreate 1 -ContentCreateShortcut 1 -ContentRemoveShortcut 1 -BatchProcess 1
                    Set-InowDrawerPrivs -Drawer "Folders_" -User $groupName -SearchDoc 1 -DocView 1 -ContentCreate 1 -ContentCreateShortcut 1
                    Set-InowGlobalPrivs -User $GroupName -CaptureBatchCreate 1 -CaptureSingleCreate 1 -CaptureBatchQa 1 -CaptureBatchLink 1 -CaptureBatchDelete 1 -CaptureBatchModifyNotes 1 -CaptureBatchStepState 1 -CaptureBatchResubmit 1
                    if($FolderTypeName -ne $null) {Set-INowFolderTypePrivs -FolderType $FolderTypeName -User $groupName -FolderTypeUse 1}
                }
                Full {
                    Set-InowDrawerPrivs -Drawer $DrawerName -User $GroupName -SearchDoc 1 -ViewerMailImageLink 1 -ViewerMailWebLink 1 -ViewerLaunchAssociatedApp 1 -DocView 1 -DocListLaunchAssociatedApp 1 -DocListMailWebLink 1 -DocListMailImageLink 1 -ContentCreate 1 -ContentCreateShortcut 1 -ContentRemoveShortcut 1 -BatchProcess 1 -ContentDelete 1 -CustomPropModify 1 -contentModifyType 1 -DocModifyKeys 1 -DocModifyNotes 1 -DocMerge 1 -DocPageDelete 1 -DocPageReorder 1 -ViewerPrintDoc 1 -DocListPrintDoc 1 -ContentMove 1 -ContentRename 1 -DocSign 1 -DocSignVoid 1 -DocPageMove 1 -DocDeleteSigned 1 -DocMoveSignRep 1 -DocDeleteSignRep 1 -DocCopyToClipboard 1 -FolderModifyStatus 1 -ViewerMailAttachment 1 -ViewerFaxDoc 1 -DocListFaxDoc 1 -DocListMailAttachment 1 -VersionCtrlUse 1 -VersionCtrlRemove 1 -VersionCtrlDeleteHistory 1 -VersionCtrlUndo3rdParty 1 -DocListExportDoc 1 -ViewerExportDoc 1
                    Set-InowDrawerPrivs -Drawer "Folders_" -User $groupName -SearchDoc 1 -DocView 1 -ContentCreate 1 -ContentCreateShortcut 1 -ContentMove 1 -ContentRename 1 -ContentDelete 1 -CustomPropModify 1 -contentModifyType 1 -ContentRemoveShortcut 1 -FolderModifyStatus 1
                    Set-InowGlobalPrivs -User $GroupName -CaptureBatchCreate 1 -CaptureSingleCreate 1 -CaptureBatchQa 1 -CaptureBatchLink 1 -CaptureBatchDelete 1 -CaptureBatchModifyNotes 1 -CaptureBatchStepState 1 -CaptureBatchResubmit 1 -UnlinkedDocsPrintDoc 1
                    if($FolderTypeName -ne $null) {Set-INowFolderTypePrivs -FolderType $FolderTypeName -User $groupName -FolderTypeUse 1}
                }
                View {
                    Set-InowDrawerPrivs -Drawer $DrawerName -User $GroupName -SearchDoc 1 -ViewerMailImageLink 1 -ViewerMailWebLink 1 -ViewerLaunchAssociatedApp 1 -DocView 1 -DocListLaunchAssociatedApp 1 -DocListMailWebLink 1 -DocListMailImageLink 1
                    if($FolderTypeName -ne $null) {Set-INowFolderTypePrivs -FolderType $FolderTypeName -User $groupName -FolderTypeUse 1}
                }
                Update {
                    Set-InowDrawerPrivs -Drawer $DrawerName -User $GroupName -SearchDoc 1 -ViewerMailImageLink 1 -ViewerMailWebLink 1 -ViewerLaunchAssociatedApp 1 -DocView 1 -DocListLaunchAssociatedApp 1 -DocListMailWebLink 1 -DocListMailImageLink 1 -ContentCreate 1 -ContentCreateShortcut 1 -ContentRemoveShortcut 1 -BatchProcess 1 -ContentDelete 1 -CustomPropModify 1 -contentModifyType 1 -DocModifyKeys 1 -DocModifyNotes 1 -DocMerge 1 -DocPageDelete 1 -DocPageReorder 1 -ViewerPrintDoc 1 -DocListPrintDoc 1
                    Set-InowDrawerPrivs -Drawer "Folders_" -User $groupName -SearchDoc 1 -DocView 1 -ContentCreate 1 -ContentCreateShortcut 1 -ContentRename 1 -CustomPropModify 1 -contentModifyType 1 -ContentRemoveShortcut 1 -FolderModifyStatus 1
                    Set-InowGlobalPrivs -User $GroupName -CaptureBatchCreate 1 -CaptureSingleCreate 1 -CaptureBatchQa 1 -CaptureBatchLink 1 -CaptureBatchDelete 1 -CaptureBatchModifyNotes 1 -CaptureBatchStepState 1 -CaptureBatchResubmit 1 -UnlinkedDocsPrintDoc 1
                    if($FolderTypeName -ne $null) {Set-INowFolderTypePrivs -FolderType $FolderTypeName -User $groupName -FolderTypeUse 1}
                }
                Print {
                    Set-InowDrawerPrivs -Drawer $DrawerName -User $GroupName -ViewerPrintDoc 1 -DocListPrintDoc 1
                    Set-InowGlobalPrivs -User $GroupName -UnlinkedDocsPrintDoc 1
                    if($FolderTypeName -ne $null) {Set-INowFolderTypePrivs -FolderType $FolderTypeName -User $groupName -FolderTypeUse 1}
                }
            }
        }
    }
}



#endregion
