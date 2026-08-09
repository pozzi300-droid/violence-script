-- Deobfuscated by wezxwe

local  LIB = {

}
local GetService =game.GetService ( game, "Players" )
local Players= game.GetService (game , "RunService" )
local RunService=game.GetService (game ,"UserInputService" )
local VirtualInputManager = game.GetService  ( game, "VirtualInputManager" )
local VirtualUser =game.GetService  ( game ,"VirtualUser" )
local GuiService=game.GetService (game,"GuiService" )
local Lighting = game.GetService (game ,"Lighting" )
local Stats = game.GetService (game , "Stats" )
local Workspace=game.GetService  (game ,"Workspace" )
local ReplicatedStorage= game.GetService (game ,"ReplicatedStorage"  )
local CollectionService=game.GetService (game , "CollectionService" )
local UserInputService= game.GetService (game ,"UserInputService" )
local LocalPlayer= GetService .LocalPlayer
local  PlayerGui= LocalPlayer.WaitForChild (LocalPlayer, "PlayerGui"  )
local FOV_30_RAD=math.rad ( 30)
local FOV_45_RAD=math.rad ( 45 )
local FOV_42_RAD= math.rad (42 )
local FOV_28_RAD = math.rad (  28 )
local  FOV_18_RAD =math.rad ( 18)
local  FOV_72_RAD = math.rad  ( 72 )
local MIN_PITCH = -0.95
local MAX_PITCH =0.95
local GRAVITY=Workspace.Gravity
local BALLISTIC_CACHE_FRAMES = 2
local BALLISTIC_CACHE_DIST=1.5
local MIN_TRAVEL_TIME =0.15
local ACQUIRE_FRAMES =3
local UILib = loadstring(readfile("BOLONGHUB/b0lngUi.lua"))()
local  Version="v4.1.1"
local AccentColor =Color3.fromRGB (255, 255, 255 )
local
function Notify( title,message, delay) UILib :MakeNotify( {
 .Title = title or "BOLONG-HUB" , .Description = "Info" , .Content = message or  ""  , .Color =AccentColor,  .Time =0.4, .Delay =delay or 2,
} )
end
local Config = {
 .killerShowName  = false , .killerShowOutline = true ,  .killerOutlineOnly  =true, .killerColor = Color3.fromRGB ( 255 ,  60 , 60 ) ,  .survivorShowName =false, .survivorShowOutline =true , .survivorOutlineOnly = true, .survivorColor = Color3.fromRGB ( 60  , 200,255 )  ,  .maxDistance = 500, .fillTransparency  =0.6,  .cameraZoomEnabled = false, .cameraZoomValue =1000 , .warnEnabled =false , .warnDist1 =60 , .warnDist2  = 40  ,  .warnDist3 = 20  , .customFovValue  = 70 , .lockFovEnabled =false, .autoGenerator = true, .autoGeneratorMode = "Instant" , .espGenShowPK  =false, .cameralockEnabled =false, .cameralockTargetType ="All" , .cameralockMaxDistance = 700, .cameralockSmoothness = 1 , .cameralockLockMode = "Always Lock" , .cameralockAimPart = "Torso" , .hitboxEnabled = false , .survivorHitboxSize =100, .killerHitboxSize =100 , .hitboxEspEnabled = false , .hitboxEspSurvivorColor  =Color3.fromRGB ( 0 ,255 , 120 ) , .hitboxEspKillerColor = Color3.fromRGB (255 , 60 , 60 ) , .hitboxEspTransparency  = 0.5, .hitboxEspOutlineOnly  = false , .espGeneratorEnabled =false, .espGeneratorProgressGen =false, .espGeneratorColor = Color3.fromRGB (200 , 100  ,0 ) ,  .espWin
	dowEnabled = false, .espWin
		dowColor = Color3.fromRGB ( 255 , 223,  0 ) , .espPalletEnabled =false, .espPalletColor = Color3.fromRGB  (  53 ,189, 166 ) , .espHookEnabled = false, .espHookColor = Color3.fromRGB ( 252, 116 , 116  ) , .espGateEnabled =false, .espGateColor  =Color3.fromRGB (255 ,  255 ,255)  , .cameraVeilEnabled = false, .cameraVeilSnapLine  = false, .cameraVeilMaxDistance = 175 , .cameraVeilSmoothness = 1 , .cameraVeilSpearSpeed  = 220 ,  .cameraVeilGravityMult = 1 , .cameraVeilTargetType = "Survivor" , .skipEndScreenEnabled = false, .skipLoadEndScreenEnabled = false, .silentAimFovRadius =  150  , .spearFovRadius =150, .spearSnaplineMaxDistance =400, .spearSnaplineShowText = true,  .autoCrouchEnabled = false , .autoCrouchRadius =  18 , .antiBlindEnabled = false,  .espItemEnabled =false, .forceCursorEnabled = false, .moonwalkEnabled = false ,
}
		local State = {
 .espObjects = {

} , .outlineObjects = {

} , .playerRoles =  {

} , .playerTeamConns  = {

}  , .playerCharConns = {

} , .cachedMapObjects = {
  .Generators = {

} , .Pallets =  {

} ,  .Hooks  =  {

} , .Gates = {

}
} ,  .cachedPalletMeta  = {

} ,  .cachedHookMeshParts = {

} , .completedGenerators = {

} , .genIndices = {

} , .nextGenIndex = 1 , .objEspInitialized = false ,  .win
			dowEspObjects  = {

} , .NoSlow
				down =false ,  .SpeedBoost =false , .BoostPercent = 50 , .AntiFallSlow =false, .safeModeSpeed = true , .autoParryEnabled = false , .autoParryRadiusEsp =false, .autoParryRadius  = 10 ,  .lastParryTime =0 , .activeAttackers = {

} , .HoldLockActive =false, .godEnabled  =false, .godLastHP =nil, .hitboxOriginalSizes = {

}  , .hitboxEspObjects = {

} , .instantLastVisible =false , .lastPressTime = 0 , .lastSkillHit = 0 , .ran
					domIsNeutral = false, .originalMaxZoom =nil , .originalFOV =nil,  .cursorBackupIcon =nil, .cursorBackupBehavior = nil ,  .forceCursorConn1 = nil , .forceCursorConn2 =nil, .originalMouseIconEnabled =nil , .originalMouseBehavior  =nil , .perfGui  =nil , .pnameEnabled =false, .pnameFakeNames =  {

}  , .pnameNameConns = {

} , .pnameSlotConns = {

} , .pnameWatchConn  =nil ,  .pnameAddedConn =nil , .CV_Enabled = false , .CV_CurrentTarget = nil, .CV_WasHolding = false , .CV_HoldingPC =false , .CV_HoldingMobile = false , .CV_LastStableDir =nil, .CV_SnapGui  = nil, .CV_SnapLine  =nil , .CV_SnapDot  =nil, .CV_LastSpearSpeed =nil , .CV_LastGravityMult  = nil , .CV_frameCount  = 0  , .CV_snapLineFrame = - 99 , .CV_cachedSpearMode =false ,  .CV_spearModeFrame = - 99  , .CV_acquireStartFrame  =nil , .CV_ballisticFrame = - 99 , .CV_lastSolvedHeadPos  = nil, .CV_lastSolvedDir =nil , .CV_lastSolvedPredicted =nil,  .CV_lastSolvedTime = nil , .CV_Connections = {

} ,  .CV_InputBeganConn = nil , .CV_InputEndedConn = nil, .CV_WatchConn  = nil, .CV_VisualConn = nil, .CV_HookedButtons = {

} , .CV_R
				enderStepName ="BOLONGHUB_CameraVeil" , .skipEndScreenConns = {

} , .fullbrightEnabled = false, .removeVfxEnabled  = false , .silentAimEnabled =false, .silentAimTarget = nil , .silentAimLookVector =nil , .laserEspEnabled  = true, .triggerLaser =false, .currentMuzzlePos = nil , .currentTargetPos = nil, .FOVCircle =nil, .silentAimFovVisible =false , .silentSpearEnabled =false , .silentSpearTargetTorso =nil , .silentSpearTargetVel =Vector3.new (0 ,0 , 0 ) , .silentSpearLookVector =nil , .spearIndicatorEnabled =false, .spearFovCircleEnabled =false, .spearIsHolding  =false, .spearHoldStartTime = nil , .lastSpearSpeed = 142.5, .lastGravityMult =1, .SPEAR_SNAPLINE = {
 .enabled =false, .locked = false , .lockedTarget  =nil, .lockedPlayerName ="" , .currentNearestDist =math.huge  , .lockPulse  =0,
} , .SpearFOVCircle = nil,  .SpearIndicatorGui  =nil, .SpearStatusText =nil, .SpearInfoText = nil, .SpearAccentBar =nil , .SpearMainFrame =nil, .SnapLineGui  = nil, .SnapLineFrame = nil, .SnapLineDot =nil, .SnapLineTextLabel = nil,  .autoCrouchIsCrouching =false, .autoCrouchActiveSlashers =  {

} , .autoCrouchAnimConns =  {

} , ._jitterFlip =false , ._hookedMobButtons = {

} , ._hookedSlasherButtons = {

}  , ._perfElapsed = 0, ._perfFrames = 0 , ._perfActive = false, .ghostGateEnabled  = false , .movConns  = {
 .antiFall = nil , .noSlow = nil
} ,  .aimConn = nil , .aimTargetCache =nil, .aimTargetT = 0 , .aimLastStableDir  = nil, .ghostGateOriginals = {

} , .antiLoopWin
					dowEnabled =false, .predGui = nil , .predInfoLabel =nil, .predActive = false,  .predMapName ="Unknown" , .predLastPos = nil, .predMapInfoConn = nil , .autoDropNearbyPallets = false , .palletPointsCache =nil, .lastPalletPointScan = 0 , .autoDropCool
						down =false, .moonwalkMobileDir  = 0 , .moonwalkPCForward =false ,  .moonwalkPCBackward =false, .moonwalkGui = nil,
}
						local ItemIcons = {
 [ "Adrenaline Shot" ] ="rbxassetid://135388781922226" , .Bandage ="rbxassetid://97791520639443" , .Flashlight = "rbxassetid://103299939715311" , .Gate = "rbxassetid://131249244284700"  , ["Holy Water" ]  ="rbxassetid://86130208614143" ,  [ "Motion Tracker" ] = "rbxassetid://92303584765773" ,  ["Parrying Dagger" ] ="rbxassetid://76822757630703" , [ "Riot Shield" ] = "rbxassetid://95718705901699" , ["Shadow Clone" ] = "rbxassetid://134088840518889" , ["Twist of Fate" ] ="rbxassetid://98397448432071" , [ "WaxBound Candle" ] = "rbxassetid://110413686590821" ,
}
						local
						function GetItemIcon(itemName )
						if not itemName or type (itemName) ~="string"
							then
							return nil
						end itemName= itemName .match (itemName,"^%s*(.-)%s*$" )
						local iconId =ItemIcons[ itemName ]
						if iconId
							then
							return iconId
						end
						for  key,value in pairs (ItemIcons)
							do
							if key.lower ( key) ==itemName .lower (itemName)
								then
								return value
							end
						end
						return nil
					end
					local BuildNumber= 17
					local HubNames = {
"BOLONGHUB"
}
					local  ESPFolder =Instance.new ( "Folder" )ESPFolder.Name ="__BolongESP__"ESPFolder .Parent  =workspace
					local UpdateTasks=  {

}
					local
					function RegisterTask(taskName, interval , callback) UpdateTasks[ #UpdateTasks+ 1 ] = {
 .name =taskName , .interval = interval , .timer =0 , .fn =callback
}
				end
				local qX0lIxI=false
				local Im1ZmzU0
				local uu1XowWzxIwQ1p= {
 [ 25 ] =true ,  [ 17  ] =true, [30] = true, [67.8 ]  =true
}
				local
				function HookTaskDelay( )
				if Im1ZmzU0
					then
					return
				end pcall (
				function (  )Im1ZmzU0=hook
				function (task .delay ,newcclosure (
				function ( w00XlMpuWXxZM ,oUb1uHnXwX )
				if not qX0lIxI
					then
					return Im1ZmzU0(w00XlMpuWXxZM ,oUb1uHnXwX)
				end
				if uu1XowWzxIwQ1p[w00XlMpuWXxZM]
					then
					return Im1ZmzU0 ( 0, oUb1uHnXwX)
				end
				return Im1ZmzU0(w00XlMpuWXxZM , oUb1uHnXwX)
			end ) )
		end )
	end
	local
	function UnhookTaskDelay ( )
	if Im1ZmzU0
		then pcall  (restorefunction,task.delay  )Im1ZmzU0= nil
	end
end
local
function GetPlayerRole ( wnOnZ)
return State .playerRoles [wnOnZ] or "survivor"
end
local
function  UpdatePlayerRole ( InM1MXp)
local p_Xb1Xu_pZwOuo, MzOMUHp = pcall  ( function( )
return InM1MXp.Teamand InM1MXp .Team .Name :lower ( )or ""
end)State.playerRoles [InM1MXp] = ( p_Xb1Xu_pZwOuo and MzOMUHp .find  ( MzOMUHp ,"killer" ) )and  "killer"or "survivor"
end
local  OwMIl
local
function QDxDD_zwXQzl ( )task.spawn (
function ( )
local lqlz_uHz ,l1IlDO0lZxX= pcall (function( )
return ReplicatedStorage .WaitForChild ( ReplicatedStorage ,"Remotes"  ,10 ) :WaitForChild("Items" ,10) : WaitForChild("Flashlight" , 10) : WaitForChild ("GotBlinded" , 10 )
end )
if not lqlz_uHz or not  l1IlDO0lZxX
	then
	return
end OwMIl=l1IlDO0lZxX
local ubzvooDIZxz ubzvooDIZxz = hookmetamethod( game, "__namecall" ,
function ( ... )
local OwbMpxmxIIb_= getnamecallmethod( )
local  HqNNbbpoOIpDX = table.pack ( ... )
local lQpIxOzQMxnHIM=HqNNbbpoOIpDX [1 ]
if OwbMpxmxIIb_ =="FireServer" and typeof ( lQpIxOzQMxnHIM ) =="Instance"and rawequal (lQpIxOzQMxnHIM, OwMIl )
	then
	if Config .antiBlindEnabledand HqNNbbpoOIpDX[ 2 ] == true
		then
		return
	end
end
return  ubzvooDIZxz ( ... )
end )
local OX__ZID1D OX__ZID1D =hookmetamethod(game , "__index" ,function( QXZ00uWHnvWp,BONppHIDnUNXz)
if not checkcaller( ) and  BONppHIDnUNXz=="FireServer" and typeof ( QXZ00uWHnvWp ) == "Instance"and rawequal (QXZ00uWHnvWp,OwMIl )
	then
	return  newcclosure(function( ... )
	local WvpzlUoNbplMDv=table.pack (  ... )
	if Config .antiBlindEnabled and WvpzlUoNbplMDv[ 2 ] == true
		then
		return
	end
	return  OX__ZID1D ( QXZ00uWHnvWp, BONppHIDnUNXz) (  ... )
end)
end
return OX__ZID1D ( QXZ00uWHnvWp, BONppHIDnUNXz )
end)
end)
end  QDxDD_zwXQzl( )RegisterTask ("AntiBlindForce"  , 0.2 ,function(  )
if not Config .antiBlindEnabled
	then
	return
end
for pxNquNopnH, pb_D_pHxnqU in  ipairs (PlayerGui.GetDesc
endants ( PlayerGui ) )
	do
	if pb_D_pHxnqU.Name == "Blind"
		then
		if pb_D_pHxnqU .IsA ( pb_D_pHxnqU ,"ScreenGui" )
			then
			if pb_D_pHxnqU .Enabled
				then pb_D_pHxnqU.Enabled  = false
			end
		else
		if pb_D_pHxnqU.IsA (pb_D_pHxnqU,"GuiObject" )
			then
			if pb_D_pHxnqU .Visible
				then pb_D_pHxnqU.Visible =false
			end
			if pb_D_pHxnqU.BackgroundTransparency < 1
				then pb_D_pHxnqU.BackgroundTransparency = 1
			end
		end
	end
end
end)
local wl0MHx_D
local
function qwvvHbn ( bZWbzubw_U )
if bZWbzubw_U
	then
	if not wl0MHx_D
		then wl0MHx_D =LocalPlayer .Idled :Connect( function(  ) VirtualUser:CaptureController (  ) VirtualUser : ClickButton2 (Vector2.new (  )  )
	end)
end
else
if wl0MHx_D
	then wl0MHx_D.Disconnect (wl0MHx_D ) wl0MHx_D =nil
end
end
end
local EnableCameraVeil,DisableCameraVeil,SetupCameraVeilMobile ,ResetCameraVeil
	do
	local
	function GetSafeGuiParent ( )
	local  _QqDzI , NZpQOz =pcall (
	function ( )
	if gethui
		then
		return gethui( )
	end
	return  game.GetService ( game , "CoreGui" )
end )
return( _QqDzI and NZpQOz )or PlayerGui
end
local
function  GetHeadPosition(BHUQIQHZ1o_p)
if not BHUQIQHZ1o_p
	then
	return nil
end
local Mlm0WN =BHUQIQHZ1o_p.FindFirstChild (BHUQIQHZ1o_p, "Head" )
if  Mlm0WN
	then
	return Mlm0WN.Position
end
local lOIXX= BHUQIQHZ1o_p.FindFirstChild (BHUQIQHZ1o_p ,"HumanoidRootPart" )
if  lOIXX
	then
	return lOIXX.Position
end
local qxIHQnU= BHUQIQHZ1o_p .FindFirstChild ( BHUQIQHZ1o_p ,"UpperTorso" )
if qxIHQnU
	then
	return qxIHQnU .Position
end
local H0znx= BHUQIQHZ1o_p .FindFirstChild  (BHUQIQHZ1o_p ,"Torso" )
if H0znx
	then
	return H0znx.Position
end
return BHUQIQHZ1o_p.PrimaryPart and BHUQIQHZ1o_p.PrimaryPart .Positionor nil
end
local
function GetVelocity( QZwnU__v1MII)
if not  QZwnU__v1MII
	then
	return Vector3.new ( 0 , 0 ,0 )
end
local bONxNnmWz=QZwnU__v1MII.AssemblyLinearVelocity
local u_nv0U1Nm0O= Vector3.new ( bONxNnmWz .X  , 0, bONxNnmWz.Z )
if u_nv0U1Nm0O .Magnitude  > 65
	then u_nv0U1Nm0O=u_nv0U1Nm0O.Unit  * 65
end
return  u_nv0U1Nm0O
end
local
function GetOrigin( )
local OwmNHQoI1lv =LocalPlayer .Character
local DXluXUD1vwImD =OwmNHQoI1lv and OwmNHQoI1lv .FindFirstChild ( OwmNHQoI1lv,"HumanoidRootPart" )
if not DXluXUD1vwImD
	then
	return nil
end
local bH0qbxQ=Workspace .CurrentCamera
local QIID0m=  (bH0qbxQ and bH0qbxQ .CFrame .LookVector  ) or DXluXUD1vwImD.CFrame  .LookVector
return DXluXUD1vwImD .Position +QIID0m *3+ Vector3.new ( 0 ,1.5,0)
end
local
function  GetSpearSpeed(MXlnI0xZzI )
local lvqOX = tonumber ( State.CV_LastSpearSpeed )or tonumber (Config.cameraVeilSpearSpeed  )or 220
return math ( lvqOX , 35 , 800 )
end
local
function ComputeLanding( WDblnM,_pqolOuzm,NQloXUN, b_Oqvx_W_puob )
local Hzq0O1QWmUlbq =math.cos  ( _pqolOuzm)
if Hzq0O1QWmUlbq<= 0.015
	then
	return nil , nil
end
local Nxlq01NlX0oNW = WDblnM/  ( NQloXUN* Hzq0O1QWmUlbq)
if Nxlq01NlX0oNW ~=Nxlq01NlX0oNW or Nxlq01NlX0oNW <= 0
	then
	return nil, nil
end
local WxXZpwMpW= 1/ 60
local HbxOuWZ_qqHO = 0.5*b_Oqvx_W_puob *WxXZpwMpW *Nxlq01NlX0oNW
local uvUMpmnz_= NQloXUN* math.sin (_pqolOuzm) * Nxlq01NlX0oNW- ( 0.5 *b_Oqvx_W_puob *Nxlq01NlX0oNW*Nxlq01NlX0oNW)  -HbxOuWZ_qqHO
return  uvUMpmnz_,Nxlq01NlX0oNW
end
local
function ScoreCandidate (vD1HUWXzOqM0X, wulINp1quXXw,IpqwZq_vUOuvpl, uD1OZlNI,NlzZUbp_on_O)
local oHDqzU1Iu1Hpuu ,QpMQm0lZXvNo = ComputeLanding(vD1HUWXzOqM0X, IpqwZq_vUOuvpl,uD1OZlNI ,NlzZUbp_on_O)
if not oHDqzU1Iu1Hpuu or not QpMQm0lZXvNo
	then
	return  nil
end
if QpMQm0lZXvNo<0.025 or QpMQm0lZXvNo > 4
	then
	return nil
end
local OpDum =math (oHDqzU1Iu1Hpuu -wulINp1quXXw)
local BmqHUbuW =math ( IpqwZq_vUOuvpl- FOV_42_RAD,  0 ) *0.35
local DOlqo_U=math (QpMQm0lZXvNo-1.3 , 0 ) *0.25
return OpDum+BmqHUbuW+DOlqo_U,OpDum , QpMQm0lZXvNo
end
local
function SolveDirection(IwXnOXHOnOlz_,HMqzxXHwp ,w0OMbbMz1q_MW0 ,uMXnWnIn)
local  Obp0M0U0Ivw =HMqzxXHwp -IwXnOXHOnOlz_
local WzlmvOQlblMp=Vector3.new ( Obp0M0U0Ivw.X ,0 , Obp0M0U0Ivw .Z )
local DInuDmwIpnNH = WzlmvOQlblMp .Magnitude
local MIvQbIlXHm =Obp0M0U0Ivw.Y
if Obp0M0U0Ivw.Magnitude <=0.001
	then
	return  nil
end
if DInuDmwIpnNH <= 0.35 or uMXnWnIn<=0.001
	then
	return Obp0M0U0Ivw .Unit  ,math (Obp0M0U0Ivw.Magnitude /w0OMbbMz1q_MW0, 0.025, 4 )
end
local QnoQbXX=WzlmvOQlblMp .Unit
local wuHOHlmmnzo= math.atan2 ( MIvQbIlXHm,DInuDmwIpnNH )
local qNuZQwqlqqnv0l= math ( - FOV_28_RAD, wuHOHlmmnzo- FOV_18_RAD )
local MlvUHluw_u=FOV_72_RAD
local BZwbOzZzDIWZ, _UNXXWqN,Wn0wmzQxM , Bq_HxDWq_qNlb1=nil ,math.huge ,math.huge ,nil
local  bQxvx_nvnnQ= 24
for  O_O_ZUX1pNp= 0 , bQxvx_nvnnQ
	do
	local vDN1HU=qNuZQwqlqqnv0l + (MlvUHluw_u- qNuZQwqlqqnv0l) * (O_O_ZUX1pNp/ bQxvx_nvnnQ)
	local pvIQq_XInZUlzl, bWowN,QbxmIu1OH_NIvb=ScoreCandidate(DInuDmwIpnNH ,MIvQbIlXHm, vDN1HU , w0OMbbMz1q_MW0 , uMXnWnIn )
	if  pvIQq_XInZUlzl and pvIQq_XInZUlzl< _UNXXWqN
		then _UNXXWqN,Wn0wmzQxM, BZwbOzZzDIWZ, Bq_HxDWq_qNlb1 = pvIQq_XInZUlzl ,bWowN , vDN1HU,QbxmIu1OH_NIvb
		if Wn0wmzQxM < MIN_TRAVEL_TIME
			then break
		end
	end
end
if BZwbOzZzDIWZ
	then
	local pH_HpONHmz = (MlvUHluw_u - qNuZQwqlqqnv0l ) /bQxvx_nvnnQ * 2.5
	local lO_qopX= ( Wn0wmzQxM<MIN_TRAVEL_TIME) and 1 or 3
	for u1QmNW_MxOOvqq= 1 ,lO_qopX
		do
		local HUlqu00,vquwopOpOv ,_vU0vzlvvQll, MUIHD_MNxqwOI = BZwbOzZzDIWZ, _UNXXWqN,Wn0wmzQxM, Bq_HxDWq_qNlb1
		for lmo0WpwX10nMN = - 3 , 3
			do
			local O0WlqO =math ( BZwbOzZzDIWZ+pH_HpONHmz* ( lmo0WpwX10nMN / 3)  ,qNuZQwqlqqnv0l , MlvUHluw_u)
			local vMqzXwm,MIH0lUbvNq,w_bNbwllHmHlzW=ScoreCandidate(DInuDmwIpnNH , MIvQbIlXHm, O0WlqO,w0OMbbMz1q_MW0, uMXnWnIn)
			if vMqzXwm and vMqzXwm<vquwopOpOv
				then vquwopOpOv , _vU0vzlvvQll , HUlqu00 ,MUIHD_MNxqwOI =vMqzXwm ,MIH0lUbvNq,O0WlqO ,w_bNbwllHmHlzW
			end
		end BZwbOzZzDIWZ,_UNXXWqN ,Wn0wmzQxM, Bq_HxDWq_qNlb1 =HUlqu00,vquwopOpOv ,_vU0vzlvvQll ,MUIHD_MNxqwOI
		if Wn0wmzQxM< MIN_TRAVEL_TIME
			then  break
		end  pH_HpONHmz=pH_HpONHmz * 0.38
	end
end
if  not BZwbOzZzDIWZ
	then
	local OMow0Z = math  (DInuDmwIpnNH/w0OMbbMz1q_MW0,0.025 ,4 )
	local lbN1pOIzoQ =HMqzxXHwp+Vector3.new ( 0, 0.5 *uMXnWnIn*OMow0Z*OMow0Z ,0)
	local ozvlzDOw1XDwD =lbN1pOIzoQ- IwXnOXHOnOlz_
	if ozvlzDOw1XDwD.Magnitude <= 0.001
		then
		return nil
	end
	return ozvlzDOw1XDwD .Unit , OMow0Z
end
local BzmzM0puov=QnoQbXX*math.cos (BZwbOzZzDIWZ ) +Vector3.new ( 0, math.sin ( BZwbOzZzDIWZ ) ,  0 )
if BzmzM0puov .Magnitude <=0.001
	then
	return nil
end
return BzmzM0puov.Unit , Bq_HxDWq_qNlb1
end
local
function SolveBallisticToTarget( oHq1wHNwqUpZq)
local O00NnqIQU= GetOrigin( )
if not O00NnqIQU or not oHq1wHNwqUpZq
	then
	return nil
end
local WoHOWIxNp_ =GetSpearSpeed ( ( oHq1wHNwqUpZq -O00NnqIQU ) .Magnitude )
local bzxQuu01=math (tonumber (State.CV_LastGravityMult ) or tonumber (Config .cameraVeilGravityMult ) or1 , 0 )
local q1p1mUu0N1H=GRAVITY*bzxQuu01
return SolveDirection(O00NnqIQU ,oHq1wHNwqUpZq,WoHOWIxNp_, q1p1mUu0N1H)
end
local
function SolveBallistic (_1IQW1bWuwuX , OoopINQpI1Hv)
if not _1IQW1bWuwuX
	then
	return nil
end
local oxOQOu =GetOrigin( )
if oxOQOu
	then
	local _MOQOwpUxWM0= _1IQW1bWuwuX-oxOQOu
	local vbqbmOHpDvWQWl=_MOQOwpUxWM0.Magnitude
	if vbqbmOHpDvWQWl< 6
		then
		if vbqbmOHpDvWQWl < 0.001
			then
			return nil
		end
		local  ow_WN_HX = tonumber (State.CV_LastSpearSpeed )or tonumber  (Config .cameraVeilSpearSpeed )or220
		return _MOQOwpUxWM0.Unit  ,_1IQW1bWuwuX, math ( vbqbmOHpDvWQWl/math ( ow_WN_HX, 1 )  ,0.01, 1 )
	end
end
local MxQUNumD = State .CV_frameCount
local OQvInxpqX= MxQUNumD -State .CV_ballisticFrame
local HpI_0Nv= State.CV_lastSolvedHeadPos and ( _1IQW1bWuwuX -State.CV_lastSolvedHeadPos ) .Magnitude < BALLISTIC_CACHE_DIST
if  OQvInxpqX < BALLISTIC_CACHE_FRAMES and HpI_0Nv  and  State .CV_lastSolvedDir
	then
	return State.CV_lastSolvedDir  ,State.CV_lastSolvedPredicted ,State.CV_lastSolvedTime
end
local pZ_NINbWO= _1IQW1bWuwuX
local vuUQv,QMzmU =SolveBallisticToTarget( pZ_NINbWO )
if vuUQv and QMzmU and OoopINQpI1Hv and OoopINQpI1Hv.Magnitude >1.25
	then
	local HnZxImnzNHlQu =math ( QMzmU* 0.68 , 0 , 1.1)
	local luuxOQnXM= OoopINQpI1Hv*HnZxImnzNHlQu
	if  luuxOQnXM .Magnitude > 32
		then luuxOQnXM=luuxOQnXM.Unit  * 32
	end
	local qxpUzubnxvxvp=_1IQW1bWuwuX +luuxOQnXM
	local  wUIUUxUvu ,BbxoIwWu1HHOQ =SolveBallisticToTarget (qxpUzubnxvxvp)
	if wUIUUxUvu and BbxoIwWu1HHOQ
		then vuUQv ,QMzmU , pZ_NINbWO=wUIUUxUvu,BbxoIwWu1HHOQ,qxpUzubnxvxvp
	end
end  State.CV_ballisticFrame = MxQUNumD State .CV_lastSolvedHeadPos = _1IQW1bWuwuX State .CV_lastSolvedDir  = vuUQv State.CV_lastSolvedPredicted = pZ_NINbWO State .CV_lastSolvedTime = QMzmU
return vuUQv , pZ_NINbWO, QMzmU
end
local IsSpearMode
local
function FindNearestSurvivor( )
local NvOIlUo= Workspace.CurrentCamera
if not NvOIlUo
	then
	return nil
end
local uZvquuxInbb1 ,HDIMx =NvOIlUo.CFrame .Position , NvOIlUo .CFrame .LookVector
local  bMmpzwuuMxo , lWxHnlM= nil,FOV_30_RAD
local  BX0nbn1=LocalPlayer .Character
local  NHuQzlI = BX0nbn1  and BX0nbn1.FindFirstChild (BX0nbn1 ,"HumanoidRootPart" )
if not NHuQzlI
	then
	return nil
end
for  qnNWlNblDoI, WXuIUlMu  in ipairs  ( GetService.GetPlayers  (GetService) )
	do
	if WXuIUlMu~=LocalPlayer
		then
		local BNIHq1= GetPlayerRole (WXuIUlMu )
		if BNIHq1 =="survivor"
			then
			local WwuWbu= WXuIUlMu.Character
			local bOMpbOzpzIXwX =WwuWbu and WwuWbu.FindFirstChildOfClass  (WwuWbu ,"Humanoid" )
			if WwuWbu and bOMpbOzpzIXwX and bOMpbOzpzIXwX .Health > 0
				then
				local QvQpWnvbpx= GetHeadPosition(WwuWbu )
				if QvQpWnvbpx
					then
					local llzzo10_ =  (QvQpWnvbpx -NHuQzlI.Position ) .Magnitude
					if llzzo10_ <=Config.cameraVeilMaxDistance
						then
						local  Duuoo1o =QvQpWnvbpx-uZvquuxInbb1
						if Duuoo1o .Magnitude > 0.001
							then
							local BzXH0_q00z= math.acos  ( math (HDIMx.Dot  ( HDIMx, Duuoo1o .Unit )  , - 1 , 1) )
							if BzXH0_q00z <lWxHnlM
								then lWxHnlM =BzXH0_q00z;
								
bMmpzwuuMxo = WXuIUlMu
							end
						end
					end
				end
			end
		end
	end
end
return bMmpzwuuMxo
end
local
function  INZnNq1Zw(  )
if State.CV_SnapGui and State .CV_SnapGui .Parentand State .CV_SnapLineand State.CV_SnapLine .Parentand State.CV_SnapDotand State.CV_SnapDot  .Parent
	then
	return
end
local MDIMbu_zIqX0D=Instance.new ( "ScreenGui" )MDIMbu_zIqX0D.Name ="CameraVeil_SnapLine"MDIMbu_zIqX0D.IgnoreGuiInset =true;

MDIMbu_zIqX0D .ResetOnSpawn =false ;

MDIMbu_zIqX0D .Parent  =GetSafeGuiParent ( )
local  QqzDxbZvqMwb = Instance.new ("Frame" )QqzDxbZvqMwb .Name ="Line"  ;

QqzDxbZvqMwb.AnchorPoint  = Vector2 .new ( 0.5 ,0.5) ;

QqzDxbZvqMwb.BorderSizePixel = 0 QqzDxbZvqMwb.BackgroundColor3 = Color3.fromRGB ( 0 , 255 , 120 )  ;

QqzDxbZvqMwb.BackgroundTransparency = 0.08 QqzDxbZvqMwb.Visible = false ;

 QqzDxbZvqMwb .Parent =MDIMbu_zIqX0D
local vOw1wz=Instance.new ("Frame" ) vOw1wz.Name ="Dot" ;

vOw1wz .AnchorPoint =Vector2.new (0.5, 0.5) ;

vOw1wz .BorderSizePixel  = 0 vOw1wz .BackgroundColor3 =Color3.fromRGB  ( 0,255, 120 ) ;

vOw1wz.BackgroundTransparency = 0 vOw1wz .Size =UDim2.fromOffset ( 7 , 7 ) ;

vOw1wz.Visible = false;

vOw1wz .Parent =MDIMbu_zIqX0D
local pmlZuxUuNqUX_ =Instance.new ("UICorner" )  ;

pmlZuxUuNqUX_.CornerRadius = UDim.new ( 1, 0 ) ;

 pmlZuxUuNqUX_ .Parent = vOw1wz State .CV_SnapGui = MDIMbu_zIqX0D ;

State .CV_SnapLine = QqzDxbZvqMwb;

State.CV_SnapDot = vOw1wz
end
local
function UpdateSnapLine( DlZlHMpvlDZ_nD )
if not  Config .cameraVeilSnapLine or  not State.CV_Enabled
	then
	if State.CV_SnapLine
		then State .CV_SnapLine .Visible =false
	end
	if State .CV_SnapDot
		then State.CV_SnapDot .Visible =false
	end
	return
end
if not IsSpearMode( )
	then
	if State.CV_SnapLine
		then  State.CV_SnapLine .Visible =false
	end
	if State .CV_SnapDot
		then State .CV_SnapDot .Visible  =false
	end
	return
end
local qMW_QMN =State.CV_frameCount
if DlZlHMpvlDZ_nD and( qMW_QMN -State .CV_snapLineFrame ) <2
	then
	return
end State .CV_snapLineFrame =qMW_QMN
local OmbM_Mx0zM=pcall (function( )INZnNq1Zw( )
local _UD0HxWXZMlOzD= State.CV_SnapLine  ;

local HvHHU110ZDDw = State.CV_SnapDot ;


local qDwouHxODONwzq=Workspace.CurrentCamera
if not _UD0HxWXZMlOzD or  not qDwouHxODONwzq
	then
	if _UD0HxWXZMlOzD
		then _UD0HxWXZMlOzD.Visible = false
	end
	if HvHHU110ZDDw
		then HvHHU110ZDDw .Visible = false
	end
	return
end
local BoWOvqm=DlZlHMpvlDZ_nD
local  DMmMmQv = ( State .CV_CurrentTarget ~= nil and  State .CV_WasHolding )
if not DMmMmQv
	then
	local MNpHu0b= FindNearestSurvivor ( )
	if  MNpHu0b
		then
		local wwDOoOoI0 = MNpHu0b.Character
		if wwDOoOoI0
			then  BoWOvqm = GetHeadPosition (wwDOoOoI0)
		end
	else  BoWOvqm=nil
end
end
if  not BoWOvqm
	then _UD0HxWXZMlOzD.Visible  =false;
	

	if HvHHU110ZDDw
		then  HvHHU110ZDDw.Visible = false
	end
	return
end
local Q1IqxOOXMMmDb, bbouponbIpmxU=qDwouHxODONwzq .WorldToViewportPoint (qDwouHxODONwzq , BoWOvqm )
if not bbouponbIpmxU or Q1IqxOOXMMmDb .Z <= 0
	then  _UD0HxWXZMlOzD.Visible  = false ;
	

	if HvHHU110ZDDw
		then HvHHU110ZDDw.Visible = false
	end
	return
end
local  wXD0WZxpWm =qDwouHxODONwzq.ViewportSize
local DUOwWvUO = Vector2 .new ( wXD0WZxpWm .X *0.5, wXD0WZxpWm.Y *0.5 )
local HHlQMNmlXDpqo= Vector2.new ( Q1IqxOOXMMmDb .X  ,Q1IqxOOXMMmDb .Y )
local pMO_ZI0npQmX =HHlQMNmlXDpqo -DUOwWvUO ;

local uoDHvplb0ZnI0 =pMO_ZI0npQmX.Magnitude
if uoDHvplb0ZnI0<2
	then _UD0HxWXZMlOzD.Visible =false ;
	

	if HvHHU110ZDDw
		then  HvHHU110ZDDw .Visible = false
	end
	return
end
local olzMnl= DMmMmQv and Color3.fromRGB  ( 0 , 255 ,120) or Color3.fromRGB ( 255 , 220 ,0)
local lvDHXZ=DMmMmQv and 0.08 or 0.35 _UD0HxWXZMlOzD.BackgroundColor3 =olzMnl;

_UD0HxWXZMlOzD .BackgroundTransparency =lvDHXZ _UD0HxWXZMlOzD .Size =UDim2.fromOffset ( uoDHvplb0ZnI0 ,DMmMmQv  and 2 or 1 ) _UD0HxWXZMlOzD .Position =UDim2.fromOffset  (  ( DUOwWvUO.X +HHlQMNmlXDpqo .X  ) * 0.5, ( DUOwWvUO .Y +HHlQMNmlXDpqo.Y ) *0.5) _UD0HxWXZMlOzD .Rotation =math.deg ( math.atan2 ( pMO_ZI0npQmX.Y , pMO_ZI0npQmX .X ) ) ;

_UD0HxWXZMlOzD.Visible = true
if HvHHU110ZDDw
	then HvHHU110ZDDw .BackgroundColor3 = olzMnl ;
	
 HvHHU110ZDDw .Position = UDim2.fromOffset (HHlQMNmlXDpqo.X , HHlQMNmlXDpqo .Y ) ;
	
 HvHHU110ZDDw .Visible =true
end
end)
if not OmbM_Mx0zM
	then
	if State .CV_SnapLine
		then  State .CV_SnapLine .Visible = false
	end
	if State .CV_SnapDot
		then State .CV_SnapDot .Visible = false
	end
end
end
function ResetCameraVeil( )State .CV_CurrentTarget =nil;

State.CV_WasHolding  = false State.CV_LastStableDir = nil ;

State.CV_acquireStartFrame = nil UpdateSnapLine (nil)
end IsSpearMode=function( )
local ooHMIpMN=State.CV_frameCount
if ooHMIpMN==State .CV_spearModeFrame
	then
	return State.CV_cachedSpearMode
end State.CV_spearModeFrame = ooHMIpMN
local pWvNmQ=LocalPlayer .Character
local IwDwUOIwxplm=false
if pWvNmQ
	then
	local  Wnvz0Ql ,qQHuQH =pcall (pWvNmQ .GetAttribute  ,pWvNmQ,"spearmode"  )IwDwUOIwxplm=Wnvz0Ql and qQHuQH ==true
end  State .CV_cachedSpearMode =IwDwUOIwxplm
return IwDwUOIwxplm
end
local
function IsHoldingSpear ( )
if not IsSpearMode ( )
	then
	return false
end
return State.CV_HoldingPCor State.CV_HoldingMobile
end
local
function CameraVeilUpdate ( ) State .CV_frameCount = State .CV_frameCount + 1
if not State .CV_Enabled
	then
	return
end
local opbQz0IlNuOXn=IsHoldingSpear ( )
if not opbQz0IlNuOXn
	then
	if State .CV_WasHolding
		then ResetCameraVeil(  )
	else UpdateSnapLine(nil)
end
return
end
if not  State .CV_WasHolding
	then State .CV_LastStableDir =nil State.CV_CurrentTarget =FindNearestSurvivor ( )State.CV_WasHolding  = true State .CV_acquireStartFrame =State.CV_frameCount
end
if  State .CV_acquireStartFrameand (State .CV_frameCount -State .CV_acquireStartFrame ) < ACQUIRE_FRAMES
	then
	local DNDb1qzQ = FindNearestSurvivor ( )
	if DNDb1qzQ
		then State.CV_CurrentTarget = DNDb1qzQ
	end
end
local pNvNno1W0n1xm = State.CV_CurrentTarget
if not  pNvNno1W0n1xm
	then State.CV_WasHolding  =false ;
	

	return
end
local lu_0NWnUp =pNvNno1W0n1xm .Character
local BDuXQMoHu1w =lu_0NWnUp and lu_0NWnUp.FindFirstChildOfClass ( lu_0NWnUp,"Humanoid" )
local qzDZNlN00mWOUz=GetPlayerRole( pNvNno1W0n1xm )
if not lu_0NWnUp or not BDuXQMoHu1w or  BDuXQMoHu1w.Health <= 0or qzDZNlN00mWOUz ~="survivor"
	then State .CV_WasHolding = false ;
	
State.CV_CurrentTarget =nil ;
	

	return
end
local uH_pv_O_=GetHeadPosition( lu_0NWnUp)
if not uH_pv_O_
	then  State.CV_WasHolding =false;
	
 State.CV_CurrentTarget =nil ;
	

	return
end
local NpZuOM_Mxq= Workspace.CurrentCamera
local B0oWw = LocalPlayer.Character
local qMZwMNlmWQ =B0oWw and B0oWw .FindFirstChild ( B0oWw, "HumanoidRootPart"  )
if not NpZuOM_Mxq or not qMZwMNlmWQ
	then
	return
end if(uH_pv_O_ -qMZwMNlmWQ.Position ) .Magnitude >Config.cameraVeilMaxDistance
	then State.CV_WasHolding  = false;
	
State.CV_CurrentTarget =nil ;
	

	return
end
local  Bo0pHnmZqbn = GetVelocity(lu_0NWnUp.FindFirstChild (lu_0NWnUp, "HumanoidRootPart" ) )
local WUbzuHzzMloZDZ = SolveBallistic(uH_pv_O_ ,Bo0pHnmZqbn )
local OXOQU_Xn=WUbzuHzzMloZDZ and  WUbzuHzzMloZDZ .Magnitude  >0.001 and WUbzuHzzMloZDZ.Y  < MAX_PITCH and WUbzuHzzMloZDZ .Y > MIN_PITCH
if OXOQU_Xn
	then
	if State.CV_LastStableDir
		then
		local WlqwnmNm =math.acos ( math (State .CV_LastStableDir : Dot( WUbzuHzzMloZDZ.Unit ) , -  1 ,1) )
		if WlqwnmNm< FOV_45_RAD
			then  State.CV_LastStableDir  =WUbzuHzzMloZDZ.Unit
		end
	else State .CV_LastStableDir = WUbzuHzzMloZDZ.Unit
end WUbzuHzzMloZDZ=State.CV_LastStableDir
else
if  State .CV_LastStableDir
	then WUbzuHzzMloZDZ= State.CV_LastStableDir
else WUbzuHzzMloZDZ=NpZuOM_Mxq .CFrame .LookVector
end
local qxOqMUvoMOH=NpZuOM_Mxq .CFrame  .Position
local WpwlOU= math  (Config .cameraVeilSmoothnessor 1, 0.05 , 1 )
local HzQqNOQH_= NpZuOM_Mxq .CFrame .LookVector :Lerp ( WUbzuHzzMloZDZ ,WpwlOU )
if HzQqNOQH_.Magnitude > 0.001
	then NpZuOM_Mxq.CFrame = CFrame.new ( qxOqMUvoMOH ,qxOqMUvoMOH +HzQqNOQH_.Unit ) UpdateSnapLine( uH_pv_O_)
end
end
local
function IsDesc
endantOf(_bmuxpMqMI, _0z_Oz1NHwXn_H )
local OQQW00oZUXU0H_ =_bmuxpMqMI and _bmuxpMqMI .Parent
while OQQW00oZUXU0H_
	do
	if OQQW00oZUXU0H_ .Name ==_0z_Oz1NHwXn_H
		then
		return true
	end OQQW00oZUXU0H_ = OQQW00oZUXU0H_ .Parent
end
return false
end
local
function  IsAttackButton ( pvDbMz)
if not(pvDbMz and pvDbMz .IsA ( pvDbMz ,"GuiButton" ) )
	then
	return false
end
if pvDbMz.Name ~="attack"
	then
	return false
end
if not IsDesc
endantOf( pvDbMz, "Slasher-mob"  )
	then
	return false
end
if not IsDesc
endantOf (pvDbMz, "Control" ) and not IsDesc
endantOf (pvDbMz , "Controls"  )
	then
	return false
end
return true
end
local
function  HookAttackButton( HxozwplXoD_M)
if not IsAttackButton(HxozwplXoD_M)
	then
	return
end
if State .CV_HookedButtons [HxozwplXoD_M]
	then
	return
end State .CV_HookedButtons [HxozwplXoD_M]  =true
local
function Nuv_Un (  )
if  not State .CV_Enable
	dor not IsSpearMode( )
		then
		return
	end State.CV_HoldingMobile =true
end
local
function Nvp00NDMlpmDlH( ) State .CV_HoldingMobile  =false
end
local DZbzQbUZn =HxozwplXoD_M .InputBegan : Connect (
function (ImDpX0pnI1UIQ )
local BzMn0UI=ImDpX0pnI1UIQ.UserInputType
if BzMn0UI ~=Enum .UserInputType .Touch and  BzMn0UI ~=Enum.UserInputType .MouseButton1
	then
	return
end Nuv_Un( )
local obQnz0uMuQ1Iql obQnz0uMuQ1Iql =UserInputService.InputEnded :Connect(
function ( bHZWXMnlXxN1 )
if bHZWXMnlXxN1== ImDpX0pnI1UIQ
	then Nvp00NDMlpmDlH( ) ;
	

	if obQnz0uMuQ1Iql
		then obQnz0uMuQ1Iql.Disconnect ( obQnz0uMuQ1Iql)
	end
end
end)
end)table ( State .CV_Connections , DZbzQbUZn )
local qIQuO= HxozwplXoD_M.InputEnded  : Connect ( function(wIzHwwXxlqlDw )
local u_qzzzuUm =wIzHwwXxlqlDw .UserInputType
if  u_qzzzuUm ~= Enum.UserInputType .Touch and u_qzzzuUm~= Enum .UserInputType .MouseButton1
	then
	return
end Nvp00NDMlpmDlH( )
end )table (State .CV_Connections  , qIQuO)
end
function SetupCameraVeilMobile( )
local H_10HM0OMN_Z =LocalPlayer .FindFirstChildOfClass  (LocalPlayer,"PlayerGui" )or PlayerGui
if not H_10HM0OMN_Z
	then
	return
end pcall (function( )
for H_z0ouQD_MlX , IzwDIWWwD in ipairs (H_10HM0OMN_Z .GetDesc
endants (H_10HM0OMN_Z) )
	do HookAttackButton ( IzwDIWWwD )
end
end)
if  State .CV_WatchConn
	then State.CV_WatchConn : Disconnect ( )
end  State.CV_WatchConn =H_10HM0OMN_Z.Desc
endantAdded :Connect(HookAttackButton ) table (State.CV_Connections  , State.CV_WatchConn  )
end
local
function HX_Hp ( )
if State.CV_VisualConn
	then
	return
end
local BoumqvpZpH,Q1bDv0 =pcall (function(  )
local _qZmZm =game.GetService (game , "ReplicatedStorage" )
local  HXIzuIpHuU = _qZmZm.FindFirstChild ( _qZmZm, "Remotes" )
local  _oo1Qbw= HXIzuIpHuU and HXIzuIpHuU .FindFirstChild (HXIzuIpHuU , "Mechanics"  )
return  _oo1Qbw  and _oo1Qbw.FindFirstChild  ( _oo1Qbw , "visualize" )
end)
if BoumqvpZpH and Q1bDv0 and Q1bDv0.IsA ( Q1bDv0 , "RemoteEvent" )
	then  State.CV_VisualConn =Q1bDv0 .OnClientEvent :Connect(
	function ( lqpuHnQOq_oMpM,uUvN_xIzZ , IpX1pQHx_W_xo, MvpblUn1m00_HI)
	if  lqpuHnQOq_oMpM~=LocalPlayer .Character
		then
		return
	end
	if type ( IpX1pQHx_W_xo ) =="number"and  IpX1pQHx_W_xo > 0
		then State .CV_LastSpearSpeed =IpX1pQHx_W_xo
	end
	if type ( MvpblUn1m00_HI ) == "number"and MvpblUn1m00_HI >= 0
		then  State.CV_LastGravityMult =MvpblUn1m00_HI
	end
end ) table ( State.CV_Connections , State.CV_VisualConn )
end
end
function EnableCameraVeil ( )
if State.CV_Enabled
	then
	return
end  State.CV_Enabled  = true State.CV_HoldingPC = false ;

State.CV_HoldingMobile = false  ResetCameraVeil ( ) ;

 HX_Hp( ) ;

SetupCameraVeilMobile( )State.CV_InputBeganConn =UserInputService .InputBegan : Connect (
function ( OWwZDuxHow00)
if OWwZDuxHow00 .UserInputType ==Enum.UserInputType .MouseButton2 and IsSpearMode( )
	then State.CV_HoldingPC = true
end
end)table ( State .CV_Connections ,State .CV_InputBeganConn ) State.CV_InputEndedConn =UserInputService.InputEnded : Connect( function(HQwZWn1bZN)
if HQwZWn1bZN .UserInputType  == Enum.UserInputType .MouseButton2
	then State .CV_HoldingPC = false
end
end) table ( State .CV_Connections ,State.CV_InputEndedConn ) pcall ( function( ) Players:UnbindFromR
enderStep( State .CV_R
enderStepName )
end) pcall (function( )Players :BindToR
enderStep (State.CV_R
enderStepName ,Enum.R
enderPriority .Camera .Value + 2 , CameraVeilUpdate )
end )
end
function  DisableCameraVeil( )State.CV_Enabled =false State .CV_HoldingPC =false ;

State.CV_HoldingMobile =false ResetCameraVeil ( )State .CV_frameCount =0 ;

 State.CV_snapLineFrame = -99;

State.CV_spearModeFrame  =  - 99 ;

State.CV_cachedSpearMode = false  State .CV_ballisticFrame = - 99 ;

State.CV_lastSolvedHeadPos  =nil;

 State .CV_lastSolvedDir = nil State.CV_lastSolvedPredicted =nil ;


if 0 > ( 730)
	then
	local HIwxZu1= 381 + 730
	local boHMwownU= HIwxZu1 *2
end  State .CV_lastSolvedTime =nil pcall  (function(  )Players:UnbindFromR
enderStep( State.CV_R
enderStepName )
end)
for oUNoI ,v_UMbvvnzpopql in ipairs (State .CV_Connections )
	do  pcall (function( )v_UMbvvnzpopql : Disconnect ( )
end)
end State .CV_Connections = {

} ;

State.CV_HookedButtons  =  {

} State.CV_InputBeganConn =nil ;

 State.CV_InputEndedConn = nil ;

State .CV_WatchConn =nil ;

 State.CV_VisualConn =nil
end
end
local
function CreateBillboardLabel( wxbXbI,QnvbX00QlovM, wUNI_u,BwM0wo )
local  uIn1xq = Instance.new ("BillboardGui" )uIn1xq.AlwaysOnTop  =true;

 uIn1xq .Size = wUNI_u or UDim2.new  ( 0 , 40 , 0 ,40) ;

uIn1xq.StudsOffset =Vector3.new (0 , 3.5,0)
local _WHxwDXUx=Instance.new ("TextLabel" )_WHxwDXUx .Name = "Label" ;

_WHxwDXUx.Size =UDim2.new ( 1 ,0 ,1 , 0 )  ;

_WHxwDXUx.BackgroundTransparency =1 _WHxwDXUx.Text = wxbXbI ;

 _WHxwDXUx .TextColor3 = QnvbX00QlovM ;

 _WHxwDXUx.TextStrokeTransparency  = 0_WHxwDXUx.TextStrokeColor3 =Color3.new ( 0, 0 ,0) ;

 _WHxwDXUx.TextSize =BwM0wo or 22 _WHxwDXUx .Font =Enum.Font.GothamBold ;

 _WHxwDXUx.RichText =true ;

_WHxwDXUx .Parent  = uIn1xq
return uIn1xq
end
local
function RefreshAllESP( )
for uNpoqHmX, DHnUvMIZXI_QW in pairs  (State.espObjects )
	do
	if DHnUvMIZXI_QW and DHnUvMIZXI_QW .billboard and  DHnUvMIZXI_QW .billboard .Parent
		then
		local oXwqO =GetPlayerRole( uNpoqHmX ) ;
		

		local IqxzpuHXZn =oXwqO == "killer"DHnUvMIZXI_QW.nameLabel .Visible = (IqxzpuHXZn and Config .killerShowName ) or ( not  IqxzpuHXZn and Config.survivorShowName )DHnUvMIZXI_QW.nameLabel .Text =State .pnameEnabled and ( State .pnameFakeNames [ uNpoqHmX ]or uNpoqHmX.Name ) or uNpoqHmX.NameDHnUvMIZXI_QW.billboard .MaxDistance =Config.maxDistance
	end
end
for bDZWWwpUHIOnM, bboZN1z_ in pairs ( State.outlineObjects )
	do
	if  bboZN1z_  and bboZN1z_.Parent
		then
		local pxxxOb =GetPlayerRole(bDZWWwpUHIOnM) ;
		

		local qQomm =pxxxOb=="killer"
		local HOmQDIvDx=qQomm  and Config.killerColoror Config.survivorColor
		local u_ZmHpO = ( qQomm  and Config .killerShowOutline )or (not qQomm and Config.survivorShowOutline )
		local QOv1W1IU = ( qQomm and Config.killerOutlineOnly ) or(not qQomm and  Config .survivorOutlineOnly )bboZN1z_.FillColor = HOmQDIvDx;
		
 bboZN1z_ .OutlineColor =HOmQDIvDx;
		
 bboZN1z_.Enabled =u_ZmHpO  bboZN1z_.FillTransparency =QOv1W1IU and1 or Config.fillTransparency
	end
end
end
local
function UpdatePlayerESP ( MQ00Dw1nI0bZml ,WOQq_)
local WlZpwHHHqDDN=State.espObjects [ MQ00Dw1nI0bZml ]
if not WlZpwHHHqDDN
	then
	return
end
if not WOQq_ or not WOQq_.Parentor MQ00Dw1nI0bZml .Character ~=WOQq_
	then
	return
end
local qZvwm=WOQq_.FindFirstChild (WOQq_ ,"HumanoidRootPart" )or WOQq_.FindFirstChild ( WOQq_, "Torso" )or WOQq_ .FindFirstChild ( WOQq_ , "UpperTorso" ) or WOQq_.FindFirstChild  (WOQq_ ,"Head" )
if not qZvwm
	then task.spawn (
	function ( )
	local QwbwpWpxwqXpW ,_p0nO= pcall  ( function( )
	return WOQq_.WaitForChild ( WOQq_, "HumanoidRootPart" , 3 )
end)
if QwbwpWpxwqXpW and _p0nO and _p0nO .Parent and WOQq_.Parentand MQ00Dw1nI0bZml.Character == WOQq_
	then
	if WlZpwHHHqDDN.billboard
		then  WlZpwHHHqDDN.billboard .A
			dornee = _p0nO WlZpwHHHqDDN.billboard .Enabled  =true
		end
		if WlZpwHHHqDDN.itemBillboard
			then WlZpwHHHqDDN.itemBillboard .A
				dornee =_p0nO  WlZpwHHHqDDN.itemBillboard .Enabled  =true
			end
		end
	end)
	return
end
if WlZpwHHHqDDN .billboard
	then  WlZpwHHHqDDN.billboard  .A
		dornee = qZvwm WlZpwHHHqDDN.billboard .Enabled = true
	end
	if WlZpwHHHqDDN .itemBillboard
		then WlZpwHHHqDDN .itemBillboard .A
			dornee =qZvwm WlZpwHHHqDDN.itemBillboard .Enabled =true
		end
		local bnnUxDM1 =GetPlayerRole (MQ00Dw1nI0bZml) ;
		

		local vZIXnl_lqw0nv = bnnUxDM1 =="killer"WlZpwHHHqDDN .nameLabel .Visible = (vZIXnl_lqw0nv and Config.killerShowName ) or ( not vZIXnl_lqw0nv and Config.survivorShowName )WlZpwHHHqDDN .nameLabel .Text  =State.pnameEnabled and(State.pnameFakeNames [MQ00Dw1nI0bZml ] or  MQ00Dw1nI0bZml.Name ) or MQ00Dw1nI0bZml .Name
	end
	local
	function RemovePlayerESP ( HM0pbqmvOM)
	if State .espObjects [HM0pbqmvOM]
		then
		if State .espObjects [HM0pbqmvOM ] .billboard
			then State .espObjects [HM0pbqmvOM] .billboard  :Destroy( )
		end
		if State.espObjects  [HM0pbqmvOM] .itemBillboard
			then State.espObjects [ HM0pbqmvOM]  .itemBillboard : Destroy ( )
		end  State .espObjects [ HM0pbqmvOM ] = nil
	end
	if State .outlineObjects [ HM0pbqmvOM]
		then State.outlineObjects [ HM0pbqmvOM] :Destroy ( ) ;
		
State.outlineObjects [HM0pbqmvOM] = nil
	end State .playerRoles [HM0pbqmvOM ] = nil
	if State.playerTeamConns  [HM0pbqmvOM ]
		then State.playerTeamConns [ HM0pbqmvOM ] :Disconnect( ) ;
		
 State .playerTeamConns [HM0pbqmvOM] = nil
	end
end
local
function UpdatePlayerOutline (DQvmwUI0,puNHplqx)
local NnvMmbmNn1oDp=State.outlineObjects [DQvmwUI0]
if  not NnvMmbmNn1oDp
	then
	return
end
if not puNHplqx or not puNHplqx .Parentor DQvmwUI0.Character  ~=puNHplqx
	then
	return
end
local D_vDMoxHUWuvD= GetPlayerRole ( DQvmwUI0 )  ;


local BOWXw =D_vDMoxHUWuvD=="killer"
local  lZnQmH0Mz=BOWXw and Config.killerColoror Config.survivorColor
local vUDUZN = (BOWXw and Config.killerShowOutline )or(not BOWXw and Config.survivorShowOutline  )
local pmUnNOobopbOW= (BOWXw and Config .killerOutlineOnly )or ( not BOWXw and Config.survivorOutlineOnly ) NnvMmbmNn1oDp.A
	dornee =puNHplqx NnvMmbmNn1oDp.FillColor = lZnQmH0Mz NnvMmbmNn1oDp.OutlineColor = lZnQmH0Mz  NnvMmbmNn1oDp.FillTransparency  = pmUnNOobopbOW and 1 or Config .fillTransparency NnvMmbmNn1oDp.OutlineTransparency  =0 NnvMmbmNn1oDp.DepthMode =Enum .HighlightDepthMode .AlwaysOnTop NnvMmbmNn1oDp .Enabled =vUDUZN
end
local
function UpdatePlayerState( v_xQlDHqM_ )
if v_xQlDHqM_ ==LocalPlayer
	then
	return
end
if not v_xQlDHqM_ or not v_xQlDHqM_.Parent
	then
	return
end
local oQpWoU1zzo_q= State.espObjects [ v_xQlDHqM_]
local  B_WUpUI=State .outlineObjects  [v_xQlDHqM_]
if not oQpWoU1zzo_q and not B_WUpUI
	then
	return
end
local vlo_lu=v_xQlDHqM_ .Character
if not vlo_lu  or not vlo_lu.Parent
	then
	if oQpWoU1zzo_q and oQpWoU1zzo_q.billboard
		then  oQpWoU1zzo_q.billboard .A
			dornee = nil
		end
		if oQpWoU1zzo_q and oQpWoU1zzo_q .itemBillboard
			then oQpWoU1zzo_q.itemBillboard .A
				dornee =nil
			end
			if B_WUpUI
				then B_WUpUI .A
					dornee = nil;
					
 B_WUpUI .Enabled  = false
				end
				return
			end
			local uNWMMboxW1DvW=vlo_lu.FindFirstChild ( vlo_lu,"HumanoidRootPart" ) or  vlo_lu.FindFirstChild  (vlo_lu , "Torso" )or vlo_lu.FindFirstChild  (vlo_lu,"UpperTorso" ) or  vlo_lu.FindFirstChild ( vlo_lu, "Head" )
			if not uNWMMboxW1DvW
				then
				return
			end
			if oQpWoU1zzo_q and oQpWoU1zzo_q.billboard
				then
				if oQpWoU1zzo_q.billboard .A
					dornee ~=uNWMMboxW1DvW
						then oQpWoU1zzo_q .billboard .A
							dornee =uNWMMboxW1DvW
						end
						if not oQpWoU1zzo_q .billboard .Enabled
							then oQpWoU1zzo_q .billboard .Enabled = true
						end
					end
					if oQpWoU1zzo_q and  oQpWoU1zzo_q.itemBillboard
						then
						if oQpWoU1zzo_q.itemBillboard .A
							dornee ~= uNWMMboxW1DvW
								then oQpWoU1zzo_q .itemBillboard .A
									dornee = uNWMMboxW1DvW
								end
								if not  oQpWoU1zzo_q.itemBillboard .Enabled
									then oQpWoU1zzo_q .itemBillboard .Enabled =true
								end
							end
							if B_WUpUI
								then
								if B_WUpUI.A
									dornee  ~=vlo_lu
										then UpdatePlayerOutline ( v_xQlDHqM_ ,vlo_lu )
									else
									if not B_WUpUI.Enabled
										then
										local  uuNzvHb=GetPlayerRole(v_xQlDHqM_) ;
										

										local MuHWlq0nU1Z = uuNzvHb =="killer"
										local qXDmlN0wxxZq= ( MuHWlq0nU1Z and Config.killerShowOutline ) or( not MuHWlq0nU1Z and  Config .survivorShowOutline  )B_WUpUI .Enabled = qXDmlN0wxxZq
									end
								end
							end
						end
						local
						function  AddPlayerESP(M_qXM )
						if M_qXM==LocalPlayer
							then
							return
						end UpdatePlayerRole( M_qXM)
						local v1nzqXmWXmIU_ = GetPlayerRole (M_qXM)
						local NZOnqO1 = Instance.new  ( "BillboardGui" )NZOnqO1.Name = "ESP_BB_" ..M_qXM .Name ;
						
NZOnqO1.AlwaysOnTop  =true  NZOnqO1.Size = UDim2.new ( 0 , 150 , 0 , 18 )NZOnqO1.StudsOffset =Vector3.new ( 0 , 3.5, 0 )NZOnqO1 .MaxDistance = Config.maxDistance  ;
						
 NZOnqO1 .Parent = ESPFolder
						local M_nM_w=Instance.new ( "TextLabel" ) M_nM_w.Name = "NameLabel" ;
						
M_nM_w.Size = UDim2.new (1, 0, 1 , 0)M_nM_w.BackgroundTransparency = 1  M_nM_w.TextColor3 =Color3.fromRGB  ( 255 , 255 ,255) ;
						
 M_nM_w .TextStrokeTransparency = 0 M_nM_w .TextStrokeColor3 = Color3.new ( 0 , 0 , 0 ) ;
						
M_nM_w.TextSize  = 12 M_nM_w.Font =Enum.Font.GothamBoldM_nM_w .Text = State.pnameEnabledand(State .pnameFakeNames [M_qXM] or M_qXM .Name  )or M_qXM .Name M_nM_w.Visible = ( v1nzqXmWXmIU_=="killer" and Config .killerShowName ) or(v1nzqXmWXmIU_ ~="killer"and Config.survivorShowName )M_nM_w.Parent =NZOnqO1
						local  vm_vUow= Instance.new  ( "BillboardGui" )vm_vUow .Name = "ESP_Item_" ..M_qXM .Name vm_vUow.AlwaysOnTop =true  vm_vUow.Size = UDim2.new (1.5, 0 ,1.5 ,0) vm_vUow .StudsOffset =Vector3.new ( 0  , -5, 0 ) vm_vUow.MaxDistance = Config.maxDistance vm_vUow .Parent = ESPFolder
						local _MxUNnNZuzM= Instance.new ( "ImageLabel"  )_MxUNnNZuzM .Name ="ItemImage"_MxUNnNZuzM.Size = UDim2.new  ( 1 ,0, 1 , 0) _MxUNnNZuzM.BackgroundTransparency = 1_MxUNnNZuzM .Visible = false  _MxUNnNZuzM.Parent =vm_vUow State .espObjects [M_qXM ]  =  {
  .billboard = NZOnqO1 , .nameLabel =M_nM_w, .itemBillboard  = vm_vUow, .itemImage =_MxUNnNZuzM
}
						if M_qXM .Character
							then  UpdatePlayerESP (M_qXM,M_qXM.Character  )
						end
						if not State .playerTeamConns [M_qXM]
							then State.playerTeamConns [ M_qXM ] =M_qXM .GetPropertyChangedSignal ( M_qXM ,"Team" ) : Connect(
							function ( ) UpdatePlayerRole (M_qXM)RefreshAllESP (  )task .delay ( 0.5 ,
							function ( )UpdatePlayerState ( M_qXM)
						end)task.delay ( 2, function(  ) UpdatePlayerState(M_qXM)
					end)
				end)
			end
		end
		local
		function AddPlayerOutline (qpuXO_xp1QqO_)
		if qpuXO_xp1QqO_==LocalPlayer
			then
			return
		end
		local wNmDv=Instance.new ("Highlight" )  ;
		
 wNmDv .Parent = ESPFolder  State.outlineObjects [ qpuXO_xp1QqO_ ]  = wNmDv
		if qpuXO_xp1QqO_.Character
			then UpdatePlayerOutline ( qpuXO_xp1QqO_ , qpuXO_xp1QqO_.Character  )
		end
	end
	local
	function GetAttributeValue( IbqwwuNomON1p, __DWvwowb )
	if typeof ( IbqwwuNomON1p) ~= "Instance"
		then
		return nil
	end
	local Bvb_Op =IbqwwuNomON1p .GetAttribute ( IbqwwuNomON1p,__DWvwowb)
	if  Bvb_Op~=nil
		then
		return  Bvb_Op
	end
	local vMZlzvx=IbqwwuNomON1p.FindFirstChild (IbqwwuNomON1p,__DWvwowb)
	if vMZlzvx and vMZlzvx .IsA  (vMZlzvx, "ValueBase"  )
		then
		return vMZlzvx .Value
	end
	return  nil
end
local
function  AddHighlight ( DUZuDNN, ubUlQIO0W_XuXz )
if not DUZuDNN or not  DUZuDNN.Parent
	then
	return
end
local vDbNw = DUZuDNN.FindFirstChild (DUZuDNN , "__BolongHL__" )
if not vDbNw
	then vDbNw =Instance.new ("Highlight" ) ;
	
 vDbNw .Name ="__BolongHL__" ;
	
vDbNw .A
		dornee =DUZuDNN vDbNw .FillTransparency = 1 ;
		
vDbNw .OutlineTransparency = 0;
		
 vDbNw.DepthMode =Enum.HighlightDepthMode .AlwaysOnTop vDbNw .FillColor =ubUlQIO0W_XuXz ;
		
vDbNw.OutlineColor = ubUlQIO0W_XuXz;
		
vDbNw .Parent =DUZuDNN ;
		

		return
	end
	if vDbNw .FillColor ~= ubUlQIO0W_XuXz
		then vDbNw .FillColor =ubUlQIO0W_XuXz ;
		
 vDbNw .OutlineColor =ubUlQIO0W_XuXz
	end
	if not vDbNw .Enabled
		then vDbNw .Enabled =true
	end
end
local
function RemoveHighlight( wMuuQUW)
if not wMuuQUW
	then
	return
end
local OlIWZnXQxOHOZO = wMuuQUW.FindFirstChild ( wMuuQUW , "__BolongHL__"  )
if OlIWZnXQxOHOZO
	then OlIWZnXQxOHOZO.Destroy (OlIWZnXQxOHOZO)
end
end
local
function UpdateGenerator (pDHwxpwpHNZW)
if not pDHwxpwpHNZW or  not pDHwxpwpHNZW .Parent
	then
	return true
end
if State.completedGenerators [pDHwxpwpHNZW]
	then
	return true
end
local BZ0Z01DmoM = pDHwxpwpHNZW .GetAttribute ( pDHwxpwpHNZW , "RepairProgress"  )or pDHwxpwpHNZW .GetAttribute  ( pDHwxpwpHNZW , "Progress" ) or 0
local B0DZZ0UQo = ( BZ0Z01DmoM >= 100 ) or(pDHwxpwpHNZW.GetAttribute (pDHwxpwpHNZW , "Completed" ) ==true)or( pDHwxpwpHNZW.GetAttribute (pDHwxpwpHNZW ,"IsCompleted" )  == true) or (pDHwxpwpHNZW.GetAttribute  (pDHwxpwpHNZW ,"Done" ) ==true )
local  vu0MWq0nn=pDHwxpwpHNZW.FindFirstChild (pDHwxpwpHNZW , "__BolongGenProgress__" )
if B0DZZ0UQo
	then
	if vu0MWq0nn
		then vu0MWq0nn .Destroy ( vu0MWq0nn)
	end RemoveHighlight(pDHwxpwpHNZW)pDHwxpwpHNZW:SetAttribute( "__BolongGenLastPct__" , nil)pDHwxpwpHNZW :SetAttribute("__BolongGenLastInfo__" , nil) State.completedGenerators [ pDHwxpwpHNZW ] =true State.genIndices  [ pDHwxpwpHNZW] = nil
	return B0DZZ0UQo
end
if Config.espGeneratorEnabled
	then  AddHighlight( pDHwxpwpHNZW, Config .espGeneratorColor )
else RemoveHighlight ( pDHwxpwpHNZW )
end
if Config .espGeneratorProgressGen
	then
	local Nx_zuWb= pDHwxpwpHNZW .GetAttribute (pDHwxpwpHNZW,"PlayersRepairingCount" )or0
	local BZI1MQnNWw0=pDHwxpwpHNZW .GetAttribute (pDHwxpwpHNZW ,"kickcount" )or 0
		do
		local qQIZX1vZlnO1= 279 * ( 0+ 1-1)
		local  q1bvIqU0D1Uw1= qQIZX1vZlnO1+495- 495
	end
	local qbXxHWO0qXZvqH = math (BZ0Z01DmoM+0.5)
	local wUWHvwMN1pHq = pDHwxpwpHNZW .GetAttribute ( pDHwxpwpHNZW, "__BolongGenLastPct__" )
	local MZ00U =pDHwxpwpHNZW .GetAttribute ( pDHwxpwpHNZW ,"__BolongGenLastInfo__" )
	local HuHqmn=State .genIndices [pDHwxpwpHNZW] or 1
	local MzDH01zw0Qn= string ( "%d_%d_%d_%s_%d"  , qbXxHWO0qXZvqH, Nx_zuWb ,BZI1MQnNWw0,tostring (Config.espGenShowPK )  ,HuHqmn )
	if wUWHvwMN1pHq== qbXxHWO0qXZvqH and  MZ00U== MzDH01zw0Qn and vu0MWq0nn
		then
		return false
	end pDHwxpwpHNZW .SetAttribute ( pDHwxpwpHNZW, "__BolongGenLastPct__" , qbXxHWO0qXZvqH)pDHwxpwpHNZW :SetAttribute( "__BolongGenLastInfo__"  ,MzDH01zw0Qn )
	local lnoUHpIOmDH =math (BZ0Z01DmoM,  0 , 100 )
	local wnqOuNwOnl = (lnoUHpIOmDH <50)and Config.espGeneratorColor : Lerp(Color3.fromRGB ( 255 ,  200 ,0 ) , lnoUHpIOmDH/ 50 )or Color3.fromRGB ( 255 , 200,0) : Lerp( Color3.fromRGB ( 100 ,255, 80 ) , (lnoUHpIOmDH- 50 ) / 50)
	local pmb1M= wnqOuNwOnl.ToHex (wnqOuNwOnl )
	local pbUWvuz =string ("GEN%d" , HuHqmn)
	local _IM1vxnv_0Ib= string  ("%d%%" , qbXxHWO0qXZvqH)
	local lQIInQnUH =pDHwxpwpHNZW .FindFirstChild  (pDHwxpwpHNZW,"GeneratorBody" ,true )or pDHwxpwpHNZW.FindFirstChild (pDHwxpwpHNZW , "defaultMaterial"  , true) or( pDHwxpwpHNZW.IsA (pDHwxpwpHNZW , "Model" )and pDHwxpwpHNZW .PrimaryPart ) or pDHwxpwpHNZW .FindFirstChildWhichIsA  ( pDHwxpwpHNZW ,"BasePart" ,true)
	if not lQIInQnUH
		then
		return false
	end
	local uvoUpD11WWMM ="F4D03F"
	local WXmn1vO= string ( "<font size=\"9\" color=\"#%s\">%s</font> <font color=\"#555555\">│</font> <font color=\"#%s\">%s</font>" ,uvoUpD11WWMM,pbUWvuz , pmb1M ,_IM1vxnv_0Ib)
	if Config.espGenShowPK
		then WXmn1vO =WXmn1vO..string (" <font color=\"#555555\">│</font> <font color=\"#76D7C4\">P:%d</font> <font color=\"#555555\">│</font> <font color=\"#FF6B6B\">K:%d</font>" ,Nx_zuWb ,BZI1MQnNWw0 )
	end
	if not vu0MWq0nn
		then vu0MWq0nn =Instance.new  ("BillboardGui" )vu0MWq0nn.Name ="__BolongGenProgress__"vu0MWq0nn .A
			dornee = lQIInQnUH vu0MWq0nn.AlwaysOnTop =true vu0MWq0nn.LightInfluence  =0  vu0MWq0nn.ResetOnSpawn = false vu0MWq0nn .MaxDistance = 260vu0MWq0nn.Size = UDim2.new ( 0, 100 , 0 , 14 )
			local HmDNup_oMWN = (lQIInQnUH .Size .Y  / 2) +3.5 vu0MWq0nn .StudsOffset =Vector3.new ( 0 , HmDNup_oMWN,0) vu0MWq0nn.Parent =pDHwxpwpHNZW
			local _1Xm1boDQ =Instance.new  ( "TextLabel" )_1Xm1boDQ .Name  ="Label"_1Xm1boDQ .BackgroundTransparency =1 _1Xm1boDQ .Size  = UDim2.new ( 1 , 0, 1 , 0) _1Xm1boDQ .Position = UDim2.new ( 0,0, 0 ,0 )_1Xm1boDQ .Font  =Enum.Font.GothamBlack_1Xm1boDQ.TextSize = 11 _1Xm1boDQ .RichText  = true _1Xm1boDQ .Text =WXmn1vO  _1Xm1boDQ .TextColor3 =Color3.fromRGB (255, 255, 255) _1Xm1boDQ .TextXAlignment = Enum.TextXAlignment  .Center _1Xm1boDQ .Parent = vu0MWq0nn
			local lZzqZWppz=Instance.new ("UIStroke" ) lZzqZWppz .Thickness =0.8 lZzqZWppz .Transparency = 0.4  lZzqZWppz .Color = Color3.new (0, 0 ,  0 ) lZzqZWppz .Parent =_1Xm1boDQ
		else
		if vu0MWq0nn.A
			dornee  ~= lQIInQnUH
				then vu0MWq0nn.A
					dornee =lQIInQnUH
				end
				local pXWM0ox= (lQIInQnUH.Size .Y /2 ) +3.5 vu0MWq0nn.StudsOffset  = Vector3.new ( 0, pXWM0ox , 0 )
				local HHmboXDH1 =vu0MWq0nn .FindFirstChild ( vu0MWq0nn ,"Label" )
				if HHmboXDH1
					then HHmboXDH1.Text = WXmn1vO
				end
			end
		else
		if  vu0MWq0nn
			then vu0MWq0nn .Destroy (vu0MWq0nn )pDHwxpwpHNZW:SetAttribute( "__BolongGenLastPct__" , nil )pDHwxpwpHNZW:SetAttribute ( "__BolongGenLastInfo__" ,nil )
		end
	end
	return  false
end
local
function ConnectGeneratorSignals(uQwnIWq )
local
function qvb__00MX(  )
if  not Config.espGeneratorEnabledand not Config.espGeneratorProgressGen
	then
	return
end UpdateGenerator( uQwnIWq)
end pcall (
function ( ) uQwnIWq :GetAttributeChangedSignal("RepairProgress" ) : Connect ( qvb__00MX )uQwnIWq :GetAttributeChangedSignal ( "Progress" ) : Connect( qvb__00MX) uQwnIWq :GetAttributeChangedSignal( "Completed" ) :Connect( qvb__00MX )uQwnIWq: GetAttributeChangedSignal("IsCompleted" ) : Connect( qvb__00MX)uQwnIWq : GetAttributeChangedSignal("PlayersRepairingCount" ) :Connect ( qvb__00MX)uQwnIWq :GetAttributeChangedSignal ("kickcount" ) :Connect (qvb__00MX)
end)
end
local
function ConnectPalletSignals(ollbxU,bmIvxUmw )
local
function wzxpnp ( )
local llo0uI=GetAttributeValue ( ollbxU , "Dropped" ) or  GetAttributeValue( ollbxU , "IsDropped" )
local MQbm1zl1 =GetAttributeValue ( ollbxU,"Broken" ) or GetAttributeValue( ollbxU ,"IsBroken"  )or  GetAttributeValue( ollbxU,"Destroyed" )
if llo0uI  or MQbm1zl1 or bmIvxUmw.isFake
	then RemoveHighlight ( ollbxU)
	for vZoIuz1ZMIbQv ,_Xqln_ in ipairs (State .cachedMapObjects .Pallets )
		do
		if _Xqln_ ==ollbxU
			then table ( State.cachedMapObjects .Pallets , vZoIuz1ZMIbQv )  ;
			
 break
		end
	end State .cachedPalletMeta  [ ollbxU] = nil
end
end
for qq1bWop , DMXux in  ipairs ( {
"Dropped" ,"IsDropped" ,"Broken" ,"IsBroken" ,"Destroyed"
} )
	do  ollbxU .GetAttributeChangedSignal ( ollbxU, DMXux ) : Connect ( wzxpnp )
end ollbxU.ChildAdded :Connect( function(lwNxm0XbH)
if  lwNxm0XbH.IsA ( lwNxm0XbH,"ValueBase" )and( lwNxm0XbH .Name =="Dropped" or lwNxm0XbH.Name == "IsDropped" or lwNxm0XbH .Name  == "Broken"or lwNxm0XbH.Name == "IsBroken" or lwNxm0XbH.Name =="Destroyed" )
	then lwNxm0XbH .Changed  : Connect( wzxpnp )
end
end )
end
local
function SetGateGhost ( _XUDb ,ubWxl )
if not _XUDb or not  _XUDb .Parent
	then
	return
end
local pnOmmozpNpz = _XUDb .IsA (_XUDb , "BasePart" )and{
_XUDb
}or _XUDb .GetDesc
endants ( _XUDb )
for NmwpxIuzZH, lpXboQo1 in ipairs ( pnOmmozpNpz)
	do
	if lpXboQo1 .IsA  (lpXboQo1 ,"BasePart" )
		then
		if ubWxl
			then
			if not  State.ghostGateOriginals [ lpXboQo1]
				then State.ghostGateOriginals [lpXboQo1] =  {
 .CanCollide = lpXboQo1.CanCollide  , .Transparency = lpXboQo1.Transparency
}
			end  lpXboQo1.CanCollide = false lpXboQo1.Transparency  = 0.6
		else
		if State.ghostGateOriginals [lpXboQo1 ]
			then lpXboQo1.CanCollide =State .ghostGateOriginals [ lpXboQo1] .CanCollidelpXboQo1.Transparency  =State.ghostGateOriginals  [lpXboQo1 ] .Transparency
		end
	end
end
end
end
local
function  OnMapObjectAdded (oHDvv)
local OHbqD=oHDvv.Name
if  OHbqD == "Generator"
	then table  (State.cachedMapObjects .Generators , oHDvv)
	if not State .genIndices [oHDvv]
		then
		if next (State.genIndices ) ==nil
			then State.nextGenIndex  = 1
		end State.genIndices [ oHDvv ] =State .nextGenIndex State .nextGenIndex =State .nextGenIndex + 1
	end
	if Config.espGeneratorEnabled
		then UpdateGenerator( oHDvv ) ;
		
ConnectGeneratorSignals(oHDvv)
	end
else
if  OHbqD == "Hook"
	then table (State.cachedMapObjects .Hooks , oHDvv )
	local MvDuv = {

}
	local  vQIzDWqobqIZ= oHDvv.FindFirstChild ( oHDvv ,"Model" )
	if  vQIzDWqobqIZ
		then
		for pUXNxDMoUzvD_z , qHIo0muZx in ipairs ( vQIzDWqobqIZ .GetDesc
	endants  (vQIzDWqobqIZ) )
		do
		if qHIo0muZx.IsA ( qHIo0muZx , "MeshPart" )
			then table ( MvDuv,qHIo0muZx)
		end
	end
end State .cachedHookMeshParts [oHDvv ] =MvDuv
if Config .espHookEnabled
	then  if# MvDuv> 0
		then
		for  _HuHwZQ,wuqvv1bQ0X0  in  ipairs (MvDuv )
			do AddHighlight(wuqvv1bQ0X0 ,Config.espHookColor )
		end
	else AddHighlight ( oHDvv ,Config.espHookColor )
end
end
else
if OHbqD=="Gate"
	then table ( State .cachedMapObjects  .Gates  , oHDvv )
	if Config.espGateEnabled
		then AddHighlight( oHDvv, Config .espGateColor )
	end
	if State.ghostGateEnabled
		then SetGateGhost ( oHDvv ,true )
	end
else
if OHbqD =="Pallet"or  OHbqD=="Palletwrong"
	then table ( State .cachedMapObjects .Pallets ,oHDvv )
	local Ib0XXw1mUuXHZI=OHbqD.lower ( OHbqD )
	local  oqHOQUQDI = ( oHDvv.IsA ( oHDvv,"Model" ) and  oHDvv.PrimaryPart )or oHDvv.FindFirstChildWhichIsA ( oHDvv ,"BasePart" , true) or( oHDvv.IsA (oHDvv , "BasePart" ) and oHDvv)
	local vOIbMnl1n0bm=Ib0XXw1mUuXHZI .find (Ib0XXw1mUuXHZI , "fake" ) or Ib0XXw1mUuXHZI.find ( Ib0XXw1mUuXHZI , "broken" )or Ib0XXw1mUuXHZI.find ( Ib0XXw1mUuXHZI, "destroyed" )
	local pNIuz = {
 .part =oqHOQUQDI , .isFake  =vOIbMnl1n0bm and true or false
}State.cachedPalletMeta [ oHDvv ] = pNIuz
	if Config .espPalletEnabledand not  pNIuz .isFake
		then  AddHighlight(oHDvv, Config.espPalletColor )
	end ConnectPalletSignals(oHDvv ,pNIuz)
end
end
local
function OnMapObjectRemoved( Nl_mM )
local  BvU1xlxp= Nl_mM .Name
if BvU1xlxp =="Generator"
	then
	for _nmDHDuX1, uoooznUZz in ipairs (State .cachedMapObjects  .Generators )
		do
		if  uoooznUZz== Nl_mM
			then table (State .cachedMapObjects .Generators , _nmDHDuX1 ) ;
			
break
		end
	end State .genIndices [Nl_mM] = nil State.completedGenerators  [ Nl_mM] = nil RemoveHighlight (Nl_mM )
	local  bWWwzWQxUo =Nl_mM.FindFirstChild ( Nl_mM , "__BolongGenProgress__" )
	if bWWwzWQxUo
		then bWWwzWQxUo.Destroy ( bWWwzWQxUo)
	end
	if next  (State.genIndices ) == nil
		then  State .nextGenIndex  = 1
	end
else
if BvU1xlxp== "Hook"
	then
	for W1ovqUnu1D,lWuoDQ1 in ipairs  (State .cachedMapObjects .Hooks )
		do
		if lWuoDQ1==Nl_mM
			then table ( State.cachedMapObjects .Hooks , W1ovqUnu1D ) ;
			
break
		end
	end
	local NwOvHU = State.cachedHookMeshParts [ Nl_mM]
	if NwOvHU
		then
		for ImbDbD,llu_UloD_1 in ipairs (NwOvHU)
			do  RemoveHighlight(llu_UloD_1)
		end
	else RemoveHighlight(Nl_mM )
end State .cachedHookMeshParts [ Nl_mM ] = nil
else
if BvU1xlxp == "Gate"
	then
	for OxqIZolbnpUIX ,o1bo0wObZH1pb in ipairs ( State.cachedMapObjects  .Gates )
		do
		if o1bo0wObZH1pb== Nl_mM
			then table  (State.cachedMapObjects .Gates ,OxqIZolbnpUIX) ;
			
 break
		end
	end  RemoveHighlight (Nl_mM)
else
if BvU1xlxp== "Pallet"or BvU1xlxp =="Palletwrong"
	then
	for qIw1vDn0W1bz1, vQIwx in ipairs (State.cachedMapObjects .Pallets )
		do
		if vQIwx== Nl_mM
			then table (State.cachedMapObjects .Pallets ,qIw1vDn0W1bz1 ) ;
			
 break
		end
	end RemoveHighlight(Nl_mM) State.cachedPalletMeta [Nl_mM] = nil
end
end
local
function InitMapESP (bpZ1ZlIDDIUIw )
if not bpZ1ZlIDDIUIw
	then
	return
end State.cachedMapObjects = {
 .Generators =  {

} , .Pallets = {

} , .Hooks = {

} , .Gates = {

}
}State.cachedPalletMeta = {

}  ;

 State.cachedHookMeshParts  = {

}  ;

 State.completedGenerators = {

}State.genIndices = {

} ;

 State.nextGenIndex = 1
for lvwMZ1w1 , WvDoZIbMW  in ipairs (bpZ1ZlIDDIUIw.GetDesc
endants ( bpZ1ZlIDDIUIw) )
	do OnMapObjectAdded( WvDoZIbMW)
end
end
local
function SetupMapESP(bquDOpnb )
if not bquDOpnb
	then
	return
end InitMapESP(bquDOpnb)bquDOpnb.Desc
endantAdded :Connect ( OnMapObjectAdded) bquDOpnb .Desc
endantRemoving :Connect (OnMapObjectRemoved )State .objEspInitialized =true
end State .win
	dowEspObjects = {

}
	local
	function  AddWin
		dowESP (lwxXvqNU)
		if  not  lwxXvqNU or not lwxXvqNU .Parent or State.win
			dowEspObjects [lwxXvqNU ]
				then
				return
			end
			local OzUwz =Config .espWin
				dowColor
				local Iwun1_zqluI= Instance.new ("BoxHandleAdornment" ) Iwun1_zqluI .Name ="WindowESP_Box" Iwun1_zqluI.A
					dornee =lwxXvqNU Iwun1_zqluI.Color3 =OzUwz  Iwun1_zqluI.Transparency  =0.3 Iwun1_zqluI .Size =lwxXvqNU.Size Iwun1_zqluI .AlwaysOnTop =true Iwun1_zqluI.ZIndex  =10 Iwun1_zqluI .Parent =ESPFolder State .win
						dowEspObjects [lwxXvqNU ]  =Iwun1_zqluI
					end
					local
					function RemoveWin
						dowESP(ObnHuZq )
						local IpXvwbuvbU=State .win
							dowEspObjects [ ObnHuZq]
							if IpXvwbuvbU
								then  pcall (function( )IpXvwbuvbU :Destroy ( )
							end )State .win
								dowEspObjects [ObnHuZq ] = nil
							end
						end
						local
						function  FindWin
							dowPart( wb1oq1)
							if typeof ( wb1oq1) ~= "Instance"
								then
								return nil
							end
							local DNMZMn =string.lower ( wb1oq1.Name )
							if DNMZMn=="window" and wb1oq1.IsA ( wb1oq1 ,"Model"  )
								then
								local IDxpzWZQovu =wb1oq1.FindFirstChild (wb1oq1, "Bottom" , true)
								if  IDxpzWZQovu  and IDxpzWZQovu.IsA ( IDxpzWZQovu ,"BasePart" )
									then
									return IDxpzWZQovu
								end
								return wb1oq1.PrimaryPart
							end
							if DNMZMn== "bottom" and wb1oq1 .IsA ( wb1oq1 , "BasePart" )
								then
								if wb1oq1.Parentand string.lower (wb1oq1.Parent .Name ) =="window"
									then
									return wb1oq1
								end
							end
							return nil
						end
						local
						function OnWin
							dowAdded(IXUuzUWoDmXN )
							local pHZUvZnvq=FindWin
								dowPart ( IXUuzUWoDmXN )
								if pHZUvZnvq
									then
									if Config.espWin
										dowEnabledand  not  State .win
											dowEspObjects  [pHZUvZnvq]
												then AddWin
													dowESP(pHZUvZnvq)
												end
											end
										end Workspace .Desc
									endantAdded : Connect(
									function ( ImOQ0XH1m)OnWin
										dowAdded (ImOQ0XH1m )
									end) Workspace .Desc
								endantRemoving :Connect(function( Ov1pxpO1vlIbQ )
								local WIxqnZqmUv0z= FindWin
									dowPart(Ov1pxpO1vlIbQ ) or Ov1pxpO1vlIbQ
									if State .win
										dowEspObjects [WIxqnZqmUv0z]
											then RemoveWin
												dowESP(WIxqnZqmUv0z )
											end
										end)
										local
										function RefreshWin
											dowESP (  )
											for IzWqxqvHvlZ0N_,wvQovQ_UmZ in pairs (State .win
												dowEspObjects )
													do
													if not  IzWqxqvHvlZ0N_ or not IzWqxqvHvlZ0N_ .Parent
														then RemoveWin
															dowESP (IzWqxqvHvlZ0N_)
														end
													end
													if Config .espWin
														dowEnabled
															then
															for DHpolb, qZzX1UU in ipairs ( Workspace.GetDesc
														endants (Workspace)  )
															do OnWin
																dowAdded( qZzX1UU )
															end
														end
													end task .spawn (
													function ( )task .wait ( 3)RefreshWin
														dowESP(  )
													end )
													local
													function RefreshObjectESP( )
													if not  State.objEspInitialized
														then
														return
													end
													local NlZXb=Config.espGeneratorEnabled or Config .espGeneratorProgressGen
													if  NlZXb
														then
														local IDZnlWm=  {

}
														for vnumNM0N, _UzWHvUnmIOMm in ipairs (State.cachedMapObjects .Generators )
															do
															if  _UzWHvUnmIOMm  and _UzWHvUnmIOMm .Parent
																then
																local _mQQzQwNwo1v_ =UpdateGenerator (_UzWHvUnmIOMm)
																if not _mQQzQwNwo1v_
																	then table ( IDZnlWm , _UzWHvUnmIOMm )
																end
															end
														end State.cachedMapObjects .Generators = IDZnlWm
													else
													for MqunID , MbDUu1 in ipairs ( State.cachedMapObjects .Generators )
														do
														if MbDUu1  and MbDUu1.Parent
															then  RemoveHighlight( MbDUu1 )
															local qnm1q=MbDUu1.FindFirstChild  (MbDUu1 ,"__BolongGenProgress__" )
															if qnm1q
																then qnm1q .Destroy ( qnm1q)
															end MbDUu1 .SetAttribute ( MbDUu1,"__BolongGenLastPct__" , nil)
														end
													end
												end
												if Config .espPalletEnabled
													then
													for pDox0wQ__ ,HX1OUpNlDmxQl  in ipairs ( State .cachedMapObjects  .Pallets )
														do
														if HX1OUpNlDmxQl and HX1OUpNlDmxQl.Parent
															then
															local vzZnp0oQvbwZM=State.cachedPalletMeta [ HX1OUpNlDmxQl]
															if vzZnp0oQvbwZM and not vzZnp0oQvbwZM.isFake
																then  AddHighlight(HX1OUpNlDmxQl, Config .espPalletColor )
															end
														end
													end
												else
												for bOHqqWIbxXDIX, WDpuWDZuwNv in ipairs ( State .cachedMapObjects .Pallets )
													do
													if WDpuWDZuwNv
														then  RemoveHighlight(WDpuWDZuwNv)
													end
												end
											end
											if Config .espHookEnabled
												then
												for  v0WlDvl ,bMmzqquHlp1u in ipairs (State .cachedMapObjects .Hooks )
													do
													if bMmzqquHlp1u and bMmzqquHlp1u .Parent
														then
														local WUvZuQoWmO = State.cachedHookMeshParts [bMmzqquHlp1u ]
														if WUvZuQoWmO
															then
															for D0HXHNZqZZ0I , oxwMo in ipairs (WUvZuQoWmO)
																do  AddHighlight(oxwMo,Config .espHookColor  )
															end
														else AddHighlight(bMmzqquHlp1u ,Config.espHookColor )
													end
												end
											end
										else
										for D0NNI1OZ ,_pIWI1pqn in ipairs (State.cachedMapObjects .Hooks )
											do
											if _pIWI1pqn and _pIWI1pqn.Parent
												then
												local wnmoHo =State.cachedHookMeshParts [ _pIWI1pqn]
												if wnmoHo
													then
													for uHq1WmmODzU0 , DDZpWH in ipairs (wnmoHo)
														do  RemoveHighlight (DDZpWH)
													end
												else RemoveHighlight( _pIWI1pqn)
											end
										end
									end
								end
								if Config.espGateEnabled
									then
									for qMWOo ,MUDbQmnUUIUqZ  in ipairs  (State.cachedMapObjects .Gates )
										do
										if MUDbQmnUUIUqZ and MUDbQmnUUIUqZ.Parent
											then  AddHighlight (MUDbQmnUUIUqZ ,Config .espGateColor )
										end
									end
								else
								for QmuwobOow__N1, lz_XNIUz in ipairs ( State.cachedMapObjects .Gates )
									do
									if lz_XNIUz and lz_XNIUz .Parent
										then RemoveHighlight(lz_XNIUz)
									end
								end
							end
							if Config.espWin
								dowEnabled
									then RefreshWin
										dowESP ( )
										for _qWD_1,_NnnN in pairs (State .win
											dowEspObjects )
												do
												if  _qWD_1 and _qWD_1 .Parentand _NnnN and _NnnN.Parent
													then  pcall (function( )
													local H1Hbwo =Config.espWin
														dowColor_NnnN.Color3 = H1Hbwo _NnnN .Size =_qWD_1 .Size
													end )
												else RemoveWin
													dowESP( _qWD_1 )
												end
											end
										else
										for H0zOZZuMN11, bmvQoqMx in pairs ( State .win
											dowEspObjects )
												do RemoveWin
													dowESP (H0zOZZuMN11)
												end
											end
										end
										local
										function  OqMUXvUHHDu ( )
										local QzNX1nOq = {

}
										local MHbbQ1W0O1lQ=workspace .FindFirstChild ( workspace,"Map" )
										if MHbbQ1W0O1lQ
											then
											for WbXZIID ,bpquZbWbm1QNn in ipairs ( MHbbQ1W0O1lQ .GetDesc
										endants  (MHbbQ1W0O1lQ)  )
											do
											if (bpquZbWbm1QNn .Name == "Window" or  bpquZbWbm1QNn.Name == "VaultPoint" or string (bpquZbWbm1QNn.Name , "Window" ) )
												then
												if bpquZbWbm1QNn .IsA ( bpquZbWbm1QNn, "BasePart" ) or bpquZbWbm1QNn.IsA (bpquZbWbm1QNn ,"Model" )
													then table ( QzNX1nOq,bpquZbWbm1QNn)
												end
											end
										end
									end
									for HXonvQmoQvMDu, WoHDm in ipairs (CollectionService.GetTagged ( CollectionService , "VaultPoint" ) )
										do table ( QzNX1nOq ,WoHDm)
									end
									return QzNX1nOq
								end
								local
								function vlmOH1_X( )
								if not State .antiLoopWin
									dowEnabled
										then
										return
									end
									local WwlXu=ReplicatedStorage.FindFirstChild (ReplicatedStorage , "Remotes" )
									if not WwlXu
										then
										return
									end
									local uXlubH= WwlXu .FindFirstChild (WwlXu,"Window" )
									if not uXlubH
										then
										return
									end
									local BNxUop =uXlubH .FindFirstChild (uXlubH, "VaultEvent" )
									if not BNxUop
										then
										return
									end task .spawn (
									function (  )task.wait ( 1 )
									local OpWnOlZ =OqMUXvUHHDu( )
									for  WMO0QDwO1 ,I0Qm1Z_ in ipairs (OpWnOlZ)
										do task.spawn ( function(  )pcall (
										function ( ) BNxUop:FireServer ( I0Qm1Z_,true )
									end )
								end)task.wait ( 0.05 )
							end
						end )
					end
					local
					function IM_WpzUx1nu( )
					local _DlWvHZ0vz0MuM = ReplicatedStorage .FindFirstChild (ReplicatedStorage, "Remotes" )
					if not _DlWvHZ0vz0MuM
						then
						return
					end
					local qQXNUMnXXbMq= _DlWvHZ0vz0MuM .FindFirstChild (_DlWvHZ0vz0MuM,"Window"  )
					if not qQXNUMnXXbMq
						then
						return
					end
					local lb1u0vOv=qQXNUMnXXbMq.FindFirstChild ( qQXNUMnXXbMq ,"VaultCompleteEvent"  )
					local  umWbnMxH_ =qQXNUMnXXbMq.FindFirstChild ( qQXNUMnXXbMq , "VaultCompleteEventpart1" ) task .spawn (
					function ( )
					local OUMOm0vxbvQm = OqMUXvUHHDu( )
					for MIHUbUuNWN0M , QwH0plnlq1pbZ in ipairs (OUMOm0vxbvQm )
						do task.spawn (function( )pcall (
						function ( )
						if lb1u0vOv
							then lb1u0vOv.FireServer (lb1u0vOv, QwH0plnlq1pbZ ,false)
						end
						if umWbnMxH_
							then umWbnMxH_ .FireServer ( umWbnMxH_)
						end
					end)
				end ) task.wait (0.05)
			end
		end)
	end
		do
		local oUZ1uwZI = workspace .FindFirstChild ( workspace, "Map" )
		if oUZ1uwZI
			then SetupMapESP ( oUZ1uwZI)vlmOH1_X( )
		end workspace .ChildAdded :Connect( function( vmuxlQOU_bMz)
		if  vmuxlQOU_bMz.Name == "Map"
			then task .wait  (2) SetupMapESP(vmuxlQOU_bMz)vlmOH1_X ( )
		end
	end)workspace .ChildRemoved :Connect( function( pMoQmlzpxvZ)
	if pMoQmlzpxvZ.Name =="Map"
		then State .cachedMapObjects = {
 .Generators  = {

} , .Pallets =  {

} , .Hooks = {

} , .Gates = {

}
}State.cachedPalletMeta = {

} ;
		
State.cachedHookMeshParts = {

}State.completedGenerators = {

} ;
		
 State .objEspInitialized  = false State .genIndices =  {

} ;
		
 State.nextGenIndex =1
	end
end)
end RegisterTask( "GenESPUpdater" ,0.2,function(  )
if not  Config.espGeneratorEnabled and not Config.espGeneratorProgressGen
	then
	return
end
for lImD_QD_wnX0M, I_uWOH1lQMwD in ipairs (State.cachedMapObjects .Generators )
	do
	if I_uWOH1lQMwD and I_uWOH1lQMwD.Parent and not State .completedGenerators [I_uWOH1lQMwD ]
		then  UpdateGenerator (I_uWOH1lQMwD)
	end
end
end)
local
function w1mO_U1I_( )
if not getnilinstances
	then Notify ("Error"  , "Executor tidak support getnilinstances()" ,2)
	return
end task .spawn (function( )
local O0QoO_Wzm=ReplicatedStorage.FindFirstChild (ReplicatedStorage , "Remotes" )
if not O0QoO_Wzm
	then
	return
end
local vQn0WDo =O0QoO_Wzm .FindFirstChild (O0QoO_Wzm ,"Pallet" )vQn0WDo= vQn0WDo and vQn0WDo.FindFirstChild ( vQn0WDo ,"PalletDropEvent"  )
if not vQn0WDo
	then
	return
end
local vuHxOW = {

}
local vn_DuoM1MODzZ = {

}
local oIzQXNnZ,b1HUvOU= pcall ( getnilinstances )
if oIzQXNnZ and type ( b1HUvOU) == "table"
	then
	for poU0MQnUvvpw,BIvHI_OwoU1  in ipairs ( b1HUvOU )
		do
		if typeof (BIvHI_OwoU1 )  =="Instance"
			then
			local Q0WQZZINxu_ =BIvHI_OwoU1 .Name
			if Q0WQZZINxu_=="PalletPointSlide" or Q0WQZZINxu_=="palletDropPoint"or Q0WQZZINxu_ =="PalletDropPoint"or Q0WQZZINxu_=="PalletPoint"
				then
				if  not vn_DuoM1MODzZ[ BIvHI_OwoU1 ]
					then table (vuHxOW, BIvHI_OwoU1 ) vn_DuoM1MODzZ [ BIvHI_OwoU1 ] =true
				end
			end
		end
	end
end
for oqDXw, pXzWqqH0mH  in ipairs (workspace .GetDesc
endants ( workspace ) )
	do
	local BX_zp =pXzWqqH0mH.Name
	if BX_zp == "PalletPointSlide"or BX_zp== "palletDropPoint" or BX_zp =="PalletDropPoint" or BX_zp =="PalletPoint"
		then
		if not  vn_DuoM1MODzZ [pXzWqqH0mH ]
			then table (vuHxOW , pXzWqqH0mH) vn_DuoM1MODzZ [ pXzWqqH0mH] =true
		end
	end
end if#vuHxOW == 0
	then
	return
end
for bO0DbZUn, WD1XvmuQHIIDUU in ipairs ( vuHxOW )
	do pcall  ( function( )vQn0WDo :FireServer ( WD1XvmuQHIIDUU)
end )
end
end)
end RegisterTask("AutoDropNearbyPallets" ,0.2,
function ( )
if not State.autoDropNearbyPallets
	then
	return
end
if  State.autoDropCool
	down
		then
		return
	end
	local qMObpUObNM= LocalPlayer .Character
	if not qMObpUObNM
		then
		return
	end
	local ulMZO =qMObpUObNM .FindFirstChild ( qMObpUObNM ,"HumanoidRootPart" )
	if not ulMZO
		then
		return
	end
	local uWZH1 =ReplicatedStorage.FindFirstChild ( ReplicatedStorage ,"Remotes" )
	if not uWZH1
		then
		return
	end
	local _Wxo_lMxWQ_mW =uWZH1.FindFirstChild (uWZH1, "Pallet" ) _Wxo_lMxWQ_mW=_Wxo_lMxWQ_mW and  _Wxo_lMxWQ_mW.FindFirstChild (_Wxo_lMxWQ_mW, "PalletDropEvent"  )
	if not  _Wxo_lMxWQ_mW
		then
		return
	end
	local OxOZOpMuM = ulMZO.Position
	if not State .palletPointsCache or (tick ( ) -State.lastPalletPointScan > 5  )
		then State.lastPalletPointScan  =tick ( ) State.palletPointsCache  = {

}
		local
		function QNxOIbxDOz0Zw ( QzUxX )
		if typeof (QzUxX) ~="Instance"
			then
			return false
		end
		local ublNOzv=QzUxX.Name
		if ublNOzv== "PalletPointSlide"or ublNOzv == "palletDropPoint"or ublNOzv=="PalletDropPoint"or ublNOzv=="PalletPoint"
			then
			return true
		end
		return  false
	end
	if getnilinstances
		then
		local vHXMDQl , OmUlmql_=pcall (getnilinstances )
		if vHXMDQl and type (OmUlmql_ ) =="table"
			then
			for opNlIXw1WmuX,umn0lXxwqn in ipairs (OmUlmql_)
				do
				if QNxOIbxDOz0Zw (umn0lXxwqn )
					then table (State .palletPointsCache  , umn0lXxwqn )
				end
			end
		end
	end
	for MxDZnMQNxnDIH1,wMbNZIo0Ww0wu  in  ipairs (workspace.GetDesc
endants ( workspace) )
	do
	if QNxOIbxDOz0Zw( wMbNZIo0Ww0wu )
		then  table  (State .palletPointsCache ,wMbNZIo0Ww0wu)
	end
end
end
local D0OWzwW0bHpU =nil
local vZxvn = math.huge
for HNXqD = #State.palletPointsCache ,  1 , - 1
	do
	local IDu1WQz = State .palletPointsCache [HNXqD ]
	if not IDu1WQz or not IDu1WQz .Parent
		then table (State.palletPointsCache , HNXqD)
	else
	local  QWNxpHqDXmW= nil pcall ( function( )
	if IDu1WQz.IsA ( IDu1WQz, "BasePart" )
		then QWNxpHqDXmW= IDu1WQz.Position
	else
	if IDu1WQz.IsA (IDu1WQz, "Model" )
		then QWNxpHqDXmW = IDu1WQz.GetPivot  ( IDu1WQz) .Position
	else
	if IDu1WQz .IsA ( IDu1WQz ,"Attachment" )
		then  QWNxpHqDXmW=IDu1WQz.WorldPosition
	end
end)
if not QWNxpHqDXmW
	then
	local IowlHuH=IDu1WQz .FindFirstChildWhichIsA (IDu1WQz, "BasePart" , true)
	if IowlHuH
		then QWNxpHqDXmW=IowlHuH.Position
	end
end
if QWNxpHqDXmW
	then
	local  QubDlvUz_lvMZp = ( QWNxpHqDXmW- OxOZOpMuM) .Magnitude
	if QubDlvUz_lvMZp<vZxvn
		then  vZxvn =QubDlvUz_lvMZp  D0OWzwW0bHpU =IDu1WQz
	end
end
end
end
if D0OWzwW0bHpU  and vZxvn <= 4
	then pcall (
	function ( ) _Wxo_lMxWQ_mW : FireServer(D0OWzwW0bHpU)
end)
for  HqXHp ,WpNv1W in  ipairs (State .palletPointsCache )
	do
	if WpNv1W== D0OWzwW0bHpU
		then table  ( State .palletPointsCache ,HqXHp )break
	end
end State.autoDropCool
	down = true  task .delay ( 2 ,
	function ( ) State .autoDropCool
		down =false
	end)
end
end )
local
function WpblbNNwxMIv (ubvQnDlpZXm0pH , pn0UOxNHUzlD)
if  not Config.hitboxEnabled
	then
	return
end
if not pn0UOxNHUzlD
	then
	return
end
local MmNNHW= GetPlayerRole(ubvQnDlpZXm0pH )
local DQnuNppl = (MmNNHW =="killer" ) and Config.killerHitboxSize or Config .survivorHitboxSize
local  _ZUUNWvwqXD0 = DQnuNppl/ 100
local QpX1WnZv= pn0UOxNHUzlD.FindFirstChild (pn0UOxNHUzlD, "HumanoidRootPart" )
if QpX1WnZv and QpX1WnZv.IsA ( QpX1WnZv, "BasePart" )
	then
	if not  State.hitboxOriginalSizes  [QpX1WnZv ]
		then State.hitboxOriginalSizes  [ QpX1WnZv] = QpX1WnZv .Size
	end
	local MwpMnqqv0= 2
	local _WvUXNNvx = Vector3.new ( MwpMnqqv0 *_ZUUNWvwqXD0 ,MwpMnqqv0*_ZUUNWvwqXD0 , MwpMnqqv0* _ZUUNWvwqXD0 )pcall ( function( ) QpX1WnZv .Size =_WvUXNNvx QpX1WnZv .Transparency  =1 QpX1WnZv .CanCollide  =false
end)
end
end
local
function NnnxXDbZqlOwxv( Bo1Hp,I0WUnxn0Qb )
if not I0WUnxn0Qb
	then
	return
end
local ODDoHNIUQzqnum=I0WUnxn0Qb .FindFirstChild ( I0WUnxn0Qb ,"HumanoidRootPart" )
if ODDoHNIUQzqnum  and ODDoHNIUQzqnum .IsA (ODDoHNIUQzqnum, "BasePart" )
	then
	local BQOuObvwUbw=State.hitboxOriginalSizes [ ODDoHNIUQzqnum]
	if BQOuObvwUbw
		then pcall (function(  )ODDoHNIUQzqnum .Size =BQOuObvwUbw ODDoHNIUQzqnum.Transparency = 1
	end) State.hitboxOriginalSizes [ODDoHNIUQzqnum] =nil
end
end
end
local
function pIWIOMWp( )
if not Config.hitboxEnabled
	then
	return
end
for  HowX_, wNW0I1Z in ipairs  (GetService.GetPlayers (GetService) )
	do
	if wNW0I1Z~= LocalPlayer and wNW0I1Z .Character
		then WpblbNNwxMIv( wNW0I1Z,wNW0I1Z .Character )
	end
end
end
local
function  vXQHOzmuNXl( )
for pMXunI,O0lzqwl  in ipairs (GetService .GetPlayers ( GetService ) )
	do
	if O0lzqwl~= LocalPlayer and O0lzqwl .Character
		then NnnxXDbZqlOwxv(O0lzqwl, O0lzqwl .Character )
	end
end
end
local
function _zWMxWbmXoUxzU( N_lZDH, Dlm1b)
if N_lZDH ==LocalPlayer
	then
	return
end
local uO_1b=Dlm1b and Dlm1b.FindFirstChild (Dlm1b,"HumanoidRootPart" )
if  not uO_1b
	then
	return
end
local OlHHDzUlN=State .hitboxEspObjects [N_lZDH]
if OlHHDzUlN  and OlHHDzUlN .Parent
	then
	if OlHHDzUlN .A
		dornee  ==uO_1b
			then
			return
		end OlHHDzUlN .Destroy (OlHHDzUlN )
	end
	local NHqDUM0n =GetPlayerRole (N_lZDH)
	local IobmwNW = (NHqDUM0n =="killer" )and Config.hitboxEspKillerColor or Config.hitboxEspSurvivorColor
	local IHMnWWzx=Instance.new ( "SelectionBox" ) IHMnWWzx.A
		dornee = uO_1b ;
		
 IHMnWWzx.Color3 =IobmwNW;
		
 IHMnWWzx.LineThickness =0.10 IHMnWWzx.SurfaceTransparency = Config.hitboxEspOutlineOnlyand1or Config.hitboxEspTransparency IHMnWWzx.SurfaceColor3 = IobmwNW;
		
IHMnWWzx.Parent = ESPFolder State .hitboxEspObjects  [ N_lZDH ] = IHMnWWzx
	end
	local
	function QNnzOW0mu( W0D0OMWbUmvH )
	local _M_UMln1wQuuZ= State .hitboxEspObjects [ W0D0OMWbUmvH]
	if _M_UMln1wQuuZ
		then pcall  (function( ) _M_UMln1wQuuZ:Destroy( )
	end ) ;
	
 State.hitboxEspObjects [ W0D0OMWbUmvH ] =nil
end
end
local
function WxWMzlH( )
for wQXOnI , qHHpZ1zv_1_HUb in pairs (State.hitboxEspObjects  )
	do
	if qHHpZ1zv_1_HUb  and qHHpZ1zv_1_HUb.Parent
		then
		local  l_0uXIm= GetPlayerRole (wQXOnI )
		local  INpwHoHvl = ( l_0uXIm=="killer" ) and Config.hitboxEspKillerColoror Config .hitboxEspSurvivorColorqHHpZ1zv_1_HUb.Color3 =INpwHoHvl;
		
 qHHpZ1zv_1_HUb .SurfaceColor3 = INpwHoHvl qHHpZ1zv_1_HUb .SurfaceTransparency = Config.hitboxEspOutlineOnly and 1 or Config .hitboxEspTransparency
	end
end
end
local
function pNzHND( )
for BmMHwNzupXMq,vmwQM in ipairs (GetService .GetPlayers ( GetService) )
	do
	if vmwQM~=LocalPlayer and  vmwQM .Character
		then _zWMxWbmXoUxzU(vmwQM ,vmwQM .Character )
	end
end
end
local
function o1II1HWx0HbZ( )
for WmzlpZ1NvQ_wl,u1vHO in pairs  (State .hitboxEspObjects  )
	do QNnzOW0mu(WmzlpZ1NvQ_wl)
end
end
local
function  WwOu1ZXou0Z( )
if State .SpeedBoost
	then
	local MIqo0wXzxnox =math (State.BoostPercent , 0 ,100) *2
	return BuildNumber * ( 1 +MIqo0wXzxnox / 100 )
end
return BuildNumber
end
local
function qNMQXII ( uDx1MUnXNv,pnHwb)
if not uDx1MUnXNv or not uDx1MUnXNv .Parent
	then
	return
end
if math (uDx1MUnXNv .WalkSpeed -pnHwb) > 0.05
	then pcall (
	function ( ) uDx1MUnXNv .WalkSpeed =pnHwb
end)
end
end
local
function uXupvXZzOImon( )task.spawn  (function( )
local  QqOnNDxpnx , DwMnmDwQ=pcall (
function ( )
return game.GetService ( game ,"ReplicatedStorage" )  : WaitForChild("Remotes" ,  10 )  : WaitForChild("Mechanics" , 10 ) : WaitForChild("Fall"  ,10)
end)
if not QqOnNDxpnx or not  DwMnmDwQ
	then
	return
end
local qzwUuwzp qzwUuwzp = hookmetamethod(game , "__namecall" ,function( OXZXZZO0WHNov,  ... )
local vUzlloUbUI =getnamecallmethod( )
if State.AntiFallSlow and vUzlloUbUI =="FireServer" and rawequal (OXZXZZO0WHNov ,DwMnmDwQ)
	then
	return
end
return qzwUuwzp(OXZXZZO0WHNov, ... )
end)
end )
end
local
function  Nvw0ZDnxoImoH (NvxQWH )
if State .movConns .antiFall
	then State .movConns .antiFall :Disconnect( )
end uXupvXZzOImon( )
if  not  NvxQWH
	then
	return
end pcall (
function ( ) NvxQWH : SetStateEnabled( Enum .HumanoidStateType  .FallingDown , false )
end )State .movConns .antiFall =NvxQWH .StateChanged  :Connect (function( lMW0UbWUM_q ,Mu1uO__bXOnmwU)
if not State .AntiFallSlow
	then
	return
end
if Mu1uO__bXOnmwU == Enum .HumanoidStateType .Landed or  Mu1uO__bXOnmwU == Enum.HumanoidStateType .GettingUp or Mu1uO__bXOnmwU==Enum .HumanoidStateType .FallingDown
	then pcall (function( )NvxQWH :ChangeState( Enum.HumanoidStateType .Running  )
end)qNMQXII ( NvxQWH,WwOu1ZXou0Z (  ) )
end
end)
end
local
function vZW11Xq1xZD_( MlmIp0v)
if State.movConns .antiFall
	then State.movConns .antiFall :Disconnect(  ) ;
	
 State .movConns .antiFall  =nil
end
if MlmIp0v  and MlmIp0v .Parent
	then pcall  (
	function (  )MlmIp0v :SetStateEnabled( Enum.HumanoidStateType .FallingDown , true)
end)
end
end
local
function vqQoXU( NXwX1OX )
if State .movConns .noSlow
	then  State .movConns  .noSlow  :Disconnect( )  ;
	
State.movConns .noSlow =nil
end
if not  NXwX1OX
	then
	return
end
if GetPlayerRole ( LocalPlayer ) == "killer"
	then
	return
end State .movConns .noSlow =NXwX1OX .GetPropertyChangedSignal (NXwX1OX ,"WalkSpeed"  )  : Connect (
function ( )
if not State.NoSlow
	down
		then
		return
	end
	if  GetPlayerRole(LocalPlayer) == "killer"
		then
		return
	end
	local B1WH0pv1bND= LocalPlayer .Character
	if State.safeModeSpeedand B1WH0pv1bND and (B1WH0pv1bND.GetAttribute ( B1WH0pv1bND , "IsHooked"  )or  B1WH0pv1bND.GetAttribute (B1WH0pv1bND ,"IsCarried" )or NXwX1OX.Health <= 50 )
		then
		return
	end
	local _NDbOZMUmmz=WwOu1ZXou0Z( )
	if NXwX1OX .WalkSpeed <_NDbOZMUmmz - 0.05
		then  pcall (function( ) NXwX1OX.WalkSpeed =_NDbOZMUmmz
	end)
end
end)
end
local
function INoz_NoZH (BlMboH)
if not  BlMboH
	then
	return
end
local BWUmzWu= BlMboH .WaitForChild (BlMboH,"Humanoid" , 5 )
if not BWUmzWu
	then
	return
end
if  State.AntiFallSlow
	then Nvw0ZDnxoImoH(BWUmzWu)
end
if  State .NoSlow
	downand GetPlayerRole (LocalPlayer) ~="killer"
		then vqQoXU ( BWUmzWu)
	end
	if State.SpeedBoost
		then
		local _HmxMq0n= WwOu1ZXou0Z( )task .wait (0.15)
		if not State .safeModeSpee
			dor ( BWUmzWu.Health >50 and not ( BlMboH .GetAttribute ( BlMboH,"IsHooked" )or BlMboH .GetAttribute ( BlMboH, "IsCarried"  )  ) )
				then  qNMQXII(BWUmzWu,_HmxMq0n )
			end
		end
	end
	local
	function ox0Np (Duo0IW )
	if not Duo0IW
		then
		return
	end
	local WHQz000HHmxx= Duo0IW.WaitForChild (Duo0IW ,"Humanoid" , 5 )
	if not  WHQz000HHmxx
		then
		return
	end
	if  State .AntiFallSlow
		then Nvw0ZDnxoImoH(WHQz000HHmxx)
	end
	if State.NoSlow
		down and GetPlayerRole(LocalPlayer) ~="killer"
			then vqQoXU( WHQz000HHmxx)
		end
		if State.SpeedBoost
			then
			local WMNoWO=WwOu1ZXou0Z(  ) task.wait ( 0.15) qNMQXII (WHQz000HHmxx , WMNoWO )
		end
	end LocalPlayer .GetPropertyChangedSignal (LocalPlayer,"Team" )  : Connect( function( ) UpdatePlayerRole(LocalPlayer )
	if GetPlayerRole(LocalPlayer) == "killer"and State.movConns .noSlow
		then  State.movConns .noSlow :Disconnect( ) ;
		
 State .movConns .noSlow =nil
	end
end)
local
function NubHIl ( )
if State .moonwalkGui
	then
	return
end
local qHbxuWDvpmqN = LocalPlayer.WaitForChild (LocalPlayer ,"PlayerGui" )
local IWNXqUnODxM =Instance.new ( "ScreenGui" ) IWNXqUnODxM.Name ="BolongHubMoonwalk" IWNXqUnODxM .ResetOnSpawn =false IWNXqUnODxM.Enabled = false IWNXqUnODxM.Parent = qHbxuWDvpmqN
local WpXmOIzQMMbzQ=Instance.new ("Frame" )WpXmOIzQMMbzQ.Name  ="MoonwalkBtns" WpXmOIzQMMbzQ.AnchorPoint =Vector2.new (  1 ,1)WpXmOIzQMMbzQ.Position =UDim2.new ( 1 ,  - 18,1, -170) WpXmOIzQMMbzQ .Size = UDim2.fromOffset  ( 46 ,96)WpXmOIzQMMbzQ.BackgroundTransparency =1 WpXmOIzQMMbzQ .Parent = IWNXqUnODxM
local
function  DZlqz_UlMU_DZ(q_Uq__, unxuMXIw)
local WnoWx = Instance.new ( "ImageButton" ) WnoWx .BackgroundTransparency =1  WnoWx .BorderSizePixel = 0 WnoWx .AutoButtonColor = false  WnoWx.AnchorPoint =Vector2 .new (0.5 , 0 ) WnoWx.Position  =UDim2.new ( 0.5, 0, 0 ,unxuMXIw ) WnoWx .Size =UDim2.fromOffset (  42 , 42) WnoWx .Image  ="rbxassetid://125598796341580" WnoWx .ScaleType =Enum.ScaleType .SliceWnoWx.ImageColor3 =Color3.fromRGB ( 170 ,170 , 170 )WnoWx.ImageTransparency =0.25 WnoWx .Rotation =q_Uq__  WnoWx .Parent =WpXmOIzQMMbzQ
return  WnoWx
end
local Iqnpl_=DZlqz_UlMU_DZ ( -90 ,0 )
local bpXvx1pWwmN0v= DZlqz_UlMU_DZ ( 90 , 50 )
local
function uvZ0wUnuzOz( vovUMqlqwwQO,upHxIppzXMmDo)vovUMqlqwwQO .InputBegan :Connect(
function ( uUIwHuXlp )
if uUIwHuXlp.UserInputType ==Enum.UserInputType  .Touch or uUIwHuXlp.UserInputType == Enum.UserInputType .MouseButton1
	then State.moonwalkMobileDir  = upHxIppzXMmDo vovUMqlqwwQO .ImageColor3 =Color3.fromRGB (255, 255 , 255) vovUMqlqwwQO.ImageTransparency  = 0
end
end)vovUMqlqwwQO.InputEnded : Connect (
function (D_zlDHMpM1Qm)
if D_zlDHMpM1Qm.UserInputType  ==Enum.UserInputType .Touch or D_zlDHMpM1Qm.UserInputType ==Enum.UserInputType .MouseButton1
	then State.moonwalkMobileDir = 0 vovUMqlqwwQO .ImageColor3  =Color3.fromRGB  ( 170  ,  170  , 170 ) vovUMqlqwwQO.ImageTransparency = 0.25
end
end )
end uvZ0wUnuzOz ( Iqnpl_,1) uvZ0wUnuzOz(bpXvx1pWwmN0v ,  -1)State.moonwalkGui =IWNXqUnODxM
end
local
function _ZxmxZqIZ (M0QznbDpv)
if M0QznbDpv.FindFirstChild ( M0QznbDpv,"BolongMoonwalkAlign" )
	then
	return M0QznbDpv.FindFirstChild ( M0QznbDpv,"BolongMoonwalkAlign" )
end
local uWIQwoQ = Instance.new ( "Attachment" )uWIQwoQ .Name = "BolongMoonwalkAtt"uWIQwoQ.Parent =M0QznbDpv
local bXHIObpxqm0QO =Instance.new  ("AlignOrientation" ) bXHIObpxqm0QO.Name ="BolongMoonwalkAlign"bXHIObpxqm0QO .Mode =Enum.OrientationAlignmentMode .OneAttachmentbXHIObpxqm0QO.Attachment0  =uWIQwoQ bXHIObpxqm0QO.MaxTorque = 1000000bXHIObpxqm0QO .Responsiveness = 15 bXHIObpxqm0QO.Parent =M0QznbDpv
return bXHIObpxqm0QO
end
local
function NmlZX ( QUopDNNZIznDu)
local OpUWQOmlI11=QUopDNNZIznDu.FindFirstChild (QUopDNNZIznDu, "BolongMoonwalkAlign" )
local QID01oWbvpQxX =QUopDNNZIznDu .FindFirstChild (QUopDNNZIznDu ,"BolongMoonwalkAtt" )
if OpUWQOmlI11
	then OpUWQOmlI11.Destroy (OpUWQOmlI11)
end
if QID01oWbvpQxX
	then QID01oWbvpQxX .Destroy ( QID01oWbvpQxX)
end
end RegisterTask( "MoonwalkLock" ,0,
function ( uzvIm1Nbnq0HNn)
if not Config.moonwalkEnabled
	then
	return
end
local MvIH1MXQw =LocalPlayer .Character
local Nl1Oo=MvIH1MXQw and MvIH1MXQw .FindFirstChildOfClass (MvIH1MXQw , "Humanoid" )
local WvompqNqHNN=MvIH1MXQw and MvIH1MXQw .FindFirstChild (MvIH1MXQw,"HumanoidRootPart"  )
local  IpHNulHmMqxQv=Workspace.CurrentCamera
if  not Nl1Oo or not  WvompqNqHNN or not IpHNulHmMqxQv
	then
	return
end
local uM1InOuMN1w= 0
if State .moonwalkPCForward
	then  uM1InOuMN1w = 1
end
if State .moonwalkPCBackward
	then uM1InOuMN1w= - 1
end
if State .moonwalkMobileDir ~= 0
	then uM1InOuMN1w =State.moonwalkMobileDir
end
if uM1InOuMN1w==  0
	then
	if not Nl1Oo.AutoRotate
		then Nl1Oo.AutoRotate  =true
	end NmlZX(WvompqNqHNN)
	return
end  Nl1Oo.AutoRotate =false
local _qZXDux = _ZxmxZqIZ( WvompqNqHNN)
local lNwom=IpHNulHmMqxQv .CFrame .LookVector
local vwxXW=Vector3.new  (lNwom .X , 0 ,lNwom.Z  )
if vwxXW.Magnitude > 0.001
	then vwxXW =vwxXW.Unit
	local _MNvOMo = ( uM1InOuMN1w == 1 ) and vwxXW or -vwxXW
	local MM1WOzbQWIuI=CFrame.lookAt (Vector3.new (0 , 0 , 0  ) ,_MNvOMo) _qZXDux .CFrame =MM1WOzbQWIuI
end
end )
local
function D_wqpNMI1MUvm( )State .godEnabled =true ;

 State .godLastHP = nil pcall (
function ( )
local _OqZZIn =LocalPlayer.Character
if _OqZZIn
	then
	local _MnzOx = _OqZZIn.FindFirstChildOfClass (_OqZZIn , "Humanoid" )
	if _MnzOx
		then _MnzOx .SetStateEnabled  (_MnzOx,Enum.HumanoidStateType .Dead ,false) _MnzOx :SetStateEnabled (Enum.HumanoidStateType .Rag
			doll , false ) _MnzOx:SetStateEnabled (Enum .HumanoidStateType .FallingDown , false)
		end
	end
end)
end
local
function HoHNI0HlooDU ( ) State .godEnabled = false;

State.godLastHP = nil pcall (
function ( )
local oumzbxbNXwOpvz = LocalPlayer .Character
if not oumzbxbNXwOpvz
	then
	return
end
local  pxxvOv1zxMwun_ = oumzbxbNXwOpvz .FindFirstChildOfClass ( oumzbxbNXwOpvz ,"Humanoid" )
if not  pxxvOv1zxMwun_
	then
	return
end pxxvOv1zxMwun_.SetStateEnabled ( pxxvOv1zxMwun_ ,Enum.HumanoidStateType .Dead ,true) pxxvOv1zxMwun_ : SetStateEnabled (Enum.HumanoidStateType .Rag
	doll ,true ) pxxvOv1zxMwun_ : SetStateEnabled ( Enum.HumanoidStateType .FallingDown ,true)
end )
end RegisterTask( "GodMode" ,0.2 , function( )
if not State.godEnabled
	then
	return
end
local woWXz=LocalPlayer.Character
if not woWXz
	then
	return
end
local Hn0ZX= woWXz .FindFirstChildOfClass ( woWXz , "Humanoid" )
if not Hn0ZX
	then
	return
end
local _vUQMwUvo =Hn0ZX.MaxHealth
local qq1UI1ND = Hn0ZX .Health
if State .godLastHP ~=nil and qq1UI1ND< State .godLastHPand qq1UI1ND> 0
	then pcall (function( ) Hn0ZX.Health =_vUQMwUvo
end )
end State .godLastHP = Hn0ZX.Healthpcall (
function ( )
local  Hml1MvIo=Hn0ZX.GetState ( Hn0ZX )
if Hml1MvIo== Enum .HumanoidStateType .Dead
	then Hn0ZX.Health = _vUQMwUvo ;
	
Hn0ZX .ChangeState  ( Hn0ZX , Enum.HumanoidStateType .Running ) ;
	
State.godLastHP =_vUQMwUvo
else
if Hml1MvIo ==Enum .HumanoidStateType  .Rag
	doll or Hml1MvIo==Enum.HumanoidStateType .FallingDown
		then Hn0ZX .ChangeState ( Hn0ZX,Enum.HumanoidStateType .GettingUp )
	end
end)
end )
local l_up0NM=  {
 .active = false, .target =nil , .generator =nil
}
local _qx1XlDlWOQQ0H =ReplicatedStorage.Remotes .KillerPerks .kingscourge : WaitForChild("KingScourgeStart" )
local  uOOb1NUXpNnUWv =ReplicatedStorage .Remotes .KillerPerks .kingscourge :WaitForChild ( "KingScourgeEnd" )_qx1XlDlWOQQ0H.OnClientEvent : Connect(
function ( WOHbMonN,MOqXmo, _DzI0UblIDqXnU)l_up0NM.active =true;

 l_up0NM .target  =MOqXmo;

l_up0NM.generator = WOHbMonN
end )uOOb1NUXpNnUWv.OnClientEvent : Connect (function( )l_up0NM .active = false ;

l_up0NM.target = nil ;

l_up0NM.generator  =nil
end )
local
function NWqzXnq_bXuMWN (  )
for HDbNWQzIpQMvXl,QXuowX_bv in ipairs ( {
"SkillCheckPromptGui" , "SkillCheckPromptGui-con"
} )
	do
	local blvqQzXZ =PlayerGui.FindFirstChild (PlayerGui,QXuowX_bv , true )
	if blvqQzXZ
		then
		local QIpONN01=blvqQzXZ.FindFirstChild ( blvqQzXZ,"Check"  ,true)
		if QIpONN01 and QIpONN01.Visible
			then
			return QIpONN01 .FindFirstChild (QIpONN01,"Line" ,true ) , QIpONN01.FindFirstChild  ( QIpONN01 ,"Goal" , true)
		end
	end
end
end
local vQwIl= nil
local
function IXXqZQbU( )
if vQwIl and vQwIl .Parent
	then
	return vQwIl
end
local  p_QNlu = PlayerGui.FindFirstChild  (PlayerGui ,"Survivor-mob" ,true)
if not p_QNlu
	then
	return nil
end
local w_mmNZD_zzm= p_QNlu.FindFirstChild ( p_QNlu ,"Controls" ,true)
if not w_mmNZD_zzm
	then
	return nil
end
local Hp_lD= w_mmNZD_zzm .FindFirstChild  ( w_mmNZD_zzm ,"action" )
if Hp_lD and Hp_lD.IsA  ( Hp_lD, "GuiButton" )
	then  vQwIl =Hp_lD ;
	

	return Hp_lD
end Hp_lD =w_mmNZD_zzm .FindFirstChild (w_mmNZD_zzm ,"Gui-mob" )
if Hp_lD and Hp_lD.IsA (Hp_lD , "GuiButton" )
	then vQwIl=Hp_lD ;
	

	return Hp_lD
end
return  nil
end
local
function WvzWHbWO0NQbwm( )
local uz_lHwI = IXXqZQbU( )
if uz_lHwI and type (firesignal ) == "function"
	then firesignal ( uz_lHwI .MouseButton1Down  )task .delay (0.05 ,
	function ( )
	if  uz_lHwI and  uz_lHwI.Parent
		then firesignal(uz_lHwI .MouseButton1Up ) firesignal ( uz_lHwI .MouseButton1Click  )
	end
end )
return
end
local plplxbp= PlayerGui.FindFirstChild  ( PlayerGui, "check" , true)
if plplxbp  and plplxbp .IsA (plplxbp,"GuiObject" ) and plplxbp.Visible
	then
	local WqplvX1nDUpXq =plplxbp.AbsolutePosition ;
	

	local lQqnH1XlvzQU_X= plplxbp.AbsoluteSize
	local u0wOIZmMzb= GuiService.GetGuiInset  ( GuiService)
	local vpMMpNu = WqplvX1nDUpXq.X +  (lQqnH1XlvzQU_X.X / 2 ) +u0wOIZmMzb.X  ;
	

	local QDp0Hv = WqplvX1nDUpXq .Y + (lQqnH1XlvzQU_X .Y / 2 ) + u0wOIZmMzb.Ypcall (function(  )VirtualInputManager : S
endMouseButtonEvent (vpMMpNu,QDp0Hv,0 , true, game, 1 ) task .wait (0.01 ) VirtualInputManager :S
endMouseButtonEvent( vpMMpNu ,QDp0Hv , 0, false , game ,1)
end )
else VirtualInputManager.S
endKeyEvent (VirtualInputManager ,true, Enum.KeyCode .Space  , false ,game ) task.wait ( ) VirtualInputManager:S
endKeyEvent ( false ,Enum.KeyCode .Space , false, game)
end
end RegisterTask("Generator" , 0,
function ( )
if not Config .autoGenerator
	then
	return
end
local lOUpNUZWxo, bvq0NXowOHZO_ = NWqzXnq_bXuMWN ( )
if not( lOUpNUZWxo  and  bvq0NXowOHZO_)
	then State .instantLastVisible = false State.lastGoalRot = nil State.prevLr = nil
	return
end
local NQowW1ppUUIQX= bvq0NXowOHZO_ .Rotation
local vDDZl= lOUpNUZWxo.Rotation
local uOlbZMnZO_D =tick ( )
local OwQwHQXNo0O =l_up0NM.activeand 0.05 or 0.1
if uOlbZMnZO_D-State.lastPressTime <OwQwHQXNo0O
	then State.prevLr = vDDZl
	return
end
if  Config.autoGeneratorMode =="Instant"
	then
	if not State .instantLastVisible or NQowW1ppUUIQX~=State.lastGoalRot
		then lOUpNUZWxo.Rotation = NQowW1ppUUIQX+ 109 State.lastGoalRot  = NQowW1ppUUIQX State.instantLastVisible =true State.lastPressTime = uOlbZMnZO_D State.lastSkillHit =uOlbZMnZO_D WvzWHbWO0NQbwm ( )
	end
else
local NqplumI= (vDDZl-NQowW1ppUUIQX) % 360
local  pvQNXq = -  1
if State .prevLrand State.lastGoalRot ==NQowW1ppUUIQX
	then pvQNXq= (State .prevLr -NQowW1ppUUIQX) %360
end State.lastGoalRot  =NQowW1ppUUIQX
local pqxWvZp1Q,_lpIZ1OX
if Config .autoGeneratorMode =="Perfect"
	then  pqxWvZp1Q= 102_lpIZ1OX = 116
else
if Config.autoGeneratorMode == "Normal"
	then pqxWvZp1Q= 116_lpIZ1OX =159
else
if Config.autoGeneratorMode == "Random"
	then
	if not  State.ran
		domIsNeutral
			then pqxWvZp1Q= 102 ;
			
_lpIZ1OX= 116
		else pqxWvZp1Q=116;
		
_lpIZ1OX= 159
	end
else
return
end
local NQqNZx_l1MqInm= NqplumI>= pqxWvZp1Q and NqplumI <= _lpIZ1OX
local  HUWmxQ= pvQNXq >= 0and pvQNXq< pqxWvZp1Q and NqplumI >_lpIZ1OX
if NQqNZx_l1MqInm or HUWmxQ
	then
	if HUWmxQ
		then lOUpNUZWxo .Rotation  = NQowW1ppUUIQX+ ( pqxWvZp1Q+ _lpIZ1OX)  / 2
	end State .lastPressTime =uOlbZMnZO_D  State .lastSkillHit =uOlbZMnZO_D WvzWHbWO0NQbwm( )
	if Config .autoGeneratorMode =="Random"
		then State.ran
			domIsNeutral = not State.ran
				domIsNeutral
			end
		end
	end State.prevLr  =vDDZl
end)RegisterTask("GenBtnRefresh" ,2.0 ,function(  )
if  not Config.autoGenerator
	then
	return
end
if not vQwIl or not vQwIl .Parent
	then IXXqZQbU ( )
end
end) RegisterTask("KillerWarn" ,0.1,
function ( )
if not Config .warnEnabled
	then
	local M1pQX= LocalPlayer.Character
	local WuwwMl0ZwnOW=M1pQX and M1pQX .FindFirstChild ( M1pQX ,"HumanoidRootPart" )
	if WuwwMl0ZwnOW
		then
		local HXUxmzH_lZo_Nw=WuwwMl0ZwnOW.FindFirstChild ( WuwwMl0ZwnOW ,"KillerWarn" )
		if  HXUxmzH_lZo_Nw
			then HXUxmzH_lZo_Nw .Destroy  (HXUxmzH_lZo_Nw)
		end
	end
	return
end
local D0zOoIlMOMoOu=LocalPlayer.Character
local uuzNxwU1= D0zOoIlMOMoOu and D0zOoIlMOMoOu.FindFirstChild ( D0zOoIlMOMoOu, "HumanoidRootPart" )
if  not uuzNxwU1
	then
	return
end
local vDXUMOp_=math.huge
for u01Mv,Q1ZWqnvWDm in  pairs ( State.espObjects )
	do
	if u01Mv and u01Mv.Parent
		then
		local u00WwQqZnD= GetPlayerRole (u01Mv )
		if  u00WwQqZnD == "killer"
			then
			local MuW1ubbDIWX= u01Mv.Character
			local IHH0IOWu= MuW1ubbDIWX and MuW1ubbDIWX.FindFirstChild (MuW1ubbDIWX, "HumanoidRootPart" )
			if IHH0IOWu
				then
				local DmvwUODDXx = ( IHH0IOWu .Position - uuzNxwU1 .Position ) .Magnitude
				if DmvwUODDXx<vDXUMOp_
					then vDXUMOp_ =DmvwUODDXx
				end
			end
		end
	end
end
local wpWHInXz=uuzNxwU1 .FindFirstChild ( uuzNxwU1 ,"KillerWarn" )
if vDXUMOp_ <=Config .warnDist1
	then
	local bODN0xqNUQ, Im1ZObOzIZO
	if vDXUMOp_<= Config .warnDist3
		then bODN0xqNUQ= "!!!" ;
		
 Im1ZObOzIZO=Color3.fromRGB ( 255 , 0 ,  0 )
	else
	if vDXUMOp_<=Config .warnDist2
		then bODN0xqNUQ= "!!" ;
		
Im1ZObOzIZO=Color3.fromRGB ( 255 , 80 , 0)
	else  bODN0xqNUQ ="!" ;
	
Im1ZObOzIZO = Color3.fromRGB ( 255 , 160  ,0)
end
if not wpWHInXz
	then wpWHInXz = CreateBillboardLabel ( bODN0xqNUQ , Im1ZObOzIZO,UDim2.new ( 0 , 40,0 , 40 ) , 22  )wpWHInXz .Name = "KillerWarn" ;
	
wpWHInXz .Parent = uuzNxwU1
else wpWHInXz .Label .Text = bODN0xqNUQ;

wpWHInXz.Label .TextColor3 = Im1ZObOzIZO
end
else
if wpWHInXz
	then wpWHInXz.Destroy (wpWHInXz)
end
end )RegisterTask ("ESPValidator"  , 1 ,function( )
for IoO1qDW0,IZ1ZDvo_Z in pairs ( State.espObjects )
	do  UpdatePlayerState( IoO1qDW0 )
end
for HwDwQDNNN1lwZ , onIwXWqmUM in pairs ( State .outlineObjects  )
	do
	if not State .espObjects [HwDwQDNNN1lwZ ]
		then UpdatePlayerState (HwDwQDNNN1lwZ)
	end
end
end)RegisterTask ("ItemESP"  ,0.2,function( )
if  not Config.espItemEnabled
	then
	for uWXIZMUXZbXb_z,WHpQlnxX1qN  in pairs (State.espObjects )
		do
		if WHpQlnxX1qN and WHpQlnxX1qN .itemImageand WHpQlnxX1qN .itemImage  .Visible
			then  WHpQlnxX1qN.itemImage .Visible =false
		end
	end
	return
end
local u1_0_Wm= LocalPlayer .Character
local O1HoQQQ=u1_0_Wm and  u1_0_Wm .FindFirstChild ( u1_0_Wm , "HumanoidRootPart" )
for pNvDMOUUwD,Ol_HX0HwnQ in pairs ( State .espObjects  )
	do
	if Ol_HX0HwnQ and Ol_HX0HwnQ .billboard and Ol_HX0HwnQ .billboard .Parent and Ol_HX0HwnQ.itemBillboard
		then
		if  GetPlayerRole(pNvDMOUUwD) == "killer"
			then
			if Ol_HX0HwnQ .itemImage .Visible
				then Ol_HX0HwnQ .itemImage .Visible = false
			end continue
		end
		local DpoQZuMN=pNvDMOUUwD.Character
		local HwMMXoQn_N_Zz=nil
		if DpoQZuMN
			then
			local qUbOQmW0Zqv =DpoQZuMN .GetAttribute (DpoQZuMN ,"EquippedItem"  )or DpoQZuMN.GetAttribute (DpoQZuMN, "Equippedltem" )
			if type (qUbOQmW0Zqv) =="string"
				then HwMMXoQn_N_Zz=qUbOQmW0Zqv
			else
			if  typeof (qUbOQmW0Zqv) == "Instance"
				then  HwMMXoQn_N_Zz= qUbOQmW0Zqv .Name
			end
		end
		if not HwMMXoQn_N_Zz
			then
			local oUlOXOxN11qq= pNvDMOUUwD .GetAttribute ( pNvDMOUUwD,"EquippedItem" )or pNvDMOUUwD .GetAttribute (pNvDMOUUwD,"Equippedltem" )
			if type ( oUlOXOxN11qq ) =="string"
				then HwMMXoQn_N_Zz=oUlOXOxN11qq
			else
			if typeof ( oUlOXOxN11qq) == "Instance"
				then HwMMXoQn_N_Zz =oUlOXOxN11qq .Name
			end
		end
		local bvDwpuqzxz0xMb=GetItemIcon(HwMMXoQn_N_Zz )
		if bvDwpuqzxz0xMb
			then
			if Ol_HX0HwnQ .itemImage  .Image ~=bvDwpuqzxz0xMb
				then Ol_HX0HwnQ.itemImage .Image =bvDwpuqzxz0xMb
			end
			if O1HoQQQ and DpoQZuMN
				then
				local I_ppnMqlzw1M = DpoQZuMN.FindFirstChild (DpoQZuMN , "HumanoidRootPart" )
				if I_ppnMqlzw1M
					then
					local wQQMNzwZu0NUv=  (O1HoQQQ.Position -I_ppnMqlzw1M.Position ) .Magnitude
					local QqpMlD0n =1.5 + ( ( wQQMNzwZu0NUv / 200 ) * 2) QqpMlD0n =math (QqpMlD0n, 1.5 , 3.5)Ol_HX0HwnQ.itemBillboard .Size =UDim2.new ( QqpMlD0n, 0  , QqpMlD0n, 0 )
				end
			end Ol_HX0HwnQ.itemImage  .Visible = true
		else
		if Ol_HX0HwnQ.itemImage .Visible
			then Ol_HX0HwnQ.itemImage .Visible = false
		end
	end
else
if Ol_HX0HwnQ and Ol_HX0HwnQ .itemImage
	then
	if Ol_HX0HwnQ .itemImage .Visible
		then Ol_HX0HwnQ.itemImage .Visible =false
	end
end
end
end) RegisterTask("SpeedBoost"  , 0, function( )
if not State.SpeedBoost
	then
	return
end
local u1XmoDuomOW=LocalPlayer.Character
if not u1XmoDuomOW
	then
	return
end
local w1HxqnZuI_=u1XmoDuomOW.FindFirstChildOfClass ( u1XmoDuomOW, "Humanoid"  )
if not w1HxqnZuI_
	then
	return
end
if State .safeModeSpeedand(u1XmoDuomOW .GetAttribute ( u1XmoDuomOW, "IsHooked"  )or u1XmoDuomOW.GetAttribute  (u1XmoDuomOW, "IsCarried" )or w1HxqnZuI_.Health <=50 )
	then
	return
end
local Q_XQouQz0nbDn=WwOu1ZXou0Z( )
if Q_XQouQz0nbDn <= 0
	then
	return
end
local MmbNnoxZMDzQlO = BuildNumber * ( math ( State.BoostPercent , 0 , 100 ) / 100) State._jitterFlip = not State ._jitterFlip
local I_uq0bZxpXnHl0=State ._jitterFlipand(Q_XQouQz0nbDn+MmbNnoxZMDzQlO)or Q_XQouQz0nbDn
if math ( w1HxqnZuI_.WalkSpeed  -I_uq0bZxpXnHl0) > 0.1
	then pcall (function( )w1HxqnZuI_ .WalkSpeed =I_uq0bZxpXnHl0
end )
end
end)
local
function vIMwU( lUzXI1W_MDzp, bM110 )
if not lUzXI1W_MDzp or not lUzXI1W_MDzp .Parent
	then
	return  false
end
local bmQH0WuXXIXp=lUzXI1W_MDzp .AbsolutePosition ;


local qOZDlHpZbwmOIp = lUzXI1W_MDzp .AbsoluteSize
local BvnuDUN011nunW= bmQH0WuXXIXp.X +qOZDlHpZbwmOIp.X / 2 ;


local vxOvnDnnn_= bmQH0WuXXIXp.Y + qOZDlHpZbwmOIp .Y / 2
local M_zIooIwOWx=math ( qOZDlHpZbwmOIp .X , qOZDlHpZbwmOIp .Y ) / 2  * 0.8
local ppNZvOQv1_uvnM= bM110.X -BvnuDUN011nunW;


local Nbqpm1 = bM110.Y -vxOvnDnnn_
return( ppNZvOQv1_uvnM *ppNZvOQv1_uvnM+Nbqpm1*Nbqpm1 ) <= ( M_zIooIwOWx* M_zIooIwOWx)
end
local
function _OXuNQQUXO ( MlnmUOplZvIu)
if not MlnmUOplZvIu .IsA ( MlnmUOplZvIu,"ImageButton" )
	then
	return
end
if MlnmUOplZvIu .Name  ~= "Gui-mob"
	then
	return
end
if State._hookedMobButtons [MlnmUOplZvIu]
	then
	return
end State._hookedMobButtons [MlnmUOplZvIu ] =true UserInputService.InputBegan : Connect (
function ( boZzNnz0zQ)
if boZzNnz0zQ .UserInputType  ~=Enum.UserInputType  .Touch
	then
	return
end
if  not vIMwU ( MlnmUOplZvIu , boZzNnz0zQ.Position  )
	then
	return
end State .HoldLockActive  =true
local pHqMIqnwv pHqMIqnwv= UserInputService .InputEnded  : Connect (
function (u1X0Dp )
if  u1X0Dp == boZzNnz0zQ
	then State .HoldLockActive =false pHqMIqnwv .Disconnect (pHqMIqnwv)
end
end)
end)
end
local WlZOm1 = {
 ["Slasher-mob"  ] = true, [ "Masked-mob" ] =true ,  ["Hidden-mob" ] = true, ["Killer-mob" ] =true ,
}
local
function qZlwNbxo1mqQbp(O_vMx_)
if not( O_vMx_ and O_vMx_.IsA (O_vMx_ , "GuiButton" )  )
	then
	return false
end
if  O_vMx_ .Name ~="attack"
	then
	return false
end
local NXQnN,bHWbl =false, false
local _0mDHl_x1 =O_vMx_.Parent
while _0mDHl_x1
	do
	if WlZOm1[ _0mDHl_x1.Name ]
		then NXQnN =true
	end
	if _0mDHl_x1 .Name == "Controls"or _0mDHl_x1.Name == "Control"
		then  bHWbl =true
	end _0mDHl_x1=_0mDHl_x1.Parent
end
return NXQnN and bHWbl
end
local
function  QbpzUuNN( uuo1Iq1IOz )
if State._hookedSlasherButtons [ uuo1Iq1IOz ]
	then
	return
end State._hookedSlasherButtons [ uuo1Iq1IOz]  =true uuo1Iq1IOz.InputBegan :Connect( function(Mn0wNOv1 )
if Mn0wNOv1.UserInputType ==Enum .UserInputType .Touchor Mn0wNOv1.UserInputType ==Enum.UserInputType  .MouseButton1
	then State .HoldLockActive = true
end
end )uuo1Iq1IOz.InputEnded :Connect( function( DmDlQ01zoQ0pMm)
if DmDlQ01zoQ0pMm.UserInputType ==Enum.UserInputType .Touchor DmDlQ01zoQ0pMm .UserInputType ==Enum.UserInputType  .MouseButton1
	then State .HoldLockActive  =false
end
end)
end
local
function BlmXw (qq1OIDUm0WUZ )
for MwqUbIb, wbHHUMmu0 in  ipairs ( qq1OIDUm0WUZ .GetDesc
endants ( qq1OIDUm0WUZ ) )
	do
	if wbHHUMmu0.IsA ( wbHHUMmu0 , "ImageButton"  )and wbHHUMmu0.Name =="Gui-mob"
		then _OXuNQQUXO (wbHHUMmu0)
	end
	if  qZlwNbxo1mqQbp( wbHHUMmu0)
		then  QbpzUuNN (wbHHUMmu0)
	end
end qq1OIDUm0WUZ .Desc
endantAdded : Connect( function(NvuuxwIw11)
if NvuuxwIw11 .IsA  (NvuuxwIw11,"ImageButton" ) and NvuuxwIw11.Name =="Gui-mob"
	then _OXuNQQUXO (NvuuxwIw11 )
end
if qZlwNbxo1mqQbp ( NvuuxwIw11)
	then QbpzUuNN(NvuuxwIw11 )
end
end)
end task.spawn (
function ( )
local WbOqvlDHzqMo1 =LocalPlayer .WaitForChild ( LocalPlayer , "PlayerGui" )BlmXw ( WbOqvlDHzqMo1)
end) UserInputService.InputBegan  :Connect(
function ( D1bHZDoOp, Nw_OOvII)
local NvvvXoOoWO=GetPlayerRole (LocalPlayer) == "killer"
if  NvvvXoOoWO
	then
	if D1bHZDoOp.UserInputType ==Enum.UserInputType .MouseButton1
		then State.HoldLockActive =true
	end
else
if not Nw_OOvII and D1bHZDoOp.UserInputType  == Enum.UserInputType .MouseButton2
	then State .HoldLockActive =true
end
end
if not Nw_OOvII and D1bHZDoOp.UserInputType  == Enum .UserInputType .Gamepad1and  D1bHZDoOp.KeyCode == Enum .KeyCode .ButtonL2
	then State.HoldLockActive =true
end
end )UserInputService .InputEnded  : Connect(
function (qq1nlXWlMxvWqv)
if  qq1nlXWlMxvWqv .UserInputType  ==Enum.UserInputType .MouseButton1or qq1nlXWlMxvWqv .UserInputType ==Enum.UserInputType  .MouseButton2
	then State .HoldLockActive =false
end
if qq1nlXWlMxvWqv.UserInputType == Enum .UserInputType .Gamepad1 and qq1nlXWlMxvWqv .KeyCode ==Enum.KeyCode .ButtonL2
	then State.HoldLockActive = false
end
end) RegisterTask("HoldLock" ,0.2 ,function( )
if not  Config.cameralockEnabled
	then
	return
end
if State .HoldLockActive
	then
	return
end
local ux_uqIIxu0qI= LocalPlayer .Character
if  ux_uqIIxu0qI and ux_uqIIxu0qI.GetAttribute (ux_uqIIxu0qI ,"Aiming" ) ==true
	then State .HoldLockActive =true
end
end)
local
function pnZ0u(pZZlXw_W)
if not  pZZlXw_W
	then
	return nil
end
if  Config.cameralockAimPart =="Head"
	then
	local bpxnqNZDMUwD=pZZlXw_W .FindFirstChild ( pZZlXw_W, "Head" )
	if  bpxnqNZDMUwD
		then
		return bpxnqNZDMUwD.Position
	end
end
local vUN_1Mmwq = pZZlXw_W .FindFirstChild ( pZZlXw_W,"UpperTorso" )
if vUN_1Mmwq
	then
	return vUN_1Mmwq.Position
end
local HDvUQHzWqbW = pZZlXw_W .FindFirstChild  ( pZZlXw_W ,"Torso" )
if HDvUQHzWqbW
	then
	return HDvUQHzWqbW.Position
end
local WNXXWwx_IDWQv= pZZlXw_W .FindFirstChild (pZZlXw_W,"HumanoidRootPart" )
if WNXXWwx_IDWQv
	then
	return WNXXWwx_IDWQv.Position +  (Config.cameralockAimPart == "Head" and Vector3.new ( 0 ,2.5, 0 ) or Vector3.new ( 0 , 1.2, 0 ) )
end
return nil
end
function LIB.IxWX0_XNwuzw ( oUXqlDUX ,HNmZDb , MZ_wIn )
if not HNmZDb or not MZ_wIn or MZ_wIn.Health <= 0
	then
	return false
end
if MZ_wIn .Health <50
	then
	return false
end
if HNmZDb.GetAttribute (HNmZDb , "IsHooked" )
	then
	return false
end
if HNmZDb .GetAttribute ( HNmZDb,"IsCarried" )
	then
	return false
end
if oUXqlDUX.GetAttribute ( oUXqlDUX,"IsHooked" )
	then
	return false
end
if oUXqlDUX .GetAttribute ( oUXqlDUX ,"IsCarried" )
	then
	return false
end
local MOnWUQ= MZ_wIn.GetState (MZ_wIn )
if MOnWUQ==Enum .HumanoidStateType .PlatformStanding
	then
	return false
end
if MOnWUQ == Enum .HumanoidStateType .Physicsand MZ_wIn.PlatformStand
	then
	return false
end
local WQ_v10Uw=HNmZDb .FindFirstChild ( HNmZDb,"HumanoidRootPart" )
if  WQ_v10Uw and WQ_v10Uw.Anchored
	then
	return false
end
return true
end
function LIB._I_mHX_DbX(wZHX1lquluQ)
local unmxOunH= LocalPlayer .Character
local IvIXI =unmxOunH and unmxOunH.FindFirstChild ( unmxOunH, "HumanoidRootPart" )
if not IvIXI
	then
	return nil
end
local  NHHz_Np_I=IvIXI .Position
local IOzl10mHXIwZD =0.1
local  luWoxQW= nil
local IqlObXU1Um=Config .cameralockMaxDistance
if wZHX1lquluQ and wZHX1lquluQ .Character
	then
	local ObWNNHU_nqxW1=wZHX1lquluQ.Character
	local  DqpZbUUNNpn = ObWNNHU_nqxW1.FindFirstChildOfClass  ( ObWNNHU_nqxW1 ,"Humanoid" )
	local H1wmWqzp_zp = pnZ0u(ObWNNHU_nqxW1)
	if  LIB.IxWX0_XNwuzw ( wZHX1lquluQ ,ObWNNHU_nqxW1 , DqpZbUUNNpn )and H1wmWqzp_zp
		then luWoxQW=wZHX1lquluQ IqlObXU1Um= ( H1wmWqzp_zp-NHHz_Np_I) .Magnitude -IOzl10mHXIwZD
	end
end
for WXwlQDm0DpqNq, BDODNH_X in ipairs (GetService.GetPlayers ( GetService ) )
	do
	if BDODNH_X== LocalPlayer
		then continue
	end
	local HOHZqwuXmHZ=BDODNH_X .Character
	if not HOHZqwuXmHZ
		then continue
	end
	local pQzoIHNHxMzm= HOHZqwuXmHZ.FindFirstChildOfClass (HOHZqwuXmHZ , "Humanoid" )
	if not LIB.IxWX0_XNwuzw( BDODNH_X , HOHZqwuXmHZ,pQzoIHNHxMzm )
		then continue
	end
	local  MDQ00mQQ=pnZ0u (HOHZqwuXmHZ )
	if not MDQ00mQQ
		then continue
	end
	local  D0vZlxQ=GetPlayerRole( BDODNH_X)
	if Config.cameralockTargetType =="Killer"and  D0vZlxQ~="killer"
		then  continue
	end
	if Config .cameralockTargetType =="Survivor"and D0vZlxQ~= "survivor"
		then continue
	end
	local uZuxvuzMmHU1= (MDQ00mQQ - NHHz_Np_I ) .Magnitude
	if uZuxvuzMmHU1 < IqlObXU1Um
		then IqlObXU1Um = uZuxvuzMmHU1;
		
luWoxQW = BDODNH_X
	end
end
return  luWoxQW
end
function  LIB.vMvvZ ( )
if State.aimConn
	then State .aimConn : Disconnect ( )
end  State .aimTargetCache =nil;

 State.aimTargetT =0;

 State .aimLastStableDir =nil State .aimConn =Players.R
enderStepped  :Connect (
function ( o1ZuNZqQvU)
if not Config.cameralockEnabled
	then
	return
end
if Config .cameralockLockMode =="Hold to Lock"and not  State.HoldLockActive
	then State.aimTargetCache  = nil;
	
 State.aimLastStableDir =nil;
	

	return
end
local obMOmmun = LocalPlayer .Character
if not obMOmmun
	then
	return
end
local bMbUmX=obMOmmun.FindFirstChild  ( obMOmmun, "HumanoidRootPart" )
if not bMbUmX
	then
	return
end State .aimTargetT  = State .aimTargetT + o1ZuNZqQvU
if State .aimTargetT >= 0.15
	then State .aimTargetT = 0 State .aimTargetCache = LIB._I_mHX_DbX ( State.aimTargetCache )
end
local u1nbUvNIpxHHn=State .aimTargetCache
if not u1nbUvNIpxHHn
	then State .aimLastStableDir = nil;
	

	return
end
local H0X0OqN =u1nbUvNIpxHHn.Character
if not H0X0OqN
	then State.aimTargetCache = nil;
	
 State.aimLastStableDir =nil;
	

	return
end
local pHwDQp0mp= H0X0OqN.FindFirstChildOfClass (H0X0OqN , "Humanoid"  )
if not LIB.IxWX0_XNwuzw( u1nbUvNIpxHHn,H0X0OqN,pHwDQp0mp )
	then State .aimTargetCache =nil ;
	
 State .aimLastStableDir = nil ;
	

	return
end
local oXbDwUZz=pnZ0u (H0X0OqN )
if not oXbDwUZz
	then State.aimTargetCache  = nil ;
	
 State .aimLastStableDir = nil;
	

	return
end
local qwvuWzWzD= workspace .CurrentCamera
if not qwvuWzWzD
	then
	return
end
local  uqXmwpqzouHv =qwvuWzWzD.CFrame
local upWop0lIopWHqX =uqXmwpqzouHv.Position
local QbbXvlw0NNX_Q =uqXmwpqzouHv.LookVector
local oIoux1mMXN = Config.cameralockSmoothness
local vo_pz =oXbDwUZz-upWop0lIopWHqX
local HxxzQNO =vo_pz.Magnitude
local qqIzwHv= ( oXbDwUZz- bMbUmX.Position )  .Magnitude
local BHzUnN0= 4.0
local vOWnw1
if HxxzQNO>=BHzUnN0 and qqIzwHv>=1.5
	then  vOWnw1 = vo_pz.Unit ;
	
 State.aimLastStableDir =vOWnw1
else
if State.aimLastStableDir
	then vOWnw1 =State .aimLastStableDir
else vOWnw1=QbbXvlw0NNX_Q
end
local uOwnb1bpwpz = QbbXvlw0NNX_Q.Lerp ( QbbXvlw0NNX_Q ,vOWnw1 , oIoux1mMXN )
if  uOwnb1bpwpz .Magnitude < 0.001
	then
	return
end qwvuWzWzD.CFrame = CFrame.new (upWop0lIopWHqX ,upWop0lIopWHqX +uOwnb1bpwpz)
local vbMN1DqZz1=obMOmmun.FindFirstChildOfClass (obMOmmun ,"Humanoid" )
if vbMN1DqZz1  and not  vbMN1DqZz1 .AutoRotate
	then
	local b1oOQZlzWoO = qwvuWzWzD.CFrame .LookVector
	local DDvDDoD= bMbUmX.Position
	local DlDqmwXux= Vector3.new (b1oOQZlzWoO .X ,0,b1oOQZlzWoO.Z )
	if  DlDqmwXux .Magnitude > 0.001
		then
		local wpxU_ZXq= math.atan2 ( bMbUmX .CFrame .LookVector .X , bMbUmX .CFrame .LookVector .Z  )
		local D0nqDpM=math.atan2 (DlDqmwXux.X , DlDqmwXux.Z )
		local O0mNz=D0nqDpM-wpxU_ZXq O0mNz = ( (O0mNz + math .pi ) % ( 2 * math.pi ) ) -math .pi
		local WD0UHQmUxpMln=wpxU_ZXq + O0mNz*0.15
		local  B_NHbZ = math.sin  ( WD0UHQmUxpMln )
		local HwnWuwbmz1IU = math.cos (WD0UHQmUxpMln)
		local NDM1ZwIoNpwz1=DDvDDoD+Vector3.new (B_NHbZ, 0 , HwnWuwbmz1IU) *900 bMbUmX.CFrame =CFrame.new ( DDvDDoD, Vector3.new  (NDM1ZwIoNpwz1 .X ,DDvDDoD.Y ,NDM1ZwIoNpwz1.Z ) )
	end
end
end)
end
function  LIB.Hq1wbQvMzoz( )
if State .aimConn
	then State.aimConn : Disconnect( ) ;
	
State .aimConn = nil
end State .aimTargetCache =nil;

State.aimLastStableDir =nil
end
function LIB.w_vnXUZ(wnMNU0bQnlX1 )
if State.originalMaxZoom ==nil
	then State.originalMaxZoom =LocalPlayer.CameraMaxZoomDistance
end LocalPlayer .CameraMaxZoomDistance = wnMNU0bQnlX1
end
function LIB.Ww1z_Ob0vX( )
if  State .originalMaxZoom ~= nil
	then LocalPlayer .CameraMaxZoomDistance =State .originalMaxZoom
end  State.originalMaxZoom =nil
end
function LIB.BWQoHbUwlp0MZb(QQXuQ )
local qI1Uo0IW_o_0=workspace .CurrentCamera
if not qI1Uo0IW_o_0
	then
	return
end
if State.originalFOV ==nil
	then State .originalFOV = qI1Uo0IW_o_0.FieldOfView
end qI1Uo0IW_o_0.FieldOfView  = QQXuQ
end
function  LIB.bxOlDXWlooNM ( )
local D__zvW= workspace.CurrentCamera
if D__zvW and  State .originalFOV
	then D__zvW .FieldOfView = State.originalFOV
end State .originalFOV =nil
end LocalPlayer.GetPropertyChangedSignal  (LocalPlayer , "CameraMaxZoomDistance"  ) : Connect(
function (  )
if Config.cameraZoomEnabledand LocalPlayer.CameraMaxZoomDistance ~= Config .cameraZoomValue
	then LocalPlayer.CameraMaxZoomDistance = Config.cameraZoomValue
end
end)
function LIB.v_NpDbxz ( )
local QqpXnqqD_IwDI =workspace .CurrentCamera
if not QqpXnqqD_IwDI
	then
	return
end  QqpXnqqD_IwDI.GetPropertyChangedSignal (QqpXnqqD_IwDI ,"FieldOfView" ) :Connect ( function( )
if Config .lockFovEnabled and QqpXnqqD_IwDI.FieldOfView ~= Config .customFovValue
	then QqpXnqqD_IwDI .FieldOfView =Config .customFovValue
end
end )
end  LIB.v_NpDbxz ( )
function LIB.vvw0v_lDxx (  )
if UserInputService.TouchEnabledand  not UserInputService .KeyboardEnabled
	then
	return
end State.originalMouseIconEnabled =UserInputService.MouseIconEnabledState .originalMouseBehavior = UserInputService .MouseBehaviorUserInputService.MouseIconEnabled =true UserInputService.MouseBehavior = Enum.MouseBehavior .Default
if State .forceCursorConn1
	then State.forceCursorConn1 :Disconnect( )
end
if State .forceCursorConn2
	then State.forceCursorConn2  : Disconnect( )
end State .forceCursorConn1 =UserInputService.GetPropertyChangedSignal ( UserInputService,"MouseIconEnabled" ) :Connect (function( )
if Config.forceCursorEnabled and not UserInputService.MouseIconEnabled
	then UserInputService .MouseIconEnabled =true
end
end) State .forceCursorConn2 =UserInputService .GetPropertyChangedSignal (UserInputService , "MouseBehavior" ) :Connect (function( )
if Config.forceCursorEnabledand UserInputService .MouseBehavior == Enum.MouseBehavior .LockCenter
	then UserInputService .MouseBehavior = Enum .MouseBehavior .Default
end
end)
end
function  LIB.Bu0oXoOlbI( )
if State.forceCursorConn1
	then State .forceCursorConn1  :Disconnect( ) State.forceCursorConn1  =nil
end
if State.forceCursorConn2
	then State.forceCursorConn2 :Disconnect ( ) State.forceCursorConn2 =nil
end
if  State.originalMouseIconEnabled ~=nil
	then UserInputService.MouseIconEnabled =State .originalMouseIconEnabledState.originalMouseIconEnabled = nil
end
if State.originalMouseBehavior ~= nil
	then  UserInputService.MouseBehavior =State .originalMouseBehaviorState.originalMouseBehavior = nil
end
end
function  LIB.lpZNv1HZpDo ( )
local _zwU1=Instance.new ("ScreenGui" ) _zwU1 .Name ="BolongPerfMon" ;

 _zwU1.ResetOnSpawn = false _zwU1.ZIndexBehavior =Enum.ZIndexBehavior .Sibling  ;

_zwU1.IgnoreGuiInset = false;

_zwU1.Parent =PlayerGui
local wuUN10n = Instance.new ( "Frame" )wuUN10n.Name = "PerfFrame"  ;

 wuUN10n.Size = UDim2.fromOffset (160, 28)wuUN10n.AnchorPoint = Vector2.new ( 1 ,0 )  ;

wuUN10n.Position = UDim2.new  (1, -  10 ,0, 10 ) wuUN10n .BackgroundColor3 =Color3.fromRGB ( 10,  10 ,14 ) ;

wuUN10n.BorderSizePixel = 0 wuUN10n.Active = true;

 wuUN10n.Parent  =_zwU1
local MunOnDvpolHq= Instance.new ( "UICorner" ) ;

MunOnDvpolHq.CornerRadius = UDim.new ( 0 , 8 ) ;

 MunOnDvpolHq.Parent = wuUN10n
local WvqHmqIq0_olI = Instance.new ("UIStroke"  ) ;

WvqHmqIq0_olI .Color = Color3.fromRGB (60, 60 , 75 )WvqHmqIq0_olI.Thickness =1;

WvqHmqIq0_olI .Parent =wuUN10n
local  w_MnQ1HX_ZWp= Instance.new ("TextLabel" ) w_MnQ1HX_ZWp.Name = "InfoLabel" ;

w_MnQ1HX_ZWp.Size  =UDim2.new ( 1 ,0,1 ,  0 )w_MnQ1HX_ZWp.BackgroundTransparency = 1 ;

w_MnQ1HX_ZWp .Text ="FPS — | PING —" w_MnQ1HX_ZWp .TextColor3 = Color3.fromRGB ( 200 , 200 ,210 ) ;

w_MnQ1HX_ZWp .TextSize =12 w_MnQ1HX_ZWp.Font =Enum.Font.GothamBold ;

w_MnQ1HX_ZWp.TextXAlignment =Enum.TextXAlignment .Center w_MnQ1HX_ZWp .TextYAlignment = Enum .TextYAlignment .Center  ;

 w_MnQ1HX_ZWp.RichText =true ;

 w_MnQ1HX_ZWp.Parent  =wuUN10n
local  oDpwnX_M0, pZMUWX0vIvo , WZQxOWUppWIN_ wuUN10n.InputBegan : Connect( function(MW1pNmnNNnzH_Z )
if MW1pNmnNNnzH_Z .UserInputType  == Enum.UserInputType .MouseButton1or MW1pNmnNNnzH_Z .UserInputType ==Enum.UserInputType .Touch
	then oDpwnX_M0 =true;
	
 pZMUWX0vIvo=MW1pNmnNNnzH_Z.Position  ;
	
WZQxOWUppWIN_=wuUN10n .Position
end
end)wuUN10n .InputEnded : Connect(function( oQvqXq_ZHQwq0m)
if oQvqXq_ZHQwq0m .UserInputType ==Enum .UserInputType .MouseButton1 or oQvqXq_ZHQwq0m .UserInputType ==Enum .UserInputType .Touch
	then oDpwnX_M0 =false
end
end)UserInputService.InputChanged : Connect ( function(pD0wWUNNxNw1nl)
if oDpwnX_M0 and(pD0wWUNNxNw1nl.UserInputType ==Enum .UserInputType .MouseMovement or pD0wWUNNxNw1nl.UserInputType == Enum .UserInputType .Touch )
	then
	local p_WuU= pD0wWUNNxNw1nl.Position -pZMUWX0vIvo wuUN10n.Position =UDim2.new ( 1 , WZQxOWUppWIN_ .X .Offset  + p_WuU.X  , 0  ,WZQxOWUppWIN_.Y .Offset  + p_WuU.Y )
end
end )
return _zwU1, w_MnQ1HX_ZWp
end  RegisterTask ("PerfMonitor" ,0.5 , function( )
if not State._perfActive
	then
	return
end
local OqIqzx = math (State._perfFrames /math (State ._perfElapsed  , 0.001) )
local qp_qowHo0x=math (Stats.Network .ServerStatsItem  ["Data Ping" ]  :GetValue(  ) )
local OwZuQz= OqIqzx >=  50and "rgb(80,220,100)" or  OqIqzx >= 30and "rgb(255,200,60)" or "rgb(255,70,70)"
local Bwpmv1X0vXbN = qp_qowHo0x<= 80and  "rgb(80,220,100)" or qp_qowHo0x <= 150 and "rgb(255,200,60)" or "rgb(255,70,70)"
if State .perfGuiand State.perfGui .Parent
	then
	local  oln_x =State.perfGui :FindFirstChild("PerfFrame" ) : FindFirstChild ("InfoLabel" )
	if oln_x
		then oln_x .Text = string  ("<font color=\"%s\">FPS %d</font> <font color=\"rgb(60,60,75)\">|</font> <font color=\"%s\">PING %d</font>"  ,OwZuQz , OqIqzx, Bwpmv1X0vXbN,qp_qowHo0x)
	end
end State ._perfElapsed = 0;

State._perfFrames =0
end)RegisterTask ( "PerfCounter" ,0,
function ( DIbMZOlUq)
if State._perfActive
	then State._perfFrames =State ._perfFrames +1 State ._perfElapsed = State ._perfElapsed + DIbMZOlUq
end
end)
function  LIB.lUwpXW( )
if State.perfGui
	then State.perfGui :Destroy ( )
end
local  N_q1oHobZ,bZXnUXWW = LIB.lpZNv1HZpDo( )State.perfGui =N_q1oHobZ;

 State._perfActive = true State ._perfElapsed = 0 ;

 State._perfFrames =  0
end
function LIB.p_X0zlUul( ) State ._perfActive =false
if State.perfGui
	then State.perfGui : Destroy ( ) ;
	
State .perfGui = nil
end
end
function LIB.M1INum0lnUMMI(BDM1MoZv,Wun_Qbl1)
if not BDM1MoZv
	then
	return nil
end
local QuOZ1HmuZ =BDM1MoZv.GetAttribute (BDM1MoZv, Wun_Qbl1)
if QuOZ1HmuZ~= nil
	then
	return QuOZ1HmuZ
end
local  NZnm_OOHmwv=BDM1MoZv.FindFirstChild (BDM1MoZv, Wun_Qbl1)
if NZnm_OOHmwv
	then
	local OXnw0bl ,vNMUowwZHZ= pcall (function( )
	return NZnm_OOHmwv.Value
end )
if  OXnw0bl
	then
	return  vNMUowwZHZ
end
end
return nil
end
function LIB.HM0v1q1I1Ix ( )
local p_nwvHv=Instance.new ( "ScreenGui" ) p_nwvHv .Name ="BolongPrediction" p_nwvHv .ResetOnSpawn =false p_nwvHv .IgnoreGuiInset  = true p_nwvHv.DisplayOrder = 9999999 p_nwvHv .ZIndexBehavior = Enum.ZIndexBehavior .Sibling
local  b_D0vo = nil pcall (
function ( )b_D0vo= gethui( )
end)
if not b_D0vo
	then pcall (
	function (  ) b_D0vo=game.GetService (game,"CoreGui" )
end )
end
if not b_D0vo
	then b_D0vo = PlayerGui
end p_nwvHv .Parent =b_D0vo
local p_mWOQlv_mpnbU =Instance.new ("TextLabel"  )p_mWOQlv_mpnbU.Name ="InfoLabel"p_mWOQlv_mpnbU.AnchorPoint = Vector2.new (0.5 , 0 )
if State .predLastPos
	then  p_mWOQlv_mpnbU.Position = State.predLastPos
else p_mWOQlv_mpnbU.Position =UDim2.new ( 0.5 ,0, 0 ,50 )
end  p_mWOQlv_mpnbU.BackgroundTransparency = 1 p_mWOQlv_mpnbU .AutomaticSize =Enum.AutomaticSize .XY p_mWOQlv_mpnbU.Text = "Map: — | Killer: —"p_mWOQlv_mpnbU .TextColor3 =Color3.fromRGB (252 ,235 , 229 )p_mWOQlv_mpnbU .TextSize = 14p_mWOQlv_mpnbU .Font = Enum.Font.GothamBold p_mWOQlv_mpnbU .TextXAlignment =Enum.TextXAlignment .Centerp_mWOQlv_mpnbU.TextYAlignment =Enum.TextYAlignment .Centerp_mWOQlv_mpnbU.RichText = true p_mWOQlv_mpnbU.Active =true p_mWOQlv_mpnbU .Parent = p_nwvHv
local  NUplUXvW_n1 =Instance.new ("UIStroke" ) NUplUXvW_n1.Name = "Outline"NUplUXvW_n1 .Color = Color3.new ( 0  ,0, 0 )NUplUXvW_n1.Thickness = 1NUplUXvW_n1.Transparency =0.2 NUplUXvW_n1 .Parent =p_mWOQlv_mpnbU
local oZWNHlN = false
local _bOlv= Vector2.new  ( )
local vqvDIbOuxlnXmm=UDim2.new  ( )p_mWOQlv_mpnbU .InputBegan :Connect (function( OxXUWWNx)
if OxXUWWNx.UserInputType == Enum .UserInputType  .MouseButton1or OxXUWWNx.UserInputType ==Enum.UserInputType .Touch
	then oZWNHlN= true _bOlv= OxXUWWNx .Position vqvDIbOuxlnXmm =p_mWOQlv_mpnbU.Position
end
end)p_mWOQlv_mpnbU.InputEnded :Connect (
function (Wvb1qz1nbu0DHD)
if Wvb1qz1nbu0DHD .UserInputType ==Enum.UserInputType .MouseButton1 or Wvb1qz1nbu0DHD .UserInputType ==Enum.UserInputType .Touch
	then oZWNHlN =false
end
end)UserInputService.InputChanged :Connect (
function (bWI0_ZwlxDnuIz )
if  oZWNHlN and (bWI0_ZwlxDnuIz.UserInputType == Enum .UserInputType .MouseMovementor  bWI0_ZwlxDnuIz .UserInputType ==Enum.UserInputType .Touch )
	then
	local  Wxmb0WxHv =bWI0_ZwlxDnuIz .Position - _bOlv
	local IXM1Onq=UDim2.new (vqvDIbOuxlnXmm .X .Scale , vqvDIbOuxlnXmm .X  .Offset + Wxmb0WxHv.X  ,vqvDIbOuxlnXmm .Y .Scale , vqvDIbOuxlnXmm.Y .Offset + Wxmb0WxHv.Y ) p_mWOQlv_mpnbU.Position = IXM1Onq State.predLastPos = IXM1Onq
end
end)
return p_nwvHv , p_mWOQlv_mpnbU
end
function LIB.IuxHvXo ( )
if  State.predMapInfoConn
	then
	return
end task .spawn (
function ( )
local  bUmxXOoXWvW,BoxunQbqXpN=pcall ( function( )
return ReplicatedStorage.WaitForChild  (ReplicatedStorage,"Remotes"  ,10 ) : WaitForChild( "Messages" , 10 ) :WaitForChild ("Mapinfo" , 10)
end )
if bUmxXOoXWvW and  BoxunQbqXpN and BoxunQbqXpN .IsA  (BoxunQbqXpN,"RemoteEvent" )
	then State .predMapInfoConn = BoxunQbqXpN.OnClientEvent :Connect(
	function ( pOOxbvQ ,OMqmMuMlM )
	if type ( pOOxbvQ ) =="string"and pOOxbvQ~=""
		then State.predMapName =pOOxbvQ
	end
end)
end
end )
end RegisterTask( "PredictionMonitor" , 1 ,function( )
if not  State.predActive
	then
	return
end
if not State.predGuior not State.predGui .Parent
	then
	if State .predGui
		then State .predGui : Destroy ( )
	end
	local  HqwXx,lQlwQp=LIB.HM0v1q1I1Ix ( ) State .predGui = HqwXx State.predInfoLabel = lQlwQp
end
local lpMqNuoQpnlXW= State.predGui :FindFirstChild( "InfoLabel" )
if not lpMqNuoQpnlXW
	then
	return
end
local uvMOwNWODmO = GetService .GetPlayers ( GetService )table.sort ( uvMOwNWODmO ,function( wwqnIom, HqXQOX0Z )
local IWID11wpMp10NW =LIB.M1INum0lnUMMI( wwqnIom ,"AllowKiller" )
local  ouxWp= LIB.M1INum0lnUMMI(HqXQOX0Z,"AllowKiller" )
local OzxW_ZUO = (IWID11wpMp10NW ==false)
local DXoo0_lm1Qx= (ouxWp ==false )
if OzxW_ZUO~= DXoo0_lm1Qx
	then
	return not OzxW_ZUO
end
if  not  OzxW_ZUO and  not DXoo0_lm1Qx
	then
	return (LIB.M1INum0lnUMMI ( wwqnIom, "KillerChance" )or 0 ) > (LIB.M1INum0lnUMMI ( HqXQOX0Z ,"KillerChance" )or 0  )
end
return (LIB.M1INum0lnUMMI ( wwqnIom, "KillerChance" )or0 )  < ( LIB.M1INum0lnUMMI ( HqXQOX0Z ,"KillerChance" ) or  0 )
end)
local Oob0ZvxqMvObw =uvMOwNWODmO [1 ]
local p1Ooz ="<font color=\"rgb(100,110,130)\">—</font>"
if Oob0ZvxqMvObw
	then
	local QQDv1HWQxqUH0=Oob0ZvxqMvObw.Name
	local _IloQ=LIB.M1INum0lnUMMI( Oob0ZvxqMvObw,"SelectedKiller"  )
	local  _bMH1qOQUowNn =LIB.M1INum0lnUMMI ( Oob0ZvxqMvObw, "AllowKiller" )
	if Oob0ZvxqMvObw== LocalPlayer
		then QQDv1HWQxqUH0 ="YOU"
	end
	local _UvMwO___
	if  _bMH1qOQUowNn ==false
		then _UvMwO___= "rgb(255,0,30)"
	else _UvMwO___= "rgb(252,235,229)"
end
if _IloQ and type (_IloQ)  =="string"and _IloQ~=""
	then p1Ooz=string ( "<font color=\"%s\">%s</font> <font color=\"rgb(255,0,30)\">(%s)</font>" , _UvMwO___ , QQDv1HWQxqUH0 ,_IloQ )
else p1Ooz =string ( "<font color=\"%s\">%s</font>"  ,_UvMwO___, QQDv1HWQxqUH0)
end
end
local W_HXo0w=State.predMapName or  "—"lpMqNuoQpnlXW.Text = string ( "<font color=\"rgb(255,210,60)\">Map:</font> <font color=\"rgb(252,235,229)\">%s</font>  <font color=\"rgb(80,80,85)\">|</font>  <font color=\"rgb(255,210,60)\">Killer:</font> %s" , W_HXo0w, p1Ooz )
end )
function LIB.HuQnoUuWpwo (  )
if State .predGui
	then State.predGui :Destroy( )
end State .predMapName = nil  LIB.IuxHvXo( )
local  lHpXvDmmnIH_ ,MH0Qb_oDOxnz= LIB.HM0v1q1I1Ix( )State .predGui =lHpXvDmmnIH_ State .predInfoLabel =MH0Qb_oDOxnz State.predActive =true
end
function LIB.lboDUI( ) State.predActive =false
if State .predMapInfoConn
	then pcall (
	function ( )State .predMapInfoConn :Disconnect (  )
end )State.predMapInfoConn = nil
end
if State .predGui
	then State .predGui : Destroy( ) State .predGui  =nil
end
end CROSSHAIR_STYLES = {
"Dot" ,"Circle" ,"Circle + Dot" , "Plus" ,"Cross (X)" , "T-Shape" ,"Square"
}
	do LIB.HUvmUM1Uu =80 LIB.qqQHNWzvmq =LIB.HUvmUM1Uu / 2LIB.bwDoXvvnnDOn=  {

}
	function LIB.Dq_W0bDW0( ONWD0x_HoHIm , lDH1_zWD ,uXwUONoHZ,D1xwNvNl,QpIn_qbIzoUO, D0xzqUnHp, WZqOuqX1owO, wovbwZWqUq_ )
	local qvxD_= Instance.new ( "Frame" )qvxD_.Name =wovbwZWqUq_  or  "CH_Part" qvxD_.BackgroundColor3 =D0xzqUnHp  qvxD_.BackgroundTransparency =WZqOuqX1owO  qvxD_.BorderSizePixel  = 0 qvxD_.Size = UDim2.fromOffset (math ( 1 , math .round (uXwUONoHZ) ) , math  ( 1,math.round ( D1xwNvNl) ) )qvxD_ .AnchorPoint =Vector2.new (0.5,0.5)qvxD_ .Position = UDim2.fromOffset ( math .round (ONWD0x_HoHIm) ,math .round ( lDH1_zWD ) )
	if QpIn_qbIzoUO~= 0
		then qvxD_ .Rotation = QpIn_qbIzoUO
	end
	return qvxD_
end
function LIB.HIXMnml1M(u1wpZMHv )
return 0.3+ ( math ( u1wpZMHv,1, 100 ) /  100 ) *2.2
end  LIB.bwDoXvvnnDOn.Plus =function(w_uw_N1IWH ,WwlpxwHDMownH,omqbDb )
local vwIODUxbp1qxm= {

}
local voonNm0Zp1zZ=LIB.HIXMnml1M(w_uw_N1IWH )
local bHqx1DwWMDN=math (2 ,math .round ( 2 * voonNm0Zp1zZ ) )
local Oq1WuoOxuIbHH=math ( 8 ,math.round ( 25 *voonNm0Zp1zZ) )
local BMQHXo_upmoNzz =LIB.qqQHNWzvmq table ( vwIODUxbp1qxm, LIB.Dq_W0bDW0( BMQHXo_upmoNzz , BMQHXo_upmoNzz,bHqx1DwWMDN , Oq1WuoOxuIbHH , 0 , WwlpxwHDMownH , omqbDb ) )table (vwIODUxbp1qxm,LIB.Dq_W0bDW0 (BMQHXo_upmoNzz ,BMQHXo_upmoNzz, Oq1WuoOxuIbHH,bHqx1DwWMDN, 0  , WwlpxwHDMownH ,omqbDb ) )
return vwIODUxbp1qxm , {

} , {

}
end LIB.bwDoXvvnnDOn [ "Cross (X)" ] =
function (woMbvvmW0zI, bOXDMW, w0DXINqwM_ )
local NZuZZl = {

}
local I1nxv =LIB.HIXMnml1M(woMbvvmW0zI )
local pwu1Wbx=math (2, math.round ( 2*I1nxv )  )
local qpnvMvHU_0u =math ( 8 ,math .round (  25 *I1nxv ) )
local  NxHvq=LIB.qqQHNWzvmq  table (NZuZZl, LIB.Dq_W0bDW0( NxHvq ,NxHvq,pwu1Wbx , qpnvMvHU_0u, 45 ,bOXDMW,w0DXINqwM_ )  )table (NZuZZl, LIB.Dq_W0bDW0( NxHvq,NxHvq , pwu1Wbx,qpnvMvHU_0u, - 45 ,bOXDMW, w0DXINqwM_) )
return NZuZZl, {

} , {

}
end LIB.bwDoXvvnnDOn.Dot =function(pmzxDvbvOp, bzbxxzMzboM , _lonX )
local DOQpunvllNZ =  {

}
local HnMMZ_bppuolx =LIB.HIXMnml1M ( pmzxDvbvOp )
local BW_NqvuvvN =math ( 3 ,math.round (  8 * HnMMZ_bppuolx) )
local qUMXWDomn1qN=LIB.qqQHNWzvmq
local p_xHDpD= LIB.Dq_W0bDW0(qUMXWDomn1qN,qUMXWDomn1qN ,BW_NqvuvvN ,BW_NqvuvvN, 0 , bzbxxzMzboM, _lonX , "CH_Dot" )
local BWOwOqN=Instance.new ("UICorner" )BWOwOqN .CornerRadius =UDim.new ( 1  , 0)BWOwOqN .Parent = p_xHDpD  table ( DOQpunvllNZ,p_xHDpD)
return DOQpunvllNZ,  {

} , {

}
end LIB.bwDoXvvnnDOn .Circle =function( QmDbvzNOX ,BZHHu,WXIuowDoX )
local Bx0nN, B_DQQN= {

} ,  {

}
local  bUwzb1vlQmbM = LIB.HIXMnml1M( QmDbvzNOX)
local  IOXUOobXHUm = math (4 , math.round  (  12 * bUwzb1vlQmbM) )
local uZoONlOvmDmpp=math  ( 2 ,math .round ( 2 * bUwzb1vlQmbM)  )
local Qww1mmb =LIB.qqQHNWzvmq
local DxHNqp1=Instance.new ("Frame" )DxHNqp1.Name ="CH_Ring" DxHNqp1 .BackgroundTransparency  =1 DxHNqp1.Size = UDim2.fromOffset ( IOXUOobXHUm *  2 ,IOXUOobXHUm* 2 ) DxHNqp1.AnchorPoint =Vector2 .new  (0.5 , 0.5) DxHNqp1 .Position =UDim2.fromOffset (Qww1mmb, Qww1mmb)
local DlmNUmxOHZwZ=Instance.new ( "UICorner"  )DlmNUmxOHZwZ .CornerRadius =UDim.new (1 , 0 )DlmNUmxOHZwZ .Parent =DxHNqp1
local  _lXoOlpMODNn= Instance.new ("UIStroke" ) _lXoOlpMODNn.Name ="CH_Stroke" _lXoOlpMODNn .Color =BZHHu _lXoOlpMODNn.Thickness =uZoONlOvmDmpp _lXoOlpMODNn.Transparency = WXIuowDoX  _lXoOlpMODNn .Parent = DxHNqp1 table  ( Bx0nN,DxHNqp1 ) table ( B_DQQN,_lXoOlpMODNn)
return Bx0nN ,B_DQQN , {

}
end LIB.bwDoXvvnnDOn["Circle + Dot" ] =
function (MUHbWq ,BHnuQH , WvWuvI )
local qp_zZHqNqHu ,qOX1v,WNvNbnnunM0 = {

} , {

} , {

}
local WMUzXnUUW = LIB.HIXMnml1M (MUHbWq )
local DINmW =math (4,math.round ( 12 * WMUzXnUUW ) )
local  OXMlluMquUIXlI=math  ( 2 , math .round ( 2 *WMUzXnUUW )  )
local vquXvOXbDpzWm = math  ( 2 ,math.round (4* WMUzXnUUW ) )
local v_1N1QoqDbq =LIB.qqQHNWzvmq
local  qQ0DMwzZm0ZwMH= Instance.new ("Frame" )qQ0DMwzZm0ZwMH .Name ="CH_Ring"qQ0DMwzZm0ZwMH.BackgroundTransparency =1 qQ0DMwzZm0ZwMH .Size  = UDim2.fromOffset ( DINmW*2 ,DINmW * 2 )qQ0DMwzZm0ZwMH.AnchorPoint = Vector2.new ( 0.5 , 0.5 )qQ0DMwzZm0ZwMH .Position =UDim2.fromOffset (v_1N1QoqDbq , v_1N1QoqDbq )
local Bunuw= Instance.new ( "UICorner" )Bunuw.CornerRadius =UDim.new ( 1 , 0) Bunuw .Parent = qQ0DMwzZm0ZwMH
local o1wuIIZp=Instance.new ( "UIStroke" )o1wuIIZp .Name ="CH_Stroke"o1wuIIZp.Color = BHnuQH o1wuIIZp.Thickness =OXMlluMquUIXlI  o1wuIIZp .Transparency =WvWuvI o1wuIIZp .Parent =qQ0DMwzZm0ZwMH table (qp_zZHqNqHu,qQ0DMwzZm0ZwMH ) table (qOX1v ,o1wuIIZp)
local w0qMvuOzIqZo=LIB.Dq_W0bDW0 (v_1N1QoqDbq ,v_1N1QoqDbq ,vquXvOXbDpzWm, vquXvOXbDpzWm, 0  ,BHnuQH ,WvWuvI , "CH_Dot" )
local IDWDb0OmmxU0o=Instance.new ("UICorner" ) IDWDb0OmmxU0o.CornerRadius = UDim.new ( 1 ,0)IDWDb0OmmxU0o.Parent =w0qMvuOzIqZo table  ( qp_zZHqNqHu,w0qMvuOzIqZo) table ( WNvNbnnunM0 ,w0qMvuOzIqZo )
return qp_zZHqNqHu,qOX1v ,WNvNbnnunM0
end LIB.bwDoXvvnnDOn[ "T-Shape" ] =function(qomNzQ,I1H_pbqZIpxlM ,oOzw1QZm )
local vOZbn= {

}
local wQQNwHNn =LIB.HIXMnml1M ( qomNzQ )
local  u0Xom0MDlxNxO= math ( 2,math .round (2 *wQQNwHNn ) )
local MznQ0Ipb=math  (8, math.round ( 25 * wQQNwHNn ) )
local BZbDMXQlnx=LIB.qqQHNWzvmq
local oWvZ_b=math .round (MznQ0Ipb* 0.25 ) table  (vOZbn ,LIB.Dq_W0bDW0(BZbDMXQlnx, BZbDMXQlnx - oWvZ_b, MznQ0Ipb , u0Xom0MDlxNxO , 0 ,I1H_pbqZIpxlM , oOzw1QZm) ) table ( vOZbn, LIB.Dq_W0bDW0 ( BZbDMXQlnx ,BZbDMXQlnx-oWvZ_b + MznQ0Ipb/2 ,u0Xom0MDlxNxO ,MznQ0Ipb ,0,I1H_pbqZIpxlM, oOzw1QZm ) )
return vOZbn , {

} , {

}
end  LIB.bwDoXvvnnDOn .Square  =function( OnWmXnQw0_ZIWl , BqQII0QM,uq1Huw )
local ImHOou= {

}
local Ml1mXXzzzvH =LIB.HIXMnml1M ( OnWmXnQw0_ZIWl)
local oWZum0I0zx__1= math (2, math.round ( 2 * Ml1mXXzzzvH)  )
local NzqIwHzMZ = math ( 8 , math.round ( 22 *Ml1mXXzzzvH ) )
local  vWQnDmIbqZuq0O=math (3, math.round (NzqIwHzMZ*0.4)  )
local HbuUo_oxN=LIB.qqQHNWzvmq
local ooQNDWIvvN= NzqIwHzMZ / 2table ( ImHOou , LIB.Dq_W0bDW0 ( HbuUo_oxN - ooQNDWIvvN +vWQnDmIbqZuq0O / 2, HbuUo_oxN- ooQNDWIvvN,vWQnDmIbqZuq0O,oWZum0I0zx__1, 0 ,BqQII0QM ,uq1Huw ) )table  (ImHOou , LIB.Dq_W0bDW0(HbuUo_oxN-ooQNDWIvvN,HbuUo_oxN -ooQNDWIvvN+vWQnDmIbqZuq0O / 2 , oWZum0I0zx__1, vWQnDmIbqZuq0O, 0 ,BqQII0QM,uq1Huw) )table (ImHOou,LIB.Dq_W0bDW0(HbuUo_oxN + ooQNDWIvvN -vWQnDmIbqZuq0O/2, HbuUo_oxN- ooQNDWIvvN , vWQnDmIbqZuq0O,oWZum0I0zx__1, 0,BqQII0QM ,uq1Huw) )table ( ImHOou ,LIB.Dq_W0bDW0(HbuUo_oxN + ooQNDWIvvN,HbuUo_oxN -ooQNDWIvvN+ vWQnDmIbqZuq0O / 2 , oWZum0I0zx__1, vWQnDmIbqZuq0O , 0 , BqQII0QM ,uq1Huw) ) table ( ImHOou, LIB.Dq_W0bDW0(HbuUo_oxN -ooQNDWIvvN +vWQnDmIbqZuq0O / 2 ,HbuUo_oxN+ ooQNDWIvvN,vWQnDmIbqZuq0O,oWZum0I0zx__1,  0 , BqQII0QM, uq1Huw)  )table (ImHOou,LIB.Dq_W0bDW0 (HbuUo_oxN-ooQNDWIvvN, HbuUo_oxN+ooQNDWIvvN-vWQnDmIbqZuq0O/ 2 ,oWZum0I0zx__1,vWQnDmIbqZuq0O ,0 ,BqQII0QM,uq1Huw ) ) table ( ImHOou,LIB.Dq_W0bDW0 ( HbuUo_oxN+ooQNDWIvvN -vWQnDmIbqZuq0O / 2 ,HbuUo_oxN + ooQNDWIvvN, vWQnDmIbqZuq0O,oWZum0I0zx__1 , 0,BqQII0QM,uq1Huw) ) table ( ImHOou,LIB.Dq_W0bDW0 ( HbuUo_oxN +ooQNDWIvvN, HbuUo_oxN + ooQNDWIvvN- vWQnDmIbqZuq0O/ 2,oWZum0I0zx__1 ,vWQnDmIbqZuq0O,  0 , BqQII0QM,uq1Huw) )
return ImHOou, {

} , {

}
end LIB.wIxwUXZxX= {

} LIB.wIxwUXZxX.__index = LIB.wIxwUXZxX
function LIB.wIxwUXZxX. new( )
local _voUW1uD_DDp =setmetatable( {

}  ,LIB.wIxwUXZxX) _voUW1uD_DDp .config  = {
  .enabled  = false , .style  ="Plus" , .size =1,  .opacity =1.0 ,  .offsetX = 0 , .offsetY =0 , .color  =Color3.fromRGB ( 255,  255 ,255 ) , .smooth =true , .smoothSpeed  =0.25,
} _voUW1uD_DDp.gui = nil _voUW1uD_DDp.container =nil _voUW1uD_DDp.parent = nil _voUW1uD_DDp .parts = {
 .frames = {

} ,  .strokes = {

}  , .
	dots = {

}
}_voUW1uD_DDp.connections = {

} _voUW1uD_DDp .r
enderConn =nil _voUW1uD_DDp .currentOffset = Vector2 .new ( 0 ,  0 )_voUW1uD_DDp .targetOffset  =Vector2.new ( 0 , 0 ) _voUW1uD_DDp ._frameCount = 0
return _voUW1uD_DDp
end
function LIB.qXo_llDnw( )
local lDpQOQ1 pcall ( function( )
if gethui
	then  lDpQOQ1= gethui ( )
end
end)
if lDpQOQ1 and lDpQOQ1.Parent
	then
	return lDpQOQ1
end pcall (
function ( )lDpQOQ1= game.GetService (game ,"CoreGui"  )
end )
if lDpQOQ1 and lDpQOQ1.Parent
	then
	return lDpQOQ1
end
return PlayerGui
end
function LIB.wIxwUXZxX : _createGui (  )
if self.guiand self.gui .Parent
	then
	return
end
local wvvxMHXUum=Instance.new ("ScreenGui"  )wvvxMHXUum .Name ="BolongCrosshair" wvvxMHXUum .ResetOnSpawn =false  wvvxMHXUum .ZIndexBehavior = Enum.ZIndexBehavior  .SiblingwvvxMHXUum .IgnoreGuiInset =true wvvxMHXUum .DisplayOrder =  999999
local HqMlzvpOqoOuD_ = LIB.qXo_llDnw ( ) wvvxMHXUum .Parent  =HqMlzvpOqoOuD_ self.parent =HqMlzvpOqoOuD_
local bINvn = Instance.new ("Frame" )bINvn.Name = "Container"bINvn .Size =UDim2.fromOffset  (LIB.HUvmUM1Uu, LIB.HUvmUM1Uu )bINvn.AnchorPoint = Vector2 .new (0.5,0.5 ) bINvn .BackgroundTransparency = 1bINvn.BorderSizePixel =0 bINvn.Parent = wvvxMHXUum self .gui  = wvvxMHXUum self .container = bINvn self:_rebuild( )self .targetOffset = Vector2.new ( self.config  .offsetX  ,self.config  .offsetY ) self.currentOffset  =self.targetOffsetself :_updatePosition ( )
end
function LIB.wIxwUXZxX: _rebuild( )
if not self.container
	then
	return
end
for oWuUbuUWQqwD,pno_0qbOnqmlmX in ipairs (self.parts  .frames  )
	do pcall  (
	function ( ) pno_0qbOnqmlmX:Destroy( )
end )
end self .parts = {
 .frames = {

} , .strokes =  {

} , .
	dots = {

}
}
	local  QlIwl1m = LIB.bwDoXvvnnDOn [ self .config .style  ]
	if not  QlIwl1m
		then
		return
	end
	local Mlv1xUlz_ = 1 -self .config .opacity
	local MxpHoNNZU ,_bppDlWHZoUu, w0INlm000IoHn = QlIwl1m(self.config .size ,self.config .color ,Mlv1xUlz_)
	for I0NoNu_NMXMM ,NpDOpZ in ipairs ( MxpHoNNZU )
		do NpDOpZ.Parent =self .containertable (self.parts .frames ,NpDOpZ)
	end
	for bDxlqmWQ0w0Xu,wbvUUQvXqZ  in ipairs  (_bppDlWHZoUu )
		do table ( self.parts .strokes , wbvUUQvXqZ )
	end self.parts .
		dots = w0INlm000IoHn or{

}
	end
	function LIB.wIxwUXZxX :_updateColors ( )
	local  _zlUw= self.config .color
	local  NHZzq1uwonWpH = 1 -self.config .opacity
	local _mqo01v1_ = {

}
	for v_mIXzlq1DzO ,OvqIIIWDl in ipairs (self.parts .
		dots )
			do _mqo01v1_ [ OvqIIIWDl] =true
		end
		for MpM0pqwmo , NOuMMxIXNmZv in ipairs ( self .parts  .frames )
			do
			if NOuMMxIXNmZv and NOuMMxIXNmZv.Parent
				then  NOuMMxIXNmZv .BackgroundColor3 = _mqo01v1_[NOuMMxIXNmZv ]and Color3.fromRGB ( 255 , 255 , 255  ) or _zlUw
				if not  NOuMMxIXNmZv.FindFirstChildWhichIsA (NOuMMxIXNmZv , "UIStroke" )
					then NOuMMxIXNmZv.BackgroundTransparency = NHZzq1uwonWpH
				end
			end
		end
		for IwzQzX0Wwu0Xq,Iw1lZmWbl in ipairs  (self .parts .strokes )
			do
			if  Iw1lZmWbl and  Iw1lZmWbl .Parent
				then  Iw1lZmWbl.Color =_zlUw Iw1lZmWbl.Transparency = NHZzq1uwonWpH
			end
		end
	end
	function LIB.wIxwUXZxX :_updatePosition( )
	if not self.container
		then
		return
	end
	local OM1_zoXmUbp = workspace .CurrentCamera
	if not OM1_zoXmUbp
		then
		return
	end
	local lmpQbqxvWom = OM1_zoXmUbp.ViewportSize self .container .Position =UDim2.fromOffset (lmpQbqxvWom.X * 0.5+ self .currentOffset .X ,lmpQbqxvWom.Y *0.5+self.currentOffset .Y )
end
function LIB.wIxwUXZxX: _hookCamera( )
if self.connections .camViewport
	then self .connections .camViewport :Disconnect (  )self .connections .camViewport = nil
end
local Bmx_0M =workspace.CurrentCamera
if Bmx_0M
	then self.connections .camViewport =Bmx_0M .GetPropertyChangedSignal ( Bmx_0M,"ViewportSize" ) :Connect( function( ) self: _updatePosition(  )
end )
end
end
function LIB.wIxwUXZxX: _setupConnections( )self: _hookCamera(  )while(190* 0 ~=0)
	do
	local  N1U10I_D1m= 416 break
end
if  not  self.connections .camChange
	then self .connections  .camChange =workspace .GetPropertyChangedSignal ( workspace ,"CurrentCamera" ) :Connect ( function( )self:_hookCamera( ) self: _updatePosition( )
end)
end
if  not self .connections .childRemoved
	then self .connections .childRemoved = self.parent .ChildRemoved  :Connect(
	function (DWwXIUzxXuMv_ )
	if DWwXIUzxXuMv_ == self .gui and  self.config  .enabled
		then self .gui = nil self.container = nil  self.parts = {
  .frames = {

} , .strokes = {

} , .
			dots = {

}
} task.wait (0.05 )
			if self .config .enabled
				then self ._createGui (self )
			end
		end
	end)
end
if not self.connections .touchChanged
	then self.connections .touchChanged = UserInputService.GetPropertyChangedSignal (UserInputService,"TouchEnabled" ) :Connect (function( ) self: _updatePosition( )
end )
end
end
function LIB.wIxwUXZxX:_startR
ender( )
if self .r
enderConn
	then
	return
end self .r
enderConn =Players.R
enderStepped :Connect(
function (Dmmbu0N )
if  not self .config .enabled
	then
	return
end
if not self .guior not self .gui  .Parent
	then self._createGui  ( self )
	return
end
if  not self.gui .Enabled
	then  self.gui .Enabled =true
end self ._frameCount =self ._frameCount + 1
if  self ._frameCount % 30 == 0
	then
	local bDZHOluz= false
	for  lDZwwz ,pDmO_wlQZxQ1D  in ipairs (self .parts .frames )
		do
		if  pDmO_wlQZxQ1D and pDmO_wlQZxQ1D.Parent
			then bDZHOluz= true;
			
break
		end
	end
	if not bDZHOluz and #self .parts .frames > 0
		then self._rebuild (self )
	end
end
if self.config .smooth
	then
	local oDpNbQX =self.targetOffset -self .currentOffset
	if oDpNbQX.Magnitude  >0.01
		then
		local HlZW0v10pzl= 1  -math.pow  (  1 -self .config  .smoothSpeed ,Dmmbu0N*60)self.currentOffset =self.currentOffset : Lerp ( self .targetOffset ,HlZW0v10pzl ) self:_updatePosition (  )
	end
end
end)
end
function LIB.wIxwUXZxX: _stopR
ender (  )
if self.r
enderConn
	then self.r
enderConn : Disconnect( )self.r
enderConn = nil
end
end
function  LIB.wIxwUXZxX: SetEnabled (HHuNNHOwp ) self.config .enabled = HHuNNHOwp
if HHuNNHOwp
	then
	if not self.guior not self.gui .Parent
		then self ._createGui ( self)self: _setupConnections( )
	end self.gui .Enabled =true self.targetOffset = Vector2.new ( self .config .offsetX , self .config .offsetY ) self .currentOffset = self .targetOffsetself: _updatePosition( )self: _startR
ender ( )
else self ._stopR
ender ( self)
if self .gui
	then self.gui .Enabled = false
end
end
end
function LIB.wIxwUXZxX: SetStyle( _xxUlHNNMbqqQ)self .config  .style  =_xxUlHNNMbqqQ
if  self.config .enabledand self .gui
	then self._rebuild  ( self)
end
end
function LIB.wIxwUXZxX:SetSize ( QZ0qbzZ )self .config .size = QZ0qbzZ
if self .config .enabledand  self.gui
	then  self._rebuild ( self)
end
end
function LIB.wIxwUXZxX: SetOpacity( bHn_0uUvQzbqlv)self.config .opacity  = bHn_0uUvQzbqlv
if self .config .enabledand self.gui
	then self._updateColors ( self )
end
end
function LIB.wIxwUXZxX :SetColor ( Qbl0QXp) self .config .color =Qbl0QXp
if self .config  .enabled and  self.gui
	then self ._updateColors ( self)
end
end
function LIB.wIxwUXZxX :SetOffsetX(QQoqq)self.config .offsetX = QQoqq  self.targetOffset  = Vector2.new (QQoqq ,self.config .offsetY )
if not self.config .smooth and self.config  .enabled
	then self.currentOffset =self.targetOffset self : _updatePosition( )
end
end
function LIB.wIxwUXZxX : SetOffsetY( OzQwqO0) self.config .offsetY =OzQwqO0 self .targetOffset = Vector2 .new (self .config  .offsetX , OzQwqO0 )
if not self .config .smooth and self .config .enabled
	then  self .currentOffset =self.targetOffsetself:_updatePosition( )
end
end
function LIB.wIxwUXZxX :Destroy( )self.config .enabled = false  self ._stopR
ender ( self )
for pOWvxN_MOIuNMn,uDuwbQ in  pairs ( self .connections )
	do pcall  (
	function ( )uDuwbQ: Disconnect ( )
end)
end self.connections = {

}
if self.gui
	then pcall (
	function ( ) self.gui :Destroy( )
end )
end self.gui =nil self.container = nil  self .parts = {
 .frames  = {

} ,  .strokes = {

} , .
	dots = {

}
}
end LIB.Iw0_ov = LIB.wIxwUXZxX.new ( )
end
function LIB._ouxzuoxpIb_n(HwW1m )
if not State.pnameFakeNames [HwW1m ]
	then
	local wWM0p = ( #State.pnameFakeNames % # HubNames ) +1 State .pnameFakeNames [HwW1m ] = HubNames [wWM0p]
end
return State.pnameFakeNames [ HwW1m]
end
function  LIB.qMpmWHOmoNvm ( H_qzHWHxv,qDpMbIZ0_opH )
if not H_qzHWHxv
	then
	return
end
local  uZl0wuM =H_qzHWHxv.FindFirstChild ( H_qzHWHxv,"Head"  )
if  not uZl0wuM
	then
	return
end
for b0OMuUo,_WqoMOHIIooZo in ipairs (uZl0wuM.GetChildren (uZl0wuM )  )
	do
	if _WqoMOHIIooZo.IsA ( _WqoMOHIIooZo , "BillboardGui" )
		then
		local wbbq0WZ1NU=_WqoMOHIIooZo.FindFirstChildWhichIsA (_WqoMOHIIooZo, "TextLabel" , true)
		if wbbq0WZ1NU
			then wbbq0WZ1NU .Text = qDpMbIZ0_opH
		end
	end
end
local Mu1lNupo_ =H_qzHWHxv.FindFirstChildOfClass ( H_qzHWHxv,"Humanoid" )
if Mu1lNupo_
	then pcall (
	function ( )Mu1lNupo_.DisplayDistanceType =Enum.HumanoidDisplayDistanceType .None
end )
end
end
function  LIB.vwmHN1nIDm0X( qnxNHwOoMvHX1Q,QMxQWH_uM)
if not qnxNHwOoMvHX1Q
	then
	return
end
local Woww0umZ =qnxNHwOoMvHX1Q.FindFirstChild ( qnxNHwOoMvHX1Q, "Head" )
if Woww0umZ
	then
	for IZl_Xzbl,_WQuWlqpomU in ipairs  ( Woww0umZ.GetChildren ( Woww0umZ) )
		do
		if _WQuWlqpomU.IsA  (_WQuWlqpomU , "BillboardGui" )
			then
			local  _QDXXZzQ= _WQuWlqpomU .FindFirstChildWhichIsA (_WQuWlqpomU ,"TextLabel" , true)
			if _QDXXZzQ
				then _QDXXZzQ.Text =QMxQWH_uM
			end
		end
	end
end
local  QvqqzWzX_bbb1N =qnxNHwOoMvHX1Q.FindFirstChildOfClass ( qnxNHwOoMvHX1Q, "Humanoid"  )
if QvqqzWzX_bbb1N
	then pcall  (
	function ( ) QvqqzWzX_bbb1N.DisplayDistanceType  = Enum .HumanoidDisplayDistanceType .Limit
end )
end
end
function LIB.WQWzx ( HwUvOD1vpO )
local HbNHbOb = PlayerGui.FindFirstChild ( PlayerGui ,"Survivor-mob" )
if  not HbNHbOb
	then
	return nil
end
local IHonobMQ1ZMuO= HbNHbOb .FindFirstChild (HbNHbOb , "Frame" )
if not  IHonobMQ1ZMuO
	then
	return nil
end
for omXDOvpulUxWl =1 ,5
	do
	local NWDnzIWH_= IHonobMQ1ZMuO.FindFirstChild ( IHonobMQ1ZMuO ,"Survivor" .. omXDOvpulUxWl)
	if NWDnzIWH_ and NWDnzIWH_ .GetAttribute (NWDnzIWH_ ,"UserId" )  == HwUvOD1vpO
		then
		return  NWDnzIWH_ .FindFirstChild (NWDnzIWH_,"TextLabel" )
	end
end
return nil
end
function LIB.W_vpz( uozOZ )
local bMvNzl = (uozOZ == LocalPlayer )
local bDzWmlp0vZqu=LIB._ouxzuoxpIb_n( uozOZ)
if not  bMvNzl
	then
	if State .espObjects [uozOZ ]
		then State.espObjects  [uozOZ] .nameLabel  .Text =bDzWmlp0vZqu
	end
	if uozOZ .Character
		then LIB.qMpmWHOmoNvm ( uozOZ.Character  , bDzWmlp0vZqu )
	end
end
local pHppQvNo =LIB.WQWzx (uozOZ .UserId )
if pHppQvNo
	then  pHppQvNo .Text = bDzWmlp0vZqu
end
if not bMvNzl  and  not State .pnameNameConns [uozOZ]
	then State.pnameNameConns [uozOZ] =uozOZ.CharacterAdded  : Connect(
	function (HHNWnHp )
	if not State.pnameEnabled
		then
		return
	end
	local OqoqXOvXMv=LIB._ouxzuoxpIb_n(uozOZ )task .wait ( 0.5 )LIB.qMpmWHOmoNvm (HHNWnHp,OqoqXOvXMv )
	if State.espObjects [uozOZ ]
		then State.espObjects [ uozOZ]  .nameLabel .Text =OqoqXOvXMv
	end
	local  p1w1px= LIB.WQWzx(uozOZ.UserId )
	if p1w1px
		then p1w1px .Text =OqoqXOvXMv
	end
end)
end
end
function LIB.HpnnwXmlxZ1(bvIZZmqHzqlIU)
local OpuuIpQuNloOQv= (bvIZZmqHzqlIU==LocalPlayer )
local HqzqI= bvIZZmqHzqlIU.Name
if not OpuuIpQuNloOQv
	then
	if State.espObjects [ bvIZZmqHzqlIU]
		then  State.espObjects [bvIZZmqHzqlIU ] .nameLabel .Text =HqzqI
	end
	if  bvIZZmqHzqlIU .Character
		then  LIB.vwmHN1nIDm0X ( bvIZZmqHzqlIU.Character ,HqzqI)
	end
	if  State .pnameNameConns [bvIZZmqHzqlIU ]
		then State.pnameNameConns [ bvIZZmqHzqlIU] :Disconnect ( )State .pnameNameConns [ bvIZZmqHzqlIU] =nil
	end
end
local BMvwnbvN = LIB.WQWzx (bvIZZmqHzqlIU .UserId  )
if BMvwnbvN
	then BMvwnbvN .Text =HqzqI
end
end
function LIB.DMMn1nInqXml(poHnqZxmQnbq, qovnuZ)
local BZzXo =poHnqZxmQnbq .Name
if State.pnameSlotConns [BZzXo]
	then State.pnameSlotConns [BZzXo ] : Disconnect(  )State.pnameSlotConns [ BZzXo]  =nil
end
local Hb0_oQQz_nN =poHnqZxmQnbq .GetAttribute  ( poHnqZxmQnbq ,"UserId" )
if not Hb0_oQQz_nN
	then
	return
end
local DvXNQu
for vxqq0QI0,OHOqnmx in ipairs (GetService.GetPlayers ( GetService) )
	do
	if OHOqnmx .UserId  == Hb0_oQQz_nN
		then DvXNQu = OHOqnmx;
		
 break
	end
end
if not DvXNQu
	then
	return
end
local  oQo0mubmvDqQDZ =LIB._ouxzuoxpIb_n(DvXNQu )State .pnameSlotConns [ BZzXo] =qovnuZ.GetPropertyChangedSignal  (qovnuZ ,"Text" )  : Connect (function( )
if not State .pnameEnabled
	then
	return
end
local ImqpIoImMOU=poHnqZxmQnbq.GetAttribute  ( poHnqZxmQnbq, "UserId" )
if not ImqpIoImMOU
	then
	return
end
local DqUHDQ
for  puMwpQol ,MwxvlzupIWQbQ in ipairs (GetService.GetPlayers (GetService) )
	do
	if MwxvlzupIWQbQ .UserId == ImqpIoImMOU
		then  DqUHDQ= MwxvlzupIWQbQ;
		
break
	end
end
if not DqUHDQ
	then
	return
end
local bpwUIbo_0Q= LIB._ouxzuoxpIb_n (DqUHDQ )
if qovnuZ.Text ~=bpwUIbo_0Q
	then qovnuZ.Text = bpwUIbo_0Q
end
end )
end
function LIB.q0vOXnXpp0qUQQ( )
for  Q0nXbqlOx, _WpwQ0zpwM1l  in pairs ( State .pnameSlotConns )
	do _WpwQ0zpwM1l .Disconnect ( _WpwQ0zpwM1l )State .pnameSlotConns [ Q0nXbqlOx] = nil
end
local buZDI00Muxxq=PlayerGui.FindFirstChild (PlayerGui ,"Survivor-mob" )
if not buZDI00Muxxq
	then
	return
end
local IzbOINmq00Wq=buZDI00Muxxq.FindFirstChild (buZDI00Muxxq,"Frame" )
if not IzbOINmq00Wq
	then
	return
end
for QnHoI_b= 1, 5
	do
	local Mp0Hn0DQ0N =IzbOINmq00Wq .FindFirstChild (IzbOINmq00Wq,"Survivor" .. QnHoI_b )
	if Mp0Hn0DQ0N
		then
		local  pzb0bqv_HN= Mp0Hn0DQ0N .FindFirstChild ( Mp0Hn0DQ0N , "TextLabel" )
		if  pzb0bqv_HN
			then LIB.DMMn1nInqXml( Mp0Hn0DQ0N,pzb0bqv_HN)
		end
	end
end
end
function LIB.QwZpNwn( )State .pnameEnabled = true
for  OwMpNNWxxunMpZ , _l0NZUbzZIXWWn in ipairs  (GetService.GetPlayers (GetService) )
	do LIB.W_vpz ( _l0NZUbzZIXWWn)
end LIB.q0vOXnXpp0qUQQ( )
if not State.pnameWatchConn
	then  State.pnameWatchConn =PlayerGui .ChildAdded :Connect (function( O_HQZHW )
	if  O_HQZHW .Name =="Survivor-mob"
		then task .wait ( 0.2 )
		if State.pnameEnabled
			then LIB.q0vOXnXpp0qUQQ ( )
			for Q1MUwn,IulHOZWx in ipairs ( GetService .GetPlayers  (GetService ) )
				do LIB.W_vpz(IulHOZWx)
			end
		end
	end
end )
end
if  not State .pnameAddedConn
	then State.pnameAddedConn = GetService .PlayerAdded :Connect ( function(IqO0xXDuuuv)
	if State .pnameEnabled
		then task.wait ( 1 ) LIB.W_vpz(IqO0xXDuuuv )LIB.q0vOXnXpp0qUQQ(  )
	end
end )
end
end
function LIB.lOqqxMquzxn_( )State .pnameEnabled =false
for OUqpx,HZuZOlDQ0xW  in pairs ( State .pnameSlotConns )
	do HZuZOlDQ0xW.Disconnect (HZuZOlDQ0xW )State .pnameSlotConns [OUqpx ] = nil
end
if State.pnameWatchConn
	then State .pnameWatchConn : Disconnect( ) State .pnameWatchConn = nil
end
for HZUvoZ1l00lHqm,_UpuNvX in ipairs  (GetService .GetPlayers (GetService ) )
	do LIB.HpnnwXmlxZ1( _UpuNvX)
end State .pnameFakeNames = {

}
if State .pnameAddedConn
	then  State.pnameAddedConn  :Disconnect( ) State .pnameAddedConn =nil
end
end
function  LIB.oqWmXqpHU (lWquoZN ) lWquoZN =lWquoZN or false
local WN1DIxbx=Workspace.CurrentCamera
local DWuXW=State.skipEndScreenConns
local wUIpxbuZXHNw = false
local wmHq1xDNo1H =false
local Oxl0NMnQ =false  pcall (
function ( )
local DIu_wnmXXpwlwq =ReplicatedStorage.FindFirstChild ( ReplicatedStorage,"Remotes" )
if  not DIu_wnmXXpwlwq
	then
	return
end
local
function  vXqQwb_N(BlxbvHpU)
if BlxbvHpU and BlxbvHpU.IsA ( BlxbvHpU , "RemoteEvent" )
	then
	for vwX0p_bIm_Uv,QoDbHvpw1b  in ipairs (getconnections(BlxbvHpU.OnClientEvent ) )
		do QoDbHvpw1b.Disable (QoDbHvpw1b )QoDbHvpw1b: Disconnect ( )
	end
end
end
local BZXxIXl1= DIu_wnmXXpwlwq.FindFirstChild ( DIu_wnmXXpwlwq , "Game" )
if BZXxIXl1
	then
	for WOHQQHZQo , qvlZuZZQUwOX in ipairs (  {
"cutscene" ,"cutsceneEnd" ,"cutsceneEnd2" ,"endscreencutscene" ,"cutsceneEndwithownchar"  ,"shake"
} )
		do vXqQwb_N( BZXxIXl1.FindFirstChild (BZXxIXl1,qvlZuZZQUwOX) )
	end
end
local HMnNm= DIu_wnmXXpwlwq.FindFirstChild ( DIu_wnmXXpwlwq, "Killers" )
if HMnNm
	then vXqQwb_N(HMnNm.FindFirstChild  ( HMnNm,"Startmori" ) )
end
if lWquoZN
	then vXqQwb_N (DIu_wnmXXpwlwq .FindFirstChild (DIu_wnmXXpwlwq , "Darkness2" ) )
end
end )
local
function WvxNv0n( )
if not WN1DIxbx
	then
	return
end
if WN1DIxbx .CameraType ==Enum.CameraType .Scriptable
	then wUIpxbuZXHNw =true WN1DIxbx .CameraType =Enum .CameraType .Custom wUIpxbuZXHNw=false
end
end
if WN1DIxbx
	then WvxNv0n( ) table ( DWuXW,WN1DIxbx.GetPropertyChangedSignal ( WN1DIxbx, "CameraType"  ) : Connect( function( )
	if not  wUIpxbuZXHNw
		then WvxNv0n ( )
	end
end) ) table (DWuXW , WN1DIxbx.GetPropertyChangedSignal ( WN1DIxbx ,"FieldOfView" ) :Connect(function( )
if wmHq1xDNo1H or  Config.lockFovEnabled
	then
	return
end
if  WN1DIxbx.FieldOfView ~=  70
	then wmHq1xDNo1H= true WN1DIxbx .FieldOfView  =70 wmHq1xDNo1H =false
end
end)  )
end  table ( DWuXW, Workspace .GetPropertyChangedSignal ( Workspace,"CurrentCamera" ) : Connect(
function ( )WN1DIxbx =Workspace.CurrentCamera
if WN1DIxbx
	then WvxNv0n ( )
end
end) ) table  (DWuXW ,LocalPlayer.GetAttributeChangedSignal ( LocalPlayer,"isspectating" ) :Connect(
function ( )
if Oxl0NMnQ
	then
	return
end
if  LocalPlayer.GetAttribute ( LocalPlayer, "isspectating" )
	then Oxl0NMnQ = true LocalPlayer .SetAttribute ( LocalPlayer,"isspectating" , false)Oxl0NMnQ =false
end
end ) )table  ( DWuXW ,LocalPlayer .GetAttributeChangedSignal (LocalPlayer,"killerend" )  : Connect (
function ( )
if Oxl0NMnQ
	then
	return
end
if  LocalPlayer.GetAttribute (LocalPlayer , "killerend" )
	then Oxl0NMnQ = true LocalPlayer.SetAttribute ( LocalPlayer , "killerend"  ,false ) Oxl0NMnQ =false
end
end ) )
local
function ONMOlOHl( )
local wq_Xn_W_W=Workspace.FindFirstChild (Workspace , "Map" )
if wq_Xn_W_W
	then
	local  lZZOpQMDDMqx= wq_Xn_W_W .FindFirstChild ( wq_Xn_W_W , "endscreen" )
	if  lZZOpQMDDMqx
		then pcall  (function( ) lZZOpQMDDMqx .Parent = nil
	end)
end
end
local DpxuZUpDNUon01= Workspace .FindFirstChild ( Workspace,"BackgroundSounds" )
if DpxuZUpDNUon01
	then  pcall (
	function ( )DpxuZUpDNUon01:Destroy( )
end )
end
end  ONMOlOHl( ) table (DWuXW, Workspace.Desc
endantAdded :Connect( function(wzNnNH)
if wzNnNH .Name =="endscreen" and wzNnNH .Parent and  wzNnNH.Parent .Name  =="Map"
	then task .wait (0.01 ) pcall ( function( )wzNnNH.Parent = nil
end)
else
if  wzNnNH .Name == "BackgroundSounds"
	then pcall (
	function ( ) wzNnNH:Destroy ( )
end )
end
end) )
local
function qDXQqNpOx_x( NMMoDNmv1Iz1o )
if not  NMMoDNmv1Iz1o or not NMMoDNmv1Iz1o.Parent
	then
	return
end pcall ( function( )
if lWquoZN and NMMoDNmv1Iz1o.Name =="Darkness"and NMMoDNmv1Iz1o .IsA (NMMoDNmv1Iz1o,"ScreenGui" )
	then  NMMoDNmv1Iz1o .Enabled =false
end
for vqwOp ,WONuHmwUDU0O in ipairs (NMMoDNmv1Iz1o .GetDesc
endants ( NMMoDNmv1Iz1o) )
	do
	if WONuHmwUDU0O.IsA  (WONuHmwUDU0O ,"VideoFrame" )
		then WONuHmwUDU0O.Destroy (WONuHmwUDU0O )
	else
	if WONuHmwUDU0O.IsA ( WONuHmwUDU0O, "Frame" ) and(WONuHmwUDU0O.Name =="Frame2" or  WONuHmwUDU0O .Name == "blackout" )
		then WONuHmwUDU0O .BackgroundTransparency = 1
		if lWquoZN
			then WONuHmwUDU0O .Visible =false WONuHmwUDU0O .GetPropertyChangedSignal ( WONuHmwUDU0O,"BackgroundTransparency" ) : Connect (function( )
			if WONuHmwUDU0O.BackgroundTransparency  < 1
				then WONuHmwUDU0O .BackgroundTransparency =1
			end
		end ) WONuHmwUDU0O :GetPropertyChangedSignal ("Visible" ) :Connect(
		function ( )
		if WONuHmwUDU0O.Visible
			then WONuHmwUDU0O.Visible =false
		end
	end )
end
else
if WONuHmwUDU0O .IsA (WONuHmwUDU0O, "ParticleEmitter" ) or  WONuHmwUDU0O.IsA (WONuHmwUDU0O ,"Beam" ) or WONuHmwUDU0O.IsA ( WONuHmwUDU0O ,"Trail" )
	then WONuHmwUDU0O .Enabled =false
end
end
end )
end
for uvuZn1xzp1, wozm_ in  ipairs (PlayerGui .GetChildren ( PlayerGui ) )
	do
	local QqbIpDxWl0 =wozm_.Name
	if QqbIpDxWl0== "Darkness"or  QqbIpDxWl0=="EndScreen"or  QqbIpDxWl0== "Cutscene" or QqbIpDxWl0=="Results"
		then qDXQqNpOx_x(wozm_)
	end
end table (DWuXW ,PlayerGui.ChildAdded :Connect (function(uWzlDzNNHHXImM )
local pnHZUz = uWzlDzNNHHXImM .Name
if pnHZUz=="Darkness"or pnHZUz == "EndScreen" or pnHZUz =="Cutscene" or pnHZUz=="Results"
	then task.wait ( 0.05) qDXQqNpOx_x (uWzlDzNNHHXImM)
end
end) )
end
function LIB.Wb0x1XpWv (  )
for pDWH_oX ,M1oqpNNIzXw in ipairs  (State .skipEndScreenConns )
	do pcall (function( )M1oqpNNIzXw:Disconnect( )
end)
end table .clear ( State .skipEndScreenConns )
end
	do LIB.DUpNoHpX0DZv = {
 [ 78432063483146] =true, [ 121216847022485 ]  = true, [74968262036854 ] =true, [  132817836308238  ]  = true , [ 82666958311998 ] =true , [ 111920872708571 ]  =true, [ 106871536134254 ] = true, [ 109402730355822 ] =true ,  [ 130593238885843 ] =true, [ 138720291317243 ] =true, [139369275981139] =true, [ 133963973694098 ] =true, [ 78935059863801 ] = true
} LIB.BOouUDMI0x= {
 [ 118907603246885 ] =true , [ 135002183282873] = true, [ 113255068724446  ] =true, [ 129784271201071 ] = true,  [ 105374834496520 ] =true , [ 117070354890871  ] = true , [ 115244153053858 ] =true , [ 110355011987939 ] = true,  [  117042998468241 ] = true,  [ 122812055447896] =true
}LIB.IxW_Dmx_ZxU1Uv= {

}
	for vWpqDlOU , DbvDb  in pairs (LIB.DUpNoHpX0DZv )
		do  LIB.IxW_Dmx_ZxU1Uv [ "rbxassetid://" ..vWpqDlOU ] = "attack"
	end
	for BvMIwlOuzI ,l0mUwom in pairs (LIB.BOouUDMI0x)
		do LIB.IxW_Dmx_ZxU1Uv ["rbxassetid://" ..BvMIwlOuzI ] ="lungehold"
	end
	function LIB.MQQuzxZ (BoupqvXnz_x1p, BwM_obqOH )
	if not BoupqvXnz_x1p or not BwM_obqOH
		then
		return nil
	end
	if  BoupqvXnz_x1p ==LocalPlayer
		then
		local lzxnow=LocalPlayer.GetAttribute (LocalPlayer, "SelectedKiller" )
		if lzxnow
			then
			return lzxnow
		end
	end
	local QMlo_ ,IOwmIw0XqnN =pcall  ( function(  )
	return BwM_obqOH .WaitForChild ( BwM_obqOH, "Values" , 2 )
end )
if QMlo_ and IOwmIw0XqnN
	then
	local  obxvpHlNpO1=IOwmIw0XqnN.FindFirstChild (IOwmIw0XqnN ,"KillerName" )
	if  obxvpHlNpO1 and obxvpHlNpO1 .IsA ( obxvpHlNpO1,"StringValue" )
		then
		return  obxvpHlNpO1.Value
	end
end
local b0qxHOQml= BoupqvXnz_x1p.GetAttribute (BoupqvXnz_x1p,"SelectedKiller" )
if b0qxHOQml
	then
	return  b0qxHOQml
end
return nil
end
function LIB.pqpqo_mIXXOmqz ( )
if not State .autoParryEnabled
	then
	return
end
if  tick( ) -State.lastParryTime < 0.15
	then
	return
end State.lastParryTime =tick( )
local  HZXzvW1Q=LocalPlayer.Character
if not HZXzvW1Q
	then
	return
end
local NwvbQ=PlayerGui .FindFirstChild ( PlayerGui,"Survivor-mob" )
local oN1wpoNpW=NwvbQ and NwvbQ .FindFirstChild  (NwvbQ , "Controls"  )
local BOnnQwbwHDv =oN1wpoNpW and oN1wpoNpW .FindFirstChild (oN1wpoNpW ,"Gui-mob" )
if BOnnQwbwHDv and BOnnQwbwHDv.IsA  (BOnnQwbwHDv, "ImageButton" )
	then firesignal(BOnnQwbwHDv.MouseButton1Down )task.delay  (0.05, function( )
	if BOnnQwbwHDv and BOnnQwbwHDv .Parent
		then firesignal( BOnnQwbwHDv.MouseButton1Up )
	end
end)
else
local QMwHUl, WH_Up = pcall (
function ( )
local H0ZZnwzbDquX =Instance.new ( "InputObject" )H0ZZnwzbDquX.UserInputType = Enum.UserInputType  .MouseButton2 H0ZZnwzbDquX.UserInputState =Enum .UserInputState .Begin
return H0ZZnwzbDquX
end)
if QMwHUl and WH_Up
	then
	for p__omXqm_1 ,vHouMQob in getconnections(UserInputService.InputBegan )
		do vHouMQob .Fire  ( vHouMQob, WH_Up, false )
	end
else  VirtualInputManager .S
endMouseButtonEvent ( VirtualInputManager,0 , 0, 1 ,true, game,0)
end
end
local  bM_llmmwDO =HZXzvW1Q .FindFirstChild  ( HZXzvW1Q, "HumanoidRootPart"  )
if bM_llmmwDO
	then task.defer ( function(  )pcall ( function( )
	if CollectionService.HasTag ( CollectionService ,bM_llmmwDO , "doing action" )
		then CollectionService.RemoveTag  ( CollectionService ,bM_llmmwDO, "doing action" )
	end
end)
end)
end
end
function LIB.omXXOoIZHO1( l0quv ,p_IIuz0Oz1)
local  buDlWNZXDnox=LocalPlayer.Character
if not  buDlWNZXDnox
	then
	return
end
local NmzOx =buDlWNZXDnox .FindFirstChild ( buDlWNZXDnox,"HumanoidRootPart" )
if not NmzOx
	then
	return
end
local wD1oHz_1vZq=l0quv .FindFirstChild ( l0quv,"HumanoidRootPart" )
if not wD1oHz_1vZq
	then
	return
end
local BxWzZ =GetService .LocalPlayer : GetNetworkPing( )
local bOWzXoMQXqZ = math (BxWzZ, 0  , 0.3 )
local MZ1MZvlM1 = wD1oHz_1vZq .AssemblyLinearVelocity
local  wzoDQ00vMU=Vector3.new ( MZ1MZvlM1 .X , 0 , MZ1MZvlM1 .Z  )
local W_lN_NxoZbHXQ=wD1oHz_1vZq .Position + ( wzoDQ00vMU*bOWzXoMQXqZ )
local wbH0u1pHqDZx=NmzOx.Position - W_lN_NxoZbHXQ
local u1lIvNoWDx_b =wbH0u1pHqDZx.Magnitude
local bO1lIXIqUM_ =State.autoParryRadius + 2
if u1lIvNoWDx_b> bO1lIXIqUM_
	then
	return
end
local OoUQxmUw = (NmzOx .Position -wD1oHz_1vZq .Position ) .Unit
if wzoDQ00vMU .Magnitude >8
	then
	local oO0QN =wzoDQ00vMU.Unit : Dot(OoUQxmUw)
	if oO0QN< -0.1
		then
		return
	end
end
if u1lIvNoWDx_b >= 15
	then
	local WwUMZxZHnUD =RaycastParams .new ( )WwUMZxZHnUD .FilterDesc
endantsInstances = {
buDlWNZXDnox, l0quv
} WwUMZxZHnUD.FilterType  = Enum.RaycastFilterType .Exclude
local _buOq =Workspace.Raycast (Workspace, wD1oHz_1vZq.Position ,wbH0u1pHqDZx, WwUMZxZHnUD )
if _buOq  and _buOq.Instanceand not  _buOq.Instance  :IsDesc
endantOf(buDlWNZXDnox)
	then
	return
end
end LIB.pqpqo_mIXXOmqz ( )
end
function LIB.uzDHHIvzqz (bzHw1N, WwXoZ )
if bzHw1N==LocalPlayer
	then
	return
end task .wait ( 0.5 )
if not WwXoZ.Parent
	then
	return
end
local _vUnnDQ= LIB.MQQuzxZ ( bzHw1N ,WwXoZ)
if _vUnnDQ or (bzHw1N.Team and bzHw1N.Team .Name :lower(  ) : find("killer" ) )
	then
	local INolnuW1wXxx= _vUnnDQ or "Unknown Killer"
	local HpD0M =WwXoZ.WaitForChild  ( WwXoZ ,"Humanoid" , 3 )
	if HpD0M
		then
		local DwopNwppQp=HpD0M .WaitForChild  ( HpD0M,"Animator" ,3)
		if DwopNwppQp
			then  DwopNwppQp .AnimationPlayed :Connect (
			function (lvUXZu)
			if not State .autoParryEnabled
				then
				return
			end
			if lvUXZu  and lvUXZu.Animation
				then
				local O1OInp0lo =LIB.IxW_Dmx_ZxU1Uv [lvUXZu .Animation .AnimationId ]
				if  O1OInp0lo
					then State.activeAttackers  [ WwXoZ ] = {
 .name =INolnuW1wXxx , .track =lvUXZu , .type = O1OInp0lo
}
					if O1OInp0lo =="attack"
						then LIB.omXXOoIZHO1 (WwXoZ ,INolnuW1wXxx )
					end
					local  IXvnz IXvnz=lvUXZu.Stopped : Connect( function( )
					if IXvnz
						then IXvnz.Disconnect (IXvnz )
					end  task.delay (0.3,
					function ( )
					if State .activeAttackers  [ WwXoZ]and  State.activeAttackers [ WwXoZ ] .track ==lvUXZu
						then State.activeAttackers [WwXoZ ] =nil
					end
				end )
			end)
		end
	end
end )
end
end
end
end
function  LIB._qM_on ( WQOIXUMQQ)
if WQOIXUMQQ== LocalPlayer
	then
	return
end
if  WQOIXUMQQ.Character
	then task.spawn (
	function ( ) LIB.uzDHHIvzqz (WQOIXUMQQ,WQOIXUMQQ .Character )
end)
end WQOIXUMQQ.CharacterAdded : Connect( function(QqMHw_UW0 )task .spawn (function( )LIB.uzDHHIvzqz(WQOIXUMQQ, QqMHw_UW0 )
end )
end)
end
for qoU0IW , lvmOIMXW in ipairs (GetService.GetPlayers  ( GetService) )
	do
	if lvmOIMXW ~= LocalPlayer
		then LIB._qM_on (lvmOIMXW )
	end
end GetService.PlayerAdded :Connect(LIB._qM_on ) RegisterTask("AttackersMonitor" ,0 ,
function (  )
if not State.autoParryEnabled
	then
	return
end
if next ( State.activeAttackers ) == nil
	then
	return
end
for wlo1W0q0XuqX,OWzxxIm_ in pairs ( State.activeAttackers  )
	do
	if not wlo1W0q0XuqX or not wlo1W0q0XuqX .Parent or not OWzxxIm_ .track
		then State .activeAttackers [ wlo1W0q0XuqX]  =nil
	else
	if  not OWzxxIm_.track .IsPlaying
		then State .activeAttackers [wlo1W0q0XuqX ] = nil
	else
	if OWzxxIm_.type  =="attack"
		then
		if OWzxxIm_.track .TimePosition < 0.25
			then LIB.omXXOoIZHO1 ( wlo1W0q0XuqX, OWzxxIm_ .name )
		end
	else
	if OWzxxIm_ .type =="lungehold"
		then
		local _lxvH1 = LocalPlayer .Character
		local p1m0I=_lxvH1 and  _lxvH1.FindFirstChild (_lxvH1,"HumanoidRootPart" )
		local Q_vvIb1MHWbxbv = wlo1W0q0XuqX.FindFirstChild  ( wlo1W0q0XuqX,"HumanoidRootPart" )
		if p1m0I and Q_vvIb1MHWbxbv
			then
			local Nn0l0oxMq_X_Hn= ( Q_vvIb1MHWbxbv .Position -p1m0I .Position ) .Magnitude
			if  Nn0l0oxMq_X_Hn<=State .autoParryRadius *0.8
				then LIB.omXXOoIZHO1 (wlo1W0q0XuqX ,OWzxxIm_ .name )
			end
		end
	end
end
end
end
end)LIB.vQbOXZmp_ = {

}LIB.lwIb11vxW = nil LIB.BMO1q = {

}LIB._MHzo1Zq=32 LIB.uWXOlqNMoNMI= -1
function LIB.qI_mZo0lWzH ( )
for WQvumQoM,uDnHU_01x in ipairs ( LIB.vQbOXZmp_)
	do
	if  uDnHU_01x and  uDnHU_01x.Parent
		then uDnHU_01x.Destroy (uDnHU_01x )
	end
end LIB.vQbOXZmp_ = {

}LIB.BMO1q =  {

}
local qNW0lquvm_ = ( 2*math.pi )  / LIB._MHzo1Zq
for Nl0Iu_l =1 , LIB._MHzo1Zq
	do
	local vmOZvpbXl =qNW0lquvm_ * ( Nl0Iu_l - 1 )
	local  DpDvmOxZbQ= qNW0lquvm_*Nl0Iu_l LIB.BMO1q [ Nl0Iu_l] =  {
 .cx = math.cos (vmOZvpbXl) , .cz =math.sin (vmOZvpbXl ) , .nx = math.cos  ( DpDvmOxZbQ ) , .nz =math.sin (DpDvmOxZbQ ) ,
}
	local OqXoMQ= Instance.new ( "Part" ) OqXoMQ .Shape =Enum.PartType .BlockOqXoMQ.Anchored  =true OqXoMQ.CanCollide =false  OqXoMQ.CanQuery =false OqXoMQ .CastSha
		dow = false OqXoMQ.Material = Enum.Material .Neon OqXoMQ.Color =Color3.fromRGB ( 255 ,60 ,60) OqXoMQ .Transparency = 0.15 OqXoMQ .Size  =Vector3.new  (0.08,0.08 , 0.1)OqXoMQ .Name ="BolongESP_Seg" OqXoMQ .Parent = Workspace LIB.vQbOXZmp_[Nl0Iu_l ] =OqXoMQ
	end
end
function LIB.I_XOXx0pqZolpo (MvNMNIo )
local Wl_oH = ( 2*math .pi *MvNMNIo ) / LIB._MHzo1Zq
for wXoZHI_n, DbQZu in ipairs  (LIB.vQbOXZmp_)
	do
	if DbQZu and DbQZu.Parent
		then DbQZu.Size =Vector3.new ( 0.08,0.08, Wl_oH+ 0.02)
	end
end
end
function LIB.lWMxxOX(  )
for qvX_MqWlDlQ1WH , wO0_mbu  in ipairs (LIB.vQbOXZmp_)
	do
	if wO0_mbu and wO0_mbu .Parent
		then wO0_mbu.Destroy ( wO0_mbu)
	end
end LIB.vQbOXZmp_=  {

}LIB.BMO1q = {

}LIB.uWXOlqNMoNMI= - 1
end
function LIB.onDxz1o( vXI0x1m1HW )
if vXI0x1m1HW
	then LIB.qI_mZo0lWzH ( )LIB.lwIb11vxW=Players .R
enderStepped :Connect( function( )
if not LocalPlayer.Character
	then
	return
end
local B_ZIuwW_vM= LocalPlayer .Character :FindFirstChild ("HumanoidRootPart" )
if  not B_ZIuwW_vM
	then
	return
end
local MZQvwUOol =State .autoParryRadius
if  MZQvwUOol ~= LIB.uWXOlqNMoNMI
	then LIB.I_XOXx0pqZolpo(MZQvwUOol) LIB.uWXOlqNMoNMI =MZQvwUOol
end
local  bOpm0_nbwIx_ =B_ZIuwW_vM .Position -Vector3.new ( 0 , B_ZIuwW_vM.Size  .Y /2+1.5, 0 )
for  uvW0m, HbQmuWxQxoIW in ipairs  (LIB.vQbOXZmp_)
	do
	if  HbQmuWxQxoIW and HbQmuWxQxoIW.Parent
		then
		local  MDuHI1U = LIB.BMO1q[uvW0m]
		local uDmzH1lW_1X = bOpm0_nbwIx_ + Vector3.new (MDuHI1U.cx * MZQvwUOol, 0 , MDuHI1U.cz * MZQvwUOol )
		local w_mmNNO = bOpm0_nbwIx_+Vector3.new ( MDuHI1U .nx *MZQvwUOol,  0 ,MDuHI1U.nz *MZQvwUOol ) HbQmuWxQxoIW .CFrame =CFrame .lookAt (uDmzH1lW_1X,w_mmNNO) *CFrame.new ( 0 , 0 , -HbQmuWxQxoIW .Size .Z / 2 )
	end
end
end )
else
if LIB.lwIb11vxW
	then LIB.lwIb11vxW.Disconnect (LIB.lwIb11vxW) ;
	
LIB.lwIb11vxW =nil
end LIB.lWMxxOX( )
end
end
end
function LIB.lHZlWupp ( )
for QzwoMnWO,plz0Iv0D1bMuIq in ipairs (State .cachedMapObjects  .Gates )
	do SetGateGhost ( plz0Iv0D1bMuIq ,State.ghostGateEnabled )
end
end
function LIB._XDNw( )
local  D1qZUOm_0l = LocalPlayer.Character
local  Q0uu0zmb_HbNz= D1qZUOm_0l  and D1qZUOm_0l .FindFirstChild ( D1qZUOm_0l, "HumanoidRootPart" )
if not Q0uu0zmb_HbNz
	then Notify ("Teleport" , "Karakter tidak ditemukan!" , 2  ) ;
	

	return
end
local uqZOXunDq1uN1b = workspace.FindFirstChild ( workspace, "Fininshline" ,true)
if not uqZOXunDq1uN1b
	then Notify ("Teleport" , "Fininshline tidak ditemukan di map!" , 2 ) ;
	

	return
end
local oNMQp= uqZOXunDq1uN1b .Position
local DlImONq1=RaycastParams.new ( )DlImONq1 .FilterType =Enum .RaycastFilterType .Exclude DlImONq1 .FilterDesc
endantsInstances = {
 D1qZUOm_0l, uqZOXunDq1uN1b .Parent
}
local onoXUqoxUoXHzl = nil
local Imqzm = oNMQp + Vector3.new ( 0 , 10 , 0 )
local  HwZZD0nU=workspace .Raycast ( workspace,Imqzm, Vector3.new ( 0 , - 30 , 0 ) , DlImONq1 )
if HwZZD0nU
	then
	local NbuppW =workspace.Raycast (workspace , HwZZD0nU .Position + Vector3.new ( 0 ,  5 ,  0  ) ,Vector3.new ( 0 , 5,0)  ,DlImONq1 )
	if not NbuppW
		then onoXUqoxUoXHzl = HwZZD0nU.Position +Vector3.new ( 0 , 3  ,0 )
	end
end
if onoXUqoxUoXHzl
	then  pcall (
	function (  )Q0uu0zmb_HbNz.CFrame  = CFrame.new (onoXUqoxUoXHzl)
end )
else pcall (
function (  )Q0uu0zmb_HbNz.CFrame = uqZOXunDq1uN1b .CFrame
end )
end
end
	do
		do
		local qQwNMH=46 * (0 + 1- 1)
		local  OopZNlOlbQ_lHq=qQwNMH+302 - 302
	end LIB._Q1MmIbx0x="80411309607666"
	function LIB.DNHmxOz0wXm (WDNbX)
	if not WDNbX
		then
		return ""
	end
	return tostring (WDNbX ) :match ("%d+" ) or ""
end
function LIB.NIlvNOODX ( )
local qmluWDpDw=LocalPlayer.FindFirstChild ( LocalPlayer, "PlayerGui"  )
if not qmluWDpDw
	then
	return nil
end
local ODOunwW=qmluWDpDw .FindFirstChild (qmluWDpDw ,"Survivor-mob"  )
if not  ODOunwW
	then
	return nil
end
local vbH_OUwMUO_X=ODOunwW.FindFirstChild ( ODOunwW, "Controls" )
if  not vbH_OUwMUO_X
	then
	return nil
end
local QbooN =vbH_OUwMUO_X .FindFirstChild (vbH_OUwMUO_X ,"crouch" )
if  QbooN and  QbooN .IsA ( QbooN , "GuiButton" )
	then
	return  QbooN
end
return  nil
end
function LIB.uuMqxOzluob(WbvomoHupl)
if State .autoCrouchIsCrouching ~=WbvomoHupl
	then State.autoCrouchIsCrouching =WbvomoHupl
	local  vNb1ouQWlXnWwp=LocalPlayer.Character
	if  vNb1ouQWlXnWwp
		then vNb1ouQWlXnWwp.SetAttribute ( vNb1ouQWlXnWwp,"Crouchingserver"  , WbvomoHupl) vNb1ouQWlXnWwp : SetAttribute ( "Crouching"  ,WbvomoHupl )
	end pcall (function( )ReplicatedStorage .Remotes .Mechanics .ChangeAttribute :FireServer( "Crouchingserver" ,WbvomoHupl ) ReplicatedStorage.Remotes .Mechanics .ChangeAttribute :FireServer("Crouching" , WbvomoHupl )
end)
local oQpqOvMx =not  UserInputService.TouchEnabled and UserInputService .KeyboardEnabled
if oQpqOvMx
	then if0 > (481 )
		then
		local uZWzoHHQ =307+ 481
		local oovvbMHX=uZWzoHHQ* 2
	end VirtualInputManager .S
endKeyEvent (VirtualInputManager , WbvomoHupl,Enum.KeyCode .C ,false,game)VirtualInputManager:S
endKeyEvent (WbvomoHupl,Enum .KeyCode .LeftControl  , false ,game)
else
local Dw_mqpQw=LIB.NIlvNOODX( )
if Dw_mqpQw and type  (firesignal)  =="function"
	then
	if  WbvomoHupl
		then firesignal(Dw_mqpQw .MouseButton1Down )
		if Dw_mqpQw.MouseButton1Click
			then firesignal( Dw_mqpQw .MouseButton1Click )
		end
	else firesignal( Dw_mqpQw .MouseButton1Up )
	if  Dw_mqpQw.MouseButton1Click
		then firesignal ( Dw_mqpQw .MouseButton1Click )
	end
end
end
end
end
end
function  LIB.uqH_ZIQnzH_u ( BNIvXQwIq_oq )
if not BNIvXQwIq_oq
	then
	return
end
local NWb0b = BNIvXQwIq_oq.FindFirstChildOfClass (BNIvXQwIq_oq, "Humanoid" )
if not NWb0b
	then
	return
end
if  State.autoCrouchAnimConns [NWb0b]
	then
	return
end State .autoCrouchAnimConns  [NWb0b] =NWb0b .AnimationPlayed  : Connect (
function (DZWIHb)
if not Config .autoCrouchEnabled
	then
	return
end
local  HIuNoU0WUU=DZWIHb.Animation
if HIuNoU0WUU
	then
	local  NWX_10XMN=LIB.DNHmxOz0wXm (HIuNoU0WUU .AnimationId )
	if NWX_10XMN ==LIB._Q1MmIbx0x
		then State .autoCrouchActiveSlashers [ BNIvXQwIq_oq] =true DZWIHb.Stopped : Connect( function( ) task.wait (0.2 ) State.autoCrouchActiveSlashers [BNIvXQwIq_oq ] =nil
	end )
end
end
end ) NWb0b.Died  : Connect(function(  )State.autoCrouchActiveSlashers [BNIvXQwIq_oq ] =nil
end)
end  RegisterTask("AutoCrouch"  ,  0  ,function( )
if not Config.autoCrouchEnabled
	then
	return
end
local H_ZXpN1M0v_Uzu=LocalPlayer.Character
if not H_ZXpN1M0v_Uzu
	then
	return
end
local HUbnl1NNzDM = H_ZXpN1M0v_Uzu.FindFirstChild  ( H_ZXpN1M0v_Uzu ,"HumanoidRootPart" )
if not HUbnl1NNzDM
	then
	return
end
local w1OUMZzWul=false
for bDMQZ , HDbUNv0uQMZW in  pairs (State .autoCrouchActiveSlashers )
	do
	if bDMQZ and  bDMQZ.Parent
		then
		local wopmxUM1U= bDMQZ.FindFirstChild (bDMQZ , "HumanoidRootPart" )
		local q_HMX0XmoUoONU=bDMQZ.FindFirstChildOfClass (bDMQZ,"Humanoid" )
		if wopmxUM1U and q_HMX0XmoUoONU and q_HMX0XmoUoONU.Health  > 0
			then
			local MMwMpNM=  (wopmxUM1U.Position -HUbnl1NNzDM.Position ) .Magnitude
			if MMwMpNM<=Config .autoCrouchRadius
				then  w1OUMZzWul = true break
			end
		end
	else State .autoCrouchActiveSlashers [ bDMQZ] = nil
end
end LIB.uuMqxOzluob( w1OUMZzWul)
end)
for OmuImNmbDzqo1I, HIvWvODwzzu_p in ipairs (GetService .GetPlayers ( GetService ) )
	do
	if HIvWvODwzzu_p~= LocalPlayer and HIvWvODwzzu_p.Character
		then LIB.uqH_ZIQnzH_u ( HIvWvODwzzu_p.Character )
	end
	if HIvWvODwzzu_p ~= LocalPlayer
		then HIvWvODwzzu_p .CharacterAdded :Connect(
		function (wXz_XuD)task .wait ( 1 ) LIB.uqH_ZIQnzH_u(wXz_XuD )
	end)
end
end  GetService .PlayerAdded : Connect(function(HqvZ0WXWIZU) HqvZ0WXWIZU .CharacterAdded :Connect(
function (BmqZDmDu1pnn ) task.wait (1 )
if Config.autoCrouchEnabled
	then LIB.uqH_ZIQnzH_u ( BmqZDmDu1pnn)
end
end )
end )
end
function LIB.vzImqwp( vnqDZuQ0XQ )
if  not vnqDZuQ0XQ  or vnqDZuQ0XQ.gsub (vnqDZuQ0XQ , "%s+" ,"" )  ==""
	then
	return
end vnqDZuQ0XQ=vnqDZuQ0XQ.gsub (vnqDZuQ0XQ ,"%s+" ,"" ) task .spawn  (
function (  )
local ppIIvIoQOOQv =tonumber (vnqDZuQ0XQ)
if not ppIIvIoQOOQv
	then
	local bmbIwHwzXm= pcall (function( )ppIIvIoQOOQv= GetService.GetUserIdFromNameAsync ( GetService , vnqDZuQ0XQ)
end )
if not bmbIwHwzXm  or not ppIIvIoQOOQv
	then
	return
end
end
local N0o0D_ZNx0l =LocalPlayer .Character
local BowwO_xwmqIn= N0o0D_ZNx0l and N0o0D_ZNx0l .FindFirstChildOfClass ( N0o0D_ZNx0l,"Humanoid" )
if not  N0o0D_ZNx0l or not BowwO_xwmqIn
	then
	return
end
local uzbXpuv0mnwZ=GetService.GetHumanoidDescriptionFromUserId (GetService , ppIIvIoQOOQv )
if not uzbXpuv0mnwZ
	then
	return
end
local QqXuW0D_bvHUN =GetService.CreateHumanoidModelFromDescription  (GetService , uzbXpuv0mnwZ , BowwO_xwmqIn.RigType  )
if not QqXuW0D_bvHUN
	then
	return
end
for bMwXIob00 , Qx_UXQb_N in ipairs ( N0o0D_ZNx0l.GetChildren ( N0o0D_ZNx0l) )
	do
	if Qx_UXQb_N.IsA (Qx_UXQb_N , "Accessory" ) or Qx_UXQb_N .IsA (Qx_UXQb_N,"Shirt" )or Qx_UXQb_N.IsA (Qx_UXQb_N,"Pants" ) or Qx_UXQb_N.IsA  (Qx_UXQb_N , "ShirtGraphic" ) or Qx_UXQb_N .IsA ( Qx_UXQb_N, "BodyColors" ) or  Qx_UXQb_N .IsA ( Qx_UXQb_N, "CharacterMesh" )
		then Qx_UXQb_N.Destroy ( Qx_UXQb_N )
	end
end
for  w0qzpxmvu, MWzUWQqDZnOHmW  in ipairs (N0o0D_ZNx0l.GetChildren ( N0o0D_ZNx0l ) )
	do
	if MWzUWQqDZnOHmW.IsA (MWzUWQqDZnOHmW,"BasePart"  )
		then
		for p0ozMOZ , pbmxO1WZI  in ipairs ( MWzUWQqDZnOHmW.GetChildren  (MWzUWQqDZnOHmW )  )
			do
			if pbmxO1WZI.IsA (pbmxO1WZI , "SpecialMesh"  ) or pbmxO1WZI .IsA (pbmxO1WZI,"Decal" )or pbmxO1WZI.IsA ( pbmxO1WZI , "Texture" ) or pbmxO1WZI .IsA (pbmxO1WZI ,"SurfaceAppearance" )
				then pbmxO1WZI.Destroy  (pbmxO1WZI)
			end
		end
	end
end
local ouxZQ = QqXuW0D_bvHUN .FindFirstChildOfClass (QqXuW0D_bvHUN ,"BodyColors" )
if ouxZQ
	then  ouxZQ.Clone  (ouxZQ) .Parent = N0o0D_ZNx0l
	local HZImx= {
 .Head  =ouxZQ.HeadColor3  , .Torso = ouxZQ.TorsoColor3 , [ "Left Arm" ] = ouxZQ .LeftArmColor3 , [ "Right Arm"  ] =ouxZQ .RightArmColor3 , ["Left Leg" ]  =ouxZQ.LeftLegColor3 , [ "Right Leg"  ] = ouxZQ.RightLegColor3 , .UpperTorso =ouxZQ .TorsoColor3 , .LowerTorso =ouxZQ.TorsoColor3  , .LeftHand =ouxZQ.LeftArmColor3 , .RightHand =ouxZQ.RightArmColor3 , .LeftLowerArm = ouxZQ .LeftArmColor3  , .RightLowerArm = ouxZQ .RightArmColor3  , .LeftUpperArm =ouxZQ .LeftArmColor3 , .RightUpperArm  =ouxZQ .RightArmColor3 , .LeftFoot =ouxZQ.LeftLegColor3 , .RightFoot = ouxZQ.RightLegColor3 ,  .LeftLowerLeg = ouxZQ.LeftLegColor3 , .RightLowerLeg  = ouxZQ.RightLegColor3  , .LeftUpperLeg = ouxZQ.LeftLegColor3 , .RightUpperLeg = ouxZQ .RightLegColor3 ,
}
	for oIW0OxMHIZH , QuqHOQ1lQ_zQv in  pairs (HZImx )
		do
		local uuM0_z = N0o0D_ZNx0l .FindFirstChild ( N0o0D_ZNx0l ,oIW0OxMHIZH )
		if uuM0_z
			then  pcall (
			function ( )uuM0_z.Color = QuqHOQ1lQ_zQv
		end)
	end
end
end
for wllqZxm , wIl1lxpxZlHnMo in ipairs (QqXuW0D_bvHUN .GetChildren  (QqXuW0D_bvHUN) )
	do
	if wIl1lxpxZlHnMo .IsA ( wIl1lxpxZlHnMo,"Shirt" ) or wIl1lxpxZlHnMo .IsA (wIl1lxpxZlHnMo,"Pants" ) or  wIl1lxpxZlHnMo .IsA (wIl1lxpxZlHnMo,"ShirtGraphic" ) or wIl1lxpxZlHnMo .IsA (wIl1lxpxZlHnMo ,"CharacterMesh" )
		then wIl1lxpxZlHnMo.Clone ( wIl1lxpxZlHnMo) .Parent  =N0o0D_ZNx0l
	end
end
for _xv1qbQwpp,NvuqulXXlbzn in ipairs (QqXuW0D_bvHUN .GetChildren (QqXuW0D_bvHUN ) )
	do
	if  NvuqulXXlbzn .IsA ( NvuqulXXlbzn , "BasePart" )
		then
		local wmQzDQ_Qm01b = N0o0D_ZNx0l .FindFirstChild ( N0o0D_ZNx0l,NvuqulXXlbzn .Name )
		if wmQzDQ_Qm01b and wmQzDQ_Qm01b .IsA ( wmQzDQ_Qm01b ,"BasePart"  )
			then
			if  NvuqulXXlbzn .IsA ( NvuqulXXlbzn, "MeshPart" )and wmQzDQ_Qm01b.IsA (wmQzDQ_Qm01b,"MeshPart" )
				then pcall ( function( ) wmQzDQ_Qm01b.MeshId =NvuqulXXlbzn .MeshIdwmQzDQ_Qm01b.TextureID =NvuqulXXlbzn.TextureIDwmQzDQ_Qm01b.Color  = NvuqulXXlbzn.ColorwmQzDQ_Qm01b.Transparency =NvuqulXXlbzn .Transparency
			end)
		end
		for HWMnXMIWo0w,MIM_Oxx in ipairs  ( NvuqulXXlbzn .GetChildren (NvuqulXXlbzn ) )
			do
			if MIM_Oxx.IsA (MIM_Oxx,"SpecialMesh" ) or MIM_Oxx.IsA  (MIM_Oxx ,"Decal" )or MIM_Oxx .IsA (MIM_Oxx,"Texture" )or MIM_Oxx .IsA (MIM_Oxx,"SurfaceAppearance" )
				then MIM_Oxx .Clone ( MIM_Oxx) .Parent =wmQzDQ_Qm01b
			end
		end
	end
end
end
local
function  _HHzNQXb(OpXUnWomU)
local DoN1p1m=OpXUnWomU.Clone ( OpXUnWomU )DoN1p1m.Parent = N0o0D_ZNx0l
local p1HqqQ =DoN1p1m.FindFirstChild (DoN1p1m , "Handle"  )
if not  p1HqqQ
	then
	return
end p1HqqQ.Anchored = false p1HqqQ.CanCollide = false pcall  (
function ( ) p1HqqQ.Massless =true
end)
for ln_ov,lXO0Qo in ipairs (p1HqqQ.GetChildren (p1HqqQ ) )
	do
	if lXO0Qo .IsA (lXO0Qo, "Weld"  ) or lXO0Qo.IsA ( lXO0Qo ,"WeldConstraint"  )or lXO0Qo.IsA (lXO0Qo,"Motor6D" )
		then lXO0Qo.Destroy  ( lXO0Qo)
	end
end pcall ( function(  )BowwO_xwmqIn :AddAccessory(DoN1p1m)
end )
local _1uDl10vWxp0xn=false
for  BuHqDzx, obZNZ1UIQXMm in ipairs ( p1HqqQ.GetChildren ( p1HqqQ ) )
	do
	if ( obZNZ1UIQXMm.IsA  ( obZNZ1UIQXMm,"Weld" ) or obZNZ1UIQXMm.IsA (obZNZ1UIQXMm, "WeldConstraint"  ) )and obZNZ1UIQXMm.Part1 and obZNZ1UIQXMm .Part1 : IsDesc
endantOf( N0o0D_ZNx0l)
	then _1uDl10vWxp0xn= true break
end
end
if not _1uDl10vWxp0xn
	then
	local  bXpDzxXODvZ= p1HqqQ.FindFirstChildOfClass  ( p1HqqQ, "Attachment" )
	local MMllwXOwo=nil
	local HOIvqoQ1W0v_o =nil
	if bXpDzxXODvZ
		then
		for  DpOunw__0b_pb ,QQ1mZxn in ipairs (N0o0D_ZNx0l .GetDesc
	endants ( N0o0D_ZNx0l) )
		do
		if QQ1mZxn .IsA ( QQ1mZxn,"Attachment" ) and QQ1mZxn.Name ==bXpDzxXODvZ.Name
			then MMllwXOwo =QQ1mZxn.ParentHOIvqoQ1W0v_o = QQ1mZxn break
		end
	end
end
if not MMllwXOwo
	then  MMllwXOwo=N0o0D_ZNx0l .FindFirstChild (N0o0D_ZNx0l, "Head" ) or N0o0D_ZNx0l .FindFirstChild ( N0o0D_ZNx0l ,"HumanoidRootPart" )
end
if  MMllwXOwo
	then
	if HOIvqoQ1W0v_o and bXpDzxXODvZ
		then p1HqqQ.CFrame =MMllwXOwo.CFrame *HOIvqoQ1W0v_o.CFrame *bXpDzxXODvZ .CFrame  : Inverse( )
	else p1HqqQ .CFrame =MMllwXOwo .CFrame
end
local Ono_UO=Instance.new ( "WeldConstraint" ) Ono_UO.Name  = "BolongWeld"Ono_UO .Part0 = p1HqqQ Ono_UO .Part1 =MMllwXOwo Ono_UO.Parent  = p1HqqQ
end
end
end
for OpWHzNmv0n, WzNZNDWoUMm in ipairs (QqXuW0D_bvHUN .GetChildren (QqXuW0D_bvHUN) )
	do
	if  WzNZNDWoUMm.IsA (WzNZNDWoUMm , "Accessory" )
		then pcall (function( )_HHzNQXb( WzNZNDWoUMm)
	end )
end
end QqXuW0D_bvHUN .Destroy ( QqXuW0D_bvHUN)
end)
end LIB.owxoOMxxHWu= {
 .Ambient = Lighting.Ambient , .Out
	doorAmbient =Lighting .Out
		doorAmbient  , .ColorShift_Bottom = Lighting.ColorShift_Bottom , .ColorShift_Top =Lighting .ColorShift_Top , .Brightness = Lighting.Brightness  , .ClockTime =Lighting.ClockTime  , .GlobalSha
			dows  =Lighting.GlobalSha
				dows ,  .FogStart  =Lighting.FogStart , .FogEnd = Lighting .FogEnd  , .FogColor =Lighting.FogColor , .ExposureCompensation = Lighting .ExposureCompensation  , .EnvironmentDiffuseScale =Lighting .EnvironmentDiffuseScale , .EnvironmentSpecularScale =Lighting.EnvironmentSpecularScale ,
}LIB.HwQWWqQUWpIl1N = {

}
				function LIB.p_01zM1nQ ( )Lighting .Ambient = Color3.fromRGB  ( 178,  178 , 178) Lighting.Out
					doorAmbient = Color3.fromRGB ( 178 , 178 ,178 )Lighting .ColorShift_Bottom = Color3.new ( 0 ,0, 0)Lighting .ColorShift_Top =Color3.new ( 0 , 0 , 0 ) Lighting .Brightness =3 ;
					
 Lighting.ClockTime = 12;
					
 Lighting.GlobalSha
						dows = false Lighting .FogStart =9e9;
						
Lighting.FogEnd =9e9 ;
						
 Lighting.ExposureCompensation =0 Lighting .EnvironmentDiffuseScale = 0 ;
						
Lighting.EnvironmentSpecularScale =  0
					end
					function  LIB.un10pxvlDoWQlp( )
					for uMMbHHO,u0pWQHvI in pairs (LIB.owxoOMxxHWu)
						do  pcall ( function( )Lighting[ uMMbHHO] =u0pWQHvI
					end)
				end
			end
			function LIB.NZ0MOpIIxM_0 ( )LIB.HwQWWqQUWpIl1N = {

}
			for pO11wzpH ,WHNHqXnl1ZQ0bH in ipairs ( Lighting .GetChildren ( Lighting ) )
				do
				if WHNHqXnl1ZQ0bH .IsA  ( WHNHqXnl1ZQ0bH,"PostEffect" ) or  WHNHqXnl1ZQ0bH.IsA  ( WHNHqXnl1ZQ0bH,"Clouds"  ) or WHNHqXnl1ZQ0bH .IsA (WHNHqXnl1ZQ0bH, "Atmosphere" ) or  WHNHqXnl1ZQ0bH.IsA  (WHNHqXnl1ZQ0bH ,"Sky" )
					then LIB.HwQWWqQUWpIl1N[WHNHqXnl1ZQ0bH ] = {
 .Enabled  =WHNHqXnl1ZQ0bH .Enabled , .Parent =WHNHqXnl1ZQ0bH.Parent
}pcall ( function( )
					if  WHNHqXnl1ZQ0bH .IsA  ( WHNHqXnl1ZQ0bH , "Sky" )
						then WHNHqXnl1ZQ0bH.Parent  =nil
					else WHNHqXnl1ZQ0bH.Enabled = false
				end
			end )
		end
	end
end
function  LIB.WwMOwDZWQxwXD( )
for bIuOM_u, _ZWNNo0MHO in pairs (LIB.HwQWWqQUWpIl1N)
	do
	if bIuOM_u
		then  pcall  (function( )
		if bIuOM_u .IsA (bIuOM_u ,"Sky" )
			then bIuOM_u .Parent  = _ZWNNo0MHO.Parent
		else bIuOM_u.Enabled = _ZWNNo0MHO .Enabled
	end
end)
end
end LIB.HwQWWqQUWpIl1N= {

}
end RegisterTask("LightingEnforcer" ,0.5,
function (  )
if State.fullbrightEnabled
	then LIB.p_01zM1nQ( )
end
if State .removeVfxEnabled
	then
	for pwvU1bHz, _DDlOw1ZI in ipairs ( Lighting .GetChildren (Lighting ) )
		do
		if _DDlOw1ZI.IsA (_DDlOw1ZI , "PostEffect" )or _DDlOw1ZI.IsA (_DDlOw1ZI,"Clouds" )or _DDlOw1ZI.IsA ( _DDlOw1ZI ,"Atmosphere"  )or _DDlOw1ZI.IsA (_DDlOw1ZI ,"Sky" )
			then pcall ( function( )
			if _DDlOw1ZI .IsA (_DDlOw1ZI,"Sky" )
				then
				if _DDlOw1ZI .Parent
					then _DDlOw1ZI .Parent =nil
				end
			else
			if _DDlOw1ZI .Enabled
				then  _DDlOw1ZI.Enabled = false
			end
		end
	end)
end
end
end
end)Lighting .ChildAdded : Connect(
function (u0xH0O0UD_)
if State .removeVfxEnabled
	then
	if u0xH0O0UD_.IsA ( u0xH0O0UD_, "PostEffect" )or u0xH0O0UD_.IsA (u0xH0O0UD_,"Clouds" )or u0xH0O0UD_.IsA ( u0xH0O0UD_, "Atmosphere" )or  u0xH0O0UD_.IsA ( u0xH0O0UD_,"Sky" )
		then  task .spawn (
		function ( ) pcall (
		function ( )
		if u0xH0O0UD_.IsA ( u0xH0O0UD_ , "Sky"  )
			then u0xH0O0UD_.Parent =nil
		else u0xH0O0UD_.Enabled =false
	end
end)
end )
end
end
end)
	do
	function LIB.DlDv_DxHml ( )
	local  oXNNpD0bNDXqwU = Instance.new  ( "ScreenGui" ) oXNNpD0bNDXqwU.Name ="BolongFOV" ;
	
oXNNpD0bNDXqwU .ResetOnSpawn =false;
	
 oXNNpD0bNDXqwU.DisplayOrder = 999999 pcall (
	function ( ) oXNNpD0bNDXqwU.Parent = (gethui and gethui ( ) or  game.GetService ( game,"CoreGui" ) )
end)
if  not oXNNpD0bNDXqwU .Parent
	then  oXNNpD0bNDXqwU.Parent =PlayerGui
end State.FOVCircle = Instance.new ( "Frame" ) State .FOVCircle  .Size  =UDim2.new  ( 0 ,Config.silentAimFovRadius * 2 , 0  ,Config.silentAimFovRadius * 2) State.FOVCircle .Position = UDim2.new ( 0.5,  0 , 0.5, 0 )State .FOVCircle .AnchorPoint  =Vector2.new  (0.5 , 0.5 ) State .FOVCircle .BackgroundColor3 = Color3.fromRGB ( 255 ,255, 255 ) State .FOVCircle .BackgroundTransparency = 1 ;

State .FOVCircle .Visible =false State .FOVCircle .Parent  =oXNNpD0bNDXqwU
local _uu_nWZU0NO = Instance.new ( "UICorner" ) ;

 _uu_nWZU0NO .CornerRadius =UDim.new (1, 0  )  ;

_uu_nWZU0NO.Parent =State .FOVCircle
local uIZNbbUQ =Instance.new ("UIStroke" )uIZNbbUQ .Color  =AccentColor ;

 uIZNbbUQ .Thickness = 2  ;

 uIZNbbUQ.Transparency =0.2 ;

uIZNbbUQ.Parent =State .FOVCircle
end LIB.DlDv_DxHml( )
function  LIB.DM_lMDIIqlpw (oxvvNv )
if not oxvvNv
	then
	return nil
end
local Ip_UZ_w= oxvvNv .FindFirstChild (oxvvNv , "UpperTorso"  )
if  Ip_UZ_w and Ip_UZ_w.IsA (Ip_UZ_w , "BasePart" )
	then
	return Ip_UZ_w.Position
end
local vNW1x=oxvvNv .FindFirstChild ( oxvvNv, "Torso" )
if vNW1x and  vNW1x .IsA (vNW1x, "BasePart"  )
	then
	return vNW1x .Position
end
local Won0M=oxvvNv.FindFirstChild (oxvvNv , "HumanoidRootPart" )
if Won0M
	then
	return Won0M.Position
end
return nil
end
function LIB.lwHZx ( )
local NwHppmuN0M__b=LocalPlayer.Character
if not NwHppmuN0M__b
	then
	return nil
end
local MqmoMU0MDXZlDm, HvlIxqz= pcall (function(  )
return NwHppmuN0M__b.FindFirstChild  (NwHppmuN0M__b, "Twist of Fate" ) :FindFirstChild("Right Arm" ) :FindFirstChild("gun" ) : FindFirstChild ("gun" )
end )
if MqmoMU0MDXZlDm and HvlIxqz and HvlIxqz .IsA ( HvlIxqz,"BasePart" )
	then
	return HvlIxqz.Position
end
local w0Zn0XowQ= NwHppmuN0M__b.FindFirstChild (NwHppmuN0M__b ,"Right Arm" )or NwHppmuN0M__b.FindFirstChild ( NwHppmuN0M__b, "RightHand" )
if w0Zn0XowQ
	then
	return w0Zn0XowQ.Position
end
return nil
end LIB.wOM_Wn= ReplicatedStorage.WaitForChild  ( ReplicatedStorage,"Remotes" ) :WaitForChild ("Items" ) :WaitForChild ( "Twist of Fate" ) :WaitForChild( "Fire" )pcall (
function ( ) LIB.BDvWIwNMuDUoz0= hookmetamethod( game,"__namecall" ,function(WqMm0W, ... )
local D1oDvlqzUMlbv=getnamecallmethod(  )
if D1oDvlqzUMlbv == "FireServer" and rawequal  (WqMm0W ,LIB.wOM_Wn )
	then
	local H__IlMOwx =table.pack ( ... )
	if State.silentAimEnabled and typeof ( State.silentAimLookVector ) == "Vector3"
		then
		if H__IlMOwx.n >= 3and typeof (H__IlMOwx[3] ) =="Vector3"
			then H__IlMOwx[ 3 ]  = State .silentAimLookVector
			if State.laserEspEnabled
				then State .triggerLaser = true
			end
		else
		if H__IlMOwx .n >= 2and  typeof (H__IlMOwx[ 2 ] ) =="Vector3"
			then H__IlMOwx [2 ] =State.silentAimLookVector
			if State.laserEspEnabled
				then State.triggerLaser = true
			end
		end
	end
	return LIB.BDvWIwNMuDUoz0(WqMm0W,table ( H__IlMOwx , 1  , H__IlMOwx.n  ) )
end
return  LIB.BDvWIwNMuDUoz0(WqMm0W, ... )
end )
end )RegisterTask ( "UpdateSilentAimTarget" ,0.05 ,function( )
if State .FOVCircle
	then State .FOVCircle .Visible  =State.silentAimFovVisible
	local NzHnwxn_u__bQH = Config .silentAimFovRadius * 2
	if State.FOVCircle .Size .X  .Offset  ~=NzHnwxn_u__bQH
		then State.FOVCircle  .Size =UDim2.new ( 0,NzHnwxn_u__bQH,0,NzHnwxn_u__bQH )
	end
end
if not State.silentAimEnabled
	then State.silentAimTarget =nil;
	
 State .silentAimLookVector = nil;
	

	return
end
local wvXquolD =LocalPlayer .Character
if not wvXquolD
	then
	return
end
local  ObXQznpDDo=wvXquolD.FindFirstChild ( wvXquolD, "HumanoidRootPart" )
if not ObXQznpDDo
	then
	return
end
local obOZ_HQn =workspace.CurrentCamera
if not obOZ_HQn
	then
	return
end
local _N_p1x__UMX=nil
local BOpXvMDw =math.huge
for BwNW_o,Bw0M_ in ipairs ( GetService.GetPlayers ( GetService ) )
	do
	if  Bw0M_~=LocalPlayer and GetPlayerRole( Bw0M_) =="killer"
		then
		local obl__IbuQlvWw1 = Bw0M_.Character
		if obl__IbuQlvWw1
			then
			local  Np0Iu= obl__IbuQlvWw1 .FindFirstChildOfClass ( obl__IbuQlvWw1 , "Humanoid" )
			local _HwnNDXHmwHm1z=LIB.DM_lMDIIqlpw( obl__IbuQlvWw1)
			if Np0Iu and Np0Iu .Health >0 and typeof (_HwnNDXHmwHm1z) == "Vector3"
				then
				local DbwNum_ZvZoX = (_HwnNDXHmwHm1z- ObXQznpDDo .Position ) .Magnitude
				if DbwNum_ZvZoX< BOpXvMDw
					then BOpXvMDw =DbwNum_ZvZoX ;
					
 _N_p1x__UMX=Bw0M_
				end
			end
		end
	end
end
if _N_p1x__UMX and _N_p1x__UMX.Character
	then
	local vnmlb1DwvbOQl= LIB.DM_lMDIIqlpw (_N_p1x__UMX.Character )
	if typeof (vnmlb1DwvbOQl) == "Vector3"
		then
		local MpU0mvuvHNxWU=true
		local HvQ0wb0wxOp_xq ,bDWoxolNOmnXz =obOZ_HQn.WorldToViewportPoint ( obOZ_HQn , vnmlb1DwvbOQl)
		if bDWoxolNOmnXz
			then
			local lnQNDUOmbNwQNo=Vector2.new (obOZ_HQn .ViewportSize  .X / 2  ,obOZ_HQn.ViewportSize .Y /  2  )
			local bMMxDp0 =  (Vector2.new (HvQ0wb0wxOp_xq.X ,HvQ0wb0wxOp_xq .Y ) -lnQNDUOmbNwQNo) .Magnitude
			if bMMxDp0> Config.silentAimFovRadius
				then MpU0mvuvHNxWU= false
			end
		else MpU0mvuvHNxWU= false
	end
	if  MpU0mvuvHNxWU
		then
		local  __pIZnl1N0 = LIB.lwHZx(  )
		if typeof ( __pIZnl1N0) ~="Vector3"
			then __pIZnl1N0 = obOZ_HQn .CFrame .Position
		end
		local MzqDOuqqou=vnmlb1DwvbOQl -__pIZnl1N0
		local DvMXmxInwzb = MzqDOuqqou .Magnitude
		if DvMXmxInwzb > 0.1
			then State.silentAimTarget = vnmlb1DwvbOQl State.silentAimLookVector  = Vector3.new ( MzqDOuqqou .X  /DvMXmxInwzb, MzqDOuqqou.Y /DvMXmxInwzb,MzqDOuqqou .Z /DvMXmxInwzb) State .currentMuzzlePos = __pIZnl1N0;
			
 State .currentTargetPos =vnmlb1DwvbOQl
		else State.silentAimTarget  = nil ;
		
 State .silentAimLookVector =nil
	end
else State .silentAimTarget =nil ;

 State .silentAimLookVector =nil
end
else State .silentAimTarget =nil ;

 State .silentAimLookVector =nil
end
else State.silentAimTarget  =nil;

State.silentAimLookVector =nil
end
end) RegisterTask ( "DrawLaserESP" ,0 ,
function ( )
if not State.triggerLaser
	then
	return
end State.triggerLaser =false
local  oqnxDxoNnOxIxq = State .currentMuzzlePos
local pxMMlmuI = State.currentTargetPos
if  typeof (oqnxDxoNnOxIxq ) ~="Vector3"or typeof (pxMMlmuI) ~= "Vector3"
	then
	return
end
local wwIxqMWlb = ( oqnxDxoNnOxIxq -pxMMlmuI) .Magnitude
if wwIxqMWlb<0.1
	then
	return
end
local NxIN1NzIq =Instance.new ( "Part"  ) NxIN1NzIq.Name ="SilentLaser" ;

NxIN1NzIq .Anchored = true;

 NxIN1NzIq.CanCollide =false NxIN1NzIq.Material =Enum .Material .Neon ;

 NxIN1NzIq.Color = Color3.fromRGB ( 255  , 0  ,0 ) NxIN1NzIq.Transparency =0.3;

NxIN1NzIq.Size  = Vector3.new  (0.15,0.15, wwIxqMWlb) NxIN1NzIq.CFrame =CFrame.new ( oqnxDxoNnOxIxq ,pxMMlmuI) * CFrame.new (0,0 , -wwIxqMWlb /2)NxIN1NzIq .Parent =workspace task.delay ( 0.4 ,
function ( )
if NxIN1NzIq
	then NxIN1NzIq .Destroy (NxIN1NzIq)
end
end )
end )
end
	do
	function  LIB.ppmDZmUwpIop( uZzNlz )
	if not uZzNlz
		then
		return nil
	end
	local BMp_1w0HQN_b =uZzNlz.FindFirstChild ( uZzNlz , "UpperTorso" )
	if BMp_1w0HQN_b  and BMp_1w0HQN_b.IsA ( BMp_1w0HQN_b,"BasePart" )
		then
		return BMp_1w0HQN_b.Position
	end
	local D_nXzn =uZzNlz.FindFirstChild (uZzNlz, "Torso" )
	if D_nXzn and D_nXzn .IsA ( D_nXzn, "BasePart" )
		then
		return D_nXzn.Position
	end
	local wD1zxIWNozb =uZzNlz.FindFirstChild (uZzNlz , "HumanoidRootPart" )
	if wD1zxIWNozb
		then
		return wD1zxIWNozb .Position  + Vector3.new  ( 0 ,0.5,0 )
	end
	return nil
end
function LIB._vMo1mZ1l (qxxuWHnX_p0, wv1lblzM , D_UInxMv)
local HoM10xblpWb ,q01XnvuZX=qxxuWHnX_p0 .WorldToViewportPoint ( qxxuWHnX_p0, wv1lblzM )
if not q01XnvuZX
	then
	return false
end
local ImuUMXID = Vector2.new (qxxuWHnX_p0 .ViewportSize .X /2 ,qxxuWHnX_p0 .ViewportSize  .Y /  2 )
local vwbHDo1 =Vector2.new  (HoM10xblpWb.X , HoM10xblpWb .Y )
local lox1u1uIuo = ( vwbHDo1 -ImuUMXID) .Magnitude
return lox1u1uIuo <=D_UInxMv
end
function LIB._ONZmmHUz( )
local bv01ZlI=Instance.new ("ScreenGui" )bv01ZlI.Name  = "BolongSpearFOV" ;

 bv01ZlI .ResetOnSpawn =false;

 bv01ZlI.DisplayOrder  = 999999 pcall (function( )bv01ZlI .Parent =  (gethui and gethui ( ) or game.GetService (game,"CoreGui"  ) )
end )
if not bv01ZlI .Parent
	then  bv01ZlI .Parent =PlayerGui
end State .SpearFOVCircle =Instance.new  ( "Frame" )State .SpearFOVCircle  .Size =UDim2.new ( 0, Config.spearFovRadius * 2, 0 ,Config.spearFovRadius *2)State .SpearFOVCircle .Position  =UDim2.new (0.5 , 0 ,0.5, 0 )State .SpearFOVCircle .AnchorPoint = Vector2 .new ( 0.5, 0.5) State.SpearFOVCircle .BackgroundColor3  =Color3.fromRGB (255, 255 ,255 ) State.SpearFOVCircle .BackgroundTransparency = 1;

State.SpearFOVCircle .Visible = false State .SpearFOVCircle .Parent =bv01ZlI
local lMHbwUw =Instance.new  ("UICorner" ) ;

lMHbwUw.CornerRadius  =UDim.new (1 , 0) ;

lMHbwUw.Parent =State .SpearFOVCircle
local oHzvuluWW=Instance.new ( "UIStroke" )oHzvuluWW.Color  = AccentColor ;

 oHzvuluWW .Thickness =2;

 oHzvuluWW.Transparency =0.2 ;

 oHzvuluWW.Parent =State.SpearFOVCircle
end  LIB._ONZmmHUz ( )
function  LIB.Bvolu1 ( )
local umDlo = Instance.new ( "ScreenGui"  )umDlo.Name = "SpearIndicatorUI" ;

umDlo.ResetOnSpawn =false;

 umDlo .Enabled =false  umDlo .DisplayOrder = 999998 ;

 umDlo.IgnoreGuiInset =true pcall  (function( )umDlo.Parent = ( gethui and gethui( )or game.GetService (game ,"CoreGui" ) )
end)
if not  umDlo.Parent
	then  umDlo.Parent =PlayerGui
end  State .SpearMainFrame  = Instance.new ( "Frame" )State .SpearMainFrame .Name = "MainFrame" State.SpearMainFrame .Size = UDim2.new ( 0 , 180, 0 ,42) State.SpearMainFrame .Position  = UDim2.new (0.5 , 0 , 0.82 , 0 ) State .SpearMainFrame .AnchorPoint =Vector2.new ( 0.5, 0.5)State .SpearMainFrame .BackgroundColor3 =Color3.fromRGB  (20 ,20,25 )State .SpearMainFrame .BackgroundTransparency =0.1 State .SpearMainFrame .BorderSizePixel =0 State.SpearMainFrame .Parent =umDlo
local BwWXUozxQQbQZM=Instance.new ("UICorner" ) ;

BwWXUozxQQbQZM .CornerRadius = UDim.new ( 0 , 8  ) ;

BwWXUozxQQbQZM .Parent = State.SpearMainFrame
local DUImup00N = Instance.new ( "UIStroke" )DUImup00N.Color =Color3.fromRGB ( 45 ,  45 , 55 ) ;

DUImup00N.Thickness =1 ;

DUImup00N .Transparency = 0.2 ;

DUImup00N.Parent =State.SpearMainFrame
local W1pmlQu1v=Instance.new ( "UIGradient" ) W1pmlQu1v .Color = ColorSequence .new ( {
 ColorSequenceKeypoint.new ( 0 ,Color3.fromRGB (35 , 35, 40  ) ) ,ColorSequenceKeypoint .new ( 1,Color3.fromRGB ( 15 ,15,20 ) )
} ) W1pmlQu1v .Rotation = 90 ;

 W1pmlQu1v .Parent = State.SpearMainFrame State .SpearAccentBar = Instance.new ("Frame" ) State.SpearAccentBar  .Name = "AccentBar" State .SpearAccentBar .Size =UDim2.new ( 0, 3 ,1 , -12 ) State .SpearAccentBar  .Position =UDim2.new ( 0,6,0, 6)State.SpearAccentBar .BackgroundColor3  =Color3.fromRGB (200 , 200 , 200  )State.SpearAccentBar .BorderSizePixel = 0 ;

State.SpearAccentBar .Parent = State .SpearMainFrame
local _1vZ1nn=Instance.new ("UICorner" ) ;

_1vZ1nn .CornerRadius =UDim.new (1 ,  0 ) ;

 _1vZ1nn .Parent =State .SpearAccentBarState .SpearStatusText =Instance.new ("TextLabel" ) State.SpearStatusText .Name = "StatusText"State.SpearStatusText  .Size = UDim2.new ( 1 , -18 , 0 , 18 )State .SpearStatusText .Position = UDim2.new (0 ,14, 0 , 5 ) State.SpearStatusText .BackgroundTransparency = 1HM1uHIZZl0 .SpearStatusText .Text  = "NO TARGET"State .SpearStatusText .TextColor3 = Color3.fromRGB (255,  255 ,255 ) State.SpearStatusText .TextSize = 13 ;

State .SpearStatusText .Font = Enum.Font.GothamBoldHM1uHIZZl0.SpearStatusText .TextXAlignment =Enum.TextXAlignment .LeftState .SpearStatusText .TextTruncate  = Enum .TextTruncate  .AtEndState.SpearStatusText .Parent = State.SpearMainFrame State .SpearInfoText = Instance.new ( "TextLabel" )State.SpearInfoText .Name = "InfoText"State .SpearInfoText  .Size =UDim2.new ( 1 , - 18  , 0 , 14 ) State .SpearInfoText .Position =UDim2.new ( 0 , 14, 0, 23 ) State .SpearInfoText  .BackgroundTransparency = 1HM1uHIZZl0 .SpearInfoText .Text  ="Aim to Survivor"State .SpearInfoText  .TextColor3 =Color3.fromRGB ( 160 , 160 , 170 )State .SpearInfoText .TextSize  = 10 ;

 State.SpearInfoText .Font = Enum.Font  .Gotham State.SpearInfoText .TextXAlignment = Enum.TextXAlignment  .Left State.SpearInfoText .TextTruncate = Enum .TextTruncate  .AtEnd State.SpearInfoText .Parent = State .SpearMainFrameState.SpearIndicatorGui =umDlo
end LIB.Bvolu1 ( )
function LIB.Bznqp( ) State .SnapLineGui =Instance.new ( "ScreenGui" )State.SnapLineGui .Name = "SpearVeil_SnapLine"State.SnapLineGui .IgnoreGuiInset =true;

 State.SnapLineGui  .ResetOnSpawn  =false State.SnapLineGui .DisplayOrder = 999999 pcall (function( ) State .SnapLineGui .Parent = (gethui  and gethui ( )or game.GetService ( game ,"CoreGui" ) )
end )
if not  State.SnapLineGui .Parent
	then  State.SnapLineGui .Parent =PlayerGui
end State.SnapLineFrame = Instance.new ( "Frame" ) State.SnapLineFrame  .Name ="Line"State.SnapLineFrame .AnchorPoint = Vector2 .new  ( 0.5 , 0.5)State .SnapLineFrame .BorderSizePixel = 0HM1uHIZZl0.SnapLineFrame .BackgroundColor3 =Color3.fromRGB  ( 255 , 220, 0 ) State.SnapLineFrame .BackgroundTransparency  =0.35 State.SnapLineFrame .Visible  = false;

State.SnapLineFrame .Parent = State.SnapLineGui State.SnapLineDot = Instance.new ( "Frame"  )State .SnapLineDot .Name  ="Dot"State .SnapLineDot .AnchorPoint =Vector2 .new (0.5 ,0.5 )State.SnapLineDot .BorderSizePixel = 0 State .SnapLineDot .BackgroundColor3  = Color3.fromRGB ( 255, 220, 0 ) State .SnapLineDot .BackgroundTransparency =0 State .SnapLineDot .Size = UDim2.fromOffset ( 4 , 4 )State.SnapLineDot .Visible = false ;

 State .SnapLineDot .Parent  =State .SnapLineGui
local ppWZDlMxM1Zz =Instance.new ("UICorner" ) ;

ppWZDlMxM1Zz .CornerRadius  = UDim.new (1,0 )  ;

 ppWZDlMxM1Zz.Parent = State.SnapLineDot State.SnapLineTextLabel =Instance.new ("TextLabel" )State .SnapLineTextLabel .Name ="InfoText" State.SnapLineTextLabel .AnchorPoint =Vector2 .new  ( 0.5,1 )State.SnapLineTextLabel .Size  =UDim2.new  ( 0 , 200  ,0,16)State.SnapLineTextLabel .BackgroundTransparency =  1 State.SnapLineTextLabel .Text = "" State.SnapLineTextLabel .TextColor3 =Color3.fromRGB (  255 , 255, 255 ) State .SnapLineTextLabel .TextSize  =12;

 State.SnapLineTextLabel .Font =Enum.Font.GothamBoldHM1uHIZZl0 .SnapLineTextLabel .TextStrokeTransparency = 0HM1uHIZZl0.SnapLineTextLabel .TextStrokeColor3 = Color3.new ( 0 , 0  , 0 )State.SnapLineTextLabel  .TextXAlignment =Enum .TextXAlignment .Center State .SnapLineTextLabel .TextTruncate =Enum.TextTruncate .AtEndState .SnapLineTextLabel .Visible = false ;

 State.SnapLineTextLabel .Parent =State .SnapLineGui
end LIB.Bznqp(  )
function LIB.Wlx1W0xW ( WpUuO1bQbqvqOW,BH_lz_O1D_QU,MODqwXnbn1Iz,qUxWlwvHZX )
local lZDoumw0Olul = math.cos ( BH_lz_O1D_QU )
if  lZDoumw0Olul <=0.015
	then
	return nil , nil
end
local OZmnlX0= WpUuO1bQbqvqOW / (MODqwXnbn1Iz*lZDoumw0Olul)
if OZmnlX0~=OZmnlX0 or OZmnlX0<= 0
	then
	return nil , nil
end
local Mv0x0HI1pbbmXz= 1 / 60
local  plbn1ZmwxlpZbQ = 0.5 *qUxWlwvHZX*Mv0x0HI1pbbmXz *OZmnlX0
local DxoQlvDUxHWxXW =MODqwXnbn1Iz *math.sin ( BH_lz_O1D_QU) *OZmnlX0- ( 0.5*qUxWlwvHZX*OZmnlX0* OZmnlX0) - plbn1ZmwxlpZbQ
return  DxoQlvDUxHWxXW , OZmnlX0
end
function LIB.oIO1v (pOMWuuQm ,bZ00l ,pmIHpDvpplMp, lMpMW ,HUqXuvXuWXu_ )
local qDzpoH0qXNM1Wu,lv_NWuq_pDX0l=LIB.Wlx1W0xW (pOMWuuQm, pmIHpDvpplMp,lMpMW ,HUqXuvXuWXu_)
if  not qDzpoH0qXNM1Wu or  not lv_NWuq_pDX0l
	then
	return nil
end
if lv_NWuq_pDX0l< 0.025 or lv_NWuq_pDX0l > 5
	then
	return nil
end
local bWlpq =math (qDzpoH0qXNM1Wu -bZ00l )
local wOnzz0OW1Xxq = math ( pmIHpDvpplMp- FOV_42_RAD, 0 ) * 0.35
local NwMqv = math (lv_NWuq_pDX0l-1.3,0) *0.25
return bWlpq+ wOnzz0OW1Xxq +NwMqv , bWlpq,lv_NWuq_pDX0l
end
function LIB.MqHuIln( qDWnbvupq,vlW1OHDx, MXMWUZn, MIlmOQHI)
if MXMWUZn <= 0
	then MXMWUZn = 142.5
end
if MIlmOQHI<= 0
	then MIlmOQHI= 196.2
end
local QqNpXI1ZMxU= vlW1OHDx-qDWnbvupq
local vwn1X= Vector3.new  ( QqNpXI1ZMxU .X  ,0,QqNpXI1ZMxU .Z  )
local  Iopppl = vwn1X .Magnitude
local lnn0WNZ=QqNpXI1ZMxU.Y
if QqNpXI1ZMxU .Magnitude <=0.001
	then
	return nil
end
if Iopppl <=0.35 or MIlmOQHI<=0.001
	then
	return  QqNpXI1ZMxU.Unit  ,math ( QqNpXI1ZMxU.Magnitude /MXMWUZn, 0.025 , 5)
end
local bZ0xl0mb= vwn1X .Unit
local H_UWmn=math.atan2  (lnn0WNZ , Iopppl )
local OpvMHpHpXN_vZ =math ( - FOV_28_RAD, H_UWmn-FOV_18_RAD)
local lQovnQD = FOV_72_RAD
local  QpwzDvQvX , IoXwDmzowvXbU, QxlObm0WO,bzlz1QD1DXvW = nil,math.huge , math.huge ,nil
local B1qMwpwxn = 30
	do
	local IzN0DMzZWuI= bit32 . band(369 ,0 )
	local pzOxz1luODDUM=bit32 . bor(IzN0DMzZWuI , 571 ) - 571
end
for pzWN01unm= 0,B1qMwpwxn
	do
	local  BxW1bzMXXDOm=OpvMHpHpXN_vZ +  ( lQovnQD -OpvMHpHpXN_vZ) *  ( pzWN01unm /B1qMwpwxn )
	local Im1M_l11z0, ql_pn , lONQu = LIB.oIO1v (Iopppl,lnn0WNZ,BxW1bzMXXDOm,MXMWUZn, MIlmOQHI )
	if Im1M_l11z0  and Im1M_l11z0< IoXwDmzowvXbU
		then IoXwDmzowvXbU, QxlObm0WO,QpwzDvQvX, bzlz1QD1DXvW= Im1M_l11z0,ql_pn, BxW1bzMXXDOm ,lONQu
		if QxlObm0WO<MIN_TRAVEL_TIME
			then break
		end
	end
end
if QpwzDvQvX
	then
	local  HMNMN= (lQovnQD -OpvMHpHpXN_vZ)  / B1qMwpwxn* 2.5
	local lQmx0Q1WQqq = (QxlObm0WO<MIN_TRAVEL_TIME)and 1 or 4
	for NwvmmmvvoWw= 1 , lQmx0Q1WQqq
		do
		local pZumMoH0DzbUbD, _on_z,DxNXwp1xOOU,w_nUqDWxW= QpwzDvQvX,IoXwDmzowvXbU,QxlObm0WO,bzlz1QD1DXvW
		for  pZzwNxD= - 3 , 3
			do
			local vWqzxlXXX1=math (QpwzDvQvX + HMNMN* ( pZzwNxD/3 ) ,OpvMHpHpXN_vZ ,lQovnQD )
			local pXxIUqDwzqU, Mu0xw1ul1vQ,wN1qup1xQ1U =LIB.oIO1v (Iopppl,lnn0WNZ, vWqzxlXXX1, MXMWUZn, MIlmOQHI )
			if pXxIUqDwzqU and pXxIUqDwzqU< _on_z
				then _on_z,DxNXwp1xOOU ,pZumMoH0DzbUbD, w_nUqDWxW=pXxIUqDwzqU , Mu0xw1ul1vQ ,vWqzxlXXX1 , wN1qup1xQ1U
			end
		end QpwzDvQvX,IoXwDmzowvXbU , QxlObm0WO ,bzlz1QD1DXvW = pZumMoH0DzbUbD ,_on_z,DxNXwp1xOOU, w_nUqDWxW
		if QxlObm0WO< MIN_TRAVEL_TIME
			then break
		end HMNMN=HMNMN *0.38
	end
end
if not  QpwzDvQvX
	then
	local w0UQHoZHMH = math (Iopppl/MXMWUZn , 0.025, 5)
	local WnXoDZpu= vlW1OHDx+Vector3.new (0 ,0.5 *MIlmOQHI * w0UQHoZHMH*w0UQHoZHMH , 0 )
	local MUopUO= WnXoDZpu - qDWnbvupq
	if MUopUO.Magnitude <=0.001
		then
		return nil
	end
	return MUopUO.Unit ,w0UQHoZHMH
end
local bw_wDDwMWx =bZ0xl0mb* math.cos ( QpwzDvQvX) + Vector3.new ( 0,math.sin (QpwzDvQvX)  , 0 )
if bw_wDDwMWx .Magnitude <= 0.001
	then if( 0>1)
		then
		if (221<497 )
			then
			local qbDUHm1QlMoD1 = 221 +497
		end
	end
	return nil
end
return bw_wDDwMWx .Unit , bzlz1QD1DXvW
end
function LIB.vpDvmUq ( q00HInHX0,_qZ0xw , NOwXIDzvXX,wDzZmp_p0m_oo)
if NOwXIDzvXX<= 0 or wDzZmp_p0m_oo<= 0
	then
	return false
end
local vb0qllMol1,uvoumZnNuNXoI,v0NQ1wOumuHvw, _XoQIuUzz0NW=q00HInHX0 , _qZ0xw,NOwXIDzvXX ,wDzZmp_p0m_oo
local pUlp1nzv1v_z_ = (_XoQIuUzz0NW *vb0qllMol1* vb0qllMol1 ) / (  2 * v0NQ1wOumuHvw *v0NQ1wOumuHvw)
if pUlp1nzv1v_z_<=0
	then
	return false
end
local bumDuWQWQON ,qxWb0NlMHXbmNv, NpoNDMMpwx = pUlp1nzv1v_z_ , -vb0qllMol1,uvoumZnNuNXoI+pUlp1nzv1v_z_
return( qxWb0NlMHXbmNv*qxWb0NlMHXbmNv -4* bumDuWQWQON*NpoNDMMpwx) >= 0
end
function LIB.BQOObX(qnNUMI, BlzQl0,q_x_WUQUoO_v)
for WumzQw=0.1 ,3.0, 0.05
	do
	local HIbQlwI0qMNn = 23
	if  WumzQw< 1
		then HIbQlwI0qMNn=math (23 , WumzQw * 150 )
	else
	if WumzQw< 2
		then HIbQlwI0qMNn= 142.5
	else HIbQlwI0qMNn =165
end
if LIB.vpDvmUq( qnNUMI,BlzQl0,HIbQlwI0qMNn, q_x_WUQUoO_v )
	then
	return WumzQw
end
end
return nil
end
	do LIB.vbbz0lv = ReplicatedStorage .WaitForChild ( ReplicatedStorage ,"Remotes" ) :WaitForChild("Killers" ) : WaitForChild( "Veil" ) : WaitForChild ( "Spearthrow" )LIB.u0uHqHxm0DHI=ReplicatedStorage.WaitForChild (ReplicatedStorage, "Remotes" )  :WaitForChild("Mechanics" )  : WaitForChild("visualize" ) LIB.u0uHqHxm0DHI .OnClientEvent :Connect (
	function ( NQ1nvw,BXZl_ ,NWMIwUoHQOZo_W ,NnubI0U0oOm)
	if NQ1nvw== LocalPlayer.Character
		then
		if type (NWMIwUoHQOZo_W)  == "number" and NWMIwUoHQOZo_W>  0
			then State .lastSpearSpeed =NWMIwUoHQOZo_W
		end
		if type ( NnubI0U0oOm ) == "number"and  NnubI0U0oOm>=0
			then State.lastGravityMult  = NnubI0U0oOm
		end
	end
end) LIB.N_ulNqbOqbD0=hookmetamethod(game,"__namecall"  ,function( ... )
local vqwMw= getnamecallmethod ( )
if vqwMw == "FireServer"
	then
	local _lNImIW =table.pack ( ... )
	local IbpZxxHOv=_lNImIW [ 1 ]
	if  typeof ( IbpZxxHOv) == "Instance"and rawequal (IbpZxxHOv , LIB.vbbz0lv )
		then
		if State.silentSpearEnabledand typeof ( State.silentSpearLookVector  )  =="Vector3"
			then
			if _lNImIW.n >= 4and typeof (_lNImIW [2 ] ) == "Vector3" and typeof ( _lNImIW[ 4] ) == "Vector3"
				then _lNImIW[ 2 ] = State.silentSpearLookVector
				return LIB.N_ulNqbOqbD0 ( table (_lNImIW, 1 , _lNImIW .n ) )
			end
		end
	end
end
return LIB.N_ulNqbOqbD0 ( ...  )
end)LIB.IOqIuMI = hookmetamethod( game,"__index" , function(bNwvpn_MwU , bqQDnmuN)
if bqQDnmuN =="FireServer"and typeof ( bNwvpn_MwU) == "Instance" and rawequal ( bNwvpn_MwU, LIB.vbbz0lv )
	then
	return newcclosure(function( ... )
	local _uUU_oxHZI=table.pack ( ... )
	if State.silentSpearEnabled and typeof (State.silentSpearLookVector ) == "Vector3"
		then
		if _uUU_oxHZI .n >= 4 and typeof ( _uUU_oxHZI[ 2 ] ) =="Vector3" and typeof  (_uUU_oxHZI[ 4 ] ) =="Vector3"
			then _uUU_oxHZI [2 ] = State .silentSpearLookVector
		end
	end
	return LIB.IOqIuMI( bNwvpn_MwU, bqQDnmuN) ( table (_uUU_oxHZI, 1, _uUU_oxHZI .n ) )
end)
end
return LIB.IOqIuMI ( bNwvpn_MwU , bqQDnmuN )
end)
end
	do LIB.vnQWv = {

}
	function LIB.WuuUo( lxQbWWOzw , qU_xzUvb0vx)
	local pZbvxUmpqwlW =lxQbWWOzw  and lxQbWWOzw .Parent
	while  pZbvxUmpqwlW
		do
		if pZbvxUmpqwlW .Name ==qU_xzUvb0vx
			then
			return true
		end pZbvxUmpqwlW = pZbvxUmpqwlW.Parent
	end
	return false
end
function LIB.NluUIOonNHv( Hb_HNXDuwbN)
if not ( Hb_HNXDuwbN and Hb_HNXDuwbN.IsA ( Hb_HNXDuwbN ,"GuiButton" ) )
	then
	return false
end
if Hb_HNXDuwbN.Name ~="attack" and Hb_HNXDuwbN.Name ~="Gui-mob"
	then
	return false
end
if not  LIB.WuuUo(Hb_HNXDuwbN, "Slasher-mob" )and not LIB.WuuUo ( Hb_HNXDuwbN , "Survivor-mob" )
	then
	return  false
end
if not LIB.WuuUo (Hb_HNXDuwbN ,"Control" )and not  LIB.WuuUo(Hb_HNXDuwbN,"Controls" )
	then
	return false
end
return true
end
function LIB.uqXMUqx (WXmwQqQX)
if not LIB.NluUIOonNHv(WXmwQqQX)
	then
	return
end
if LIB.vnQWv[WXmwQqQX]
	then
	return
end LIB.vnQWv[WXmwQqQX ] = true WXmwQqQX.InputBegan : Connect(function( wUbqNonzq)
local _vn0U=wUbqNonzq.UserInputType
if _vn0U ~=Enum .UserInputType .Touchand _vn0U~=Enum.UserInputType .MouseButton1
	then
	return
end
local bX_ZI=LocalPlayer .Character
if bX_ZI and  bX_ZI.GetAttribute (bX_ZI,"spearmode" )
	then  State.spearIsHolding = true;
	
State.spearHoldStartTime =tick (  )
end
end ) WXmwQqQX.InputEnded :Connect( function(MbWHWUbwwoI )
local v0pIb_Un = MbWHWUbwwoI.UserInputType
if v0pIb_Un~= Enum .UserInputType .Touch and v0pIb_Un ~=Enum.UserInputType .MouseButton1
	then
	return
end State .spearIsHolding  =false ;

 State.spearHoldStartTime  =nil
end )
end
function  LIB.olonnon (  )
local OnDUHXmH=LocalPlayer .FindFirstChildOfClass ( LocalPlayer ,"PlayerGui"  )or PlayerGui
if not OnDUHXmH
	then
	return
end pcall  (function( )
for l0zz0Z , pMW1_OxbqD in ipairs ( OnDUHXmH.GetDesc
endants (OnDUHXmH ) )
	do LIB.uqXMUqx (pMW1_OxbqD )
end
end)OnDUHXmH.Desc
endantAdded :Connect (
function (lIvIqWHNN)LIB.uqXMUqx (lIvIqWHNN)
end)
end UserInputService .InputBegan : Connect ( function(pHxlmuU, w1zMwI)
if pHxlmuU.UserInputType ==Enum .UserInputType .MouseButton1
	then
	local oXxvqXOD=LocalPlayer .Character
	if oXxvqXOD and oXxvqXOD .GetAttribute ( oXxvqXOD ,"spearmode" )
		then State.spearIsHolding =true ;
		
State .spearHoldStartTime = tick ( )
	end
end
end) UserInputService .InputEnded :Connect (function(oluzZHmXm0pzuM)
if oluzZHmXm0pzuM.UserInputType ==Enum.UserInputType .MouseButton1
	then State.spearIsHolding = false ;
	
State .spearHoldStartTime = nil
end
end ) LIB.olonnon( )
end RegisterTask ( "Spear_UpdateSnapLine" ,0 ,
function ( vvo_Wqm0mw)
local  _vpb_vZbuowOM= State .SPEAR_SNAPLINE
if not  _vpb_vZbuowOM .enabled
	then
	if State.SnapLineFrame
		then State.SnapLineFrame .Visible = false
	end
	if State .SnapLineDot
		then State.SnapLineDot .Visible =false
	end
	if State .SnapLineTextLabel
		then State .SnapLineTextLabel .Visible = false
	end _vpb_vZbuowOM .locked =false ;
	
 _vpb_vZbuowOM.lockedTarget  =nil ;
	
_vpb_vZbuowOM.lockedPlayerName = ""
	return
end
local Hb0zuW_ZUl_XMN = Workspace .CurrentCamera
if not Hb0zuW_ZUl_XMN
	then
	if State.SnapLineFrame
		then State.SnapLineFrame  .Visible = false
	end
	if  State.SnapLineDot
		then State .SnapLineDot .Visible = false
	end
	if State .SnapLineTextLabel
		then State .SnapLineTextLabel .Visible = false
	end
	return
end
local wn0xN = LocalPlayer.Character
local vbQOO_qQ=wn0xN and wn0xN.GetAttribute  (wn0xN ,"spearmode"  )
if not vbQOO_qQ
	then
	if State.SnapLineFrame
		then State.SnapLineFrame .Visible  = false
	end
	if State.SnapLineDot
		then State.SnapLineDot .Visible =false
	end
	if State.SnapLineTextLabel
		then  State.SnapLineTextLabel .Visible = false
	end
	return
end
local HvHvMlXv= Hb0zuW_ZUl_XMN .ViewportSize
local NzwXOZNwMmoXq= Vector2 .new (HvHvMlXv.X  / 2,HvHvMlXv.Y / 2)
local vMXwuWvbbMwDUW=wn0xN and wn0xN.FindFirstChild  ( wn0xN,"HumanoidRootPart" )
local
function lvHDz ( )
local O1XnOXz =nil
local HIDN0 =math.huge
local Dxwnp_HO =math.huge
for D_xMx , loxlI_o in ipairs (GetService .GetPlayers  ( GetService ) )
	do
	if loxlI_o~= LocalPlayer and GetPlayerRole(loxlI_o ) =="survivor"
		then
		local DWmvOwMwpQmzmu= loxlI_o .Character
		if DWmvOwMwpQmzmu
			then
			local _OIxQNzwb1OW=DWmvOwMwpQmzmu.FindFirstChildOfClass (DWmvOwMwpQmzmu , "Humanoid" )
			local MHwoOOIQXNXU_o= LIB.ppmDZmUwpIop(DWmvOwMwpQmzmu)
			if MHwoOOIQXNXU_o and _OIxQNzwb1OW and  _OIxQNzwb1OW.Health > 0 and _OIxQNzwb1OW .Health >50  and not DWmvOwMwpQmzmu .GetAttribute (DWmvOwMwpQmzmu,"IsHooked"  )
				then
				local pOnpnOzvZn = vMXwuWvbbMwDUW and( MHwoOOIQXNXU_o - vMXwuWvbbMwDUW.Position ) .Magnitude or0
				if pOnpnOzvZn <= Config.spearSnaplineMaxDistance
					then
					local D0b1xbl, DxMZHvUNN =Hb0zuW_ZUl_XMN .WorldToViewportPoint (Hb0zuW_ZUl_XMN , MHwoOOIQXNXU_o )
					if DxMZHvUNN
						then
						local  lxDlxvMb0Zpl= ( Vector2.new  (D0b1xbl.X , D0b1xbl.Y ) -NzwXOZNwMmoXq) .Magnitude
						if lxDlxvMb0Zpl<= Config.spearFovRadius
							then
							if lxDlxvMb0Zpl < HIDN0
								then HIDN0 =lxDlxvMb0Zpl;
								
Dxwnp_HO= pOnpnOzvZn;
								
 O1XnOXz = loxlI_o
							end
						end
					end
				end
			end
		end
	end
end
return  O1XnOXz, HIDN0, Dxwnp_HO
end
if State .spearIsHoldingand not _vpb_vZbuowOM .locked
	then
	local IWU1v1HbN1u1,NDuxlDnvw , QZqzuNnNI= lvHDz (  )
	if IWU1v1HbN1u1
		then _vpb_vZbuowOM .locked =true ;
		
_vpb_vZbuowOM.lockedTarget = IWU1v1HbN1u1 _vpb_vZbuowOM .lockedPlayerName =IWU1v1HbN1u1.Name ;
		
 _vpb_vZbuowOM.currentNearestDist = QZqzuNnNI
	end
end
if not State.spearIsHolding
	then _vpb_vZbuowOM.locked  = false;
	
 _vpb_vZbuowOM .lockedTarget = nil;
	
 _vpb_vZbuowOM.lockedPlayerName =""
end
local WvIIwbDxOWMXwX = false
local  uWOOoo =nil
local NoxqN =0
local WpoxvZIHqUXqDz=nil
if  _vpb_vZbuowOM.lockedand _vpb_vZbuowOM .lockedTarget
	then
	local oQUwpuuMIv0_=_vpb_vZbuowOM.lockedTarget .Character
	if oQUwpuuMIv0_
		then
		local vNDpb_ZnpNubzI= oQUwpuuMIv0_ .FindFirstChildOfClass ( oQUwpuuMIv0_,"Humanoid" )
		local DxMnDox= LIB.ppmDZmUwpIop ( oQUwpuuMIv0_ )
		if DxMnDox and  vNDpb_ZnpNubzI and vNDpb_ZnpNubzI.Health > 50  and not oQUwpuuMIv0_.GetAttribute  ( oQUwpuuMIv0_,"IsHooked"  )
			then
			local Nq0xn ,l0lOop1=Hb0zuW_ZUl_XMN.WorldToViewportPoint ( Hb0zuW_ZUl_XMN, DxMnDox)
			if  l0lOop1
				then
				local _nlUb = (Vector2 .new ( Nq0xn.X ,Nq0xn.Y ) -NzwXOZNwMmoXq ) .Magnitude
				if _nlUb<=Config .spearFovRadius *1.15
					then uWOOoo = Vector2.new  (Nq0xn.X ,Nq0xn.Y )NoxqN= vMXwuWvbbMwDUW and ( DxMnDox- vMXwuWvbbMwDUW.Position ) .Magnitudeor  0 WpoxvZIHqUXqDz =DxMnDox;
					
 WvIIwbDxOWMXwX=true  _vpb_vZbuowOM .currentNearestDist  =NoxqN
				end
			end
		end
	end
	if not WvIIwbDxOWMXwX
		then _vpb_vZbuowOM.locked  =false ;
		
_vpb_vZbuowOM .lockedTarget =nil ;
		
 _vpb_vZbuowOM.lockedPlayerName = ""
	end
end
local WWDxnpWx_D =nil
local bOnNoNQ= 0
local QDMOHqw_H0qD= nil
local unZXzDooOlXv =nil
if not _vpb_vZbuowOM .locked
	then
	local DxlXb, IuMqN1DNOlp,p0mQINu= lvHDz ( )
	if DxlXb
		then
		local HUomIMXXZ = LIB.ppmDZmUwpIop(DxlXb .Character )
		local Hw0UQ ,OuUuHnNN1o= Hb0zuW_ZUl_XMN .WorldToViewportPoint  ( Hb0zuW_ZUl_XMN,HUomIMXXZ) WWDxnpWx_D =Vector2.new (Hw0UQ.X  , Hw0UQ.Y ) bOnNoNQ= p0mQINu ;
		
 QDMOHqw_H0qD= HUomIMXXZ unZXzDooOlXv =DxlXb;
		
_vpb_vZbuowOM .currentNearestDist  =p0mQINu
	end
end
local IHupbUQlqW = false
if State .spearIsHolding and  State.spearHoldStartTime and vMXwuWvbbMwDUW
	then
	local pmn_nDZM =WpoxvZIHqUXqDz or(unZXzDooOlXv and LIB.ppmDZmUwpIop (unZXzDooOlXv .Character ) )
	if pmn_nDZM
		then
		local oMwp1_uvNw=Hb0zuW_ZUl_XMN .CFrame .Position
		local uMbQqxOoHpUDD = pmn_nDZM -oMwp1_uvNw
		local pDbxQZzlu1Om =Vector3.new (uMbQqxOoHpUDD.X , 0 , uMbQqxOoHpUDD .Z )
		local Dn0XDvbwlu_x_=pDbxQZzlu1Om .Magnitude
		local BoQbIU=uMbQqxOoHpUDD.Y
		local wWDQWv = Workspace .Gravity * (State .lastGravityMultor 1 )
		local  oDNWNQ =LIB.BQOObX( Dn0XDvbwlu_x_ ,BoQbIU, wWDQWv )
		if oDNWNQ
			then
			local HZI__U= tick ( ) - State .spearHoldStartTime
			if HZI__U >= oDNWNQ
				then IHupbUQlqW=true
			end
		end
	end
end
local Qoxwm= nil
local  oIxlONx1X = ""
local ux0_0vmD =0
if _vpb_vZbuowOM .lockedand WvIIwbDxOWMXwX
	then Qoxwm=uWOOoo;
	
 oIxlONx1X = _vpb_vZbuowOM .lockedPlayerName ux0_0vmD =NoxqN
else
if WWDxnpWx_D
	then Qoxwm= WWDxnpWx_D;
	
 oIxlONx1X= unZXzDooOlXv and unZXzDooOlXv.Nameor "" ux0_0vmD =bOnNoNQ
end
local OQwXzu0O_p = pcall (
function ( )
if  not State .SnapLineFrame or not State.SnapLineDotor not State.SnapLineTextLabelor not  Hb0zuW_ZUl_XMN
	then
	if State.SnapLineFrame
		then State.SnapLineFrame  .Visible =false
	end
	if State.SnapLineDot
		then State.SnapLineDot .Visible = false
	end
	if State .SnapLineTextLabel
		then State.SnapLineTextLabel .Visible = false
	end
	return
end
if not Qoxwm
	then State.SnapLineFrame .Visible =false ;
	
State .SnapLineDot  .Visible =false State.SnapLineTextLabel .Visible = false ;
	
_vpb_vZbuowOM .currentNearestDist =math.huge
	return
end
local NWO1I = NzwXOZNwMmoXq ;

local DxoOO1pInNl= Qoxwm
local wXDZmZp0qOWO=DxoOO1pInNl- NWO1I;


local _bwuuHvWp = wXDZmZp0qOWO.Magnitude
if _bwuuHvWp < 2
	then State .SnapLineFrame .Visible  = false;
	
 State .SnapLineDot .Visible  = false State .SnapLineTextLabel .Visible =false;
	

	return
end
local _mpqbM_zMvI =IHupbUQlqW
local pmwXQb0= _mpqbM_zMvI  and Color3.fromRGB ( 0  , 255 ,120 ) or Color3.fromRGB  ( 255 , 220 , 0 )
local WvZx0zNqMW_bNp=_mpqbM_zMvI and 0.08 or 0.35 State.SnapLineFrame .BackgroundColor3 = pmwXQb0 State.SnapLineFrame .BackgroundTransparency  =WvZx0zNqMW_bNp State .SnapLineFrame .Size =UDim2.fromOffset (_bwuuHvWp , _mpqbM_zMvI and2 or 1 )State .SnapLineFrame .Position =UDim2.fromOffset ( (NWO1I.X +DxoOO1pInNl.X ) * 0.5 , ( NWO1I .Y + DxoOO1pInNl.Y  )  *0.5 )State.SnapLineFrame  .Rotation  =math.deg (math.atan2 (wXDZmZp0qOWO.Y ,wXDZmZp0qOWO.X ) )State .SnapLineFrame .Visible = true  State .SnapLineDot .BackgroundColor3 =pmwXQb0 State.SnapLineDot .Position = UDim2.fromOffset (DxoOO1pInNl.X  , DxoOO1pInNl.Y ) State.SnapLineDot .Visible = true
if Config.spearSnaplineShowText and oIxlONx1X~= ""
	then State.SnapLineTextLabel .Text =string ("%s [%dm]" ,oIxlONx1X, math (ux0_0vmD)  ) State .SnapLineTextLabel .TextColor3 = pmwXQb0 State.SnapLineTextLabel .Position =UDim2.fromOffset  ( DxoOO1pInNl.X ,DxoOO1pInNl .Y -14)State .SnapLineTextLabel .Visible = true
else State .SnapLineTextLabel .Visible = false
end
end)
if not OQwXzu0O_p
	then
	if State .SnapLineFrame
		then State .SnapLineFrame .Visible  =false
	end
	if State.SnapLineDot
		then State.SnapLineDot  .Visible = false
	end
	if  State.SnapLineTextLabel
		then State.SnapLineTextLabel .Visible = false
	end
end
end) RegisterTask ("Spear_UpdateSpearSystem" , 0 , function( )
if State.SpearFOVCircle
	then State.SpearFOVCircle  .Visible =State.spearFovCircleEnabled
	local D0UXlbNnwI11 = Config.spearFovRadius * 2
	if State .SpearFOVCircle .Size .X .Offset  ~=D0UXlbNnwI11
		then State.SpearFOVCircle .Size = UDim2.new (0 , D0UXlbNnwI11 , 0  ,D0UXlbNnwI11)
	end
end
if not State .silentSpearEnabled
	then State .silentSpearTargetTorso = nil;
	
State .silentSpearLookVector =nil
end
local lxwxD=LocalPlayer.Character
local WNUlz=lxwxD and lxwxD.GetAttribute ( lxwxD, "spearmode" )
if not State.spearIndicatorEnable
	dor not WNUlz
		then
		if State .SpearIndicatorGui
			then State .SpearIndicatorGui .Enabled  =false
		end
		if not State .silentSpearEnabled or not WNUlz
			then
			return
		end
	end
	local DDW1X = lxwxD and lxwxD .FindFirstChild (lxwxD, "HumanoidRootPart" )
	if not DDW1X
		then
		return
	end
	local p1oov = workspace .CurrentCamera
	if not p1oov
		then
		return
	end
	if State.spearIndicatorEnabledand WNUlz and State.SpearIndicatorGui
		then State.SpearIndicatorGui  .Enabled = true
	end
	local  upxqloop = nil
	local _vulNzvqxwQQ =math.huge
	local wDDXpzDq = math.huge
	local _oM0xzo =false
	local vMIqlpHpQob=Vector2 .new (p1oov.ViewportSize .X / 2 , p1oov .ViewportSize  .Y / 2 )
	for  lWIHb_1, H_HUX0oZmvoxI in ipairs ( GetService .GetPlayers (GetService ) )
		do
		if H_HUX0oZmvoxI~=LocalPlayer and GetPlayerRole( H_HUX0oZmvoxI) =="survivor"
			then
			local  QbHI_N1u_qIQM = H_HUX0oZmvoxI .Character
			if QbHI_N1u_qIQM
				then
				local  umUHnqDbqm= QbHI_N1u_qIQM.FindFirstChildOfClass (QbHI_N1u_qIQM,"Humanoid" )
				local MwNUbHbn1= LIB.ppmDZmUwpIop (QbHI_N1u_qIQM)
				local WXXDQvpwZ = QbHI_N1u_qIQM .FindFirstChild  (QbHI_N1u_qIQM, "HumanoidRootPart" )
				if umUHnqDbqm and umUHnqDbqm.Health  > 50 and typeof ( MwNUbHbn1 )  == "Vector3"and  WXXDQvpwZ and not  QbHI_N1u_qIQM.GetAttribute (QbHI_N1u_qIQM,"IsHooked" )
					then
					local _ZuOoquMnDDvn = ( MwNUbHbn1- DDW1X .Position ) .Magnitude
					local NuzNU,DxlO1 = p1oov.WorldToViewportPoint ( p1oov , MwNUbHbn1)
					if  DxlO1
						then
						local lmwNON0bpWM1v = (Vector2.new (NuzNU .X , NuzNU.Y ) -vMIqlpHpQob) .Magnitude
						if lmwNON0bpWM1v<= Config .spearFovRadius
							then
							if lmwNON0bpWM1v<_vulNzvqxwQQ
								then _vulNzvqxwQQ=lmwNON0bpWM1v;
								
wDDXpzDq=_ZuOoquMnDDvn upxqloop= H_HUX0oZmvoxI ;
								
_oM0xzo =true
							end
						else
						if not _oM0xzo and  _ZuOoquMnDDvn < wDDXpzDq
							then  wDDXpzDq =_ZuOoquMnDDvn ;
							
 upxqloop =H_HUX0oZmvoxI
						end
					else
					if not _oM0xzo and _ZuOoquMnDDvn < wDDXpzDq
						then wDDXpzDq=_ZuOoquMnDDvn ;
						
upxqloop=H_HUX0oZmvoxI
					end
				end
			end
		end
	end
	if upxqloop and upxqloop .Character
		then
		local wuINmNuuDbOqwM=LIB.ppmDZmUwpIop(upxqloop.Character )
		if wuINmNuuDbOqwM
			then  _oM0xzo = LIB._vMo1mZ1l( p1oov ,wuINmNuuDbOqwM ,Config.spearFovRadius )
		end
	end
	if State.spearIndicatorEnabled and WNUlz
		then
		if not upxqloop  or not upxqloop .Character
			then  State.SpearStatusText .Text = "NO TARGET" State .SpearStatusText .TextColor3 = Color3.fromRGB (200 , 200 ,  200 )State.SpearAccentBar .BackgroundColor3 =Color3.fromRGB ( 80 , 80,  80 )State .SpearInfoText .Text = "Aim to Survivor" ;
			

			return
		end
		local IqZIQIO=LIB.ppmDZmUwpIop(upxqloop .Character  )
		local pqOpN =p1oov.CFrame  .Position
		local ponn_pvvQDwzOD = IqZIQIO-pqOpN
		local Wb1XmqOwqDoOq= Vector3.new  (ponn_pvvQDwzOD.X , 0 , ponn_pvvQDwzOD.Z )
		local  DzHM_In__HMDN =Wb1XmqOwqDoOq.Magnitude
		local  lHWIXw0oNZ =ponn_pvvQDwzOD .Y
		local HZvO0=ponn_pvvQDwzOD.Magnitude
		local lp0zI= Workspace.Gravity * ( State.lastGravityMultor 1 )
		local llIZUvZIN=LIB.BQOObX(DzHM_In__HMDN,lHWIXw0oNZ,lp0zI)
		local  QZ1bqI1xqx_ =upxqloop.Name
		local BXZQpXbnbq= string ("%.0f" ,HZvO0 )
		if not llIZUvZIN
			then State.SpearStatusText .Text = "OUT OF RANGE"State .SpearStatusText .TextColor3  =Color3.fromRGB (255 ,80 ,80)State.SpearAccentBar  .BackgroundColor3 = Color3.fromRGB ( 255,50 , 50)State.SpearInfoText .Text  = string  ( "%s | %s studs" , QZ1bqI1xqx_, BXZQpXbnbq)
		else
		if not _oM0xzo
			then State.SpearStatusText .Text ="AIM AT TARGET" State.SpearStatusText .TextColor3 = Color3.fromRGB (255 , 150 , 150 ) State.SpearAccentBar .BackgroundColor3 = Color3.fromRGB (255, 100 ,  100  )
			local lDvuvMnM , W0IlZNQMzHW_Iz= p1oov .WorldToViewportPoint (p1oov, IqZIQIO)
			local oOUXOo0WlXn1vl= Vector2 .new ( p1oov.ViewportSize  .X / 2 , p1oov.ViewportSize .Y /2)
			local lzwwUpn=  ( Vector2.new  (lDvuvMnM .X ,lDvuvMnM.Y ) -oOUXOo0WlXn1vl)  .Magnitude
			local o100vmw=string ( "%.0f" , lzwwUpn-Config.spearFovRadius )
			if not W0IlZNQMzHW_Iz
				then State.SpearInfoText .Text  = "Target di belakang kamera"
			else State.SpearInfoText  .Text = string ("Masuk FOV: %s px lagi" ,o100vmw)
		end
	else
	if not State .spearIsHolding
		then State.SpearStatusText .Text = "READY"State.SpearStatusText .TextColor3 = Color3.fromRGB ( 255 , 255  ,255 )State.SpearAccentBar .BackgroundColor3 = Color3.fromRGB  ( 150  , 150 ,200) State .SpearInfoText .Text = string ("%s | %s studs | Hold: %ss" ,QZ1bqI1xqx_, BXZQpXbnbq,string ("%.2f" ,llIZUvZIN) )
	else
	local WWm__uuqI= tick ( ) - State.spearHoldStartTime
	local DbD0uuzu = string ( "%.2f" ,WWm__uuqI)
	local M0Iv_I_I =string  ( "%.2f" , llIZUvZIN )
	local vuuu_wvnuW0l =LIB._vMo1mZ1l (p1oov,IqZIQIO,Config .spearFovRadius )
	if not vuuu_wvnuW0l
		then State .SpearStatusText  .Text ="AIM AT TARGET" State.SpearStatusText .TextColor3 = Color3.fromRGB ( 255 ,150, 150 ) State.SpearAccentBar .BackgroundColor3 =Color3.fromRGB (255, 100,  100 )State.SpearInfoText .Text ="Target keluar FOV!"
	else
	if WWm__uuqI >= llIZUvZIN
		then State.SpearStatusText .Text ="RELEASE!" State .SpearStatusText .TextColor3 =Color3.fromRGB ( 80 ,255, 120 )State.SpearAccentBar  .BackgroundColor3 = Color3.fromRGB  ( 50 , 255 ,  100 ) State .SpearInfoText .Text =string ( "Hold: %ss | Ideal: %ss" , DbD0uuzu ,M0Iv_I_I)
	else  State .SpearStatusText .Text ="HOLD..." State.SpearStatusText .TextColor3  = Color3.fromRGB  ( 255 ,220, 100  ) State .SpearAccentBar  .BackgroundColor3 =Color3.fromRGB ( 255 , 200 , 50  ) State .SpearInfoText  .Text =string ( "Hold: %ss | Ideal: %ss" , DbD0uuzu,M0Iv_I_I)
end
end
end
if State.silentSpearEnabledand  WNUlz and upxqloop  and upxqloop .Character
	then
	local MzUnxONb = LIB.ppmDZmUwpIop ( upxqloop.Character )
	local  qObNlX_Ul=upxqloop .Character :FindFirstChild("HumanoidRootPart" )
	if typeof (MzUnxONb) =="Vector3" and qObNlX_Ul
		then
		local  InwZpW= LIB._vMo1mZ1l( p1oov ,MzUnxONb,Config .spearFovRadius )
		if InwZpW
			then
			local  WOXopozU= p1oov.CFrame  .Position
			local QHD1WOqv= MzUnxONb-WOXopozU
			local  HDpxvHUZXbo=QHD1WOqv.Magnitude
			if HDpxvHUZXbo>0.1
				then
				local  MIowbHNlZX0vN =142.5
				if State .spearIsHolding and State .spearHoldStartTime
					then
					local bZwH_MNMvXDX =tick( ) - State .spearHoldStartTime
					if bZwH_MNMvXDX>= 2
						then MIowbHNlZX0vN= 165
					else
					if bZwH_MNMvXDX>= 1
						then MIowbHNlZX0vN= 142.5
					else MIowbHNlZX0vN=math ( 23, bZwH_MNMvXDX * 150 )
				end
			end
			local NU_IubZ_MZp=Workspace .Gravity * (State .lastGravityMultor 1)
			local wXqNx =qObNlX_Ul.AssemblyLinearVelocity
			local MIqoIqz =Vector3.new (wXqNx .X , 0,wXqNx .Z )
			if  MIqoIqz .Magnitude > 65
				then MIqoIqz =MIqoIqz.Unit * 65
			end State.silentSpearTargetVel =MIqoIqz
			local MQlIpoO_oz0n,QnwzNlvHWXuwb0= LIB.MqHuIln ( WOXopozU, MzUnxONb,MIowbHNlZX0vN, NU_IubZ_MZp)
			if MQlIpoO_oz0n and QnwzNlvHWXuwb0
				then
				local B_xNDHonMHQ0X = State .silentSpearTargetVel  *QnwzNlvHWXuwb0
				local QOZlOqQpouunD= MzUnxONb+ B_xNDHonMHQ0X
				local DHOQnwwuovnHxW ,QOvzmllUM = LIB.MqHuIln(WOXopozU ,QOZlOqQpouunD , MIowbHNlZX0vN, NU_IubZ_MZp)
				if DHOQnwwuovnHxW
					then State.silentSpearTargetTorso = QOZlOqQpouunD ;
					
 State.silentSpearLookVector  =DHOQnwwuovnHxW
				else State.silentSpearTargetTorso = nil;
				
 State.silentSpearLookVector =nil
			end
		else State .silentSpearTargetTorso =nil ;
		
 State .silentSpearLookVector =nil
	end
else State .silentSpearTargetTorso =nil ;

State .silentSpearLookVector = nil
end
else State.silentSpearTargetTorso = nil;

State .silentSpearLookVector =nil
end
else State .silentSpearTargetTorso =nil;

State .silentSpearLookVector =nil
end
else State .silentSpearTargetTorso = nil;

 State.silentSpearLookVector = nil
end
end)
end
	do LIB.BZUMvI11 = nil LIB.DmbuD1Qpb=nil LIB._oNm_= nil LIB.wXwovuIzmDD =nil LIB.um_DWDl = false
	function LIB.DWNI01xM ( ) LIB.um_DWDl= false
	if LIB.wXwovuIzmDD
		then pcall  (
		function ( ) LIB.wXwovuIzmDD:Stop ( )
	end ) LIB.wXwovuIzmDD=nil
end
end
function LIB._H1m_uqbulDO ( ) LIB.DWNI01xM( )
if  LIB.DmbuD1Qpb
	then pcall (
	function ( ) task.cancel ( LIB.DmbuD1Qpb)
end) LIB.DmbuD1Qpb =nil
end
if  LIB.BZUMvI11
	then pcall (
	function ( ) LIB.BZUMvI11 : Destroy ( )
end)LIB.BZUMvI11=nil
end
end
function LIB.vlOXUQnZm ( )LIB._H1m_uqbulDO( )
local oOp_Mv= LocalPlayer.Character
if not oOp_Mv
	then
	return
end
local Ho00ZIpb = oOp_Mv.FindFirstChildOfClass ( oOp_Mv , "Humanoid" )
local lX_Qw=LocalPlayer .FindFirstChildOfClass (LocalPlayer, "Backpack"  )
if not Ho00ZIpb or not lX_Qw
	then
	return
end LIB.BZUMvI11=Instance.new ("Tool" ) LIB.BZUMvI11.Name  ="Jerk Off"LIB.BZUMvI11 .ToolTip = "in the stripped club. straight up \"jorking it\" . and by \"it\" , haha, well. let's justr say. My peanits."LIB.BZUMvI11 .RequiresHandle =false LIB.BZUMvI11.Parent = lX_Qw LIB.BZUMvI11 .Equipped :Connect(
function ( )LIB.um_DWDl= true
end) LIB.BZUMvI11.Unequipped : Connect (LIB.DWNI01xM ) Ho00ZIpb .Died : Connect( LIB.DWNI01xM )LIB.DmbuD1Qpb =task.spawn (function( )
while task .wait  ( )
	do
	if not LIB.um_DWDl
		then continue
	end
	local l0mpU0Up = LocalPlayer .Character
	local  BllMvZ1zUu = l0mpU0Up  and l0mpU0Up.FindFirstChildOfClass (l0mpU0Up,"Humanoid"  )
	if not BllMvZ1zUu
		then continue
	end
	local vmxZmXu = BllMvZ1zUu .RigType ==Enum.HumanoidRigType .R15
	if not LIB.wXwovuIzmDD
		then LIB._oNm_= Instance.new ( "Animation" )LIB._oNm_.AnimationId =not vmxZmXu and "rbxassetid://72042024" or "rbxassetid://698251653" pcall (function( ) LIB.wXwovuIzmDD =BllMvZ1zUu.LoadAnimation  (BllMvZ1zUu,LIB._oNm_)
	end)
end
if LIB.wXwovuIzmDD
	then pcall (
	function (  ) LIB.wXwovuIzmDD :Play( )LIB.wXwovuIzmDD: AdjustSpeed(vmxZmXu and 0.7 or 0.65)LIB.wXwovuIzmDD.TimePosition =0.6
end ) task .wait (0.1)
while LIB.wXwovuIzmDD and LIB.wXwovuIzmDD.TimePosition  < (not  vmxZmXu and 0.65 or 0.7)
	do task .wait (0.1)
end
if LIB.wXwovuIzmDD
	then pcall (function( ) LIB.wXwovuIzmDD : Stop ( )
end)LIB.wXwovuIzmDD = nil
end
end
end
end)
end
end
function LIB.bX_UINwW0NZ ( HoHxxlzq,INxbwvxx_DNUw)
if  HoHxxlzq ==LocalPlayer
	then
	return
end
if not INxbwvxx_DNUw or not INxbwvxx_DNUw.Parentor  HoHxxlzq .Character ~= INxbwvxx_DNUw
	then
	return
end UpdatePlayerESP (HoHxxlzq,INxbwvxx_DNUw ) UpdatePlayerOutline ( HoHxxlzq , INxbwvxx_DNUw )
if Config .hitboxEnabled
	then task .wait ( 0.3)
	if HoHxxlzq.Character == INxbwvxx_DNUw  and INxbwvxx_DNUw .Parent
		then WpblbNNwxMIv (HoHxxlzq, INxbwvxx_DNUw)
	end
end
if Config .hitboxEspEnabled
	then _zWMxWbmXoUxzU (HoHxxlzq ,INxbwvxx_DNUw)
end
if  State .autoParryEnable
	dor(AP_State and AP_State.Enabled )
		then
		if  AP_HookKiller
			then AP_HookKiller(HoHxxlzq ,INxbwvxx_DNUw )
		end
	end
end
function LIB.NuMzNx( HpwX0vQxDo1Wpo)
if HpwX0vQxDo1Wpo==LocalPlayer
	then
	return
end  UpdatePlayerRole ( HpwX0vQxDo1Wpo ) AddPlayerESP( HpwX0vQxDo1Wpo) AddPlayerOutline ( HpwX0vQxDo1Wpo)HpwX0vQxDo1Wpo: GetPropertyChangedSignal("Team"  ) :Connect(
function ( ) UpdatePlayerRole(HpwX0vQxDo1Wpo ) task .wait ( 0.2)
if State .autoParryEnabled or ( AP_State  and  AP_State.Enabled )
	then
	if  AP_HookKiller
		then AP_HookKiller ( HpwX0vQxDo1Wpo )
	end
end
end)
if HpwX0vQxDo1Wpo.Character
	then  task.spawn (
	function ( )LIB.bX_UINwW0NZ (HpwX0vQxDo1Wpo , HpwX0vQxDo1Wpo .Character  )
end )
end HpwX0vQxDo1Wpo.CharacterAdded : Connect (function(MwZx_mq )task.spawn ( function( )LIB.bX_UINwW0NZ(HpwX0vQxDo1Wpo,MwZx_mq)
end )
end )
end
function LIB.MnZvvMbQvnOzu( IuXvZp )RemovePlayerESP(IuXvZp)QNnzOW0mu( IuXvZp)
if IuXvZp.Character
	then NnnxXDbZqlOwxv(IuXvZp, IuXvZp.Character  )
end
end GetService .PlayerAdded : Connect ( LIB.NuMzNx) GetService.PlayerRemoving :Connect (LIB.MnZvvMbQvnOzu )
for w0zmvpUIn , MND0WOn in ipairs (GetService.GetPlayers ( GetService) )
	do
	if MND0WOn ~= LocalPlayer
		then LIB.NuMzNx ( MND0WOn)
	end
end
function LIB.pzZMm (ODOwMO ) State .HoldLockActive =false ;

 State.godLastHP = nil  State .CV_HoldingPC  = false;

State .CV_HoldingMobile =false ResetCameraVeil( )
if State .CV_Enabled
	then task.defer (SetupCameraVeilMobile )
end task .spawn ( ox0Np,ODOwMO )
if  State.godEnabled
	then task .wait (0.3) ;
	
HoHNI0HlooDU ( ) ;
	
 D_wqpNMI1MUvm ( )
end
if Config.lockFovEnabled
	then task .wait  ( 0.1) ;
	
 State.originalFOV = nil;
	
LIB.BWQoHbUwlp0MZb (Config.customFovValue )
end
if Config.cameraZoomEnabled
	then task .wait (0.1 ) ;
	
 State.originalMaxZoom = nil ;
	
LIB.w_vnXUZ(Config.cameraZoomValue  )
end
end
if LocalPlayer.Character
	then  task.spawn ( LIB.pzZMm,LocalPlayer.Character )
end LocalPlayer.CharacterAdded :Connect (
function (Nb_bQvlImbwUW)task.spawn  ( LIB.pzZMm ,Nb_bQvlImbwUW)
end ) Players .Heartbeat :Connect(
function (QpQDqWu)
for IXmHQmXHHqno=  1 , #UpdateTasks
	do
	local  Bxu_OOQM= UpdateTasks [ IXmHQmXHHqno ]Bxu_OOQM .timer = Bxu_OOQM.timer  + QpQDqWu
	if Bxu_OOQM.timer >=Bxu_OOQM.interval
		then Bxu_OOQM.timer = 0 Bxu_OOQM .fn (QpQDqWu)
	end
end
end ) LIB.p0WOU0IM = UILib .Win
	dow ( UILib, {
  .Title = "BOLONG-HUB" , .Image  ="84034353458936" , .Footer = "Violence District" , .Author ="Discord.gg/pWpgqVGxNK" , .Color =AccentColor, .Version = 1, .Search  = true ,
} ) LIB.p0WOU0IM : InfoTab( {
 .Name  = "Info"  , .Icon ="info" , .SectionTitle = "Information" , .Banner ="79662603577585"  , .BannerAspectRatio = 16 /5 ,  .Version =Version, .DiscordLink = "https://discord.gg/pWpgqVGxNK" , .DiscordName = "Community BolongHub"  , .DiscordText ="Gabung untuk update & support." ,  .DiscordDesc ="Made by 11rill — features: Killer & Survivor Hitbox/ESP, Auto Aim, Auto Generator, Killer Warn, Camera Veil, and many more." , .CardsWidget = {
 {
  .catwidget ="rbxassetid://117486345000318"
}
} ,
} )LIB.WXDOInoUOHpw = LIB.p0WOU0IM .AddTab (LIB.p0WOU0IM , {
 .Name ="Exclusive" , .Icon = "sparkles"
} ) LIB.uXo1oQQNM= LIB.p0WOU0IM.AddTab (LIB.p0WOU0IM , {
  .Name = "Killer" , .Icon = "swords"
} )LIB.DO_nopuz=LIB.p0WOU0IM .AddTab  (LIB.p0WOU0IM , {
  .Name ="Survivor" , .Icon = "user"
} )LIB._Q_UQwvznNuxzH = LIB.p0WOU0IM .AddTab (LIB.p0WOU0IM ,  {
 .Name  ="Visual" , .Icon = "eye"
} ) LIB.p0N1pxWHmq=LIB.p0WOU0IM.AddTab (LIB.p0WOU0IM , {
  .Name ="Misc" ,  .Icon  ="settings"
} )LIB.ODQQmq = LIB.p0WOU0IM.AddTab (LIB.p0WOU0IM , {
 .Name ="Config" , .Icon ="save"
} )
		do LIB.Mqqznm= LIB.WXDOInoUOHpw .AddSection ( LIB.WXDOInoUOHpw, "Auto Parry"  , nil) LIB.Opoxb=LIB.Mqqznm.AddHStack  ( LIB.Mqqznm ) LIB.Opoxb: AddToggle ( {
 .Title ="Auto Parry" , .Default =false ,  .Callback =
		function (OqoZW) State .autoParryEnabled =OqoZW
	end,
} )LIB.Opoxb:AddToggle (  {
 .Title ="Radius ESP" ,  .Default = false , .Callback =
	function (BW1HZvUHupMn) State .autoParryRadiusEsp =BW1HZvUHupMn
	if LIB.onDxz1o
		then LIB.onDxz1o (BW1HZvUHupMn )
	end
end ,
} )LIB.Mqqznm :AddSlider( {
 .Title ="Parry Radius (Stud)"  , .Min =4 , .Max =40 , .Default =11, .Increment =  1 , .Callback =
function (_ZNz0W_1) State.autoParryRadius = _ZNz0W_1
end ,
}  )LIB.BlDnnQHIqXvO=LIB.WXDOInoUOHpw .AddSection ( LIB.WXDOInoUOHpw , "God Mode" ,nil ) LIB.BlDnnQHIqXvO:AddParagraph( {
 .Title = "God Mode" , .Content ="Instant Heal + Anti Knock/Down.\nSangat Cocok Jika Digunakan Untuk Main Pistol-pistolan."
} )LIB.BlDnnQHIqXvO : AddToggle ( {
 .Title ="Enable God Mode" , .Default =false, .Callback =
function (MoInqnm1_W)
if MoInqnm1_W
	then D_wqpNMI1MUvm( )
else HoHNI0HlooDU( )
end
end ,
} ) LIB.uWO1p1noQnlWm = LIB.WXDOInoUOHpw .AddSection ( LIB.WXDOInoUOHpw , "Aim Lock (Legit)"  , nil ) LIB.uWO1p1noQnlWm :AddToggle( {
 .Title = "Enable Aim Lock" , .Default =false, .Callback =
function ( pwHM_pI_mU0 )Config.cameralockEnabled =pwHM_pI_mU0
if pwHM_pI_mU0
	then LIB.vMvvZ( )
else LIB.Hq1wbQvMzoz ( )
end
end,
} ) LIB.uWO1p1noQnlWm :AddDrop
	down ( {
  .Title ="Target Type" , .Options = {
"Survivor" ,"Killer"
} , .Default = "Survivor" , .Callback =
	function (uUxQl ) Config .cameralockTargetType = uUxQl
end,
} )LIB.uWO1p1noQnlWm: AddDrop
	down( {
 .Title  ="Aim Part" , .Options = {
"Torso" ,"Head"
} , .Default = "Torso" , .Callback =
	function (v0lz_olwppOvMO ) Config .cameralockAimPart = v0lz_olwppOvMO
end,
} ) LIB.uWO1p1noQnlWm: AddDrop
	down(  {
 .Title  = "Lock Mode" , .Content ="Recommended Use: Hold to Lock (PC: Right Click / Mobile: Slasher Attack Button)" , .Options = {
"Always Lock" ,"Hold to Lock"
} , .Default = "Always Lock" , .Callback =
	function (uunXv )Config .cameralockLockMode =uunXv
end ,
} )LIB.uWO1p1noQnlWm: AddSlider( {
 .Title ="Max Distance" , .Content = "Maximum distance to lock target (studs)" ,  .Min = 20 , .Max = 700  , .Default =Config .cameralockMaxDistance ,  .Increment = 5 , .Callback  =
function (bMHXx_M0O_ )Config.cameralockMaxDistance  = bMHXx_M0O_
end ,
} )LIB.uWO1p1noQnlWm : AddSlider( {
  .Title = "Camera Smoothness" , .Min =0.01, .Max =1 , .Default =Config .cameralockSmoothness ,  .Increment =0.01 , .Callback =function(BmuH1ZbqWb_vw ) Config.cameralockSmoothness = BmuH1ZbqWb_vw
end ,
}  ) LIB.uvmnv=LIB.WXDOInoUOHpw .AddSection (LIB.WXDOInoUOHpw ,"Camera Veil (Legit)" ,nil) LIB.uvmnv : AddToggle( {
 .Title = "Camera Veil" ,  .Default =false , .Callback =
function (omUvvM) Config.cameraVeilEnabled =omUvvM
local umQxQZZIb = pcall (
function ( )
if  omUvvM
	then EnableCameraVeil( )
else DisableCameraVeil ( )
end
end)
if not umQxQZZIb
	then Config.cameraVeilEnabled =false Notify("Camera Veil" , "Gagal mengaktifkan Camera Veil" ,2)
end
end,
} )LIB.uvmnv: AddToggle ( {
 .Title = "SnapLine ESP"  ,  .Default = false, .Callback =function(OUXwqZ ) Config.cameraVeilSnapLine = OUXwqZ
if not OUXwqZ
	then
	if  State.CV_SnapLine
		then State.CV_SnapLine .Visible = false
	end
	if State.CV_SnapDot
		then State .CV_SnapDot .Visible  =false
	end
end
end,
} )LIB.WoM_lmuoD_0o =LIB.WXDOInoUOHpw .AddSection (LIB.WXDOInoUOHpw, "Crosshair" , nil )LIB.WoM_lmuoD_0o:AddToggle( {
  .Title ="Enable Crosshair" , .Default =false, .Callback =function( wHpbvZXX )LIB.Iw0_ov :SetEnabled( wHpbvZXX)
end,
}  )LIB.WoM_lmuoD_0o : AddDrop
	down(  {
 .Title = "Style / Model" , .Options =CROSSHAIR_STYLES , .Default = "Dot" , .Callback =function(NDHwuN )LIB.Iw0_ov: SetStyle( NDHwuN )
end,
} )LIB.WoM_lmuoD_0o :AddSlider ( {
 .Title = "Size" , .Min = 1 , .Max =  100 , .Default = 20 , .Increment = 1 ,  .Callback  = function( pz1moxHIvW) LIB.Iw0_ov : SetSize(pz1moxHIvW)
end,
} )LIB.WoM_lmuoD_0o : AddSlider( {
 .Title = "Opacity" , .Min = 0, .Max = 100 , .Default = 100 ,  .Increment  =  1  ,  .Callback = function( QpW0MuX)LIB.Iw0_ov :SetOpacity ( QpW0MuX/100)
end,
}  )LIB.WoM_lmuoD_0o:AddInput ( {
 .Title ="Position X (px)" ,  .Default = "0" , .Placeholder ="Offset from center (positive = right)" , .Callback =function( lOMxw)
local uXD1nDv= tonumber (lOMxw )
if uXD1nDv
	then LIB.Iw0_ov.SetOffsetX  ( LIB.Iw0_ov, math ( uXD1nDv , - 1000, 1000) )
end
end,
} )LIB.WoM_lmuoD_0o: AddInput ( {
  .Title ="Position Y (px)" , .Default ="0" , .Placeholder = "Offset from center (positive = down)" , .Callback = function(QDmx0zDW1 )
local q_vWvIw= tonumber ( QDmx0zDW1 )
if q_vWvIw
	then LIB.Iw0_ov.SetOffsetY  (LIB.Iw0_ov, math (q_vWvIw , -  1000 , 1000 ) )
end
end ,
} ) LIB.WoM_lmuoD_0o: AddColorPicker (  {
 .Title = "Crosshair Color" , .Default = Color3.fromRGB ( 255 , 255, 255 ) , .Callback =
function (WW0XZ )LIB.Iw0_ov:SetColor( WW0XZ)
end,
} ) LIB.bI0nxwpvnN = LIB.WXDOInoUOHpw.AddSection (LIB.WXDOInoUOHpw,"Silent Spear (Veil)"  ,nil) LIB.bI0nxwpvnN :AddParagraph( {
 .Title ="Aim Guide"  , .Content ="[ID] Saat Indikator/Snapline berubah hijau atau menampilkan \"RELEASE\", itu adalah waktu paling akurat untuk melepaskan SPEAR (90% kena target jika target diam).\n\n[EN] When the Indicator/Snapline turns green or shows \"RELEASE\", it is the most accurate time to release the SPEAR (90% hit chance if the target is stationary)."
} )LIB.bI0nxwpvnN:AddToggle ( {
  .Title ="Silent Spear" , .Default = false, .Callback =function(WoDXOquvmOOw1 )State.silentSpearEnabled  =WoDXOquvmOOw1
end,
} )LIB.OplOpzllnHuMnb=LIB.bI0nxwpvnN.AddHStack ( LIB.bI0nxwpvnN )LIB.oZwUx1zxp1v= LIB.bI0nxwpvnN.AddHStack ( LIB.bI0nxwpvnN ) LIB.OplOpzllnHuMnb: AddToggle ( {
 .Title ="FOV Circle" , .Default =false, .Callback =
function (bqMu0bzmz0Qvop) State .spearFovCircleEnabled =bqMu0bzmz0Qvop
end,
} ) LIB.OplOpzllnHuMnb: AddToggle (  {
 .Title = "Aim Indicator" , .Default = false, .Callback =
function (QDDXHQQlX ) State.spearIndicatorEnabled  = QDDXHQQlX
end,
}  )LIB.oZwUx1zxp1v:AddToggle ( {
  .Title ="SnapLine"  , .Default =false, .Callback =
function ( Buxumn )State.SPEAR_SNAPLINE .enabled =Buxumn
end,
} )LIB.oZwUx1zxp1v: AddToggle( {
 .Title  = "Show Name/Studs" , .Default = true,  .Callback =function(pXznlnqoZNW) Config .spearSnaplineShowText = pXznlnqoZNW
end,
} )LIB.bI0nxwpvnN:AddSlider( {
 .Title ="Spear FOV Radius" , .Min =30 , .Max  = 500 ,  .Default =150 , .Step = 5, .Callback = function(uXOuxINNU )Config .spearFovRadius =uXOuxINNU
end ,
} )LIB.OpxnOIHWnOImW= LIB.WXDOInoUOHpw.AddSection ( LIB.WXDOInoUOHpw , "Silent Aim (Twist of Fate)" ,nil)LIB.OpxnOIHWnOImW: AddToggle ( {
 .Title  ="Silent Aim" , .Default =false , .Callback =function( bwImUDQXoqz01w )State.silentAimEnabled = bwImUDQXoqz01w
end,
} )LIB.unnpoH= LIB.OpxnOIHWnOImW .AddHStack (LIB.OpxnOIHWnOImW)LIB.unnpoH :AddToggle( {
 .Title = "FOV Circle" , .Default =false,  .Callback = function( lqmxbQ_mv)State.silentAimFovVisible =lqmxbQ_mv
end,
} )LIB.unnpoH :AddToggle (  {
 .Title = "Laser ESP" , .Default  =false, .Callback =
function (q1NnQUpX) State.laserEspEnabled =q1NnQUpX
end ,
} ) LIB.OpxnOIHWnOImW :AddSlider ( {
 .Title ="Aim FOV Radius"  , .Min =30 , .Max  = 500 , .Default = 150 , .Step =5,  .Callback = function(_nIUNWm )Config.silentAimFovRadius =_nIUNWm
end,
} )
end
	do LIB.vx1OlOw=LIB.uXo1oQQNM .AddSection ( LIB.uXo1oQQNM, "Hitbox Modifier" , nil ) LIB.vx1OlOw: AddToggle(  {
 .Title ="Enable Hitbox Modifier" , .Default = false, .Callback =function( Ozq0nXOI)Config.hitboxEnabled =Ozq0nXOI
	if Ozq0nXOI
		then pIWIOMWp ( )
	else vXQHOzmuNXl( )
end
end ,
} ) LIB.blXvQx =LIB.vx1OlOw .AddSlider (LIB.vx1OlOw, {
 .Title ="Survivor Hitbox Size (%)"  , .Content  ="Ukuran hitbox Survivor (100% = normal)" , .Min =100, .Max = 700 , .Default = 100, .Increment = 5 ,  .Callback  =
function (OXZQzq1l_HxWQ )Config .survivorHitboxSize =OXZQzq1l_HxWQ
if Config .hitboxEnabled
	then pIWIOMWp ( )
end
end ,
} )LIB.BpZnQ1wbw1Nz= LIB.vx1OlOw.AddSlider  (LIB.vx1OlOw , {
 .Title ="Killer Hitbox Size (%)" , .Content = "Ukuran hitbox Killer (100% = normal)"  , .Min = 100 ,  .Max =700 , .Default = 100, .Increment = 5 , .Callback =
function (WXZmZ_uIl )Config.killerHitboxSize  =WXZmZ_uIl
if Config.hitboxEnabled
	then pIWIOMWp ( )
end
end ,
} ) LIB._HxmI=LIB.vx1OlOw .AddHStack (LIB.vx1OlOw) LIB._HxmI:AddButton ( {
 .Title  = "Default" ,  .Callback =
function ( )LIB.blXvQx:Set ( 100 ) ;

 LIB.BpZnQ1wbw1Nz.Set (LIB.BpZnQ1wbw1Nz , 100 )
if  Config.hitboxEnabled
	then  pIWIOMWp ( )
end Notify("Hitbox Preset" ,"Reset ke Default (100%)" , 1.5 )
end,
} )LIB._HxmI:AddButton( {
 .Title = "Big (200%)" , .Callback = function( )LIB.blXvQx:Set ( 200  )  ;

 LIB.BpZnQ1wbw1Nz .Set ( LIB.BpZnQ1wbw1Nz, 200 )
if Config.hitboxEnabled
	then pIWIOMWp( )
end Notify( "Hitbox Preset" ,"Big Hitbox aktif (200%)" ,1.5 )
end,
} ) LIB.vx1OlOw:AddToggle ( {
 .Title ="Enable Hitbox ESP" , .Default =false , .Callback =function( _uuXp ) Config .hitboxEspEnabled = _uuXp
if _uuXp
	then pNzHND( )
else o1II1HWx0HbZ( )
end
end,
}  ) LIB.vx1OlOw :AddSlider( {
 .Title = "Fill Transparency"  ,  .Min =0, .Max  = 100 , .Default = 50 , .Increment = 5 , .Callback = function( QNOon)Config .hitboxEspTransparency = QNOon / 100
if not Config .hitboxEspOutlineOnly
	then WxWMzlH( )
end
end ,
} )LIB.MqpZOwDQ1nZ=LIB.vx1OlOw .AddHStack (LIB.vx1OlOw)LIB.MqpZOwDQ1nZ:AddColorPicker( {
  .Title ="Hitbox Survivor Color" , .Default = Config.hitboxEspSurvivorColor , .Callback  =
function ( _IwDIQxXQ ) Config.hitboxEspSurvivorColor =_IwDIQxXQ;

 WxWMzlH( )
end,
} ) LIB.MqpZOwDQ1nZ:AddColorPicker( {
 .Title ="HitBox Killer Color" , .Default = Config.hitboxEspKillerColor , .Callback =
function (bIXDDvxZb1) Config.hitboxEspKillerColor = bIXDDvxZb1 ;

WxWMzlH (  )
end ,
} ) LIB.qIWWoZNx1v_b =LIB.uXo1oQQNM.AddSection (LIB.uXo1oQQNM, "Killer No Cooldown" ,nil)LIB.qIWWoZNx1v_b : AddToggle ( {
 .Title  ="Enable No Cooldown Bypass" ,  .Content = "Hidden, Abysswalker, Masked, More" , .Default  =false , .Callback =function(uXDomMOO_OOo) qX0lIxI= uXDomMOO_OOo
if uXDomMOO_OOo
	then HookTaskDelay(  )
else UnhookTaskDelay ( )
end
end
} )LIB.BN1nvpWmHb = LIB.qIWWoZNx1v_b.AddHStack ( LIB.qIWWoZNx1v_b ) LIB.BN1nvpWmHb : AddButton ( {
  .Title ="Fire Corrupt (Abyss)" , .Callback  =function( ) pcall (function(  )
local lxunQ=game.GetService (game ,"ReplicatedStorage" ) .Remotes .Killers .Abysswalker .corruptlxunQ:FireServer ( )
end )
end
} ) LIB.BN1nvpWmHb :AddButton ( {
 .Title = "Fire Slash (Abyss)" , .Callback =function( ) pcall (
function ( )
local BWmqXX=game.GetService (game,"ReplicatedStorage" ) .Remotes .Attacks .BasicAttackBWmqXX:FireServer(true )
end)
end
}  ) LIB._MxlZloZbMNlX = LIB.qIWWoZNx1v_b .AddHStack (LIB.qIWWoZNx1v_b )LIB._MxlZloZbMNlX: AddButton (  {
 .Title = "Fire Leap (Hidden)" , .Callback =
function ( ) pcall (function( )
local N0pxXlzxOQ= game.GetService (game, "ReplicatedStorage" ) .Remotes .Killers .Hidden  .LeapN0pxXlzxOQ : FireServer ( true)
end)
end
} )LIB._MxlZloZbMNlX : AddButton(  {
 .Title = "Fire M2 (Hidden)" , .Callback =
function ( ) pcall (
function ( )
local QNMOlU=game.GetService ( game , "ReplicatedStorage" ) .Remotes .Killers .Hidden .M2 QNMOlU :FireServer ( {

} , false )
end )
end
} ) LIB.OupN1u_wmZpzn =LIB.uXo1oQQNM.AddSection ( LIB.uXo1oQQNM,"Masked Skill Spammer" , nil) LIB.Wqm1UMUv="Cobra" LIB.OupN1u_wmZpzn .AddDrop
	down (LIB.OupN1u_wmZpzn, {
  .Title = "Select Mask Power" , .Options = {
 "Alex" ,"Brandon" , "Cobra" , "Rabbit"  ,"Richter" ,"Tony"
}  , .Default ="Cobra" , .Callback =function(N_ZDWopxpxoUH ) LIB.Wqm1UMUv= N_ZDWopxpxoUH
end
} )LIB.DnpuM =LIB.OupN1u_wmZpzn .AddHStack  (LIB.OupN1u_wmZpzn) LIB.DnpuM : AddButton ( {
 .Title ="Activate Power" ,  .Callback =
function ( ) pcall (function( )
local  QpuXmbb0wH =game.GetService (game, "ReplicatedStorage"  ) .Remotes .Killers  .Masked .ActivatepowerQpuXmbb0wH: FireServer ( LIB.Wqm1UMUv)
end) Notify( "Masked" ,"Power Activated: "  .. LIB.Wqm1UMUv,1.5)
end
}  ) LIB.DnpuM:AddButton ( {
 .Title  = "Deactivate Power" , .Callback =
function ( ) pcall  ( function( )
local Om1po0bI0MO= game.GetService (game,"ReplicatedStorage" ) .Remotes .Killers .Masked .Deactivatepower Om1po0bI0MO: FireServer (  )
end )Notify( "Masked" , "Power Deactivated" ,1.5)
end
} )LIB.HoZvH= LIB.uXo1oQQNM.AddSection ( LIB.uXo1oQQNM, "Anti Blind"  ,nil)LIB.HoZvH: AddToggle( {
 .Title ="Anti Flashlight Blind" , .Content = "Mencegah kamu terkena efek buta (Blinded) dari senter Survivor" , .Default = false , .Callback  =
function ( vZpupHuOXNMx )Config.antiBlindEnabled = vZpupHuOXNMx
end,
} ) LIB.oz_H1NbwmH_wM = LIB.uXo1oQQNM .AddSection ( LIB.uXo1oQQNM ,"Anti Looping" , nil )LIB.oz_H1NbwmH_wM:AddToggle ( {
 .Title  = "Anti Loop Window" , .Content  = "Membuat semua window di map tidak bisa digunakan untuk looping" , .Default  =false ,  .Callback =
function ( uQqmnvUqoID)State.antiLoopWin
	dowEnabled = uQqmnvUqoID
	if uQqmnvUqoID
		then vlmOH1_X ( )
	else IM_WpzUx1nu( )
end
end
} )LIB.oz_H1NbwmH_wM:AddButton( {
 .Title  ="Auto Drop All Pallets" , .Callback = function( )w1mO_U1I_ (  )
end
} )
end
	do LIB.w_IX1 =LIB.DO_nopuz.AddSection (LIB.DO_nopuz , "Auto Generator" , nil)LIB.w_IX1:AddToggle( {
 .Title  = "Auto Generator"  ,  .Default =Config.autoGenerator , .Callback =
	function ( OWllluOD ) Config .autoGenerator = OWllluOD
end,
}  )LIB.w_IX1: AddDrop
	down ( {
 .Title ="Mode" , .Content ="Normal = safe zone | Perfect = zona Perfect | Instant = 😈 | Random = Succes/Neutral" , .Options = {
"Instant" , "Perfect" , "Normal" ,"Random"
} , .Default  =Config.autoGeneratorMode ,  .Callback =
	function ( v_Z_QZlWnxZmU) Config.autoGeneratorMode = v_Z_QZlWnxZmU
end,
}  ) LIB.lzoOZm=LIB.DO_nopuz.AddSection (LIB.DO_nopuz , "Anti Fall Slow" , nil ) LIB.lzoOZm :AddToggle ( {
 .Title = "Anti Fall Slow" , .Content = "Mencegah karakter melambat saat mendarat / jatuh dari ketinggian berapa pun" ,  .Default = false, .Callback =function( Wxz1Zw1Mp) State .AntiFallSlow =Wxz1Zw1Mp
local Mnq0NI0ZMUb=LocalPlayer .Character
local wuvbv1=Mnq0NI0ZMUb and  Mnq0NI0ZMUb.FindFirstChildOfClass ( Mnq0NI0ZMUb,"Humanoid" )
if Wxz1Zw1Mp
	then Nvw0ZDnxoImoH (wuvbv1 )
else vZW11Xq1xZD_ (wuvbv1)
end
end ,
} ) LIB._pnvvou0uvl1Mz =LIB.DO_nopuz.AddSection (LIB.DO_nopuz, "Movement Modification" , nil) LIB._pnvvou0uvl1Mz : AddToggle ( {
  .Title  ="No Slowdown"  , .Default =false, .Callback =
function (qwwomlzo_zu ) State .NoSlow
	down = qwwomlzo_zu
	local QvnD_HOqW = LocalPlayer .Character
	local NnND_N =QvnD_HOqW and QvnD_HOqW .FindFirstChildOfClass  ( QvnD_HOqW , "Humanoid" )
	if qwwomlzo_zu
		then vqQoXU(NnND_N)
	else _StopNoSlow
		down( )
	end
end,
}  ) LIB._pnvvou0uvl1Mz:AddToggle( {
 .Title ="Speed Boost" , .Default =false , .Callback =function( HX1mDmbDQ)State .SpeedBoost = HX1mDmbDQ
if not HX1mDmbDQ
	then
	local  lmHquDOzZIl1X= LocalPlayer .Character
	local IlbopNO1onvbZv = lmHquDOzZIl1X and lmHquDOzZIl1X.FindFirstChildOfClass (lmHquDOzZIl1X,"Humanoid"  )
	if IlbopNO1onvbZv
		then qNMQXII(IlbopNO1onvbZv , BuildNumber)
	end
else
local ImUUWblWD1 =LocalPlayer.Character
local Opz1DOIxozOl=ImUUWblWD1 and ImUUWblWD1.FindFirstChildOfClass  (ImUUWblWD1, "Humanoid" )
if not State .safeModeSpee
	dor ( Opz1DOIxozOl and Opz1DOIxozOl .Health > 50and not (ImUUWblWD1 .GetAttribute (ImUUWblWD1,"IsHooked" )or ImUUWblWD1 .GetAttribute ( ImUUWblWD1 ,"IsCarried" ) ) )
		then qNMQXII(Opz1DOIxozOl ,WwOu1ZXou0Z ( ) )
	end
end
end ,
} ) LIB._pnvvou0uvl1Mz :AddToggle(  {
 .Title ="Safe Mode (Speed)" , .Content ="Speed Boost & No Slowdown otomatis nonaktif saat Knockdown, Hook, dll."  , .Default =true, .Callback  =
function (_1HHmI0ooN)State .safeModeSpeed = _1HHmI0ooN
end,
} ) LIB._pnvvou0uvl1Mz: AddSlider (  {
 .Title ="Boost Amount (%)" , .Min =0, .Max =100, .Default =  50 ,  .Callback =
function (qpbQoMuNNlw1w )State.BoostPercent = qpbQoMuNNlw1w
end ,
} ) LIB.DzNvHWmzIxDmmu =LIB.DO_nopuz .AddSection (LIB.DO_nopuz, "Auto Crouch (Abyss)"  ,nil)LIB.DzNvHWmzIxDmmu:AddToggle ( {
 .Title = "Auto Crouch"  , .Default =false , .Callback =
function (_npU_pDIxzxuHU )Config .autoCrouchEnabled =_npU_pDIxzxuHU
if  not _npU_pDIxzxuHU
	then LIB.uuMqxOzluob ( false )
end
end
} )LIB.DzNvHWmzIxDmmu :AddSlider( {
 .Title  = "Crouch Radius (Stud)" , .Min =4 ,  .Max  = 40 , .Default  = 18 , .Increment = 1 , .Callback =
function (O0zwIbuImDZZu)Config.autoCrouchRadius =O0zwIbuImDZZu
end,
} ) LIB.vlIOU10MzvW=LIB.DO_nopuz.AddSection  (LIB.DO_nopuz,"Auto Drop Nearby Pallet" ,nil) LIB.vlIOU10MzvW:AddToggle( {
 .Title  = "Auto Drop Nearby Pallet" , .Default =false , .Callback =
function (BQWOMlDOM1Il) State.autoDropNearbyPallets  =BQWOMlDOM1Il
if BQWOMlDOM1Il
	then State.palletPointsCache  =nil
end
end
} ) LIB.Ox_OoNDZDOUplX=LIB.DO_nopuz.AddSection ( LIB.DO_nopuz ,"Moonwalk" , nil ) LIB.Ox_OoNDZDOUplX:AddToggle ( {
 .Title = "Enable Moonwalk (Mobile GUI)" , .Default =false, .Callback =
function (WOlQub0IInIp0 )Config.moonwalkEnabled = WOlQub0IInIp0
if WOlQub0IInIp0
	then NubHIl ( )
	if State.moonwalkGui
		then  State .moonwalkGui .Enabled =true
	end
else
if State.moonwalkGui
	then State .moonwalkGui .Enabled =false
end State .moonwalkMobileDir =  0State.moonwalkPCForward  = false State.moonwalkPCBackward = false
end
end
} )LIB.Ox_OoNDZDOUplX:AddKeybind( {
 .Title  ="PC Lock Forward Key" , .Default  =Enum .KeyCode .Unknown , .Callback  =
function ( )
if Config.moonwalkEnabled
	then State.moonwalkPCForward =not State .moonwalkPCForward
	if State.moonwalkPCForward
		then  State.moonwalkPCBackward = false
	end
end
end
} ) LIB.Ox_OoNDZDOUplX:AddKeybind ( {
 .Title ="PC Lock Backward Key"  , .Default  =Enum .KeyCode .Unknown , .Callback =function( )
if Config.moonwalkEnabled
	then State.moonwalkPCBackward =not State .moonwalkPCBackward
	if State.moonwalkPCBackward
		then State .moonwalkPCForward = false
	end
end
end
}  ) LIB.WZpWIzxOMuD =LIB.DO_nopuz.AddSection ( LIB.DO_nopuz, "Escape Gate" ,nil) LIB.WZpWIzxOMuD : AddButton( {
 .Title = "Auto Escape (Teleport)" ,  .Callback  =
function ( )LIB._XDNw( )
end
} ) LIB.WZpWIzxOMuD : AddToggle( {
  .Title  = "Ghost Gate (Legit Mode)" , .Default  = false, .Callback =
function (ImZMoux)State .ghostGateEnabled = ImZMoux LIB.lHZlWupp ( )
end
}  )LIB.OmlqwO0Z=LIB.DO_nopuz.AddSection ( LIB.DO_nopuz , "Lock FOV" , nil ) LIB.OmlqwO0Z: AddToggle ( {
 .Title = "Lock FOV" , .Default =Config .lockFovEnabled  , .Callback =
function (pzQXnNU0_lH)Config.lockFovEnabled =pzQXnNU0_lH
if  pzQXnNU0_lH
	then LIB.BWQoHbUwlp0MZb ( Config .customFovValue )
else LIB.bxOlDXWlooNM ( )
end
end ,
} ) LIB.OmlqwO0Z: AddSlider ( {
  .Title ="FOV Value" , .Min = 30 , .Max =120, .Default  =Config .customFovValue , .Increment = 1, .Callback  = function( qHwMWp0vwvp )Config.customFovValue  =qHwMWp0vwvp
if Config .lockFovEnabled
	then LIB.BWQoHbUwlp0MZb ( qHwMWp0vwvp)
end
end,
} )
end
	do LIB.NvOXM= LIB._Q_UQwvznNuxzH.AddSection  (LIB._Q_UQwvznNuxzH ,"Killer ESP" ,nil )LIB.pwQOzxOmU00Oq=LIB.NvOXM .AddHStack ( LIB.NvOXM)LIB.pwQOzxOmU00Oq : AddToggle ( {
  .Title = "Show Name" , .Default =Config.killerShowName , .Callback =function(vqubnXmvXI )Config.killerShowName = vqubnXmvXI;
	
RefreshAllESP (  )
end ,
} ) LIB.pwQOzxOmU00Oq : AddToggle ( {
  .Title ="Show Outline" , .Default = Config .killerShowOutline ,  .Callback =
function (HWXWbMQo) Config.killerShowOutline =HWXWbMQo;

RefreshAllESP( )
end ,
} ) LIB.NvOXM :AddColorPicker ( {
 .Title = "Killer Color" , .Default =Config.killerColor , .Callback  = function(qWwbub_lpU1) Config.killerColor =qWwbub_lpU1;

RefreshAllESP( )
end ,
} ) LIB.vIZuUHO1=LIB._Q_UQwvznNuxzH.AddSection ( LIB._Q_UQwvznNuxzH ,"Survivor ESP" ,nil) LIB.loHWU = LIB.vIZuUHO1 .AddHStack (LIB.vIZuUHO1)LIB.loHWU:AddToggle( {
 .Title ="Show Name" , .Default  =Config.survivorShowName , .Callback = function(uz1wZNHpoQzZ1I )Config.survivorShowName =uz1wZNHpoQzZ1I;

RefreshAllESP( )
end ,
} )LIB.loHWU : AddToggle ( {
 .Title = "Show Outline" ,  .Default = Config .survivorShowOutline  , .Callback =function(vQqmuZHD)Config .survivorShowOutline =vQqmuZHD;

RefreshAllESP(  )
end,
} )LIB.vIZuUHO1 : AddColorPicker ( {
 .Title ="Survivor Color" , .Default =Config.survivorColor , .Callback =
function (wzZmD0_uOvHUn) Config .survivorColor =wzZmD0_uOvHUn;

RefreshAllESP ( )
end,
} ) LIB.vlbbmUHO0DqzX = LIB._Q_UQwvznNuxzH .AddSection (LIB._Q_UQwvznNuxzH ,"Show Item Survivor"  , nil) LIB.vlbbmUHO0DqzX:AddToggle( {
 .Title = "Show Equipped Item" , .Default =false , .Callback  =
function (p1zvlbW) Config.espItemEnabled =p1zvlbW
end,
} ) LIB.MQOoHpooND=LIB._Q_UQwvznNuxzH.AddSection ( LIB._Q_UQwvznNuxzH, "Outline Settings" ,nil) LIB.MQOoHpooND:AddToggle (  {
 .Title ="Outline Only" ,  .Content = "Tampilkan outline saja tanpa fill (berlaku untuk Killer & Survivor)" , .Default = Config .killerOutlineOnly , .Callback =
function (bXMOOon )Config .killerOutlineOnly =bXMOOon ;

Config .survivorOutlineOnly =bXMOOon  RefreshAllESP( )
end ,
} )LIB.qwXOxuX = LIB._Q_UQwvznNuxzH .AddSection (LIB._Q_UQwvznNuxzH , "Object ESP" , nil ) LIB.bwZzbozHD =LIB.qwXOxuX .AddHStack (LIB.qwXOxuX )LIB.bwZzbozHD: AddToggle( {
 .Title  = "ESP Generator" , .Default = Config .espGeneratorEnabled , .Callback = function(q1uDuD10X0HH_u) Config.espGeneratorEnabled =q1uDuD10X0HH_u ;

RefreshObjectESP ( )
end,
} )LIB.bwZzbozHD : AddToggle( {
 .Title = "Progress Gen"  , .Default  =Config .espGeneratorProgressGen , .Callback =
function (BIWbZZNnpOwXWv ) Config .espGeneratorProgressGen =BIWbZZNnpOwXWv
for  _1WmxNbNzI0wz_,uIpD1QXm in ipairs  ( State.cachedMapObjects .Generators )
	do
	if uIpD1QXm and uIpD1QXm.Parent
		then uIpD1QXm.SetAttribute ( uIpD1QXm, "__BolongGenLastPct__" , nil)
		if not BIWbZZNnpOwXWv
			then
			local HNOQw1oDwHZ = uIpD1QXm .FindFirstChild  ( uIpD1QXm,"__BolongGenProgress__" )
			if HNOQw1oDwHZ
				then HNOQw1oDwHZ .Destroy (HNOQw1oDwHZ)
			end
		end
	end
end RefreshObjectESP( )
end ,
} )LIB.qwXOxuX:AddToggle ( {
 .Title  = "Show Generator Info" , .Default = Config .espGenShowPK , .Content = "Player & Break"  , .Callback = function(NMIv0lNxwIoq ) Config.espGenShowPK = NMIv0lNxwIoq
for HvInNnz ,ln0_pIZQu1W in ipairs ( State.cachedMapObjects .Generators )
	do
	if ln0_pIZQu1W and ln0_pIZQu1W.Parent
		then ln0_pIZQu1W.SetAttribute (ln0_pIZQu1W , "__BolongGenLastPct__" , nil)
	end
end
end,
} ) LIB.MN0XuxIQDDnl=LIB.qwXOxuX.AddHStack ( LIB.qwXOxuX)LIB.MN0XuxIQDDnl :AddToggle(  {
 .Title ="ESP Window" , .Default = Config .espWin
	dowEnabled  , .Callback =function(IbnIbWnQw) Config .espWin
		dowEnabled =IbnIbWnQw RefreshObjectESP ( )
	end ,
} ) LIB.MN0XuxIQDDnl :AddToggle( {
 .Title  ="ESP Pallet" , .Default = Config .espPalletEnabled , .Callback = function( wMZx_0__MIuDZ ) Config.espPalletEnabled = wMZx_0__MIuDZ;
	
RefreshObjectESP(  )
end ,
} )LIB.wlWM_qQbD= LIB.qwXOxuX.AddHStack (LIB.qwXOxuX ) LIB.wlWM_qQbD : AddToggle( {
 .Title ="ESP Hook" , .Default =Config .espHookEnabled , .Callback =function( NlNllmM0oWqp )Config .espHookEnabled =NlNllmM0oWqp ;

RefreshObjectESP(  )
end,
} )LIB.wlWM_qQbD : AddToggle(  {
 .Title  ="ESP Gate" , .Default =Config.espGateEnabled ,  .Callback =
function ( bOlI1m1Xm) Config.espGateEnabled =bOlI1m1Xm;

 RefreshObjectESP( )
end,
} ) LIB.uMUI0QpIl = LIB.qwXOxuX .AddHStack (LIB.qwXOxuX) LIB.uMUI0QpIl : AddColorPicker( {
 .Title = "Generator Color" , .Default =Config.espGeneratorColor  , .Callback =function(voH1Q1O1Zw ) Config .espGeneratorColor =voH1Q1O1Zw
if Config.espGeneratorEnabled
	then
	for HxbWnI11z,W0xbx in  ipairs ( State .cachedMapObjects .Generators )
		do
		if W0xbx and W0xbx.Parent
			then
			local QQp1v =W0xbx .FindFirstChild (W0xbx, "__BolongHL__" )
			if  QQp1v
				then QQp1v.FillColor =voH1Q1O1Zw;
				
 QQp1v .OutlineColor =voH1Q1O1Zw
			end
		end
	end
end
end,
} )LIB.uMUI0QpIl :AddColorPicker( {
 .Title ="Window Color" , .Default =Config .espWin
	dowColor , .Callback =function(NoXbob) Config.espWin
		dowColor =NoXbob
		for HU0WzpN1Hbb_Z,wqvWQNlmlXp1z in pairs ( State.win
			dowEspObjects )
				do
				if wqvWQNlmlXp1z and wqvWQNlmlXp1z.Parent
					then pcall (
					function ( ) wqvWQNlmlXp1z .Color3 = NoXbob
				end )
			end
		end
	end,
} )LIB.NMXN0uvm=LIB.qwXOxuX.AddHStack ( LIB.qwXOxuX) LIB.NMXN0uvm: AddColorPicker( {
  .Title = "Pallet Color"  ,  .Default = Config.espPalletColor , .Callback =
	function ( Bn_00)Config .espPalletColor =Bn_00
	for Ww1oxIwuOp,HDlwqHn in ipairs (State .cachedMapObjects .Pallets )
		do
		if HDlwqHn
			then
			local uDIuQxqlD =HDlwqHn.FindFirstChild ( HDlwqHn ,"__BolongHL__"  )
			if uDIuQxqlD
				then  uDIuQxqlD .FillColor = Bn_00 ;
				
 uDIuQxqlD.OutlineColor = Bn_00
			end
		end
	end
end ,
} ) LIB.NMXN0uvm : AddColorPicker(  {
 .Title = "Hook Color" , .Default =Config .espHookColor ,  .Callback =function(DQppNwUwoZonn ) Config.espHookColor =DQppNwUwoZonn
for wNbz1IOzoNH ,MNuMZD_UNozz in ipairs (State .cachedMapObjects .Hooks  )
	do
	if  MNuMZD_UNozz and MNuMZD_UNozz.Parent
		then
		local qmD0I_1_luw= State.cachedHookMeshParts [MNuMZD_UNozz]
		if qmD0I_1_luw
			then
			for  QzzqQOlvmoxbqX , qDbQWxMlN_  in ipairs ( qmD0I_1_luw )
				do
				local BpNZ_olMmqO =qDbQWxMlN_.FindFirstChild (qDbQWxMlN_,"__BolongHL__"  )
				if BpNZ_olMmqO
					then BpNZ_olMmqO.FillColor =DQppNwUwoZonn ;
					
BpNZ_olMmqO.OutlineColor = DQppNwUwoZonn
				end
			end
		end
	end
end
end,
} )LIB.bWnD000QvNl =LIB.qwXOxuX .AddHStack ( LIB.qwXOxuX )LIB.bWnD000QvNl : AddColorPicker ( {
 .Title = "Gate Color" , .Default = Config.espGateColor ,  .Callback = function(O1UN1lZX) Config.espGateColor =O1UN1lZX
for lZQzuMbno , oIWxwzwbOQ in ipairs (State .cachedMapObjects  .Gates  )
	do
	if oIWxwzwbOQ and  oIWxwzwbOQ.Parent
		then
		local WObx_IQz= oIWxwzwbOQ .FindFirstChild ( oIWxwzwbOQ,"__BolongHL__" )
		if WObx_IQz
			then WObx_IQz .FillColor = O1UN1lZX ;
			
 WObx_IQz .OutlineColor =O1UN1lZX
		end
	end
end
end ,
} ) LIB.bXI_Dz0vqn= LIB._Q_UQwvznNuxzH .AddSection (LIB._Q_UQwvznNuxzH, "Prediction Map&Killer" , nil)LIB.bXI_Dz0vqn : AddToggle ( {
  .Title  = "Show Prediction Monitor" , .Default =false, .Callback =function(vbomNWnIn )
if vbomNWnIn
	then LIB.HuQnoUuWpwo ( )
else LIB.lboDUI ( )
end
end,
} )LIB.vmo_0N =LIB._Q_UQwvznNuxzH.AddSection (LIB._Q_UQwvznNuxzH ,"World Settings" , nil ) LIB.vmo_0N: AddToggle ( {
 .Title  ="Fullbright" , .Default  =false , .Callback = function(MINOIvOXwOlxwz)State.fullbrightEnabled  =MINOIvOXwOlxwz
if MINOIvOXwOlxwz
	then LIB.p_01zM1nQ( )
else LIB.un10pxvlDoWQlp ( )
end
end ,
} ) LIB.vmo_0N : AddToggle ( {
 .Title = "Remove Visual Effects" , .Content = "BoostFps" , .Default  = false, .Callback =function(_WvWZDm ) State.removeVfxEnabled =_WvWZDm
if _WvWZDm
	then LIB.NZ0MOpIIxM_0 ( )
else LIB.WwMOwDZWQxwXD( )
end
end ,
} )
end
	do LIB.BHWwUOqxM =LIB.p0N1pxWHmq.AddSection (LIB.p0N1pxWHmq , "Anti AFK" ,nil) LIB.BHWwUOqxM: AddToggle( {
 .Title ="Enable Anti AFK" ,  .Default =false, .Callback =
	function ( vWz_pZnWxv) qwvvHbn( vWz_pZnWxv)
end ,
} )LIB.ol_p1qopNxquwo =LIB.p0N1pxWHmq.AddSection ( LIB.p0N1pxWHmq, "Killer Warn"  , nil) LIB.ol_p1qopNxquwo :AddToggle ( {
 .Title ="Enable Killer Warn" , .Content ="The ! sign above your head when the killer is around you" , .Default =Config.warnEnabled ,  .Callback =function( bplwwZI) Config.warnEnabled =bplwwZI
end ,
} ) LIB.loXWx0_lU_0H=LIB.p0N1pxWHmq.AddSection (LIB.p0N1pxWHmq , "Performance Monitor" ,nil) LIB.loXWx0_lU_0H: AddToggle( {
 .Title = "Show Performance Window" , .Default = false,  .Callback =
function ( Q1XMnDoIOQunD)
if Q1XMnDoIOQunD
	then  LIB.lUwpXW ( )
else LIB.p_X0zlUul( )
end
end,
} )LIB._MvbqpNQIo_X1I=LIB.p0N1pxWHmq.AddSection  (LIB.p0N1pxWHmq,"Camera Zoom"  , nil) LIB._MvbqpNQIo_X1I:AddToggle ( {
 .Title ="Max Camera Zoom"  , .Default = Config.cameraZoomEnabled , .Callback = function( HMW0U)Config.cameraZoomEnabled =HMW0U
if HMW0U
	then LIB.w_vnXUZ( Config.cameraZoomValue )
else LIB.Ww1z_Ob0vX (  )
end
end ,
} )LIB.u__Q_xlxpoxwxO = LIB.p0N1pxWHmq .AddSection ( LIB.p0N1pxWHmq, "Force Cursor (PC Only)" , nil)LIB.IlQXmXmuW =LIB.u__Q_xlxpoxwxO .AddToggle ( LIB.u__Q_xlxpoxwxO, {
 .Title = "Force Mouse Cursor" , .Content = "Forces the mouse cursor to always appear on the screen."  , .Default =false, .Callback =function( OIuvD )Config.forceCursorEnabled  =OIuvD
if OIuvD
	then LIB.vvw0v_lDxx( ) Notify( "Force Cursor" , "Mouse cursor forced to appear!"  , 2 )
else  LIB.Bu0oXoOlbI ( )
end
end,
} )LIB.u__Q_xlxpoxwxO:AddKeybind ( {
 .Title = "Toggle Keybind" , .Default  = Enum .KeyCode .Y , .Callback =
function ( )
local  OUlxHxooZnH0O=not  Config.forceCursorEnabledLIB.IlQXmXmuW: Set ( OUlxHxooZnH0O )
end
} )
	do
	local HNwOb11DuMn0XU =bit32.band( 23 ,0)
	local H_0OQmO=bit32. bor( HNwOb11DuMn0XU , 110)  -110
end LIB.MnDwxvu= LIB.p0N1pxWHmq.AddSection  (LIB.p0N1pxWHmq, "Protect Name" ,nil )LIB.MnDwxvu : AddToggle( {
 .Title = "Enable Protect Name" , .Default = false, .Callback = function( BnlOmXmbozz)
if BnlOmXmbozz
	then LIB.QwZpNwn( )
else LIB.lOqqxMquzxn_( )
end
end,
} )LIB.OppMnHnZv = LIB.p0N1pxWHmq.AddSection (LIB.p0N1pxWHmq , "Skip Cutscene" ,nil )LIB.NzXpUbznz =false LIB.bxUOQ = LIB.OppMnHnZv.AddToggle ( LIB.OppMnHnZv , {
 .Title ="Skip End Screen"  , .Default = false , .Callback =function(Dm1IuI0oDn )
if LIB.NzXpUbznz
	then
	return
end Config.skipEndScreenEnabled =Dm1IuI0oDn
if Dm1IuI0oDn
	then LIB.NzXpUbznz =true  Config .skipLoadEndScreenEnabled =false
	if LIB.pXHb0oo
		then  LIB.pXHb0oo.Set  (LIB.pXHb0oo, false)
	end LIB.NzXpUbznz=false LIB.Wb0x1XpWv(  )LIB.oqWmXqpHU(false)
else LIB.Wb0x1XpWv(  )
end
end,
} ) LIB.pXHb0oo= LIB.OppMnHnZv.AddToggle  (LIB.OppMnHnZv , {
 .Title ="Skip Loading & End Screen" , .Default = false, .Callback =
function ( pmnozwuqZwwUQ)
if  LIB.NzXpUbznz
	then
	return
end  Config.skipLoadEndScreenEnabled = pmnozwuqZwwUQ
if pmnozwuqZwwUQ
	then LIB.NzXpUbznz=true Config .skipEndScreenEnabled = false
	if LIB.bxUOQ
		then LIB.bxUOQ.Set ( LIB.bxUOQ , false)
	end  LIB.NzXpUbznz =false LIB.Wb0x1XpWv ( )LIB.oqWmXqpHU ( true )
else LIB.Wb0x1XpWv ( )
end
end ,
}  )LIB.NN_xb =LIB.p0N1pxWHmq .AddSection (LIB.p0N1pxWHmq , "Avatar Copy (Visual)" ,nil )LIB.NN_xb: AddPresetManager( {
 .Title ="Profile Avatar By Username / ID" ,  .Placeholder ="Jandel / 1234..." , .Default ="" , .Presets = {
 .Boy1  ="kiicaine" , .Boy2 = "444jamesss" , .Boy3 = "KiLouo14" , .Girl1 ="9kinb"  , .Girl2 ="winterilous" ,  .Girl3 = "ellea_893"
} , .Callback =function(uD_xIzH_)currentAvatarInput= uD_xIzH_
end
} )LIB.NN_xb: AddButton( {
 .Title = "Copy Avatar" , .Callback =function( )
if  currentAvatarInput and currentAvatarInput~=""
	then  LIB.vzImqwp(currentAvatarInput)
else  Notify( "BolongHub" ,"Masukkan Username/ID terlebih dahulu!"  , 2 )
end
end
} ) LIB.vDNxQoZU_ = LIB.p0N1pxWHmq.AddSection  (LIB.p0N1pxWHmq ,"Jerk Off (Fun)" , nil) LIB.vDNxQoZU_ :AddToggle( {
 .Title  = "Enable Jerk Off" , .Default =false , .Callback =
function ( _zIn_UHZNlM)
if _zIn_UHZNlM
	then LIB.vlOXUQnZm( )
else LIB._H1m_uqbulDO( )
end
end
} )
end
	do LIB.WHZomMMH= LIB.ODQQmq .AddSection ( LIB.ODQQmq,"Configuration" , true )LIB.WHZomMMH:AddConfig( )
end print  ( "BOLONGHUB LOADED!" )