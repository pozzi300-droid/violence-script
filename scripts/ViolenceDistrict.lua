-- Deobfuscated by wezxwe

local MainState={}
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local UserInputService=game:GetService("UserInputService")
local VirtualInputManager=game:GetService("VirtualInputManager")
local VirtualUser=game:GetService("VirtualUser")
local GuiService=game:GetService("GuiService")
local Lighting=game:GetService("Lighting")
local Stats=game:GetService("Stats")
local Workspace=game:GetService("Workspace")
local ReplicatedStorage=game:GetService("ReplicatedStorage")
local CollectionService=game:GetService("CollectionService")
local UIS2=game:GetService("UserInputService")
local LocalPlayer=Players.LocalPlayer
local PlayerGui=LocalPlayer:WaitForChild("PlayerGui")
local RadAngle30=math.rad(30)
local RadAngle45=math.rad(45)
local Angle42=math.rad(42)
local Angle28=math.rad(28)
local Angle18=math.rad(18)
local Angle72=math.rad(72)
local MinClamp=-0.95
local MaxClamp=0.95
local Gravity=Workspace.Gravity
local DefaultHeight=2
local DefaultSpeed=1.5
local SmallOffset=0.15
local DefaultCount=3
local UILib=loadstring(game:HttpGet("https://raw.githubusercontent.com/pozzi300-droid/violence-script/main/libs/b0lngUi.lua"))()
local ScriptVersion="v4.1.1"
local NotifyColor=Color3.fromRGB(255,255,255)
local
function ShowNotify(Title,Message,Duration)UILib:MakeNotify({Title=Title or"BOLONG-HUB",Description="Info",Content=Message or"",Color=NotifyColor,Time=0.4,Delay=Duration or 2,})
end
local Settings={killerShowName=false,killerShowOutline=true,killerOutlineOnly=true,killerColor=Color3.fromRGB(255,60,60),survivorShowName=false,survivorShowOutline=true,survivorOutlineOnly=true,survivorColor=Color3.fromRGB(60,200,255),maxDistance=500,fillTransparency=0.6,cameraZoomEnabled=false,cameraZoomValue=1000,warnEnabled=false,warnDist1=60,warnDist2=40,warnDist3=20,customFovValue=70,lockFovEnabled=false,autoGenerator=true,autoGeneratorMode="Instant",espGenShowPK=false,cameralockEnabled=false,cameralockTargetType="All",cameralockMaxDistance=700,cameralockSmoothness=1,cameralockLockMode="Always Lock",cameralockAimPart="Torso",hitboxEnabled=false,survivorHitboxSize=100,killerHitboxSize=100,hitboxEspEnabled=false,hitboxEspSurvivorColor=Color3.fromRGB(0,255,120),hitboxEspKillerColor=Color3.fromRGB(255,60,60),hitboxEspTransparency=0.5,hitboxEspOutlineOnly=false,espGeneratorEnabled=false,espGeneratorProgressGen=false,espGeneratorColor=Color3.fromRGB(200,100,0),espWindowEnabled=false,espWindowColor=Color3.fromRGB(255,223,0),espPalletEnabled=false,espPalletColor=Color3.fromRGB(53,189,166),espHookEnabled=false,espHookColor=Color3.fromRGB(252,116,116),espGateEnabled=false,espGateColor=Color3.fromRGB(255,255,255),cameraVeilEnabled=false,cameraVeilSnapLine=false,cameraVeilMaxDistance=175,cameraVeilSmoothness=1,cameraVeilSpearSpeed=220,cameraVeilGravityMult=1,cameraVeilTargetType="Survivor",skipEndScreenEnabled=false,skipLoadEndScreenEnabled=false,silentAimFovRadius=150,spearFovRadius=150,spearSnaplineMaxDistance=400,spearSnaplineShowText=true,autoCrouchEnabled=false,autoCrouchRadius=18,antiBlindEnabled=false,espItemEnabled=false,forceCursorEnabled=false,moonwalkEnabled=false,}
local ESPState={espObjects={},outlineObjects={},playerRoles={},playerTeamConns={},playerCharConns={},cachedMapObjects={Generators={},Pallets={},Hooks={},Gates={}},cachedPalletMeta={},cachedHookMeshParts={},completedGenerators={},genIndices={},nextGenIndex=1,objEspInitialized=false,windowEspObjects={},NoSlowdown=false,SpeedBoostInit=false,BoostPercent=50,AntiFallSlow=false,safeModeSpeed=true,autoParryEnabled=false,autoParryRadiusEsp=false,autoParryRadius=10,lastParryTime=0,activeAttackers={},HoldLockActive=false,godEnabled=false,godLastHP=nil,hitboxOriginalSizes={},hitboxEspObjects={},instantLastVisible=false,lastPressTime=0,lastSkillHit=0,randomIsNeutral=false,originalMaxZoom=nil,originalFOV=nil,cursorBackupIcon=nil,cursorBackupBehavior=nil,forceCursorConn1=nil,forceCursorConn2=nil,originalMouseIconEnabled=nil,originalMouseBehavior=nil,perfGui=nil,pnameEnabled=false,pnameFakeNames={},pnameNameConns={},pnameSlotConns={},pnameWatchConn=nil,pnameAddedConn=nil,CV_Enabled=false,CV_CurrentTarget=nil,CV_WasHolding=false,CV_HoldingPC=false,CV_HoldingMobile=false,CV_LastStableDir=nil,CV_SnapGui=nil,CV_SnapLine=nil,CV_SnapDot=nil,CV_LastSpearSpeed=nil,CV_LastGravityMult=nil,CV_frameCount=0,CV_snapLineFrame=-99,CV_cachedSpearMode=false,CV_spearModeFrame=-99,CV_acquireStartFrame=nil,CV_ballisticFrame=-99,CV_lastSolvedHeadPos=nil,CV_lastSolvedDir=nil,CV_lastSolvedPredicted=nil,CV_lastSolvedTime=nil,CV_Connections={},CV_InputBeganConn=nil,CV_InputEndedConn=nil,CV_WatchConn=nil,CV_VisualConn=nil,CV_HookedButtons={},CV_RenderStepName="BOLONGHUB_CameraVeil",skipEndScreenConns={},fullbrightEnabled=false,removeVfxEnabled=false,silentAimEnabled=false,silentAimTarget=nil,silentAimLookVector=nil,laserEspEnabled=true,triggerLaser=false,currentMuzzlePos=nil,currentTargetPos=nil,FOVCircle=nil,silentAimFovVisible=false,silentSpearEnabled=false,silentSpearTargetTorso=nil,silentSpearTargetVel=Vector3.new(0,0,0),silentSpearLookVector=nil,spearIndicatorEnabled=false,spearFovCircleEnabled=false,spearIsHolding=false,spearHoldStartTime=nil,lastSpearSpeed=142.5,lastGravityMult=1,SPEAR_SNAPLINE={enabled=false,locked=false,lockedTarget=nil,lockedPlayerName="",currentNearestDist=math.huge,lockPulse=0,},SpearFOVCircle=nil,SpearIndicatorGui=nil,SpearStatusText=nil,SpearInfoText=nil,SpearAccentBar=nil,SpearMainFrame=nil,SnapLineGui=nil,SnapLineFrame=nil,SnapLineDot=nil,SnapLineTextLabel=nil,autoCrouchIsCrouching=false,autoCrouchActiveSlashers={},autoCrouchAnimConns={},_jitterFlip=false,_hookedMobButtons={},_hookedSlasherButtons={},_perfElapsed=0,_perfFrames=0,_perfActive=false,ghostGateEnabled=false,movConns={antiFall=nil,noSlow=nil},aimConn=nil,aimTargetCache=nil,aimTargetT=0,aimLastStableDir=nil,ghostGateOriginals={},antiLoopWindowEnabled=false,predGui=nil,predInfoLabel=nil,predActive=false,predMapName="Unknown",predLastPos=nil,predMapInfoConn=nil,autoDropNearbyPallets=false,palletPointsCache=nil,lastPalletPointScan=0,autoDropCooldown=false,moonwalkMobileDir=0,moonwalkPCForward=false,moonwalkPCBackward=false,moonwalkGui=nil,}
local ItemIcons={["Adrenaline Shot"]="rbxassetid://135388781922226",Bandage="rbxassetid://97791520639443",Flashlight="rbxassetid://103299939715311",Gate="rbxassetid://131249244284700",["Holy Water"]="rbxassetid://86130208614143",["Motion Tracker"]="rbxassetid://92303584765773",["Parrying Dagger"]="rbxassetid://76822757630703",["Riot Shield"]="rbxassetid://95718705901699",["Shadow Clone"]="rbxassetid://134088840518889",["Twist of Fate"]="rbxassetid://98397448432071",["WaxBound Candle"]="rbxassetid://110413686590821",}
local
function esp28_func(TypeStr)
if not TypeStr or type(TypeStr)~="string"then
 return nil
end
TypeStr=TypeStr:match("^%s*(.-)%s*$")
local Icon=ItemIcons[TypeStr]
if Icon then
 return Icon
end
for StringLib,IconUrl in pairs(ItemIcons)do
 if StringLib.lower(StringLib)==TypeStr.lower(TypeStr)then
 return IconUrl
 end
end
return nil
end
local MagicConst=17
local ESPFolder={"BOLONGHUB"}
local ESPFramesFolder=Instance.new("Folder")ESPFramesFolder.Name="__BolongESP__"ESPFramesFolder.Parent=workspace
local ESPEntries={}
local
function CreateESPEntry(EntryName,EntryInterval,EntryCallback)ESPEntries[#ESPEntries+1]={name=EntryName,interval=EntryInterval,timer=0,fn=EntryCallback}
end
local AntiAFKActive=false
local TaskDelayHook
local SpeedMultipliers={[25]=true,[17]=true,[30]=true,[67.8]=true}
local
function RemoveESPEntry()
if TaskDelayHook then
 return
end
pcall(
function()
TaskDelayHook=hookfunction(task.delay,newcclosure(
function(DelayArg,CallbackArg)
if not AntiAFKActive then
 return TaskDelayHook(DelayArg,CallbackArg)
end
if SpeedMultipliers[DelayArg]then
 return TaskDelayHook(0,CallbackArg)
end
return TaskDelayHook(DelayArg,CallbackArg)
end
))
end
)
end
local
function ClearAllESP()
if TaskDelayHook then
pcall(restorefunction,task.delay)
TaskDelayHook=nil
end
end
local
function GetPlayerRole(Player)
return ESPState.playerRoles[Player]or"survivor"
end
local
function IsPlayerAlive(IdleConn)
local PcallOk,TeamName=pcall(
function()
return IdleConn.Teamand IdleConn.Team.Name:lower()or""
end
)ESPState.playerRoles[IdleConn]=(PcallOk and TeamName:find("killer"))and"killer"or"survivor"
end
local AgainstVal
local
function UpdateAntiBlind()task.spawn(
function()
local FindOk,FindResult=pcall(
function()
return ReplicatedStorage:WaitForChild("Remotes",10):WaitForChild("Items",10):WaitForChild("Flashlight",10):WaitForChild("GotBlinded",10)
end
)
if not FindOk or not FindResult then
 return
end
AgainstVal=FindResult
local OrigNamecall OrigNamecall=hookmetamethod(game,"__namecall",
function(...)
local Method=getnamecallmethod()
local CallArgs=table.pack(...)
local CheckVal=CallArgs[1]
if Method=="FireServer"and typeof(CheckVal)=="Instance"and rawequal(CheckVal,AgainstVal)then
 if Settings.antiBlindEnabledand CallArgs[2]==true then
 return
 end
end
return OrigNamecall(...)
end
)
local OrigIndex OrigIndex=hookmetamethod(game,"__index",
function(CheckVal2,PropName)
if not checkcaller()and PropName=="FireServer"and typeof(CheckVal2)=="Instance"and rawequal(CheckVal2,AgainstVal)then
 return newcclosure(
 function(...)
 local HookArgs=table.pack(...)
 if Settings.antiBlindEnabled and HookArgs[2]==true then
 return
 end
 return OrigIndex(CheckVal2,PropName)(...)
end
)
end
return OrigIndex(CheckVal2,PropName)
end
)
end
)
end
UpdateAntiBlind()CreateESPEntry("AntiBlindForce",0.2,
function()
if not Settings.antiBlindEnabledthen
return
end
for _,Desc in ipairs(PlayerGui.GetDescendants(PlayerGui))do
 if Desc.Name=="Blind"then
 if Desc:IsA("ScreenGui")then
 if Desc.Enabled then
Desc.Enabled=false
 end
 elseif Desc:IsA("GuiObject")then
 if Desc.Visible then
Desc.Visible=false
 end
 if Desc.BackgroundTransparency<1 then
Desc.BackgroundTransparency=1
 end
 end
 end
end
end
)
local IdleConn2
local
function SetupAntiAFK(Enable)
if Enable then
 if not IdleConn2 then
IdleConn2=LocalPlayer.Idled:Connect(
 function()VirtualUser:CaptureController()VirtualUser:ClickButton2(Vector2.new())
 end
)
end
else
if IdleConn2 then
IdleConn2.Disconnect(IdleConn2)
IdleConn2=nil
end
end
end
local GuiHolder,esp1_func,TempFlag,ResetCameraVeil do
 local
 function GetExploitGui()
 local GetHuiOk,GetHuiResult=pcall(
 function()
 if gethui then
 return gethui()
 end
 return game:GetService("CoreGui")
end
)
return(GetHuiOk and GetHuiResult)or PlayerGui
end
local
function GetTargetPosition(Char)
if not Char then
 return nil
end
local Head=Char:FindFirstChild("Head")
if Head then
 return Head.Position
end
local Root=Char:FindFirstChild("HumanoidRootPart")
if Root then
 return Root.Positionend
 local UpperTorso=Char:FindFirstChild("UpperTorso")
 if UpperTorso then
 return UpperTorso.Position
 end
 local Torso=Char:FindFirstChild("Torso")
 if Torso then
 return Torso.Positionend
 return Char.PrimaryPart and Char.PrimaryPart.Positionor nil
 end
 local
 function GetFlatVelocity(VelChar)
 if not VelChar then
 return Vector3.new(0,0,0)
 end
 local Vel=VelChar.AssemblyLinearVelocitylocal FlatVel=Vector3.new(Vel.X,0,Vel.Z)
 if FlatVel.Magnitude>65 then
FlatVel=FlatVel.Unit*65
 end
 return FlatVel
end
local
function GetCameraOrigin()
local MyChar=LocalPlayer.Characterlocal MyRoot=MyChar and MyChar:FindFirstChild("HumanoidRootPart")
if not MyRoot then
 return nil
end
local Cam=Workspace.CurrentCamera
local LookDir=(Cam and Cam.CFrame.LookVector)or MyRoot.CFrame.LookVectorreturn MyRoot.Position+LookDir*3+Vector3.new(0,1.5,0)
end
local
function CalcSpearSpeed(TargetChar)
local ClampedVal=tonumber(ESPState.CV_LastSpearSpeed)or tonumber(Settings.cameraVeilSpearSpeed)or 220
return math.clamp(ClampedVal,35,800)
end
local
function BallisticSolve(Dist,Angle,Spd,Grav)
local CosA=math.cos(Angle)
if CosA<=0.015 then
 return nil,nil
end
local T=Dist/(Spd*CosA)
if T~=T or T<=0 then
 return nil,nil
end
local DT=1/60
local GravDrop=0.5*Grav*DT*T
local PredY=Spd*math.sin(Angle)*T-(0.5*Grav*T*T)-GravDrop
return PredY,T
end
local
function ScoreBallistic(Src,VertDist,PitchAngle,Spd2,GravM)
local HorizDist,TT=BallisticSolve(Src,PitchAngle,Spd2,GravM)
if not HorizDist or not TT then
 return nil
end
if TT<0.025 or TT>4 then
 return nil
end
local Score1=math.abs(HorizDist-VertDist)
local AbsVertDist=math.max(PitchAngle-Angle42,0)*0.35
local Score2=math.max(TT-1.3,0)*0.25
return Score1+AbsVertDist+Score2,Score1,TT
end
local
function PredictShot(From,To,Spd3,GravF)
local Delta=To-From
local FlatDelta=Vector3.new(Delta.X,0,Delta.Z)
local FlatDist2=FlatDelta.Magnitude
local val1=Delta.Yif Delta.Magnitude<=0.001 then
 return nil
end
if FlatDist2<=0.35 or GravF<=0.001 then
 return Delta.Unit,math.clamp(Delta.Magnitude/Spd3,0.025,4)
end
local FlatDir=FlatDelta.Unit
local MinPitch=math.atan2(val1,FlatDist2)
local LowPitch=math.max(-Angle28,MinPitch-Angle18)
local HighPitch=Angle72
local BaseY,BestScore,BestTime,BestTT=nil,math.huge,math.huge,nil
local Steps2=24
for Step=0,Steps2 do
 local TestAngle=LowPitch+(HighPitch-LowPitch)*(Step/Steps2)
 local TestScore,TestTime,TestTT=ScoreBallistic(FlatDist2,val1,TestAngle,Spd3,GravF)
 if TestScore and TestScore<BestScore then
BestScore,BestTime,BaseY,BestTT=TestScore,TestTime,TestAngle,TestTT
 if BestTime<SmallOffset then
break
 end
 end
end
if BaseY then
 local GravityMul=(HighPitch-LowPitch)/Steps2*2.5
 local RefinePasses=(BestTime<SmallOffset)and 1 or 3
 for Pass=1,RefinePasses do
 local RefBestAngle,RefBestScore,RefBestTime,RefBestTT=BaseY,BestScore,BestTime,BestTT
 for Steps=-3,3 do
 local SubAngle=math.clamp(BaseY+GravityMul*(Steps/3),LowPitch,HighPitch)
 local SubScore,SubTime,SubTT=ScoreBallistic(FlatDist2,val1,SubAngle,Spd3,GravF)
 if SubScore and SubScore<RefBestScore then
RefBestScore,RefBestTime,RefBestAngle,RefBestTT=SubScore,SubTime,SubAngle,SubTT
 end
 end
BaseY,BestScore,BestTime,BestTT=RefBestAngle,RefBestScore,RefBestTime,RefBestTT
 if BestTime<SmallOffset then
break
 end
GravityMul=GravityMul*0.38
 end
end
if not BaseY then
 local FallbackTime=math.clamp(FlatDist2/Spd3,0.025,4)
 local FallbackPos=To+Vector3.new(0,0.5*GravF*FallbackTime*FallbackTime,0)
 local FallbackDir=FallbackPos-From
 if FallbackDir.Magnitude<=0.001 then
 return nil
 end
 return FallbackDir.Unit,FallbackTime
end
local FinalDir=FlatDir*math.cos(BaseY)+Vector3.new(0,math.sin(BaseY),0)
if FinalDir.Magnitude<=0.001 then
 return nil
end
return FinalDir.Unit,BestTT
end
local
function CameraVeilSolve(TargetHeadPos)
local CamOrigin=GetCameraOrigin()
if not CamOrigin or not TargetHeadPos then
 return nil
end
local SpearSpd=CalcSpearSpeed((TargetHeadPos-CamOrigin).Magnitude)
local GravMult2=math.max(tonumber(ESPState.CV_LastGravityMult)or tonumber(Settings.cameraVeilGravityMult)or1,0)
local EffectiveGrav=Gravity*GravMult2
return PredictShot(CamOrigin,TargetHeadPos,SpearSpd,EffectiveGrav)
end
local
function CameraVeilPredict(HeadPos,Velocity2)
if not HeadPos then
 return nil
end
local CamPos=GetCameraOrigin()
if CamPos then
 local CamToHead=HeadPos-CamPos
 local DistToHead=CamToHead.Magnitudeif DistToHead<6 then
 if DistToHead<0.001 then
 return nil
 end
 local SpearSpd2=tonumber(ESPState.CV_LastSpearSpeed)or tonumber(Settings.cameraVeilSpearSpeed)or220
 return CamToHead.Unit,HeadPos,math.clamp(DistToHead/math.max(SpearSpd2,1),0.01,1)
 end
end
local FrameNum=ESPState.CV_frameCountlocal FramesSinceBallistic=FrameNum-ESPState.CV_ballisticFramelocal CloseToLast=ESPState.CV_lastSolvedHeadPos and(HeadPos-ESPState.CV_lastSolvedHeadPos).Magnitude<DefaultSpeed
if FramesSinceBallistic<DefaultHeight and CloseToLast and ESPState.CV_lastSolvedDir then
 return ESPState.CV_lastSolvedDir,ESPState.CV_lastSolvedPredicted,ESPState.CV_lastSolvedTimeend
 local PredictedHead=HeadPos
 local AimDir,AimTime=CameraVeilSolve(PredictedHead)
 if AimDir and AimTime and Velocity2 and Velocity2.Magnitude>1.25 then
 local LeadFactor=math.clamp(AimTime*0.68,0,1.1)
 local LeadOffset=Velocity2*LeadFactor
 if LeadOffset.Magnitude>32 then
LeadOffset=LeadOffset.Unit*32
 end
 local LeadedPos=HeadPos+LeadOffset
 local LeadDir,LeadTT=CameraVeilSolve(LeadedPos)
 if LeadDir and LeadTT then
AimDir,AimTime,PredictedHead=LeadDir,LeadTT,LeadedPos
 end
 end
ESPState.CV_ballisticFrame=FrameNum ESPState.CV_lastSolvedHeadPos=HeadPos ESPState.CV_lastSolvedDir=AimDir ESPState.CV_lastSolvedPredicted=PredictedHead ESPState.CV_lastSolvedTime=AimTime
 return AimDir,PredictedHead,AimTime
end
local IsSpearModeActive
local
function FindBestSurvivor()
local Cam2=Workspace.CurrentCameraif not Cam2 then
 return nil
end
local CamPos2,CamLook=Cam2.CFrame.Position,Cam2.CFrame.LookVector
local BestTarget,BestAngle2=nil,RadAngle30
local MyChar2=LocalPlayer.Character
local MyRoot2=MyChar2 and MyChar2:FindFirstChild("HumanoidRootPart")
if not MyRoot2 then
 return nil
end
for _,Plr in ipairs(Players.GetPlayers(Players))do
 if Plr~=LocalPlayer then
 local Role=GetPlayerRole(Plr)
 if Role=="survivor"then
 local PlrChar=Plr.Characterlocal PlrHum=PlrChar and PlrChar:FindFirstChildOfClass("Humanoid")
 if PlrChar and PlrHum and PlrHum.Health>0 then
 local PlrPos=GetTargetPosition(PlrChar)
 if PlrPos then
 local PlrDist=(PlrPos-MyRoot2.Position).Magnitude
 if PlrDist<=Settings.cameraVeilMaxDistancethen
 local CamToPlr=PlrPos-CamPos2
 if CamToPlr.Magnitude>0.001 then
 local AngleDiff=math.acos(math.clamp(CamLook:Dot(CamToPlr.Unit),-1,1))
 if AngleDiff<BestAngle2 then
BestAngle2=AngleDiff;
BestTarget=Plr
 end
 end
 end
 end
 end
 end
end
end
return BestTarget
end
local
function AutoGen()
if ESPState.CV_SnapGui and ESPState.CV_SnapGui.Parentand ESPState.CV_SnapLineand ESPState.CV_SnapLine.Parentand ESPState.CV_SnapDotand ESPState.CV_SnapDot.Parentthen
return
end
local SnapGui=Instance.new("ScreenGui")SnapGui.Name="CameraVeil_SnapLine"SnapGui.IgnoreGuiInset=true;
SnapGui.ResetOnSpawn=false;
SnapGui.Parent=GetExploitGui()
local SnapLine=Instance.new("Frame")SnapLine.Name="Line";
SnapLine.AnchorPoint=Vector2.new(0.5,0.5);
SnapLine.BorderSizePixel=0 SnapLine.BackgroundColor3=Color3.fromRGB(0,255,120);
SnapLine.BackgroundTransparency=0.08 SnapLine.Visible=false;
SnapLine.Parent=SnapGui
local SnapDot=Instance.new("Frame")SnapDot.Name="Dot";
SnapDot.AnchorPoint=Vector2.new(0.5,0.5);
SnapDot.BorderSizePixel=0 SnapDot.BackgroundColor3=Color3.fromRGB(0,255,120);
SnapDot.BackgroundTransparency=0 SnapDot.Size=UDim2.fromOffset(7,7);
SnapDot.Visible=false;
SnapDot.Parent=SnapGui
local DotCorner=Instance.new("UICorner");
DotCorner.CornerRadius=UDim.new(1,0);
DotCorner.Parent=SnapDot ESPState.CV_SnapGui=SnapGui;
ESPState.CV_SnapLine=SnapLine;
ESPState.CV_SnapDot=SnapDot
end
local
function UpdateSnapLine(TargetPos)
if not Settings.cameraVeilSnapLine or not ESPState.CV_Enabledthen
if ESPState.CV_SnapLinethen ESPState.CV_SnapLine.Visible=false
end
if ESPState.CV_SnapDot then
ESPState.CV_SnapDot.Visible=false
end
return
end
if not IsSpearModeActive()then
 if ESPState.CV_SnapLine then
ESPState.CV_SnapLine.Visible=false
 end
 if ESPState.CV_SnapDot then
ESPState.CV_SnapDot.Visible=false
 end
 return
end
local CurFrame=ESPState.CV_frameCountif TargetPos and(CurFrame-ESPState.CV_snapLineFrame)<2 then
 return
end
ESPState.CV_snapLineFrame=CurFrame
local SnapOk=pcall(
function()AutoGen()
local LineFrame=ESPState.CV_SnapLine;
local DotFrame=ESPState.CV_SnapDot;
local Cam3=Workspace.CurrentCameraif not LineFrame or not Cam3 then
 if LineFrame then
LineFrame.Visible=false
 end
 if DotFrame then
DotFrame.Visible=false
 end
 return
end
local DotPos=TargetPos
local IsHolding=(ESPState.CV_CurrentTarget~=nil and ESPState.CV_WasHolding)
if not IsHolding then
 local Survivor=FindBestSurvivor()
 if Survivor then
 local SurvivorChar=Survivor.Characterif SurvivorChar then
DotPos=GetTargetPosition(SurvivorChar)
 end
 else DotPos=nil
end
end
if not DotPos then
LineFrame.Visible=false;
 if DotFrame then
DotFrame.Visible=false
 end
 return
end
local ScreenPos,OnScreen=Cam3:WorldToViewportPoint(DotPos)
if not OnScreen or ScreenPos.Z<=0 then
LineFrame.Visible=false;
 if DotFrame then
DotFrame.Visible=false
 end
 return
end
local ViewportSize=Cam3.ViewportSizelocal ScreenCenter=Vector2.new(ViewportSize.X*0.5,ViewportSize.Y*0.5)
local TargetScreen=Vector2.new(ScreenPos.X,ScreenPos.Y)
local ScreenDelta=TargetScreen-ScreenCenter;
local ScreenDist=ScreenDelta.Magnitudeif ScreenDist<2 then
LineFrame.Visible=false;
 if DotFrame then
DotFrame.Visible=false
 end
 return
end
local LineColor=IsHolding and Color3.fromRGB(0,255,120)or Color3.fromRGB(255,220,0)
local LineAlpha=IsHolding and 0.08 or 0.35 LineFrame.BackgroundColor3=LineColor;
LineFrame.BackgroundTransparency=LineAlpha LineFrame.Size=UDim2.fromOffset(ScreenDist,IsHolding and 2 or 1)LineFrame.Position=UDim2.fromOffset((ScreenCenter.X+TargetScreen.X)*0.5,(ScreenCenter.Y+TargetScreen.Y)*0.5)LineFrame.Rotation=math.deg(math.atan2(ScreenDelta.Y,ScreenDelta.X));
LineFrame.Visible=true
if DotFrame then
DotFrame.BackgroundColor3=LineColor;
DotFrame.Position=UDim2.fromOffset(TargetScreen.X,TargetScreen.Y);
DotFrame.Visible=true
end
end
)
if not SnapOk then
 if ESPState.CV_SnapLinethen ESPState.CV_SnapLine.Visible=false
end
if ESPState.CV_SnapDotthen ESPState.CV_SnapDot.Visible=false
end
end
end
function ResetCameraVeil()ESPState.CV_CurrentTarget=nil;
ESPState.CV_WasHolding=false ESPState.CV_LastStableDir=nil;
ESPState.CV_acquireStartFrame=nil UpdateSnapLine(nil)
end
IsSpearModeActive=
function()
local FrameCheck=ESPState.CV_frameCount
if FrameCheck==ESPState.CV_spearModeFramethen
return ESPState.CV_cachedSpearMode
end
ESPState.CV_spearModeFrame=FrameCheck
local TargetInst=LocalPlayer.Characterlocal flag1=false
if TargetInst then
 local Wnvz0Ql,qQHuQH=pcall(TargetInst.GetAttribute,TargetInst,"spearmode")
flag1=Wnvz0Ql and qQHuQH==true
end
ESPState.CV_cachedSpearMode=flag1
return flag1
end
local
function IsSpearMode()
if not IsSpearModeActive()then
 return false
end
return ESPState.CV_HoldingPCor ESPState.CV_HoldingMobileend
local
function SetupCameraVeil()ESPState.CV_frameCount=ESPState.CV_frameCount+1
if not ESPState.CV_Enabledthen
return
end
local flag2=IsSpearMode()
if not flag2 then
 if ESPState.CV_WasHoldingthen ResetCameraVeil()
else UpdateSnapLine(nil)
end
return
end
if not ESPState.CV_WasHolding then
ESPState.CV_LastStableDir=nil ESPState.CV_CurrentTarget=FindBestSurvivor()ESPState.CV_WasHolding=true ESPState.CV_acquireStartFrame=ESPState.CV_frameCount
end
if ESPState.CV_acquireStartFrameand(ESPState.CV_frameCount-ESPState.CV_acquireStartFrame)<DefaultCount then
 local gui1=FindBestSurvivor()
 if gui1 then
ESPState.CV_CurrentTarget=gui1
 end
end
local char1=ESPState.CV_CurrentTarget
if not char1 then
ESPState.CV_WasHolding=false;
 return
end
local char2=char1.Character
local char3=char2 and char2:FindFirstChildOfClass("Humanoid")
local char4=GetPlayerRole(char1)
if not char2 or not char3 or char3.Health<=0 or char4~="survivor"then
ESPState.CV_WasHolding=false;
ESPState.CV_CurrentTarget=nil;
 return
end
local SnapTarget=GetTargetPosition(char2)
if not SnapTarget then
ESPState.CV_WasHolding=false;
ESPState.CV_CurrentTarget=nil;
 return
end
local CamPart=Workspace.CurrentCameralocal char5=LocalPlayer.Character
local char6=char5 and char5:FindFirstChild("HumanoidRootPart")
if not CamPart or not char6 then
 return
end
if(SnapTarget-char6.Position).Magnitude>Settings.cameraVeilMaxDistance then
ESPState.CV_WasHolding=false;
ESPState.CV_CurrentTarget=nil;
 return
end
local char7=GetFlatVelocity(char2:FindFirstChild("HumanoidRootPart"))
local val2=CameraVeilPredict(SnapTarget,char7)
local val3=val2 and val2.Magnitude>0.001 and val2.Y<MaxClamp and val2.Y>MinClamp
if val3 then
 if ESPState.CV_LastStableDir then
 local WlqwnmNm=math.acos(math.clamp(ESPState.CV_LastStableDir:Dot(val2.Unit),-1,1))
 if WlqwnmNm<RadAngle45 then
ESPState.CV_LastStableDir=val2.Unitend
 else ESPState.CV_LastStableDir=val2.Unitend val2=ESPState.CV_LastStableDirelseif ESPState.CV_LastStableDirthen val2=ESPState.CV_LastStableDir
 else val2=CamPart.CFrame.LookVectorend
 local SolveOrigin=CamPart.CFrame.Position
 local val4=math.clamp(Settings.cameraVeilSmoothnessor 1,0.05,1)
 local SolveDir=CamPart.CFrame.LookVector:Lerp(val2,val4)
 if SolveDir.Magnitude>0.001 then
CamPart.CFrame=CFrame.new(SolveOrigin,SolveOrigin+SolveDir.Unit)UpdateSnapLine(SnapTarget)
 end
end
local
function CleanupCameraVeil(Obj,AncestorName)
local Ancestor=Obj and Obj.Parentwhile Ancestor do
 if Ancestor.Name==AncestorName then
 return true
 end
Ancestor=Ancestor.Parentend
 return false
end
local
function SetupEndScreenSkip(Button)
if not(Button and Button:IsA("GuiButton"))then
 return false
end
if Button.Name~="attack"then
 return false
end
if not CleanupCameraVeil(Button,"Slasher-mob")then
 return false
end
if not CleanupCameraVeil(Button,"Control")and not CleanupCameraVeil(Button,"Controls")then
 return false
end
return true
end
local
function SetupSilentAim(Button2)
if not SetupEndScreenSkip(Button2)then
 return
end
if ESPState.CV_HookedButtons[Button2]then
 return
end
ESPState.CV_HookedButtons[Button2]=true
local
function SetupMoonwalk()
if not ESPState.CV_Enabledor not IsSpearModeActive()then
 return
end
ESPState.CV_HoldingMobile=true
end
local
function SetupSpeedBoost()ESPState.CV_HoldingMobile=false
end
local NewConn=Button2.InputBegan:Connect(
function(InputObj)
local InputType=InputObj.UserInputTypeif InputType~=Enum.UserInputType.Touch and InputType~=Enum.UserInputType.MouseButton1 then
 return
end
SetupMoonwalk()
local EndedConn EndedConn=UIS2.InputEnded:Connect(
function(EndedInput)
if EndedInput==InputObj then
SetupSpeedBoost();
 if EndedConn then
EndedConn.Disconnect(EndedConn)
 end
end
end
)
end
)table.insert(ESPState.CV_Connections,NewConn)
local EndedConn2=Button2.InputEnded:Connect(
function(InputObj2)
local InputType2=InputObj2.UserInputTypeif InputType2~=Enum.UserInputType.Touch and InputType2~=Enum.UserInputType.MouseButton1 then
 return
end
SetupSpeedBoost()
end
)table.insert(ESPState.CV_Connections,EndedConn2)
end
function TempFlag()
local GuiFolder=LocalPlayer:FindFirstChildOfClass("PlayerGui")or PlayerGui
if not GuiFolder then
 return
end
pcall(
function()
for ConnKey,ConnVal in ipairs(GuiFolder.GetDescendants(GuiFolder))do
SetupSilentAim(ConnVal)
end
end
)
if ESPState.CV_WatchConnthen ESPState.CV_WatchConn:Disconnect()
end
ESPState.CV_WatchConn=GuiFolder.DescendantAdded:Connect(SetupSilentAim)table.insert(ESPState.CV_Connections,ESPState.CV_WatchConn)
end
local
function HX_Hp()
if ESPState.CV_VisualConnthen
return
end
local PcallOk2,RemoteObj=pcall(
function()
local RS=game:GetService("ReplicatedStorage")
local Remotes=RS:FindFirstChild("Remotes")
local Mechanics=Remotes and Remotes:FindFirstChild("Mechanics")
return Mechanics and Mechanics:FindFirstChild("visualize")
end
)
if PcallOk2 and RemoteObj and RemoteObj:IsA("RemoteEvent")then
ESPState.CV_VisualConn=RemoteObj.OnClientEvent:Connect(
 function(PlayerChar,_,IsNumber,IsPositive)
 if PlayerChar~=LocalPlayer.Characterthen
 return
end
if type(IsNumber)=="number"and IsNumber>0 then
ESPState.CV_LastSpearSpeed=IsNumber
end
if type(IsPositive)=="number"and IsPositive>=0 then
ESPState.CV_LastGravityMult=IsPositive
end
end
)table.insert(ESPState.CV_Connections,ESPState.CV_VisualConn)
end
end
function GuiHolder()
if ESPState.CV_Enabled then
 return
end
ESPState.CV_Enabled=true ESPState.CV_HoldingPC=false;
ESPState.CV_HoldingMobile=false ResetCameraVeil();
HX_Hp();
TempFlag()ESPState.CV_InputBeganConn=UIS2.InputBegan:Connect(
function(InputObj3)
if InputObj3.UserInputType==Enum.UserInputType.MouseButton2 and IsSpearModeActive()then
ESPState.CV_HoldingPC=true
end
end
)table.insert(ESPState.CV_Connections,ESPState.CV_InputBeganConn)ESPState.CV_InputEndedConn=UIS2.InputEnded:Connect(
function(InputObj4)
if InputObj4.UserInputType==Enum.UserInputType.MouseButton2 then
ESPState.CV_HoldingPC=false
end
end
)table.insert(ESPState.CV_Connections,ESPState.CV_InputEndedConn)pcall(
function()RunService:UnbindFromRenderStep(ESPState.CV_RenderStepName)
end
)pcall(
function()RunService:BindToRenderStep(ESPState.CV_RenderStepName,Enum.RenderPriority.Camera.Value+2,SetupCameraVeil)
end
)
end
function esp1_func()ESPState.CV_Enabled=false ESPState.CV_HoldingPC=false;
ESPState.CV_HoldingMobile=false ResetCameraVeil()ESPState.CV_frameCount=0;
ESPState.CV_snapLineFrame=-99;
ESPState.CV_spearModeFrame=-99;
ESPState.CV_cachedSpearMode=false ESPState.CV_ballisticFrame=-99;
ESPState.CV_lastSolvedHeadPos=nil;
ESPState.CV_lastSolvedDir=nil ESPState.CV_lastSolvedPredicted=nil;
if 0>(730)then
 local esp1=381+730
 local esp2=esp1*2
end
ESPState.CV_lastSolvedTime=nil pcall(
function()RunService:UnbindFromRenderStep(ESPState.CV_RenderStepName)
end
)
for oUNoI,v_UMbvvnzpopql in ipairs(ESPState.CV_Connections)do
pcall(
 function()v_UMbvvnzpopql:Disconnect()
end
)
end
ESPState.CV_Connections={};
ESPState.CV_HookedButtons={}ESPState.CV_InputBeganConn=nil;
ESPState.CV_InputEndedConn=nil;
ESPState.CV_WatchConn=nil;
ESPState.CV_VisualConn=nil
end
end
local
function esp13_func(wxbXbI,QnvbX00QlovM,wUNI_u,BwM0wo)
local gui2=Instance.new("BillboardGui")gui2.AlwaysOnTop=true;
gui2.Size=wUNI_u or UDim2.new(0,40,0,40);
gui2.StudsOffset=Vector3.new(0,3.5,0)
local gui3=Instance.new("TextLabel")gui3.Name="Label";
gui3.Size=UDim2.new(1,0,1,0);
gui3.BackgroundTransparency=1 gui3.Text=wxbXbI;
gui3.TextColor3=QnvbX00QlovM;
gui3.TextStrokeTransparency=0 gui3.TextStrokeColor3=Color3.new(0,0,0);
gui3.TextSize=BwM0wo or 22 gui3.Font=Enum.Font.GothamBold;
gui3.RichText=true;
gui3.Parent=gui2
return gui2
end
local
function esp30_func()
for uNpoqHmX,HasESP in pairs(ESPState.espObjects)do
 if HasESP and HasESP.billboard and HasESP.billboard.Parentthen
 local gui4=GetPlayerRole(uNpoqHmX);
 local gui5=gui4=="killer"HasESP.nameLabel.Visible=(gui5 and Settings.killerShowName)or(not gui5 and Settings.survivorShowName)HasESP.nameLabel.Text=ESPState.pnameEnabled and(ESPState.pnameFakeNames[uNpoqHmX]or uNpoqHmX.Name)or uNpoqHmX.NameHasESP.billboard.MaxDistance=Settings.maxDistanceend
end
for bDZWWwpUHIOnM,HasOutline in pairs(ESPState.outlineObjects)do
 if HasOutline and HasOutline.Parentthen
 local esp3=GetPlayerRole(bDZWWwpUHIOnM);
 local esp4=esp3=="killer"
 local esp5=esp4 and Settings.killerColoror Settings.survivorColorlocal esp6=(esp4 and Settings.killerShowOutline)or(not esp4 and Settings.survivorShowOutline)
 local esp7=(esp4 and Settings.killerOutlineOnly)or(not esp4 and Settings.survivorOutlineOnly)HasOutline.FillColor=esp5;
HasOutline.OutlineColor=esp5;
HasOutline.Enabled=esp6 HasOutline.FillTransparency=esp7 and1 or Settings.fillTransparency
end
end
end
local
function esp27_func(MQ00Dw1nI0bZml,WOQq_)
local esp8=ESPState.espObjects[MQ00Dw1nI0bZml]
if not esp8 then
 return
end
if not WOQq_ or not WOQq_.Parentor MQ00Dw1nI0bZml.Character~=WOQq_ then
 return
end
local char8=WOQq_:FindFirstChild("HumanoidRootPart")or WOQq_:FindFirstChild("Torso")or WOQq_:FindFirstChild("UpperTorso")or WOQq_:FindFirstChild("Head")
if not char8 then
task.spawn(
 function()
 local GuiObj1,_p0nO=pcall(
 function()
 return WOQq_:WaitForChild("HumanoidRootPart",3)
end
)
if GuiObj1 and _p0nO and _p0nO.Parent and WOQq_.Parentand MQ00Dw1nI0bZml.Character==WOQq_ then
 if esp8.billboard then
esp8.billboard.Adornee=_p0nO esp8.billboard.Enabled=true
 end
 if esp8.itemBillboardthen esp8.itemBillboard.Adornee=_p0nO esp8.itemBillboard.Enabled=true
end
end
end
)
return
end
if esp8.billboardthen esp8.billboard.Adornee=char8 esp8.billboard.Enabled=true
end
if esp8.itemBillboardthen esp8.itemBillboard.Adornee=char8 esp8.itemBillboard.Enabled=true
end
local flag3=GetPlayerRole(MQ00Dw1nI0bZml);
local gui6=flag3=="killer"esp8.nameLabel.Visible=(gui6 and Settings.killerShowName)or(not gui6 and Settings.survivorShowName)esp8.nameLabel.Text=ESPState.pnameEnabled and(ESPState.pnameFakeNames[MQ00Dw1nI0bZml]or MQ00Dw1nI0bZml.Name)or MQ00Dw1nI0bZml.Nameend
local
function MXwU1D0(HM0pbqmvOM)
if ESPState.espObjects[HM0pbqmvOM]then
 if ESPState.espObjects[HM0pbqmvOM].billboardthen ESPState.espObjects[HM0pbqmvOM].billboard:Destroy()
end
if ESPState.espObjects[HM0pbqmvOM].itemBillboardthen ESPState.espObjects[HM0pbqmvOM].itemBillboard:Destroy()
end
ESPState.espObjects[HM0pbqmvOM]=nil
end
if ESPState.outlineObjects[HM0pbqmvOM]then
ESPState.outlineObjects[HM0pbqmvOM]:Destroy();
ESPState.outlineObjects[HM0pbqmvOM]=nil
end
ESPState.playerRoles[HM0pbqmvOM]=nil
if ESPState.playerTeamConns[HM0pbqmvOM]then
ESPState.playerTeamConns[HM0pbqmvOM]:Disconnect();
ESPState.playerTeamConns[HM0pbqmvOM]=nil
end
end
local
function Oqpmb(DQvmwUI0,puNHplqx)
local esp9=ESPState.outlineObjects[DQvmwUI0]
if not esp9 then
 return
end
if not puNHplqx or not puNHplqx.Parentor DQvmwUI0.Character~=puNHplqx then
 return
end
local char9=GetPlayerRole(DQvmwUI0);
local esp10=char9=="killer"
local esp11=esp10 and Settings.killerColoror Settings.survivorColorlocal esp12=(esp10 and Settings.killerShowOutline)or(not esp10 and Settings.survivorShowOutline)
local esp13=(esp10 and Settings.killerOutlineOnly)or(not esp10 and Settings.survivorOutlineOnly)esp9.Adornee=puNHplqx esp9.FillColor=esp11 esp9.OutlineColor=esp11 esp9.FillTransparency=esp13 and 1 or Settings.fillTransparency esp9.OutlineTransparency=0 esp9.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop esp9.Enabled=esp12
end
local
function esp16_func(v_xQlDHqM_)
if v_xQlDHqM_==LocalPlayer then
 return
end
if not v_xQlDHqM_ or not v_xQlDHqM_.Parent then
 return
end
local esp14=ESPState.espObjects[v_xQlDHqM_]
local esp15=ESPState.outlineObjects[v_xQlDHqM_]
if not esp14 and not esp15 then
 return
end
local vlo_lu=v_xQlDHqM_.Character
if not vlo_lu or not vlo_lu.Parentthen
if esp14 and esp14.billboardthen esp14.billboard.Adornee=nil
end
if esp14 and esp14.itemBillboard then
esp14.itemBillboard.Adornee=nil
end
if esp15 then
esp15.Adornee=nil;
esp15.Enabled=false
end
return
end
local esp16=vlo_lu:FindFirstChild("HumanoidRootPart")or vlo_lu:FindFirstChild("Torso")or vlo_lu:FindFirstChild("UpperTorso")or vlo_lu:FindFirstChild("Head")
if not esp16 then
 return
end
if esp14 and esp14.billboard then
 if esp14.billboard.Adornee~=esp16 then
esp14.billboard.Adornee=esp16
 end
 if not esp14.billboard.Enabledthen esp14.billboard.Enabled=true
end
end
if esp14 and esp14.itemBillboard then
 if esp14.itemBillboard.Adornee~=esp16 then
esp14.itemBillboard.Adornee=esp16
 end
 if not esp14.itemBillboard.Enabled then
esp14.itemBillboard.Enabled=true
 end
end
if esp15 then
 if esp15.Adornee~=vlo_lu then
Oqpmb(v_xQlDHqM_,vlo_lu)
 else
 if not esp15.Enabledthen
 local esp17=GetPlayerRole(v_xQlDHqM_);
 local esp18=esp17=="killer"
 local flag4=(esp18 and Settings.killerShowOutline)or(not esp18 and Settings.survivorShowOutline)esp15.Enabled=flag4
end
end
end
end
local
function esp6_func(M_qXM)
if M_qXM==LocalPlayer then
 return
end
IsPlayerAlive(M_qXM)
local inst1=GetPlayerRole(M_qXM)
local inst2=Instance.new("BillboardGui")inst2.Name="ESP_BB_"..M_qXM.Name;
inst2.AlwaysOnTop=true inst2.Size=UDim2.new(0,150,0,18)inst2.StudsOffset=Vector3.new(0,3.5,0)inst2.MaxDistance=Settings.maxDistance;
inst2.Parent=ESPFramesFolder
local gui7=Instance.new("TextLabel")gui7.Name="NameLabel";
gui7.Size=UDim2.new(1,0,1,0)gui7.BackgroundTransparency=1 gui7.TextColor3=Color3.fromRGB(255,255,255);
gui7.TextStrokeTransparency=0 gui7.TextStrokeColor3=Color3.new(0,0,0);
gui7.TextSize=12 gui7.Font=Enum.Font.GothamBoldM_nM_w.Text=ESPState.pnameEnabledand(ESPState.pnameFakeNames[M_qXM]or M_qXM.Name)or M_qXM.Name gui7.Visible=(inst1=="killer"and Settings.killerShowName)or(inst1~="killer"and Settings.survivorShowName)gui7.Parent=inst2
local inst3=Instance.new("BillboardGui")inst3.Name="ESP_Item_"..M_qXM.Name inst3.AlwaysOnTop=true inst3.Size=UDim2.new(1.5,0,1.5,0)inst3.StudsOffset=Vector3.new(0,-5,0)inst3.MaxDistance=Settings.maxDistance inst3.Parent=ESPFramesFolder
local gui8=Instance.new("ImageLabel")gui8.Name="ItemImage"gui8.Size=UDim2.new(1,0,1,0)gui8.BackgroundTransparency=1 gui8.Visible=false gui8.Parent=inst3 ESPState.espObjects[M_qXM]={billboard=inst2,nameLabel=gui7,itemBillboard=inst3,itemImage=gui8}
if M_qXM.Character then
esp27_func(M_qXM,M_qXM.Character)
end
if not ESPState.playerTeamConns[M_qXM]then
ESPState.playerTeamConns[M_qXM]=M_qXM:GetPropertyChangedSignal("Team"):Connect(
 function()IsPlayerAlive(M_qXM)esp30_func()task.delay(0.5,
 function()esp16_func(M_qXM)
end
)task.delay(2,
function()esp16_func(M_qXM)
end
)
end
)
end
end
local
function wxouub(qpuXO_xp1QqO_)
if qpuXO_xp1QqO_==LocalPlayer then
 return
end
local inst4=Instance.new("Highlight");
inst4.Parent=ESPFramesFolder ESPState.outlineObjects[qpuXO_xp1QqO_]=inst4
if qpuXO_xp1QqO_.Character then
Oqpmb(qpuXO_xp1QqO_,qpuXO_xp1QqO_.Character)
end
end
local
function wmbMHDw_(ValueToCheck,__DWvwowb)
if typeof(ValueToCheck)~="Instance"then
 return nil
end
local inst5=ValueToCheck:GetAttribute(__DWvwowb)
if inst5~=nil then
 return inst5
end
local inst6=ValueToCheck:FindFirstChild(__DWvwowb)
if inst6 and inst6:IsA("ValueBase")then
 return inst6.Valueend
 return nil
end
local
function esp24_func(DUZuDNN,ubUlQIO0W_XuXz)
if not DUZuDNN or not DUZuDNN.Parent then
 return
end
local esp19=DUZuDNN:FindFirstChild("__BolongHL__")
if not esp19 then
esp19=Instance.new("Highlight");
esp19.Name="__BolongHL__";
esp19.Adornee=DUZuDNN esp19.FillTransparency=1;
esp19.OutlineTransparency=0;
esp19.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop esp19.FillColor=ubUlQIO0W_XuXz;
esp19.OutlineColor=ubUlQIO0W_XuXz;
esp19.Parent=DUZuDNN;
 return
end
if esp19.FillColor~=ubUlQIO0W_XuXz then
esp19.FillColor=ubUlQIO0W_XuXz;
esp19.OutlineColor=ubUlQIO0W_XuXz
end
if not esp19.Enabledthen esp19.Enabled=true
end
end
local
function onHbZx(wMuuQUW)
if not wMuuQUW then
 return
end
local esp20=wMuuQUW:FindFirstChild("__BolongHL__")
if esp20 then
esp20.Destroy(esp20)
end
end
local
function esp23_func(GeneratorPart)
if not GeneratorPart or not GeneratorPart.Parentthen
return true
end
if ESPState.completedGenerators[GeneratorPart]then
 return true
end
local Progress=GeneratorPart:GetAttribute("RepairProgress")or GeneratorPart:GetAttribute("Progress")or 0
local gen1=(Progress>=100)or(GeneratorPart:GetAttribute("Completed")==true)or(GeneratorPart:GetAttribute("IsCompleted")==true)or(GeneratorPart:GetAttribute("Done")==true)
local inst7=GeneratorPart:FindFirstChild("__BolongGenProgress__")
if gen1 then
 if inst7 then
inst7.Destroy(inst7)
 end
onHbZx(GeneratorPart)GeneratorPart:SetAttribute("__BolongGenLastPct__",nil)GeneratorPart:SetAttribute("__BolongGenLastInfo__",nil)ESPState.completedGenerators[GeneratorPart]=true ESPState.genIndices[GeneratorPart]=nil
 return gen1
end
if Settings.espGeneratorEnabledthen esp24_func(GeneratorPart,Settings.espGeneratorColor)
else onHbZx(GeneratorPart)
end
if Settings.espGeneratorProgressGen then
 local CoordY=GeneratorPart:GetAttribute("PlayersRepairingCount")or0
 local CoordZ=GeneratorPart:GetAttribute("kickcount")or 0 do
 local gen2=279*(0+1-1)
 local gen3=gen2+495-495
 end
 local CoordX=math.floor(Progress+0.5)
 local GeneratorModel=GeneratorPart:GetAttribute("__BolongGenLastPct__")
 local MZ00U=GeneratorPart:GetAttribute("__BolongGenLastInfo__")
 local GenNum=ESPState.genIndices[GeneratorPart]or 1
 local gen4=string.format("%d_%d_%d_%s_%d",CoordX,CoordY,CoordZ,tostring(Settings.espGenShowPK),GenNum)
 if GeneratorModel==CoordX and MZ00U==gen4 and inst7 then
 return false
 end
GeneratorPart:SetAttribute("__BolongGenLastPct__",CoordX)GeneratorPart:SetAttribute("__BolongGenLastInfo__",gen4)
 local color1=math.clamp(Progress,0,100)
 local color2=(color1<50)and Settings.espGeneratorColor:Lerp(Color3.fromRGB(255,200,0),color1/50)or Color3.fromRGB(255,200,0):Lerp(Color3.fromRGB(100,255,80),(color1-50)/50)
 local color3=color2.ToHex(color2)
 local color4=string.format("GEN%d",GenNum)
 local color5=string.format("%d%%",CoordX)
 local inst8=GeneratorPart:FindFirstChild("GeneratorBody",true)or GeneratorPart:FindFirstChild("defaultMaterial",true)or(GeneratorPart:IsA("Model")and GeneratorPart.PrimaryPart)or GeneratorPart:FindFirstChildWhichIsA("BasePart",true)
 if not inst8 then
 return false
 end
 local inst9="F4D03F"
 local inst10=string.format("<font size=\"9\" color=\"#%s\">%s</font> <font color=\"#555555\">│</font> <font color=\"#%s\">%s</font>",inst9,color4,color3,color5)
 if Settings.espGenShowPKthen inst10=inst10..string.format(" <font color=\"#555555\">│</font> <font color=\"#76D7C4\">P:%d</font> <font color=\"#555555\">│</font> <font color=\"#FF6B6B\">K:%d</font>",CoordY,CoordZ)
end
if not inst7 then
inst7=Instance.new("BillboardGui")inst7.Name="__BolongGenProgress__"inst7.Adornee=inst8 inst7.AlwaysOnTop=true inst7.LightInfluence=0 inst7.ResetOnSpawn=false inst7.MaxDistance=260 inst7.Size=UDim2.new(0,100,0,14)
 local gui9=(inst8.Size.Y/2)+3.5 inst7.StudsOffset=Vector3.new(0,gui9,0)inst7.Parent=GeneratorPart
 local gui10=Instance.new("TextLabel")gui10.Name="Label"gui10.BackgroundTransparency=1 gui10.Size=UDim2.new(1,0,1,0)gui10.Position=UDim2.new(0,0,0,0)gui10.Font=Enum.Font.GothamBlack_1Xm1boDQ.TextSize=11 gui10.RichText=true gui10.Text=inst10 gui10.TextColor3=Color3.fromRGB(255,255,255)gui10.TextXAlignment=Enum.TextXAlignment.Center gui10.Parent=inst7
 local inst11=Instance.new("UIStroke")inst11.Thickness=0.8 inst11.Transparency=0.4 inst11.Color=Color3.new(0,0,0)inst11.Parent=gui10
else
if inst7.Adornee~=inst8 then
inst7.Adornee=inst8
end
local inst12=(inst8.Size.Y/2)+3.5 inst7.StudsOffset=Vector3.new(0,inst12,0)
local inst13=inst7:FindFirstChild("Label")
if inst13 then
inst13.Text=inst10
end
end
else
if inst7 then
inst7.Destroy(inst7)GeneratorPart:SetAttribute("__BolongGenLastPct__",nil)GeneratorPart:SetAttribute("__BolongGenLastInfo__",nil)
end
end
return false
end
local
function qnDOw(uQwnIWq)
local
function gen2_func()
if not Settings.espGeneratorEnabledand not Settings.espGeneratorProgressGenthen
return
end
esp23_func(uQwnIWq)
end
pcall(
function()uQwnIWq:GetAttributeChangedSignal("RepairProgress"):Connect(gen2_func)uQwnIWq:GetAttributeChangedSignal("Progress"):Connect(gen2_func)uQwnIWq:GetAttributeChangedSignal("Completed"):Connect(gen2_func)uQwnIWq:GetAttributeChangedSignal("IsCompleted"):Connect(gen2_func)uQwnIWq:GetAttributeChangedSignal("PlayersRepairingCount"):Connect(gen2_func)uQwnIWq:GetAttributeChangedSignal("kickcount"):Connect(gen2_func)
end
)
end
local
function esp4_func(ollbxU,bmIvxUmw)
local
function wzxpnp()
local conn1=wmbMHDw_(ollbxU,"Dropped")or wmbMHDw_(ollbxU,"IsDropped")
local tbl1=wmbMHDw_(ollbxU,"Broken")or wmbMHDw_(ollbxU,"IsBroken")or wmbMHDw_(ollbxU,"Destroyed")
if conn1 or tbl1 or bmIvxUmw.isFake then
onHbZx(ollbxU)
 for vZoIuz1ZMIbQv,_Xqln_ in ipairs(ESPState.cachedMapObjects.Pallets)do
 if _Xqln_==ollbxU then
table.remove(ESPState.cachedMapObjects.Pallets,vZoIuz1ZMIbQv);
break
 end
 end
ESPState.cachedPalletMeta[ollbxU]=nil
end
end
for qq1bWop,DMXux in ipairs({"Dropped","IsDropped","Broken","IsBroken","Destroyed"})do
ollbxU:GetAttributeChangedSignal(DMXux):Connect(wzxpnp)
end
ollbxU.ChildAdded:Connect(
function(lwNxm0XbH)
if lwNxm0XbH:IsA("ValueBase")and(lwNxm0XbH.Name=="Dropped"or lwNxm0XbH.Name=="IsDropped"or lwNxm0XbH.Name=="Broken"or lwNxm0XbH.Name=="IsBroken"or lwNxm0XbH.Name=="Destroyed")then
lwNxm0XbH.Changed:Connect(wzxpnp)
end
end
)
end
local
function wz0qHHnO(_XUDb,ubWxl)
if not _XUDb or not _XUDb.Parentthen
return
end
local part1=_XUDb:IsA("BasePart")and{_XUDb}or _XUDb.GetDescendants(_XUDb)
for NmwpxIuzZH,lpXboQo1 in ipairs(part1)do
 if lpXboQo1:IsA("BasePart")then
 if ubWxl then
 if not ESPState.ghostGateOriginals[lpXboQo1]then
ESPState.ghostGateOriginals[lpXboQo1]={CanCollide=lpXboQo1.CanCollide,Transparency=lpXboQo1.Transparency}
 end
lpXboQo1.CanCollide=false lpXboQo1.Transparency=0.6
 else
 if ESPState.ghostGateOriginals[lpXboQo1]then
lpXboQo1.CanCollide=ESPState.ghostGateOriginals[lpXboQo1].CanCollidelpXboQo1.Transparency=ESPState.ghostGateOriginals[lpXboQo1].Transparency
 end
 end
end
end
end
local
function ppW0q(TargetModel)
local tbl2=TargetModel.Name
if tbl2=="Generator"then
table.insert(ESPState.cachedMapObjects.Generators,TargetModel)
 if not ESPState.genIndices[TargetModel]then
 if next(ESPState.genIndices)==nil then
ESPState.nextGenIndex=1
 end
ESPState.genIndices[TargetModel]=ESPState.nextGenIndex ESPState.nextGenIndex=ESPState.nextGenIndex+1
 end
 if Settings.espGeneratorEnabledthen esp23_func(TargetModel);
qnDOw(TargetModel)
end
elseif tbl2=="Hook"then
table.insert(ESPState.cachedMapObjects.Hooks,TargetModel)
 local MapParts={}
 local ModelChild=TargetModel:FindFirstChild("Model")
 if ModelChild then
 for Idx,Child in ipairs(ModelChild.GetDescendants(ModelChild))do
 if Child:IsA("MeshPart")then
table.insert(MapParts,Child)
 end
 end
 end
ESPState.cachedHookMeshParts[TargetModel]=MapParts
 if Settings.espHookEnabled then
 if #MapParts>0 then
 for _HuHwZQ,wuqvv1bQ0X0 in ipairs(MapParts)do
esp24_func(wuqvv1bQ0X0,Settings.espHookColor)
 end
 else esp24_func(TargetModel,Settings.espHookColor)
 end
end
elseif tbl2=="Gate"then
table.insert(ESPState.cachedMapObjects.Gates,TargetModel)
 if Settings.espGateEnabled then
esp24_func(TargetModel,Settings.espGateColor)
 end
 if ESPState.ghostGateEnabledthen wz0qHHnO(TargetModel,true)
end
elseif tbl2=="Pallet"or tbl2=="Palletwrong"then
table.insert(ESPState.cachedMapObjects.Pallets,TargetModel)
 local inst14=tbl2.lower(tbl2)
 local PalletPart=(TargetModel:IsA("Model")and TargetModel.PrimaryPart)or TargetModel:FindFirstChildWhichIsA("BasePart",true)or(TargetModel:IsA("BasePart")and TargetModel)
 local IsFakePallet=inst14:find("fake")or inst14:find("broken")or inst14:find("destroyed")
 local PalletMeta={part=PalletPart,isFake=IsFakePallet and true or false}ESPState.cachedPalletMeta[TargetModel]=PalletMeta
 if Settings.espPalletEnabledand not PalletMeta.isFakethen esp24_func(TargetModel,Settings.espPalletColor)
end
esp4_func(TargetModel,PalletMeta)
end
end
local
function HHmlDn_O(Nl_mM)
local tbl3=Nl_mM.Name
if tbl3=="Generator"then
 for _nmDHDuX1,uoooznUZz in ipairs(ESPState.cachedMapObjects.Generators)do
 if uoooznUZz==Nl_mM then
table.remove(ESPState.cachedMapObjects.Generators,_nmDHDuX1);
break
 end
 end
ESPState.genIndices[Nl_mM]=nil ESPState.completedGenerators[Nl_mM]=nil onHbZx(Nl_mM)
 local gen5=Nl_mM:FindFirstChild("__BolongGenProgress__")
 if gen5 then
gen5.Destroy(gen5)
 end
 if next(ESPState.genIndices)==nil then
ESPState.nextGenIndex=1
 end
elseif tbl3=="Hook"then
 for W1ovqUnu1D,lWuoDQ1 in ipairs(ESPState.cachedMapObjects.Hooks)do
 if lWuoDQ1==Nl_mM then
table.remove(ESPState.cachedMapObjects.Hooks,W1ovqUnu1D);
break
 end
 end
 local tbl4=ESPState.cachedHookMeshParts[Nl_mM]
 if tbl4 then
 for ImbDbD,llu_UloD_1 in ipairs(tbl4)do
onHbZx(llu_UloD_1)
 end
 else onHbZx(Nl_mM)
end
ESPState.cachedHookMeshParts[Nl_mM]=nil
elseif tbl3=="Gate"then
 for OxqIZolbnpUIX,o1bo0wObZH1pb in ipairs(ESPState.cachedMapObjects.Gates)do
 if o1bo0wObZH1pb==Nl_mM then
table.remove(ESPState.cachedMapObjects.Gates,OxqIZolbnpUIX);
break
 end
 end
onHbZx(Nl_mM)
elseif tbl3=="Pallet"or tbl3=="Palletwrong"then
 for qIw1vDn0W1bz1,vQIwx in ipairs(ESPState.cachedMapObjects.Pallets)do
 if vQIwx==Nl_mM then
table.remove(ESPState.cachedMapObjects.Pallets,qIw1vDn0W1bz1);
break
 end
 end
onHbZx(Nl_mM)ESPState.cachedPalletMeta[Nl_mM]=nil
end
end
local
function esp26_func(bpZ1ZlIDDIUIw)
if not bpZ1ZlIDDIUIw then
 return
end
ESPState.cachedMapObjects={Generators={},Pallets={},Hooks={},Gates={}}ESPState.cachedPalletMeta={};
ESPState.cachedHookMeshParts={};
ESPState.completedGenerators={}ESPState.genIndices={};
ESPState.nextGenIndex=1
for lvwMZ1w1,WvDoZIbMW in ipairs(bpZ1ZlIDDIUIw.GetDescendants(bpZ1ZlIDDIUIw))do
ppW0q(WvDoZIbMW)
end
end
local
function ul0ZZMWZ(bquDOpnb)
if not bquDOpnb then
 return
end
esp26_func(bquDOpnb)bquDOpnb.DescendantAdded:Connect(ppW0q)bquDOpnb.DescendantRemoving:Connect(HHmlDn_O)ESPState.objEspInitialized=true
end
ESPState.windowEspObjects={}
local
function vzZWmwZvppv(lwxXvqNU)
if not lwxXvqNU or not lwxXvqNU.Parent or ESPState.windowEspObjects[lwxXvqNU]then
 return
end
local OzUwz=Settings.espWindowColorlocal esp21=Instance.new("BoxHandleAdornment")esp21.Name="WindowESP_Box"esp21.Adornee=lwxXvqNU esp21.Color3=OzUwz esp21.Transparency=0.3 esp21.Size=lwxXvqNU.Size esp21.AlwaysOnTop=true esp21.ZIndex=10 esp21.Parent=ESPFramesFolder ESPState.windowEspObjects[lwxXvqNU]=esp21
end
local
function esp3_func(ObnHuZq)
local inst15=ESPState.windowEspObjects[ObnHuZq]
if inst15 then
pcall(
 function()inst15:Destroy()
end
)ESPState.windowEspObjects[ObnHuZq]=nil
end
end
local
function esp9_func(wb1oq1)
if typeof(wb1oq1)~="Instance"then
 return nil
end
local inst16=string.lower(wb1oq1.Name)
if inst16=="window"and wb1oq1:IsA("Model")then
 local inst17=wb1oq1:FindFirstChild("Bottom",true)
 if inst17 and inst17:IsA("BasePart")then
 return inst17
 end
 return wb1oq1.PrimaryPartend
 if inst16=="bottom"and wb1oq1:IsA("BasePart")then
 if wb1oq1.Parentand string.lower(wb1oq1.Parent.Name)=="window"then
 return wb1oq1
 end
 end
 return nil
end
local
function esp8_func(IXUuzUWoDmXN)
local flag5=esp9_func(IXUuzUWoDmXN)
if flag5 then
 if Settings.espWindowEnabledand not ESPState.windowEspObjects[flag5]then
vzZWmwZvppv(flag5)
 end
end
end
Workspace.DescendantAdded:Connect(
function(ImOQ0XH1m)esp8_func(ImOQ0XH1m)
end
)Workspace.DescendantRemoving:Connect(
function(Ov1pxpO1vlIbQ)
local conn2=esp9_func(Ov1pxpO1vlIbQ)or Ov1pxpO1vlIbQ
if ESPState.windowEspObjects[conn2]then
esp3_func(conn2)
end
end
)
local
function uDUDl_()
for IzWqxqvHvlZ0N_,wvQovQ_UmZ in pairs(ESPState.windowEspObjects)do
 if not IzWqxqvHvlZ0N_ or not IzWqxqvHvlZ0N_.Parent then
esp3_func(IzWqxqvHvlZ0N_)
 end
end
if Settings.espWindowEnabled then
 for DHpolb,qZzX1UU in ipairs(Workspace.GetDescendants(Workspace))do
esp8_func(qZzX1UU)
 end
end
end
task.spawn(
function()task.wait(3)uDUDl_()
end
)
local
function esp22_func()
if not ESPState.objEspInitialized then
 return
end
local gen6=Settings.espGeneratorEnabled or Settings.espGeneratorProgressGen
if gen6 then
 local gen7={}
 for vnumNM0N,_UzWHvUnmIOMm in ipairs(ESPState.cachedMapObjects.Generators)do
 if _UzWHvUnmIOMm and _UzWHvUnmIOMm.Parentthen
 local tbl5=esp23_func(_UzWHvUnmIOMm)
 if not tbl5 then
table.insert(gen7,_UzWHvUnmIOMm)
 end
 end
end
ESPState.cachedMapObjects.Generators=gen7
else
for MqunID,MbDUu1 in ipairs(ESPState.cachedMapObjects.Generators)do
 if MbDUu1 and MbDUu1.Parentthen onHbZx(MbDUu1)
 local qnm1q=MbDUu1:FindFirstChild("__BolongGenProgress__")
 if qnm1q then
qnm1q.Destroy(qnm1q)
 end
MbDUu1:SetAttribute("__BolongGenLastPct__",nil)
end
end
end
if Settings.espPalletEnabled then
 for pDox0wQ__,HX1OUpNlDmxQl in ipairs(ESPState.cachedMapObjects.Pallets)do
 if HX1OUpNlDmxQl and HX1OUpNlDmxQl.Parent then
 local pallet1=ESPState.cachedPalletMeta[HX1OUpNlDmxQl]
 if pallet1 and not pallet1.isFakethen esp24_func(HX1OUpNlDmxQl,Settings.espPalletColor)
 end
 end
end
else
for bOHqqWIbxXDIX,WDpuWDZuwNv in ipairs(ESPState.cachedMapObjects.Pallets)do
 if WDpuWDZuwNv then
onHbZx(WDpuWDZuwNv)
 end
end
end
if Settings.espHookEnabled then
 for v0WlDvl,bMmzqquHlp1u in ipairs(ESPState.cachedMapObjects.Hooks)do
 if bMmzqquHlp1u and bMmzqquHlp1u.Parentthen
 local part2=ESPState.cachedHookMeshParts[bMmzqquHlp1u]
 if part2 then
 for D0HXHNZqZZ0I,oxwMo in ipairs(part2)do
esp24_func(oxwMo,Settings.espHookColor)
 end
 else esp24_func(bMmzqquHlp1u,Settings.espHookColor)
 end
end
end
else
for D0NNI1OZ,_pIWI1pqn in ipairs(ESPState.cachedMapObjects.Hooks)do
 if _pIWI1pqn and _pIWI1pqn.Parent then
 local part3=ESPState.cachedHookMeshParts[_pIWI1pqn]
 if part3 then
 for uHq1WmmODzU0,DDZpWH in ipairs(part3)do
onHbZx(DDZpWH)
 end
 else onHbZx(_pIWI1pqn)
 end
end
end
end
if Settings.espGateEnabledthen
for qMWOo,MUDbQmnUUIUqZ in ipairs(ESPState.cachedMapObjects.Gates)do
 if MUDbQmnUUIUqZ and MUDbQmnUUIUqZ.Parent then
esp24_func(MUDbQmnUUIUqZ,Settings.espGateColor)
 end
end
else
for QmuwobOow__N1,lz_XNIUz in ipairs(ESPState.cachedMapObjects.Gates)do
 if lz_XNIUz and lz_XNIUz.Parent then
onHbZx(lz_XNIUz)
 end
end
end
if Settings.espWindowEnabledthen uDUDl_()
for _qWD_1,_NnnN in pairs(ESPState.windowEspObjects)do
 if _qWD_1 and _qWD_1.Parentand _NnnN and _NnnN.Parent then
pcall(
 function()
 local color6=Settings.espWindowColor_NnnN.Color3=color6 _NnnN.Size=_qWD_1.Size
 end
)
else esp3_func(_qWD_1)
end
end
else
for H0zOZZuMN11,bmvQoqMx in pairs(ESPState.windowEspObjects)do
esp3_func(H0zOZZuMN11)
end
end
end
local
function esp12_func()
local tbl6={}
local inst18=workspace:FindFirstChild("Map")
if inst18 then
 for WbXZIID,bpquZbWbm1QNn in ipairs(inst18.GetDescendants(inst18))do
 if(bpquZbWbm1QNn.Name=="Window"or bpquZbWbm1QNn.Name=="VaultPoint"or string.find(bpquZbWbm1QNn.Name,"Window"))then
 if bpquZbWbm1QNn:IsA("BasePart")or bpquZbWbm1QNn:IsA("Model")then
table.insert(tbl6,bpquZbWbm1QNn)
 end
 end
 end
end
for HXonvQmoQvMDu,WoHDm in ipairs(CollectionService:GetTagged("VaultPoint"))do
table.insert(tbl6,WoHDm)
end
return tbl6
end
local
function vlmOH1_X()
if not ESPState.antiLoopWindowEnabledthen
return
end
local WwlXu=ReplicatedStorage:FindFirstChild("Remotes")
if not WwlXu then
 return
end
local inst19=WwlXu:FindFirstChild("Window")
if not inst19 then
 return
end
local inst20=inst19:FindFirstChild("VaultEvent")
if not inst20 then
 return
end
task.spawn(
function()task.wait(1)
local remote1=esp12_func()
for WMO0QDwO1,I0Qm1Z_ in ipairs(remote1)do
task.spawn(
 function()pcall(
 function()inst20:FireServer(I0Qm1Z_,true)
end
)
end
)task.wait(0.05)
end
end
)
end
local
function remote1_func()
local inst21=ReplicatedStorage:FindFirstChild("Remotes")
if not inst21 then
 return
end
local inst22=inst21:FindFirstChild("Window")
if not inst22 then
 return
end
local remote2=inst22:FindFirstChild("VaultCompleteEvent")
local remote3=inst22:FindFirstChild("VaultCompleteEventpart1")task.spawn(
function()
local inst23=esp12_func()
for MIHUbUuNWN0M,QwH0plnlq1pbZ in ipairs(inst23)do
task.spawn(
 function()pcall(
 function()
 if remote2 then
remote2:FireServer(QwH0plnlq1pbZ,false)
 end
 if remote3 then
remote3.FireServer(remote3)
 end
end
)
end
)task.wait(0.05)
end
end
)
end
do
 local remote4=workspace:FindFirstChild("Map")
 if remote4 then
ul0ZZMWZ(remote4)vlmOH1_X()
 end
workspace.ChildAdded:Connect(
 function(vmuxlQOU_bMz)
 if vmuxlQOU_bMz.Name=="Map"then
task.wait(2)ul0ZZMWZ(vmuxlQOU_bMz)vlmOH1_X()
 end
end
)workspace.ChildRemoved:Connect(
function(pMoQmlzpxvZ)
if pMoQmlzpxvZ.Name=="Map"then
ESPState.cachedMapObjects={Generators={},Pallets={},Hooks={},Gates={}}ESPState.cachedPalletMeta={};
ESPState.cachedHookMeshParts={}ESPState.completedGenerators={};
ESPState.objEspInitialized=false ESPState.genIndices={};
ESPState.nextGenIndex=1
end
end
)
end
CreateESPEntry("GenESPUpdater",0.2,
function()
if not Settings.espGeneratorEnabled and not Settings.espGeneratorProgressGenthen
return
end
for lImD_QD_wnX0M,I_uWOH1lQMwD in ipairs(ESPState.cachedMapObjects.Generators)do
 if I_uWOH1lQMwD and I_uWOH1lQMwD.Parent and not ESPState.completedGenerators[I_uWOH1lQMwD]then
esp23_func(I_uWOH1lQMwD)
 end
end
end
)
local
function esp33_func()
if not getnilinstances then
ShowNotify("Error","Executor tidak support getnilinstances()",2)
 return
end
task.spawn(
function()
local inst24=ReplicatedStorage:FindFirstChild("Remotes")
if not inst24 then
 return
end
local pallet2=inst24:FindFirstChild("Pallet")
pallet2=pallet2 and pallet2:FindFirstChild("PalletDropEvent")
if not pallet2 then
 return
end
local tbl7={}
local tbl8={}
local PcallOk3,b1HUvOU=pcall(getnilinstances)
if PcallOk3 and type(b1HUvOU)=="table"then
 for poU0MQnUvvpw,BIvHI_OwoU1 in ipairs(b1HUvOU)do
 if typeof(BIvHI_OwoU1)=="Instance"then
 local pallet3=BIvHI_OwoU1.Name
 if pallet3=="PalletPointSlide"or pallet3=="palletDropPoint"or pallet3=="PalletDropPoint"or pallet3=="PalletPoint"then
 if not tbl8[BIvHI_OwoU1]then
table.insert(tbl7,BIvHI_OwoU1)tbl8[BIvHI_OwoU1]=true
 end
 end
 end
 end
end
for oqDXw,pXzWqqH0mH in ipairs(workspace.GetDescendants(workspace))do
 local pallet4=pXzWqqH0mH.Name
 if pallet4=="PalletPointSlide"or pallet4=="palletDropPoint"or pallet4=="PalletDropPoint"or pallet4=="PalletPoint"then
 if not tbl8[pXzWqqH0mH]then
table.insert(tbl7,pXzWqqH0mH)tbl8[pXzWqqH0mH]=true
 end
 end
end
if #tbl7==0 then
 return
end
for bO0DbZUn,WD1XvmuQHIIDUU in ipairs(tbl7)do
pcall(
 function()pallet2:FireServer(WD1XvmuQHIIDUU)
end
)
end
end
)
end
CreateESPEntry("AutoDropNearbyPallets",0.2,
function()
if not ESPState.autoDropNearbyPallets then
 return
end
if ESPState.autoDropCooldown then
 return
end
local char10=LocalPlayer.Characterif not char10 then
 return
end
local char11=char10:FindFirstChild("HumanoidRootPart")
if not char11 then
 return
end
local char12=ReplicatedStorage:FindFirstChild("Remotes")
if not char12 then
 return
end
local pallet5=char12:FindFirstChild("Pallet")
pallet5=pallet5 and pallet5:FindFirstChild("PalletDropEvent")
if not pallet5 then
 return
end
local inst25=char11.Positionif not ESPState.palletPointsCache or(tick()-ESPState.lastPalletPointScan>5)then
ESPState.lastPalletPointScan=tick()ESPState.palletPointsCache={}
 local
 function esp15_func(QzUxX)
 if typeof(QzUxX)~="Instance"then
 return false
 end
 local pallet6=QzUxX.Name
 if pallet6=="PalletPointSlide"or pallet6=="palletDropPoint"or pallet6=="PalletDropPoint"or pallet6=="PalletPoint"then
 return true
 end
 return false
end
if getnilinstances then
 local vHXMDQl,OmUlmql_=pcall(getnilinstances)
 if vHXMDQl and type(OmUlmql_)=="table"then
 for opNlIXw1WmuX,umn0lXxwqn in ipairs(OmUlmql_)do
 if esp15_func(umn0lXxwqn)then
table.insert(ESPState.palletPointsCache,umn0lXxwqn)
 end
 end
 end
end
for MxDZnMQNxnDIH1,wMbNZIo0Ww0wu in ipairs(workspace.GetDescendants(workspace))do
 if esp15_func(wMbNZIo0Ww0wu)then
table.insert(ESPState.palletPointsCache,wMbNZIo0Ww0wu)
 end
end
end
local remote5=nil
local remote6=math.huge
for HNXqD=#ESPState.palletPointsCache,1,-1 do
 local part4=ESPState.palletPointsCache[HNXqD]
 if not part4 or not part4.Parentthen table.remove(ESPState.palletPointsCache,HNXqD)
else
local part5=nil pcall(
function()
if part4:IsA("BasePart")then
part5=part4.Positionelseif part4:IsA("Model")then
part5=part4.GetPivot(part4).Positionelseif part4:IsA("Attachment")then
part5=part4.WorldPositionend
 end
)
 if not part5 then
 local inst26=part4:FindFirstChildWhichIsA("BasePart",true)
 if inst26 then
part5=inst26.Positionend
 end
 if part5 then
 local val5=(part5-inst25).Magnitude
 if val5<remote6 then
remote6=val5 remote5=part4
 end
 end
 end
 end
 if remote5 and remote6<=4 then
pcall(
 function()pallet5:FireServer(remote5)
 end
)
 for HqXHp,WpNv1W in ipairs(ESPState.palletPointsCache)do
 if WpNv1W==remote5 then
table.remove(ESPState.palletPointsCache,HqXHp)break
 end
 end
ESPState.autoDropCooldown=true task.delay(2,
 function()ESPState.autoDropCooldown=false
end
)
end
end
)
local
function esp17_func(ubvQnDlpZXm0pH,pn0UOxNHUzlD)
if not Settings.hitboxEnabledthen
return
end
if not pn0UOxNHUzlD then
 return
end
local flag6=GetPlayerRole(ubvQnDlpZXm0pH)
local char13=(flag6=="killer")and Settings.killerHitboxSize or Settings.survivorHitboxSize
local part6=char13/100
local char14=pn0UOxNHUzlD:FindFirstChild("HumanoidRootPart")
if char14 and char14:IsA("BasePart")then
 if not ESPState.hitboxOriginalSizes[char14]then
ESPState.hitboxOriginalSizes[char14]=char14.Sizeend
 local part7=2
 local part8=Vector3.new(part7*part6,part7*part6,part7*part6)pcall(
 function()char14.Size=part8 char14.Transparency=1 char14.CanCollide=false
 end
)
end
end
local
function esp10_func(Bo1Hp,I0WUnxn0Qb)
if not I0WUnxn0Qb then
 return
end
local part9=I0WUnxn0Qb:FindFirstChild("HumanoidRootPart")
if part9 and part9:IsA("BasePart")then
 local part10=ESPState.hitboxOriginalSizes[part9]
 if part10 then
pcall(
 function()part9.Size=part10 part9.Transparency=1
 end
)ESPState.hitboxOriginalSizes[part9]=nil
end
end
end
local
function pIWIOMWp()
if not Settings.hitboxEnabled then
 return
end
for HowX_,wNW0I1Z in ipairs(Players.GetPlayers(Players))do
 if wNW0I1Z~=LocalPlayer and wNW0I1Z.Characterthen esp17_func(wNW0I1Z,wNW0I1Z.Character)
end
end
end
local
function vXQHOzmuNXl()
for pMXunI,O0lzqwl in ipairs(Players.GetPlayers(Players))do
 if O0lzqwl~=LocalPlayer and O0lzqwl.Character then
esp10_func(O0lzqwl,O0lzqwl.Character)
 end
end
end
local
function esp21_func(N_lZDH,Dlm1b)
if N_lZDH==LocalPlayer then
 return
end
local esp22=Dlm1b and Dlm1b:FindFirstChild("HumanoidRootPart")
if not esp22 then
 return
end
local esp23=ESPState.hitboxEspObjects[N_lZDH]
if esp23 and esp23.Parentthen
if esp23.Adornee==esp22 then
 return
end
esp23.Destroy(esp23)
end
local esp24=GetPlayerRole(N_lZDH)
local esp25=(esp24=="killer")and Settings.hitboxEspKillerColor or Settings.hitboxEspSurvivorColorlocal esp26=Instance.new("SelectionBox")esp26.Adornee=esp22;
esp26.Color3=esp25;
esp26.LineThickness=0.10 esp26.SurfaceTransparency=Settings.hitboxEspOutlineOnlyand1or Settings.hitboxEspTransparency esp26.SurfaceColor3=esp25;
esp26.Parent=ESPFramesFolder ESPState.hitboxEspObjects[N_lZDH]=esp26
end
local
function esp14_func(W0D0OMWbUmvH)
local inst27=ESPState.hitboxEspObjects[W0D0OMWbUmvH]
if inst27 then
pcall(
 function()inst27:Destroy()
end
);
ESPState.hitboxEspObjects[W0D0OMWbUmvH]=nil
end
end
local
function WxWMzlH()
for wQXOnI,qHHpZ1zv_1_HUb in pairs(ESPState.hitboxEspObjects)do
 if qHHpZ1zv_1_HUb and qHHpZ1zv_1_HUb.Parentthen
 local color7=GetPlayerRole(wQXOnI)
 local color8=(color7=="killer")and Settings.hitboxEspKillerColoror Settings.hitboxEspSurvivorColorqHHpZ1zv_1_HUb.Color3=color8;
qHHpZ1zv_1_HUb.SurfaceColor3=color8 qHHpZ1zv_1_HUb.SurfaceTransparency=Settings.hitboxEspOutlineOnly and 1 or Settings.hitboxEspTransparency
end
end
end
local
function pNzHND()
for BmMHwNzupXMq,vmwQM in ipairs(Players.GetPlayers(Players))do
 if vmwQM~=LocalPlayer and vmwQM.Character then
esp21_func(vmwQM,vmwQM.Character)
 end
end
end
local
function esp25_func()
for WmzlpZ1NvQ_wl,u1vHO in pairs(ESPState.hitboxEspObjects)do
esp14_func(WmzlpZ1NvQ_wl)
end
end
local
function esp18_func()
if ESPState.SpeedBoostInit then
 local esp27=math.clamp(ESPState.BoostPercent,0,100)*2
 return MagicConst*(1+esp27/100)
end
return MagicConst
end
local
function qNMQXII(uDx1MUnXNv,pnHwb)
if not uDx1MUnXNv or not uDx1MUnXNv.Parent then
 return
end
if math.abs(uDx1MUnXNv.WalkSpeed-pnHwb)>0.05 then
pcall(
 function()uDx1MUnXNv.WalkSpeed=pnHwb
end
)
end
end
local
function esp31_func()task.spawn(
function()
local Inst1,DwMnmDwQ=pcall(
function()
return game:GetService("ReplicatedStorage"):WaitForChild("Remotes",10):WaitForChild("Mechanics",10):WaitForChild("Fall",10)
end
)
if not Inst1 or not DwMnmDwQ then
 return
end
local Inst2 Inst2=hookmetamethod(game,"__namecall",
function(OXZXZZO0WHNov,..)
local remote7=getnamecallmethod()
if ESPState.AntiFallSlow and remote7=="FireServer"and rawequal(OXZXZZO0WHNov,DwMnmDwQ)then
 return
end
return Inst2(OXZXZZO0WHNov,..)
end
)
end
)
end
local
function esp11_func(NvxQWH)
if ESPState.movConns.antiFall then
ESPState.movConns.antiFall:Disconnect()
end
esp31_func()
if not NvxQWH then
 return
end
pcall(
function()NvxQWH:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
end
)ESPState.movConns.antiFall=NvxQWH.StateChanged:Connect(
function(lMW0UbWUM_q,Mu1uO__bXOnmwU)
if not ESPState.AntiFallSlowthen
return
end
if Mu1uO__bXOnmwU==Enum.HumanoidStateType.Landed or Mu1uO__bXOnmwU==Enum.HumanoidStateType.GettingUp or Mu1uO__bXOnmwU==Enum.HumanoidStateType.FallingDownthen pcall(
function()NvxQWH:ChangeState(Enum.HumanoidStateType.Running)
end
)qNMQXII(NvxQWH,esp18_func())
end
end
)
end
local
function vZW11Xq1xZD_(MlmIp0v)
if ESPState.movConns.antiFall then
ESPState.movConns.antiFall:Disconnect();
ESPState.movConns.antiFall=nil
end
if MlmIp0v and MlmIp0v.Parentthen pcall(
function()MlmIp0v:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
end
)
end
end
local
function vqQoXU(NXwX1OX)
if ESPState.movConns.noSlow then
ESPState.movConns.noSlow:Disconnect();
ESPState.movConns.noSlow=nil
end
if not NXwX1OX then
 return
end
if GetPlayerRole(LocalPlayer)=="killer"then
 return
end
ESPState.movConns.noSlow=NXwX1OX:GetPropertyChangedSignal("WalkSpeed"):Connect(
function()
if not ESPState.NoSlowdownthen
return
end
if GetPlayerRole(LocalPlayer)=="killer"then
 return
end
local char15=LocalPlayer.Character
if ESPState.safeModeSpeedand char15 and(char15:GetAttribute("IsHooked")or char15:GetAttribute("IsCarried")or NXwX1OX.Health<=50)then
 return
end
local char16=esp18_func()
if NXwX1OX.WalkSpeed<char16-0.05 then
pcall(
 function()NXwX1OX.WalkSpeed=char16
end
)
end
end
)
end
local
function esp7_func(BlMboH)
if not BlMboH then
 return
end
local char17=BlMboH:WaitForChild("Humanoid",5)
if not char17 then
 return
end
if ESPState.AntiFallSlowthen esp11_func(char17)
end
if ESPState.NoSlowdownand GetPlayerRole(LocalPlayer)~="killer"then
vqQoXU(char17)
end
if ESPState.SpeedBoostInitthen
local char18=esp18_func()task.wait(0.15)
if not ESPState.safeModeSpeedor(char17.Health>50 and not(BlMboH:GetAttribute("IsHooked")or BlMboH:GetAttribute("IsCarried")))then
qNMQXII(char17,char18)
end
end
end
local
function ox0Np(Duo0IW)
if not Duo0IW then
 return
end
local inst28=Duo0IW:WaitForChild("Humanoid",5)
if not inst28 then
 return
end
if ESPState.AntiFallSlowthen esp11_func(inst28)
end
if ESPState.NoSlowdown and GetPlayerRole(LocalPlayer)~="killer"then
vqQoXU(inst28)
end
if ESPState.SpeedBoostInit then
 local conn3=esp18_func()task.wait(0.15)qNMQXII(inst28,conn3)
end
end
LocalPlayer:GetPropertyChangedSignal("Team"):Connect(
function()IsPlayerAlive(LocalPlayer)
if GetPlayerRole(LocalPlayer)=="killer"and ESPState.movConns.noSlow then
ESPState.movConns.noSlow:Disconnect();
ESPState.movConns.noSlow=nil
end
end
)
local
function NubHIl()
if ESPState.moonwalkGuithen
return
end
local inst29=LocalPlayer:WaitForChild("PlayerGui")
local inst30=Instance.new("ScreenGui")inst30.Name="BolongHubMoonwalk"inst30.ResetOnSpawn=false inst30.Enabled=false inst30.Parent=inst29
local gui11=Instance.new("Frame")gui11.Name="MoonwalkBtns"gui11.AnchorPoint=Vector2.new(1,1)gui11.Position=UDim2.new(1,-18,1,-170)gui11.Size=UDim2.fromOffset(46,96)gui11.BackgroundTransparency=1 gui11.Parent=inst30
local
function gui1_func(q_Uq__,unxuMXIw)
local WnoWx=Instance.new("ImageButton")WnoWx.BackgroundTransparency=1 WnoWx.BorderSizePixel=0 WnoWx.AutoButtonColor=false WnoWx.AnchorPoint=Vector2.new(0.5,0)WnoWx.Position=UDim2.new(0.5,0,0,unxuMXIw)WnoWx.Size=UDim2.fromOffset(42,42)WnoWx.Image="rbxassetid://125598796341580"WnoWx.ScaleType=Enum.ScaleType.SliceWnoWx.ImageColor3=Color3.fromRGB(170,170,170)WnoWx.ImageTransparency=0.25 WnoWx.Rotation=q_Uq__ WnoWx.Parent=gui11
return WnoWx
end
local color9=gui1_func(-90,0)
local color10=gui1_func(90,50)
local
function esp32_func(vovUMqlqwwQO,upHxIppzXMmDo)vovUMqlqwwQO.InputBegan:Connect(
function(uUIwHuXlp)
if uUIwHuXlp.UserInputType==Enum.UserInputType.Touch or uUIwHuXlp.UserInputType==Enum.UserInputType.MouseButton1 then
ESPState.moonwalkMobileDir=upHxIppzXMmDo vovUMqlqwwQO.ImageColor3=Color3.fromRGB(255,255,255)vovUMqlqwwQO.ImageTransparency=0
end
end
)vovUMqlqwwQO.InputEnded:Connect(
function(D_zlDHMpM1Qm)
if D_zlDHMpM1Qm.UserInputType==Enum.UserInputType.Touch or D_zlDHMpM1Qm.UserInputType==Enum.UserInputType.MouseButton1then ESPState.moonwalkMobileDir=0 vovUMqlqwwQO.ImageColor3=Color3.fromRGB(170,170,170)vovUMqlqwwQO.ImageTransparency=0.25
end
end
)
end
esp32_func(color9,1)esp32_func(color10,-1)ESPState.moonwalkGui=inst30
end
local
function esp20_func(M0QznbDpv)
if M0QznbDpv:FindFirstChild("BolongMoonwalkAlign")then
 return M0QznbDpv:FindFirstChild("BolongMoonwalkAlign")
end
local inst31=Instance.new("Attachment")inst31.Name="BolongMoonwalkAtt"inst31.Parent=M0QznbDpv
local inst32=Instance.new("AlignOrientation")inst32.Name="BolongMoonwalkAlign"inst32.Mode=Enum.OrientationAlignmentMode.OneAttachmentbXHIObpxqm0QO.Attachment0=inst31 inst32.MaxTorque=1000000 inst32.Responsiveness=15 inst32.Parent=M0QznbDpv
return inst32
end
local
function NmlZX(QUopDNNZIznDu)
local inst33=QUopDNNZIznDu:FindFirstChild("BolongMoonwalkAlign")
local inst34=QUopDNNZIznDu:FindFirstChild("BolongMoonwalkAtt")
if inst33 then
inst33.Destroy(inst33)
end
if inst34 then
inst34.Destroy(inst34)
end
end
CreateESPEntry("MoonwalkLock",0,
function(uzvIm1Nbnq0HNn)
if not Settings.moonwalkEnabledthen
return
end
local char19=LocalPlayer.Character
local char20=char19 and char19:FindFirstChildOfClass("Humanoid")
local char21=char19 and char19:FindFirstChild("HumanoidRootPart")
local char22=Workspace.CurrentCameraif not char20 or not char21 or not char22 then
 return
end
local esp28=0
if ESPState.moonwalkPCForwardthen esp28=1
end
if ESPState.moonwalkPCBackwardthen esp28=-1
end
if ESPState.moonwalkMobileDir~=0 then
esp28=ESPState.moonwalkMobileDir
end
if esp28==0 then
 if not char20.AutoRotate then
char20.AutoRotate=true
 end
NmlZX(char21)
 return
end
char20.AutoRotate=false
local flag7=esp20_func(char21)
local val6=char22.CFrame.LookVector
local val7=Vector3.new(val6.X,0,val6.Z)
if val7.Magnitude>0.001 then
val7=val7.Unit
 local val8=(esp28==1)and val7 or-val7
 local flag8=CFrame.lookAt(Vector3.new(0,0,0),val8)flag7.CFrame=flag8
end
end
)
local
function esp2_func()ESPState.godEnabled=true;
ESPState.godLastHP=nil pcall(
function()
local char23=LocalPlayer.Character
if char23 then
 local char24=char23:FindFirstChildOfClass("Humanoid")
 if char24 then
char24:SetStateEnabled(Enum.HumanoidStateType.Dead,false)char24:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)char24:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
 end
end
end
)
end
local
function esp5_func()ESPState.godEnabled=false;
ESPState.godLastHP=nil pcall(
function()
local char25=LocalPlayer.Character
if not char25 then
 return
end
local char26=char25:FindFirstChildOfClass("Humanoid")
if not char26 then
 return
end
char26:SetStateEnabled(Enum.HumanoidStateType.Dead,true)char26:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)char26:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
end
)
end
CreateESPEntry("GodMode",0.2,
function()
if not ESPState.godEnabledthen
return
end
local char27=LocalPlayer.Characterif not char27 then
 return
end
local char28=char27:FindFirstChildOfClass("Humanoid")
if not char28 then
 return
end
local char29=char28.MaxHealthlocal char30=char28.Healthif ESPState.godLastHP~=nil and char30<ESPState.godLastHPand char30>0 then
pcall(
 function()char28.Health=char29
end
)
end
ESPState.godLastHP=char28.Healthpcall(
function()
local char31=char28.GetState(char28)
if char31==Enum.HumanoidStateType.Deadthen char28.Health=char29;
char28:ChangeState(Enum.HumanoidStateType.Running);
ESPState.godLastHP=char29
elseif char31==Enum.HumanoidStateType.Ragdoll or char31==Enum.HumanoidStateType.FallingDownthen char28:ChangeState(Enum.HumanoidStateType.GettingUp)
end
end
)
end
)
local remote8={active=false,target=nil,generator=nil}
local inst35=ReplicatedStorage.Remotes.KillerPerks.kingscourge:WaitForChild("KingScourgeStart")
local remote9=ReplicatedStorage.Remotes.KillerPerks.kingscourge:WaitForChild("KingScourgeEnd")inst35.OnClientEvent:Connect(
function(WOHbMonN,MOqXmo,_DzI0UblIDqXnU)remote8.active=true;
remote8.target=MOqXmo;
remote8.generator=WOHbMonN
end
)remote9.OnClientEvent:Connect(
function()remote8.active=false;
remote8.target=nil;
remote8.generator=nil
end
)
local
function gen1_func()
for HDbNWQzIpQMvXl,QXuowX_bv in ipairs({"SkillCheckPromptGui","SkillCheckPromptGui-con"})do
 local inst36=PlayerGui:FindFirstChild(QXuowX_bv,true)
 if inst36 then
 local inst37=inst36:FindFirstChild("Check",true)
 if inst37 and inst37.Visiblethen
 return inst37:FindFirstChild("Line",true),inst37:FindFirstChild("Goal",true)
 end
end
end
end
local inst38=nil
local
function IXXqZQbU()
if inst38 and inst38.Parentthen
return inst38
end
local inst39=PlayerGui:FindFirstChild("Survivor-mob",true)
if not inst39 then
 return nil
end
local inst40=inst39:FindFirstChild("Controls",true)
if not inst40 then
 return nil
end
local inst41=inst40:FindFirstChild("action")
if inst41 and inst41:IsA("GuiButton")then
inst38=inst41;
 return inst41
end
inst41=inst40:FindFirstChild("Gui-mob")
if inst41 and inst41:IsA("GuiButton")then
inst38=inst41;
 return inst41
end
return nil
end
local
function gui2_func()
local btn1=IXXqZQbU()
if btn1 and type(firesignal)=="function"then
firesignal(btn1.MouseButton1Down)task.delay(0.05,
 function()
 if btn1 and btn1.Parentthen firesignal(btn1.MouseButton1Up)firesignal(btn1.MouseButton1Click)
end
end
)
return
end
local plplxbp=PlayerGui:FindFirstChild("check",true)
if plplxbp and plplxbp:IsA("GuiObject")and plplxbp.Visible then
 local inst42=plplxbp.AbsolutePosition;
 local inst43=plplxbp.AbsoluteSize
 local btn2=GuiService.GetGuiInset(GuiService)
 local btn3=inst42.X+(inst43.X/2)+btn2.X;
 local btn4=inst42.Y+(inst43.Y/2)+btn2.Ypcall(
 function()VirtualInputManager:SendMouseButtonEvent(btn3,btn4,0,true,game,1)task.wait(0.01)VirtualInputManager:SendMouseButtonEvent(btn3,btn4,0,false,game,1)
end
)
else VirtualInputManager:SendKeyEvent(true,Enum.KeyCode.Space,false,game)task.wait()VirtualInputManager:SendKeyEvent(false,Enum.KeyCode.Space,false,game)
end
end
CreateESPEntry("Generator",0,
function()
if not Settings.autoGeneratorthen
return
end
local Gen1,bvq0NXowOHZO_=gen1_func()
if not(Gen1 and bvq0NXowOHZO_)then
ESPState.instantLastVisible=false ESPState.lastGoalRot=nil ESPState.prevLr=nil
 return
end
local gen8=bvq0NXowOHZO_.Rotationlocal esp29=Gen1.Rotationlocal esp30=tick()
local gen9=remote8.activeand 0.05 or 0.1
if esp30-ESPState.lastPressTime<gen9 then
ESPState.prevLr=esp29
 return
end
if Settings.autoGeneratorMode=="Instant"then
 if not ESPState.instantLastVisible or gen8~=ESPState.lastGoalRotthen Gen1.Rotation=gen8+109 ESPState.lastGoalRot=gen8 ESPState.instantLastVisible=true ESPState.lastPressTime=esp30 ESPState.lastSkillHit=esp30 gui2_func()
end
else
local esp31=(esp29-gen8)%360
local esp32=-1
if ESPState.prevLrand ESPState.lastGoalRot==gen8 then
esp32=(ESPState.prevLr-gen8)%360
end
ESPState.lastGoalRot=gen8
local Gen2,_lpIZ1OX
if Settings.autoGeneratorMode=="Perfect"then
Gen2=102 _lpIZ1OX=116
elseif Settings.autoGeneratorMode=="Normal"then
Gen2=116 _lpIZ1OX=159
elseif Settings.autoGeneratorMode=="Random"then
 if not ESPState.randomIsNeutralthen Gen2=102;
_lpIZ1OX=116
else Gen2=116;
_lpIZ1OX=159
end
else
return
end
local esp33=esp31>=Gen2 and esp31<=_lpIZ1OX
local esp34=esp32>=0 and esp32<Gen2 and esp31>_lpIZ1OX
if esp33 or esp34 then
 if esp34 then
Gen1.Rotation=gen8+(Gen2+_lpIZ1OX)/2
 end
ESPState.lastPressTime=esp30 ESPState.lastSkillHit=esp30 gui2_func()
 if Settings.autoGeneratorMode=="Random"then
ESPState.randomIsNeutral=not ESPState.randomIsNeutral
 end
end
end
ESPState.prevLr=esp29
end
)CreateESPEntry("GenBtnRefresh",2.0,
function()
if not Settings.autoGenerator then
 return
end
if not inst38 or not inst38.Parent then
IXXqZQbU()
end
end
)CreateESPEntry("KillerWarn",0.1,
function()
if not Settings.warnEnabledthen
local char32=LocalPlayer.Character
local char33=char32 and char32:FindFirstChild("HumanoidRootPart")
if char33 then
 local char34=char33:FindFirstChild("KillerWarn")
 if char34 then
char34.Destroy(char34)
 end
end
return
end
local char35=LocalPlayer.Character
local char36=char35 and char35:FindFirstChild("HumanoidRootPart")
if not char36 then
 return
end
local char37=math.huge
for u01Mv,Q1ZWqnvWDm in pairs(ESPState.espObjects)do
 if u01Mv and u01Mv.Parentthen
 local char38=GetPlayerRole(u01Mv)
 if char38=="killer"then
 local char39=u01Mv.Character
 local char40=char39 and char39:FindFirstChild("HumanoidRootPart")
 if char40 then
 local char41=(char40.Position-char36.Position).Magnitude
 if char41<char37 then
char37=char41
 end
 end
 end
end
end
local color11=char36:FindFirstChild("KillerWarn")
if char37<=Settings.warnDist1then
local Color1,Im1ZObOzIZO
if char37<=Settings.warnDist3then Color1="!!!";
Im1ZObOzIZO=Color3.fromRGB(255,0,0)
elseif char37<=Settings.warnDist2then Color1="!!";
Im1ZObOzIZO=Color3.fromRGB(255,80,0)
else Color1="!";
Im1ZObOzIZO=Color3.fromRGB(255,160,0)
end
if not color11 then
color11=esp13_func(Color1,Im1ZObOzIZO,UDim2.new(0,40,0,40),22)color11.Name="KillerWarn";
color11.Parent=char36
else color11.Label.Text=Color1;
color11.Label.TextColor3=Im1ZObOzIZO
end
elseif color11 then
color11.Destroy(color11)
end
end
)CreateESPEntry("ESPValidator",1,
function()
for IoO1qDW0,IZ1ZDvo_Z in pairs(ESPState.espObjects)do
esp16_func(IoO1qDW0)
end
for HwDwQDNNN1lwZ,onIwXWqmUM in pairs(ESPState.outlineObjects)do
 if not ESPState.espObjects[HwDwQDNNN1lwZ]then
esp16_func(HwDwQDNNN1lwZ)
 end
end
end
)CreateESPEntry("ItemESP",0.2,
function()
if not Settings.espItemEnabledthen
for uWXIZMUXZbXb_z,WHpQlnxX1qN in pairs(ESPState.espObjects)do
 if WHpQlnxX1qN and WHpQlnxX1qN.itemImageand WHpQlnxX1qN.itemImage.Visiblethen WHpQlnxX1qN.itemImage.Visible=false
end
end
return
end
local char42=LocalPlayer.Characterlocal char43=char42 and char42:FindFirstChild("HumanoidRootPart")
for pNvDMOUUwD,Ol_HX0HwnQ in pairs(ESPState.espObjects)do
 if Ol_HX0HwnQ and Ol_HX0HwnQ.billboard and Ol_HX0HwnQ.billboard.Parent and Ol_HX0HwnQ.itemBillboardthen
 if GetPlayerRole(pNvDMOUUwD)=="killer"then
 if Ol_HX0HwnQ.itemImage.Visiblethen Ol_HX0HwnQ.itemImage.Visible=false
 end
continue
end
local char44=pNvDMOUUwD.Characterlocal flag9=nil
if char44 then
 local flag10=char44:GetAttribute("EquippedItem")or char44:GetAttribute("Equippedltem")
 if type(flag10)=="string"then
flag9=flag10
 elseif typeof(flag10)=="Instance"then
flag9=flag10.Nameend
 end
 if not flag9 then
 local v1=pNvDMOUUwD:GetAttribute("EquippedItem")or pNvDMOUUwD:GetAttribute("Equippedltem")
 if type(v1)=="string"then
flag9=v1
 elseif typeof(v1)=="Instance"then
flag9=v1.Nameend
 end
 local char45=esp28_func(flag9)
 if char45 then
 if Ol_HX0HwnQ.itemImage.Image~=char45 then
Ol_HX0HwnQ.itemImage.Image=char45
 end
 if char43 and char44 then
 local char46=char44:FindFirstChild("HumanoidRootPart")
 if char46 then
 local char47=(char43.Position-char46.Position).Magnitude
 local gui12=1.5+((char47/200)*2)
gui12=math.clamp(gui12,1.5,3.5)Ol_HX0HwnQ.itemBillboard.Size=UDim2.new(gui12,0,gui12,0)
 end
 end
Ol_HX0HwnQ.itemImage.Visible=true
 else
 if Ol_HX0HwnQ.itemImage.Visible then
Ol_HX0HwnQ.itemImage.Visible=false
 end
 end
elseif Ol_HX0HwnQ and Ol_HX0HwnQ.itemImage then
 if Ol_HX0HwnQ.itemImage.Visible then
Ol_HX0HwnQ.itemImage.Visible=false
 end
end
end
end
)CreateESPEntry("SpeedBoostInit",0,
function()
if not ESPState.SpeedBoostInitthen
return
end
local char48=LocalPlayer.Character
if not char48 then
 return
end
local char49=char48:FindFirstChildOfClass("Humanoid")
if not char49 then
 return
end
if ESPState.safeModeSpeedand(char48:GetAttribute("IsHooked")or char48:GetAttribute("IsCarried")or char49.Health<=50)then
 return
end
local char50=esp18_func()
if char50<=0 then
 return
end
local char51=MagicConst*(math.clamp(ESPState.BoostPercent,0,100)/100)ESPState._jitterFlip=not ESPState._jitterFliplocal char52=ESPState._jitterFlipand(char50+char51)or char50
if math.abs(char49.WalkSpeed-char52)>0.1 then
pcall(
 function()char49.WalkSpeed=char52
end
)
end
end
)
local
function vIMwU(lUzXI1W_MDzp,bM110)
if not lUzXI1W_MDzp or not lUzXI1W_MDzp.Parentthen
return false
end
local val9=lUzXI1W_MDzp.AbsolutePosition;
local val10=lUzXI1W_MDzp.AbsoluteSize
local RoleName=val9.X+val10.X/2;
local val11=val9.Y+val10.Y/2
local gui13=math.min(val10.X,val10.Y)/2*0.8
local gui14=bM110.X-RoleName;
local gui15=bM110.Y-val11
return(gui14*gui14+gui15*gui15)<=(gui13*gui13)
end
local
function esp19_func(MlnmUOplZvIu)
if not MlnmUOplZvIu:IsA("ImageButton")then
 return
end
if MlnmUOplZvIu.Name~="Gui-mob"then
 return
end
if ESPState._hookedMobButtons[MlnmUOplZvIu]then
 return
end
ESPState._hookedMobButtons[MlnmUOplZvIu]=true UIS2.InputBegan:Connect(
function(boZzNnz0zQ)
if boZzNnz0zQ.UserInputType~=Enum.UserInputType.Touchthen
return
end
if not vIMwU(MlnmUOplZvIu,boZzNnz0zQ.Position)then
 return
end
ESPState.HoldLockActive=true
local Conn1 Conn1=UIS2.InputEnded:Connect(
function(u1X0Dp)
if u1X0Dp==boZzNnz0zQ then
ESPState.HoldLockActive=false Conn1.Disconnect(Conn1)
end
end
)
end
)
end
local conn4={["Slasher-mob"]=true,["Masked-mob"]=true,["Hidden-mob"]=true,["Killer-mob"]=true,}
local
function esp29_func(O_vMx_)
if not(O_vMx_ and O_vMx_:IsA("GuiButton"))then
 return false
end
if O_vMx_.Name~="attack"then
 return false
end
local NXQnN,bHWbl=false,false
local inst44=O_vMx_.Parent
while inst44 do
 if conn4[inst44.Name]then
NXQnN=true
 end
 if inst44.Name=="Controls"or inst44.Name=="Control"then
bHWbl=true
 end
inst44=inst44.Parent
end
return NXQnN and bHWbl
end
local
function QbpzUuNN(uuo1Iq1IOz)
if ESPState._hookedSlasherButtons[uuo1Iq1IOz]then
 return
end
ESPState._hookedSlasherButtons[uuo1Iq1IOz]=true uuo1Iq1IOz.InputBegan:Connect(
function(Mn0wNOv1)
if Mn0wNOv1.UserInputType==Enum.UserInputType.Touchor Mn0wNOv1.UserInputType==Enum.UserInputType.MouseButton1 then
ESPState.HoldLockActive=true
end
end
)uuo1Iq1IOz.InputEnded:Connect(
function(DmDlQ01zoQ0pMm)
if DmDlQ01zoQ0pMm.UserInputType==Enum.UserInputType.Touchor DmDlQ01zoQ0pMm.UserInputType==Enum.UserInputType.MouseButton1 then
ESPState.HoldLockActive=false
end
end
)
end
local
function BlmXw(qq1OIDUm0WUZ)
for MwqUbIb,wbHHUMmu0 in ipairs(qq1OIDUm0WUZ.GetDescendants(qq1OIDUm0WUZ))do
 if wbHHUMmu0:IsA("ImageButton")and wbHHUMmu0.Name=="Gui-mob"then
esp19_func(wbHHUMmu0)
 end
 if esp29_func(wbHHUMmu0)then
QbpzUuNN(wbHHUMmu0)
 end
end
qq1OIDUm0WUZ.DescendantAdded:Connect(
function(NvuuxwIw11)
if NvuuxwIw11:IsA("ImageButton")and NvuuxwIw11.Name=="Gui-mob"then
esp19_func(NvuuxwIw11)
end
if esp29_func(NvuuxwIw11)then
QbpzUuNN(NvuuxwIw11)
end
end
)
end
task.spawn(
function()
local conn5=LocalPlayer:WaitForChild("PlayerGui")BlmXw(conn5)
end
)UIS2.InputBegan:Connect(
function(D1bHZDoOp,Nw_OOvII)
local conn6=GetPlayerRole(LocalPlayer)=="killer"
if conn6 then
 if D1bHZDoOp.UserInputType==Enum.UserInputType.MouseButton1 then
ESPState.HoldLockActive=true
 end
else
if not Nw_OOvII and D1bHZDoOp.UserInputType==Enum.UserInputType.MouseButton2then ESPState.HoldLockActive=true
end
end
if not Nw_OOvII and D1bHZDoOp.UserInputType==Enum.UserInputType.Gamepad1and D1bHZDoOp.KeyCode==Enum.KeyCode.ButtonL2then ESPState.HoldLockActive=true
end
end
)UIS2.InputEnded:Connect(
function(qq1nlXWlMxvWqv)
if qq1nlXWlMxvWqv.UserInputType==Enum.UserInputType.MouseButton1or qq1nlXWlMxvWqv.UserInputType==Enum.UserInputType.MouseButton2then ESPState.HoldLockActive=false
end
if qq1nlXWlMxvWqv.UserInputType==Enum.UserInputType.Gamepad1 and qq1nlXWlMxvWqv.KeyCode==Enum.KeyCode.ButtonL2then ESPState.HoldLockActive=false
end
end
)CreateESPEntry("HoldLock",0.2,
function()
if not Settings.cameralockEnabledthen
return
end
if ESPState.HoldLockActivethen
return
end
local flag11=LocalPlayer.Characterif flag11 and flag11:GetAttribute("Aiming")==true then
ESPState.HoldLockActive=true
end
end
)
local
function pnZ0u(pZZlXw_W)
if not pZZlXw_W then
 return nil
end
if Settings.cameralockAimPart=="Head"then
 local inst45=pZZlXw_W:FindFirstChild("Head")
 if inst45 then
 return inst45.Position
 end
end
local inst46=pZZlXw_W:FindFirstChild("UpperTorso")
if inst46 then
 return inst46.Positionend
 local char53=pZZlXw_W:FindFirstChild("Torso")
 if char53 then
 return char53.Position
 end
 local char54=pZZlXw_W:FindFirstChild("HumanoidRootPart")
 if char54 then
 return char54.Position+(Settings.cameralockAimPart=="Head"and Vector3.new(0,2.5,0)or Vector3.new(0,1.2,0))
 end
 return nil
end
function MainState.IxWX0_XNwuzw(oUXqlDUX,HNmZDb,MZ_wIn)
if not HNmZDb or not MZ_wIn or MZ_wIn.Health<=0 then
 return false
end
if MZ_wIn.Health<50 then
 return false
end
if HNmZDb:GetAttribute("IsHooked")then
 return false
end
if HNmZDb:GetAttribute("IsCarried")then
 return false
end
if oUXqlDUX:GetAttribute("IsHooked")then
 return false
end
if oUXqlDUX:GetAttribute("IsCarried")then
 return false
end
local char55=MZ_wIn.GetState(MZ_wIn)
if char55==Enum.HumanoidStateType.PlatformStanding then
 return false
end
if char55==Enum.HumanoidStateType.Physicsand MZ_wIn.PlatformStandthen
return false
end
local char56=HNmZDb:FindFirstChild("HumanoidRootPart")
if char56 and char56.Anchoredthen
return false
end
return true
end
function MainState._I_mHX_DbX(wZHX1lquluQ)
local char57=LocalPlayer.Characterlocal char58=char57 and char57:FindFirstChild("HumanoidRootPart")
if not char58 then
 return nil
end
local char59=char58.Positionlocal char60=0.1
local char61=nil
local char62=Settings.cameralockMaxDistance
if wZHX1lquluQ and wZHX1lquluQ.Characterthen
local char63=wZHX1lquluQ.Character
local char64=char63:FindFirstChildOfClass("Humanoid")
local char65=pnZ0u(char63)
if MainState.IxWX0_XNwuzw(wZHX1lquluQ,char63,char64)and char65 then
char61=wZHX1lquluQ char62=(char65-char59).Magnitude-char60
end
end
for WXwlQDm0DpqNq,BDODNH_X in ipairs(Players.GetPlayers(Players))do
 if BDODNH_X==LocalPlayer then
continue
 end
 local char66=BDODNH_X.Characterif not char66 then
continue
 end
 local char67=char66:FindFirstChildOfClass("Humanoid")
 if not MainState.IxWX0_XNwuzw(BDODNH_X,char66,char67)then
continue
 end
 local char68=pnZ0u(char66)
 if not char68 then
continue
 end
 local cam1=GetPlayerRole(BDODNH_X)
 if Settings.cameralockTargetType=="Killer"and cam1~="killer"then
continue
 end
 if Settings.cameralockTargetType=="Survivor"and cam1~="survivor"then
continue
 end
 local val12=(char68-char59).Magnitude
 if val12<char62 then
char62=val12;
char61=BDODNH_X
 end
end
return char61
end
function MainState.vMvvZ()
if ESPState.aimConnthen ESPState.aimConn:Disconnect()
end
ESPState.aimTargetCache=nil;
ESPState.aimTargetT=0;
ESPState.aimLastStableDir=nil ESPState.aimConn=RunService.RenderStepped:Connect(
function(o1ZuNZqQvU)
if not Settings.cameralockEnabled then
 return
end
if Settings.cameralockLockMode=="Hold to Lock"and not ESPState.HoldLockActive then
ESPState.aimTargetCache=nil;
ESPState.aimLastStableDir=nil;
 return
end
local char69=LocalPlayer.Character
if not char69 then
 return
end
local char70=char69:FindFirstChild("HumanoidRootPart")
if not char70 then
 return
end
ESPState.aimTargetT=ESPState.aimTargetT+o1ZuNZqQvU
if ESPState.aimTargetT>=0.15 then
ESPState.aimTargetT=0 ESPState.aimTargetCache=MainState._I_mHX_DbX(ESPState.aimTargetCache)
end
local char71=ESPState.aimTargetCache
if not char71 then
ESPState.aimLastStableDir=nil;
 return
end
local char72=char71.Characterif not char72 then
ESPState.aimTargetCache=nil;
ESPState.aimLastStableDir=nil;
 return
end
local char73=char72:FindFirstChildOfClass("Humanoid")
if not MainState.IxWX0_XNwuzw(char71,char72,char73)then
ESPState.aimTargetCache=nil;
ESPState.aimLastStableDir=nil;
 return
end
local cam2=pnZ0u(char72)
if not cam2 then
ESPState.aimTargetCache=nil;
ESPState.aimLastStableDir=nil;
 return
end
local cam3=workspace.CurrentCameraif not cam3 then
 return
end
local cam4=cam3.CFrame
local cam5=cam4.Positionlocal val13=cam4.LookVectorlocal part11=Settings.cameralockSmoothness
local vo_pz=cam2-cam5
local val14=vo_pz.Magnitude
local val15=(cam2-char70.Position).Magnitude
local val16=4.0
local val17
if val14>=val16 and val15>=1.5 then
val17=vo_pz.Unit;
ESPState.aimLastStableDir=val17
elseif ESPState.aimLastStableDir then
val17=ESPState.aimLastStableDirelse val17=val13
end
local val18=val13:Lerp(val17,part11)
if val18.Magnitude<0.001 then
 return
end
cam3.CFrame=CFrame.new(cam5,cam5+val18)
local inst47=char69:FindFirstChildOfClass("Humanoid")
if inst47 and not inst47.AutoRotate then
 local val19=cam3.CFrame.LookVector
 local gui16=char70.Positionlocal DlDqmwXux=Vector3.new(val19.X,0,val19.Z)
 if DlDqmwXux.Magnitude>0.001 then
 local val20=math.atan2(char70.CFrame.LookVector.X,char70.CFrame.LookVector.Z)
 local val21=math.atan2(DlDqmwXux.X,DlDqmwXux.Z)
 local val22=val21-val20 val22=((val22+math.pi)%(2*math.pi))-math.pilocal gui17=val20+val22*0.15
 local gui18=math.sin(gui17)
 local gui19=math.cos(gui17)
 local conn7=gui16+Vector3.new(gui18,0,gui19)*900 char70.CFrame=CFrame.new(gui16,Vector3.new(conn7.X,gui16.Y,conn7.Z))
 end
end
end
)
end
function MainState.Hq1wbQvMzoz()
if ESPState.aimConn then
ESPState.aimConn:Disconnect();
ESPState.aimConn=nil
end
ESPState.aimTargetCache=nil;
ESPState.aimLastStableDir=nil
end
function MainState.w_vnXUZ(wnMNU0bQnlX1)
if ESPState.originalMaxZoom==nil then
ESPState.originalMaxZoom=LocalPlayer.CameraMaxZoomDistance
end
LocalPlayer.CameraMaxZoomDistance=wnMNU0bQnlX1
end
function MainState.Ww1z_Ob0vX()
if ESPState.originalMaxZoom~=nil then
LocalPlayer.CameraMaxZoomDistance=ESPState.originalMaxZoom
end
ESPState.originalMaxZoom=nil
end
function MainState.BWQoHbUwlp0MZb(QQXuQ)
local cam6=workspace.CurrentCameraif not cam6 then
 return
end
if ESPState.originalFOV==nil then
ESPState.originalFOV=cam6.FieldOfView
end
cam6.FieldOfView=QQXuQ
end
function MainState.bxOlDXWlooNM()
local cam7=workspace.CurrentCameraif cam7 and ESPState.originalFOV then
cam7.FieldOfView=ESPState.originalFOV
end
ESPState.originalFOV=nil
end
LocalPlayer:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(
function()
if Settings.cameraZoomEnabledand LocalPlayer.CameraMaxZoomDistance~=Settings.cameraZoomValuethen LocalPlayer.CameraMaxZoomDistance=Settings.cameraZoomValueend
end
)
function MainState.v_NpDbxz()
local cam8=workspace.CurrentCamera
if not cam8 then
 return
end
cam8:GetPropertyChangedSignal("FieldOfView"):Connect(
function()
if Settings.lockFovEnabled and cam8.FieldOfView~=Settings.customFovValue then
cam8.FieldOfView=Settings.customFovValue
end
end
)
end
MainState.v_NpDbxz()
function MainState.vvw0v_lDxx()
if UIS2.TouchEnabledand not UIS2.KeyboardEnabled then
 return
end
ESPState.originalMouseIconEnabled=UIS2.MouseIconEnabledESPState.originalMouseBehavior=UIS2.MouseBehaviorUIS2.MouseIconEnabled=true UIS2.MouseBehavior=Enum.MouseBehavior.Defaultif ESPState.forceCursorConn1 then
ESPState.forceCursorConn1:Disconnect()
end
if ESPState.forceCursorConn2 then
ESPState.forceCursorConn2:Disconnect()
end
ESPState.forceCursorConn1=UIS2:GetPropertyChangedSignal("MouseIconEnabled"):Connect(
function()
if Settings.forceCursorEnabled and not UIS2.MouseIconEnabledthen UIS2.MouseIconEnabled=true
end
end
)ESPState.forceCursorConn2=UIS2:GetPropertyChangedSignal("MouseBehavior"):Connect(
function()
if Settings.forceCursorEnabledand UIS2.MouseBehavior==Enum.MouseBehavior.LockCenter then
UIS2.MouseBehavior=Enum.MouseBehavior.Defaultend
end
)
end
function MainState.Bu0oXoOlbI()
if ESPState.forceCursorConn1 then
ESPState.forceCursorConn1:Disconnect()ESPState.forceCursorConn1=nil
end
if ESPState.forceCursorConn2then ESPState.forceCursorConn2:Disconnect()ESPState.forceCursorConn2=nil
end
if ESPState.originalMouseIconEnabled~=nil then
UIS2.MouseIconEnabled=ESPState.originalMouseIconEnabledESPState.originalMouseIconEnabled=nil
end
if ESPState.originalMouseBehavior~=nil then
UIS2.MouseBehavior=ESPState.originalMouseBehaviorESPState.originalMouseBehavior=nil
end
end
function MainState.lpZNv1HZpDo()
local inst48=Instance.new("ScreenGui")inst48.Name="BolongPerfMon";
inst48.ResetOnSpawn=false inst48.ZIndexBehavior=Enum.ZIndexBehavior.Sibling;
inst48.IgnoreGuiInset=false;
inst48.Parent=PlayerGui
local inst49=Instance.new("Frame")inst49.Name="PerfFrame";
inst49.Size=UDim2.fromOffset(160,28)inst49.AnchorPoint=Vector2.new(1,0);
inst49.Position=UDim2.new(1,-10,0,10)inst49.BackgroundColor3=Color3.fromRGB(10,10,14);
inst49.BorderSizePixel=0 inst49.Active=true;
inst49.Parent=inst48
local MunOnDvpolHq=Instance.new("UICorner");
MunOnDvpolHq.CornerRadius=UDim.new(0,8);
MunOnDvpolHq.Parent=inst49
local color12=Instance.new("UIStroke");
color12.Color=Color3.fromRGB(60,60,75)color12.Thickness=1;
color12.Parent=inst49
local color13=Instance.new("TextLabel")color13.Name="InfoLabel";
color13.Size=UDim2.new(1,0,1,0)color13.BackgroundTransparency=1;
color13.Text="FPS — | PING —"color13.TextColor3=Color3.fromRGB(200,200,210);
color13.TextSize=12 color13.Font=Enum.Font.GothamBold;
color13.TextXAlignment=Enum.TextXAlignment.Center color13.TextYAlignment=Enum.TextYAlignment.Center;
color13.RichText=true;
color13.Parent=inst49
local Conn2,pZMUWX0vIvo,WZQxOWUppWIN_ inst49.InputBegan:Connect(
function(MW1pNmnNNnzH_Z)
if MW1pNmnNNnzH_Z.UserInputType==Enum.UserInputType.MouseButton1or MW1pNmnNNnzH_Z.UserInputType==Enum.UserInputType.Touchthen Conn2=true;
pZMUWX0vIvo=MW1pNmnNNnzH_Z.Position;
WZQxOWUppWIN_=inst49.Position
end
end
)inst49.InputEnded:Connect(
function(oQvqXq_ZHQwq0m)
if oQvqXq_ZHQwq0m.UserInputType==Enum.UserInputType.MouseButton1 or oQvqXq_ZHQwq0m.UserInputType==Enum.UserInputType.Touchthen Conn2=false
end
end
)UIS2.InputChanged:Connect(
function(pD0wWUNNxNw1nl)
if Conn2 and(pD0wWUNNxNw1nl.UserInputType==Enum.UserInputType.MouseMovement or pD0wWUNNxNw1nl.UserInputType==Enum.UserInputType.Touch)then
 local gui20=pD0wWUNNxNw1nl.Position-pZMUWX0vIvo inst49.Position=UDim2.new(1,WZQxOWUppWIN_.X.Offset+gui20.X,0,WZQxOWUppWIN_.Y.Offset+gui20.Y)
end
end
)
return inst48,color13
end
CreateESPEntry("PerfMonitor",0.5,
function()
if not ESPState._perfActive then
 return
end
local OqIqzx=math.floor(ESPState._perfFrames/math.max(ESPState._perfElapsed,0.001))
local esp35=math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
local OwZuQz=OqIqzx>=50 and"rgb(80,220,100)"or OqIqzx>=30 and"rgb(255,200,60)"or"rgb(255,70,70)"
local esp36=esp35<=80 and"rgb(80,220,100)"or esp35<=150 and"rgb(255,200,60)"or"rgb(255,70,70)"
if ESPState.perfGuiand ESPState.perfGui.Parent then
 local oln_x=ESPState.perfGui:FindFirstChild("PerfFrame"):FindFirstChild("InfoLabel")
 if oln_x then
oln_x.Text=string.format("<font color=\"%s\">FPS %d</font> <font color=\"rgb(60,60,75)\">|</font> <font color=\"%s\">PING %d</font>",OwZuQz,OqIqzx,esp36,esp35)
 end
end
ESPState._perfElapsed=0;
ESPState._perfFrames=0
end
)CreateESPEntry("PerfCounter",0,
function(DIbMZOlUq)
if ESPState._perfActivethen ESPState._perfFrames=ESPState._perfFrames+1 ESPState._perfElapsed=ESPState._perfElapsed+DIbMZOlUq
end
end
)
function MainState.lUwpXW()
if ESPState.perfGuithen ESPState.perfGui:Destroy()
end
local Flag1,bZXnUXWW=MainState.lpZNv1HZpDo()ESPState.perfGui=Flag1;
ESPState._perfActive=true ESPState._perfElapsed=0;
ESPState._perfFrames=0
end
function MainState.p_X0zlUul()ESPState._perfActive=false
if ESPState.perfGui then
ESPState.perfGui:Destroy();
ESPState.perfGui=nil
end
end
function MainState.M1INum0lnUMMI(BDM1MoZv,Wun_Qbl1)
if not BDM1MoZv then
 return nil
end
local inst50=BDM1MoZv:GetAttribute(Wun_Qbl1)
if inst50~=nil then
 return inst50
end
local inst51=BDM1MoZv:FindFirstChild(Wun_Qbl1)
if inst51 then
 local OXnw0bl,vNMUowwZHZ=pcall(
 function()
 return inst51.Valueend)
 if OXnw0bl then
 return vNMUowwZHZ
 end
end
return nil
end
function MainState.HM0v1q1I1Ix()
local inst52=Instance.new("ScreenGui")inst52.Name="BolongPrediction"inst52.ResetOnSpawn=false inst52.IgnoreGuiInset=true inst52.DisplayOrder=9999999 inst52.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
local inst53=nil pcall(
function()
inst53=gethui()
end
)
if not inst53 then
pcall(
 function()
inst53=game:GetService("CoreGui")
end
)
end
if not inst53 then
inst53=PlayerGui
end
inst52.Parent=inst53
local gui21=Instance.new("TextLabel")gui21.Name="InfoLabel"gui21.AnchorPoint=Vector2.new(0.5,0)
if ESPState.predLastPos then
gui21.Position=ESPState.predLastPos
else gui21.Position=UDim2.new(0.5,0,0,50)
end
gui21.BackgroundTransparency=1 gui21.AutomaticSize=Enum.AutomaticSize.XY gui21.Text="Map: — | Killer: —"gui21.TextColor3=Color3.fromRGB(252,235,229)gui21.TextSize=14 gui21.Font=Enum.Font.GothamBold gui21.TextXAlignment=Enum.TextXAlignment.Centerp_mWOQlv_mpnbU.TextYAlignment=Enum.TextYAlignment.Centerp_mWOQlv_mpnbU.RichText=true gui21.Active=true gui21.Parent=inst52
local inst54=Instance.new("UIStroke")inst54.Name="Outline"inst54.Color=Color3.new(0,0,0)inst54.Thickness=1 inst54.Transparency=0.2 inst54.Parent=gui21
local conn8=false
local conn9=Vector2.new()
local gui22=UDim2.new()gui21.InputBegan:Connect(
function(OxXUWWNx)
if OxXUWWNx.UserInputType==Enum.UserInputType.MouseButton1or OxXUWWNx.UserInputType==Enum.UserInputType.Touchthen conn8=true conn9=OxXUWWNx.Position gui22=gui21.Position
end
end
)gui21.InputEnded:Connect(
function(Wvb1qz1nbu0DHD)
if Wvb1qz1nbu0DHD.UserInputType==Enum.UserInputType.MouseButton1 or Wvb1qz1nbu0DHD.UserInputType==Enum.UserInputType.Touchthen conn8=false
end
end
)UIS2.InputChanged:Connect(
function(bWI0_ZwlxDnuIz)
if conn8 and(bWI0_ZwlxDnuIz.UserInputType==Enum.UserInputType.MouseMovementor bWI0_ZwlxDnuIz.UserInputType==Enum.UserInputType.Touch)then
 local gui23=bWI0_ZwlxDnuIz.Position-conn9
 local gui24=UDim2.new(gui22.X.Scale,gui22.X.Offset+gui23.X,gui22.Y.Scale,gui22.Y.Offset+gui23.Y)gui21.Position=gui24 ESPState.predLastPos=gui24
end
end
)
return inst52,gui21
end
function MainState.IuxHvXo()
if ESPState.predMapInfoConnthen
return
end
task.spawn(
function()
local Inst3,BoxunQbqXpN=pcall(
function()
return ReplicatedStorage:WaitForChild("Remotes",10):WaitForChild("Messages",10):WaitForChild("Mapinfo",10)
end
)
if Inst3 and BoxunQbqXpN and BoxunQbqXpN:IsA("RemoteEvent")then
ESPState.predMapInfoConn=BoxunQbqXpN.OnClientEvent:Connect(
 function(pOOxbvQ,OMqmMuMlM)
 if type(pOOxbvQ)=="string"and pOOxbvQ~=""then
ESPState.predMapName=pOOxbvQ
 end
end
)
end
end
)
end
CreateESPEntry("PredictionMonitor",1,
function()
if not ESPState.predActivethen
return
end
if not ESPState.predGuior not ESPState.predGui.Parent then
 if ESPState.predGuithen ESPState.predGui:Destroy()
end
local HqwXx,lQlwQp=MainState.HM0v1q1I1Ix()ESPState.predGui=HqwXx ESPState.predInfoLabel=lQlwQp
end
local inst55=ESPState.predGui:FindFirstChild("InfoLabel")
if not inst55 then
 return
end
local inst56=Players.GetPlayers(Players)table.sort(inst56,
function(wwqnIom,HqXQOX0Z)
local flag12=MainState.M1INum0lnUMMI(wwqnIom,"AllowKiller")
local flag13=MainState.M1INum0lnUMMI(HqXQOX0Z,"AllowKiller")
local flag14=(flag12==false)
local flag15=(flag13==false)
if flag14~=flag15 then
 return not flag14
end
if not flag14 and not flag15 then
 return(MainState.M1INum0lnUMMI(wwqnIom,"KillerChance")or 0)>(MainState.M1INum0lnUMMI(HqXQOX0Z,"KillerChance")or 0)
end
return(MainState.M1INum0lnUMMI(wwqnIom,"KillerChance")or0)<(MainState.M1INum0lnUMMI(HqXQOX0Z,"KillerChance")or 0)
end
)
local str1=inst56[1]
local str2="<font color=\"rgb(100,110,130)\">—</font>"
if str1 then
 local str3=str1.Name
 local str4=MainState.M1INum0lnUMMI(str1,"SelectedKiller")
 local str5=MainState.M1INum0lnUMMI(str1,"AllowKiller")
 if str1==LocalPlayer then
str3="YOU"
 end
 local str6
 if str5==false then
str6="rgb(255,0,30)"
 else str6="rgb(252,235,229)"
end
if str4 and type(str4)=="string"and str4~=""then
str2=string.format("<font color=\"%s\">%s</font> <font color=\"rgb(255,0,30)\">(%s)</font>",str6,str3,str4)
else str2=string.format("<font color=\"%s\">%s</font>",str6,str3)
end
end
local esp37=ESPState.predMapName or"—"inst55.Text=string.format("<font color=\"rgb(255,210,60)\">Map:</font> <font color=\"rgb(252,235,229)\">%s</font> <font color=\"rgb(80,80,85)\">|</font> <font color=\"rgb(255,210,60)\">Killer:</font> %s",esp37,str2)
end
)
function MainState.HuQnoUuWpwo()
if ESPState.predGuithen ESPState.predGui:Destroy()
end
ESPState.predMapName=nil MainState.IuxHvXo()
local Gui1,MH0Qb_oDOxnz=MainState.HM0v1q1I1Ix()ESPState.predGui=Gui1 ESPState.predInfoLabel=MH0Qb_oDOxnz ESPState.predActive=true
end
function MainState.lboDUI()ESPState.predActive=false
if ESPState.predMapInfoConn then
pcall(
 function()ESPState.predMapInfoConn:Disconnect()
end
)ESPState.predMapInfoConn=nil
end
if ESPState.predGuithen ESPState.predGui:Destroy()ESPState.predGui=nil
end
end
CROSSHAIR_STYLES={"Dot","Circle","Circle + Dot","Plus","Cross (X)","T-Shape","Square"}do
MainState.HUvmUM1Uu=80 MainState.qqQHNWzvmq=MainState.HUvmUM1Uu/2 b0W0wpHoxmHDWX.bwDoXvvnnDOn={}
 function MainState.Dq_W0bDW0(ONWD0x_HoHIm,lDH1_zWD,uXwUONoHZ,D1xwNvNl,QpIn_qbIzoUO,D0xzqUnHp,WZqOuqX1owO,wovbwZWqUq_)
 local gui25=Instance.new("Frame")gui25.Name=wovbwZWqUq_ or"CH_Part"gui25.BackgroundColor3=D0xzqUnHp gui25.BackgroundTransparency=WZqOuqX1owO gui25.BorderSizePixel=0 gui25.Size=UDim2.fromOffset(math.max(1,math.round(uXwUONoHZ)),math.max(1,math.round(D1xwNvNl)))gui25.AnchorPoint=Vector2.new(0.5,0.5)gui25.Position=UDim2.fromOffset(math.round(ONWD0x_HoHIm),math.round(lDH1_zWD))
 if QpIn_qbIzoUO~=0 then
gui25.Rotation=QpIn_qbIzoUO
 end
 return gui25
end
function MainState.HIXMnml1M(u1wpZMHv)
return 0.3+(math.clamp(u1wpZMHv,1,100)/100)*2.2
end
MainState.bwDoXvvnnDOn.Plus=
function(w_uw_N1IWH,WwlpxwHDMownH,omqbDb)
local tbl9={}
local tbl10=MainState.HIXMnml1M(w_uw_N1IWH)
local tbl11=math.max(2,math.round(2*tbl10))
local tbl12=math.max(8,math.round(25*tbl10))
local tbl13=MainState.qqQHNWzvmq table.insert(tbl9,MainState.Dq_W0bDW0(tbl13,tbl13,tbl11,tbl12,0,WwlpxwHDMownH,omqbDb))table.insert(tbl9,MainState.Dq_W0bDW0(tbl13,tbl13,tbl12,tbl11,0,WwlpxwHDMownH,omqbDb))
return tbl9,{},{}
end
MainState.bwDoXvvnnDOn["Cross (X)"]=
function(woMbvvmW0zI,bOXDMW,w0DXINqwM_)
local tbl14={}
local tbl15=MainState.HIXMnml1M(woMbvvmW0zI)
local tbl16=math.max(2,math.round(2*tbl15))
local tbl17=math.max(8,math.round(25*tbl15))
local NxHvq=MainState.qqQHNWzvmq table.insert(tbl14,MainState.Dq_W0bDW0(NxHvq,NxHvq,tbl16,tbl17,45,bOXDMW,w0DXINqwM_))table.insert(tbl14,MainState.Dq_W0bDW0(NxHvq,NxHvq,tbl16,tbl17,-45,bOXDMW,w0DXINqwM_))
return tbl14,{},{}
end
MainState.bwDoXvvnnDOn.Dot=
function(pmzxDvbvOp,bzbxxzMzboM,_lonX)
local inst57={}
local val23=MainState.HIXMnml1M(pmzxDvbvOp)
local inst58=math.max(3,math.round(8*val23))
local inst59=MainState.qqQHNWzvmq
local inst60=MainState.Dq_W0bDW0(inst59,inst59,inst58,inst58,0,bzbxxzMzboM,_lonX,"CH_Dot")
local inst61=Instance.new("UICorner")inst61.CornerRadius=UDim.new(1,0)inst61.Parent=inst60 table.insert(inst57,inst60)
return inst57,{},{}
end
MainState.bwDoXvvnnDOn.Circle=
function(QmDbvzNOX,BZHHu,WXIuowDoX)
local Bx0nN,B_DQQN={},{}
local inst62=MainState.HIXMnml1M(QmDbvzNOX)
local gui26=math.max(4,math.round(12*inst62))
local inst63=math.max(2,math.round(2*inst62))
local inst64=MainState.qqQHNWzvmq
local inst65=Instance.new("Frame")inst65.Name="CH_Ring"inst65.BackgroundTransparency=1 inst65.Size=UDim2.fromOffset(gui26*2,gui26*2)inst65.AnchorPoint=Vector2.new(0.5,0.5)inst65.Position=UDim2.fromOffset(inst64,inst64)
local inst66=Instance.new("UICorner")inst66.CornerRadius=UDim.new(1,0)inst66.Parent=inst65
local inst67=Instance.new("UIStroke")inst67.Name="CH_Stroke"inst67.Color=BZHHu inst67.Thickness=inst63 inst67.Transparency=WXIuowDoX inst67.Parent=inst65 table.insert(Bx0nN,inst65)table.insert(B_DQQN,inst67)
return Bx0nN,B_DQQN,{}
end
MainState.bwDoXvvnnDOn["Circle + Dot"]=
function(MUHbWq,BHnuQH,WvWuvI)
local Inst4,qOX1v,WNvNbnnunM0={},{},{}
local inst68=MainState.HIXMnml1M(MUHbWq)
local gui27=math.max(4,math.round(12*inst68))
local inst69=math.max(2,math.round(2*inst68))
local inst70=math.max(2,math.round(4*inst68))
local inst71=MainState.qqQHNWzvmq
local inst72=Instance.new("Frame")inst72.Name="CH_Ring"inst72.BackgroundTransparency=1 inst72.Size=UDim2.fromOffset(gui27*2,gui27*2)inst72.AnchorPoint=Vector2.new(0.5,0.5)inst72.Position=UDim2.fromOffset(inst71,inst71)
local Bunuw=Instance.new("UICorner")Bunuw.CornerRadius=UDim.new(1,0)Bunuw.Parent=inst72
local inst73=Instance.new("UIStroke")inst73.Name="CH_Stroke"inst73.Color=BHnuQH inst73.Thickness=inst69 inst73.Transparency=WvWuvI inst73.Parent=inst72 table.insert(Inst4,inst72)table.insert(qOX1v,inst73)
local inst74=MainState.Dq_W0bDW0(inst71,inst71,inst70,inst70,0,BHnuQH,WvWuvI,"CH_Dot")
local inst75=Instance.new("UICorner")inst75.CornerRadius=UDim.new(1,0)inst75.Parent=inst74 table.insert(Inst4,inst74)table.insert(WNvNbnnunM0,inst74)
return Inst4,qOX1v,WNvNbnnunM0
end
MainState.bwDoXvvnnDOn["T-Shape"]=
function(qomNzQ,I1H_pbqZIpxlM,oOzw1QZm)
local tbl18={}
local tbl19=MainState.HIXMnml1M(qomNzQ)
local tbl20=math.max(2,math.round(2*tbl19))
local tbl21=math.max(8,math.round(25*tbl19))
local tbl22=MainState.qqQHNWzvmq
local tbl23=math.round(tbl21*0.25)table.insert(tbl18,MainState.Dq_W0bDW0(tbl22,tbl22-tbl23,tbl21,tbl20,0,I1H_pbqZIpxlM,oOzw1QZm))table.insert(tbl18,MainState.Dq_W0bDW0(tbl22,tbl22-tbl23+tbl21/2,tbl20,tbl21,0,I1H_pbqZIpxlM,oOzw1QZm))
return tbl18,{},{}
end
MainState.bwDoXvvnnDOn.Square=
function(OnWmXnQw0_ZIWl,BqQII0QM,uq1Huw)
local tbl24={}
local val24=MainState.HIXMnml1M(OnWmXnQw0_ZIWl)
local tbl25=math.max(2,math.round(2*val24))
local tbl26=math.max(8,math.round(22*val24))
local tbl27=math.max(3,math.round(tbl26*0.4))
local tbl28=MainState.qqQHNWzvmq
local tbl29=tbl26/2 table.insert(tbl24,MainState.Dq_W0bDW0(tbl28-tbl29+tbl27/2,tbl28-tbl29,tbl27,tbl25,0,BqQII0QM,uq1Huw))table.insert(tbl24,MainState.Dq_W0bDW0(tbl28-tbl29,tbl28-tbl29+tbl27/2,tbl25,tbl27,0,BqQII0QM,uq1Huw))table.insert(tbl24,MainState.Dq_W0bDW0(tbl28+tbl29-tbl27/2,tbl28-tbl29,tbl27,tbl25,0,BqQII0QM,uq1Huw))table.insert(tbl24,MainState.Dq_W0bDW0(tbl28+tbl29,tbl28-tbl29+tbl27/2,tbl25,tbl27,0,BqQII0QM,uq1Huw))table.insert(tbl24,MainState.Dq_W0bDW0(tbl28-tbl29+tbl27/2,tbl28+tbl29,tbl27,tbl25,0,BqQII0QM,uq1Huw))table.insert(tbl24,MainState.Dq_W0bDW0(tbl28-tbl29,tbl28+tbl29-tbl27/2,tbl25,tbl27,0,BqQII0QM,uq1Huw))table.insert(tbl24,MainState.Dq_W0bDW0(tbl28+tbl29-tbl27/2,tbl28+tbl29,tbl27,tbl25,0,BqQII0QM,uq1Huw))table.insert(tbl24,MainState.Dq_W0bDW0(tbl28+tbl29,tbl28+tbl29-tbl27/2,tbl25,tbl27,0,BqQII0QM,uq1Huw))
return tbl24,{},{}
end
MainState.wIxwUXZxX={}MainState.wIxwUXZxX.__index=MainState.wIxwUXZxX
function MainState.wIxwUXZxX.new()
local color14=setmetatable({},MainState.wIxwUXZxX)color14.config={enabled=false,style="Plus",size=1,opacity=1.0,offsetX=0,offsetY=0,color=Color3.fromRGB(255,255,255),smooth=true,smoothSpeed=0.25,}color14.gui=nil color14.container=nil color14.parent=nil color14.parts={frames={},strokes={},dots={}}color14.connections={}color14.renderConn=nil color14.currentOffset=Vector2.new(0,0)color14.targetOffset=Vector2.new(0,0)color14._frameCount=0
return color14
end
function MainState.qXo_llDnw()
local lDpQOQ1 pcall(
function()
if gethui then
lDpQOQ1=gethui()
end
end
)
if lDpQOQ1 and lDpQOQ1.Parent then
 return lDpQOQ1
end
pcall(
function()
lDpQOQ1=game:GetService("CoreGui")
end
)
if lDpQOQ1 and lDpQOQ1.Parentthen
return lDpQOQ1
end
return PlayerGui
end
function MainState.wIxwUXZxX:_createGui()
if self.guiand self.gui.Parentthen
return
end
local inst76=Instance.new("ScreenGui")inst76.Name="BolongCrosshair"inst76.ResetOnSpawn=false inst76.ZIndexBehavior=Enum.ZIndexBehavior.SiblingwvvxMHXUum.IgnoreGuiInset=true inst76.DisplayOrder=999999
local inst77=MainState.qXo_llDnw()inst76.Parent=inst77 self.parent=inst77
local inst78=Instance.new("Frame")inst78.Name="Container"inst78.Size=UDim2.fromOffset(MainState.HUvmUM1Uu,MainState.HUvmUM1Uu)inst78.AnchorPoint=Vector2.new(0.5,0.5)inst78.BackgroundTransparency=1 inst78.BorderSizePixel=0 inst78.Parent=inst76 self.gui=inst76 self.container=inst78 self:_rebuild()self.targetOffset=Vector2.new(self.config.offsetX,self.config.offsetY)self.currentOffset=self.targetOffsetself:_updatePosition()
end
function MainState.wIxwUXZxX:_rebuild()
if not self.containerthen
return
end
for oWuUbuUWQqwD,pno_0qbOnqmlmX in ipairs(self.parts.frames)do
pcall(
 function()pno_0qbOnqmlmX:Destroy()
end
)
end
self.parts={frames={},strokes={},dots={}}
local tbl30=MainState.bwDoXvvnnDOn[self.config.style]
if not tbl30 then
 return
end
local tbl31=1-self.config.opacity
local Tbl1,_bppDlWHZoUu,w0INlm000IoHn=tbl30(self.config.size,self.config.color,tbl31)
for I0NoNu_NMXMM,NpDOpZ in ipairs(Tbl1)do
NpDOpZ.Parent=self.containertable.insert(self.parts.frames,NpDOpZ)
end
for bDxlqmWQ0w0Xu,wbvUUQvXqZ in ipairs(_bppDlWHZoUu)do
table.insert(self.parts.strokes,wbvUUQvXqZ)
end
self.parts.dots=w0INlm000IoHn or{}
end
function MainState.wIxwUXZxX:_updateColors()
local color15=self.config.colorlocal color16=1-self.config.opacity
local _mqo01v1_={}
for v_mIXzlq1DzO,OvqIIIWDl in ipairs(self.parts.dots)do
_mqo01v1_[OvqIIIWDl]=true
end
for MpM0pqwmo,NOuMMxIXNmZv in ipairs(self.parts.frames)do
 if NOuMMxIXNmZv and NOuMMxIXNmZv.Parentthen NOuMMxIXNmZv.BackgroundColor3=_mqo01v1_[NOuMMxIXNmZv]and Color3.fromRGB(255,255,255)or color15
 if not NOuMMxIXNmZv:FindFirstChildWhichIsA("UIStroke")then
NOuMMxIXNmZv.BackgroundTransparency=color16
 end
end
end
for IwzQzX0Wwu0Xq,Iw1lZmWbl in ipairs(self.parts.strokes)do
 if Iw1lZmWbl and Iw1lZmWbl.Parent then
Iw1lZmWbl.Color=color15 Iw1lZmWbl.Transparency=color16
 end
end
end
function MainState.wIxwUXZxX:_updatePosition()
if not self.containerthen
return
end
local cam9=workspace.CurrentCameraif not cam9 then
 return
end
local cam10=cam9.ViewportSize self.container.Position=UDim2.fromOffset(cam10.X*0.5+self.currentOffset.X,cam10.Y*0.5+self.currentOffset.Y)
end
function MainState.wIxwUXZxX:_hookCamera()
if self.connections.camViewport then
self.connections.camViewport:Disconnect()self.connections.camViewport=nil
end
local conn10=workspace.CurrentCameraif conn10 then
self.connections.camViewport=conn10:GetPropertyChangedSignal("ViewportSize"):Connect(
 function()self:_updatePosition()
end
)
end
end
function MainState.wIxwUXZxX:_setupConnections()self:_hookCamera()
while(190*0~=0)do
 local conn11=416 break
end
if not self.connections.camChangethen self.connections.camChange=workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(
function()self:_hookCamera()self:_updatePosition()
end
)
end
if not self.connections.childRemoved then
self.connections.childRemoved=self.parent.ChildRemoved:Connect(
 function(DWwXIUzxXuMv_)
 if DWwXIUzxXuMv_==self.gui and self.config.enabled then
self.gui=nil self.container=nil self.parts={frames={},strokes={},dots={}}task.wait(0.05)
 if self.config.enabledthen self._createGui(self)
 end
end
end
)
end
if not self.connections.touchChangedthen self.connections.touchChanged=UIS2:GetPropertyChangedSignal("TouchEnabled"):Connect(
function()self:_updatePosition()
end
)
end
end
function MainState.wIxwUXZxX:_startRender()
if self.renderConn then
 return
end
self.renderConn=RunService.RenderStepped:Connect(
function(Dmmbu0N)
if not self.config.enabled then
 return
end
if not self.guior not self.gui.Parentthen self._createGui(self)
return
end
if not self.gui.Enabledthen self.gui.Enabled=true
end
self._frameCount=self._frameCount+1
if self._frameCount%30==0 then
 local flag16=false
 for lDZwwz,pDmO_wlQZxQ1D in ipairs(self.parts.frames)do
 if pDmO_wlQZxQ1D and pDmO_wlQZxQ1D.Parent then
flag16=true;
break
 end
 end
 if not flag16 and#self.parts.frames>0 then
self._rebuild(self)
 end
end
if self.config.smooththen
local val25=self.targetOffset-self.currentOffset
if val25.Magnitude>0.01 then
 local val26=1-math.pow(1-self.config.smoothSpeed,Dmmbu0N*60)self.currentOffset=self.currentOffset:Lerp(self.targetOffset,val26)self:_updatePosition()
end
end
end
)
end
function MainState.wIxwUXZxX:_stopRender()
if self.renderConnthen self.renderConn:Disconnect()self.renderConn=nil
end
end
function MainState.wIxwUXZxX:SetEnabled(HHuNNHOwp)self.config.enabled=HHuNNHOwp
if HHuNNHOwp then
 if not self.guior not self.gui.Parent then
self._createGui(self)self:_setupConnections()
 end
self.gui.Enabled=true self.targetOffset=Vector2.new(self.config.offsetX,self.config.offsetY)self.currentOffset=self.targetOffsetself:_updatePosition()self:_startRender()
else self._stopRender(self)
if self.gui then
self.gui.Enabled=false
end
end
end
function MainState.wIxwUXZxX:SetStyle(_xxUlHNNMbqqQ)self.config.style=_xxUlHNNMbqqQ
if self.config.enabledand self.guithen self._rebuild(self)
end
end
function MainState.wIxwUXZxX:SetSize(QZ0qbzZ)self.config.size=QZ0qbzZ
if self.config.enabledand self.guithen self._rebuild(self)
end
end
function MainState.wIxwUXZxX:SetOpacity(bHn_0uUvQzbqlv)self.config.opacity=bHn_0uUvQzbqlv
if self.config.enabledand self.gui then
self._updateColors(self)
end
end
function MainState.wIxwUXZxX:SetColor(Qbl0QXp)self.config.color=Qbl0QXp
if self.config.enabled and self.guithen self._updateColors(self)
end
end
function MainState.wIxwUXZxX:SetOffsetX(QQoqq)self.config.offsetX=QQoqq self.targetOffset=Vector2.new(QQoqq,self.config.offsetY)
if not self.config.smooth and self.config.enabled then
self.currentOffset=self.targetOffset self:_updatePosition()
end
end
function MainState.wIxwUXZxX:SetOffsetY(OzQwqO0)self.config.offsetY=OzQwqO0 self.targetOffset=Vector2.new(self.config.offsetX,OzQwqO0)
if not self.config.smooth and self.config.enabledthen self.currentOffset=self.targetOffsetself:_updatePosition()
end
end
function MainState.wIxwUXZxX:Destroy()self.config.enabled=false self._stopRender(self)
for pOWvxN_MOIuNMn,uDuwbQ in pairs(self.connections)do
pcall(
 function()uDuwbQ:Disconnect()
end
)
end
self.connections={}
if self.guithen pcall(
function()self.gui:Destroy()
end
)
end
self.gui=nil self.container=nil self.parts={frames={},strokes={},dots={}}
end
MainState.Iw0_ov=MainState.wIxwUXZxX.new()
end
function MainState._ouxzuoxpIb_n(HwW1m)
if not ESPState.pnameFakeNames[HwW1m]then
 local esp38=(#ESPState.pnameFakeNames%#ESPFolder)+1 ESPState.pnameFakeNames[HwW1m]=ESPFolder[esp38]
end
return ESPState.pnameFakeNames[HwW1m]
end
function MainState.qMpmWHOmoNvm(H_qzHWHxv,qDpMbIZ0_opH)
if not H_qzHWHxv then
 return
end
local inst79=H_qzHWHxv:FindFirstChild("Head")
if not inst79 then
 return
end
for b0OMuUo,_WqoMOHIIooZo in ipairs(inst79.GetChildren(inst79))do
 if _WqoMOHIIooZo:IsA("BillboardGui")then
 local gui28=_WqoMOHIIooZo:FindFirstChildWhichIsA("TextLabel",true)
 if gui28 then
gui28.Text=qDpMbIZ0_opH
 end
 end
end
local gui29=H_qzHWHxv:FindFirstChildOfClass("Humanoid")
if gui29 then
pcall(
 function()gui29.DisplayDistanceType=Enum.HumanoidDisplayDistanceType.Noneend)
end
end
function MainState.vwmHN1nIDm0X(qnxNHwOoMvHX1Q,QMxQWH_uM)
if not qnxNHwOoMvHX1Q then
 return
end
local inst80=qnxNHwOoMvHX1Q:FindFirstChild("Head")
if inst80 then
 for IZl_Xzbl,_WQuWlqpomU in ipairs(inst80.GetChildren(inst80))do
 if _WQuWlqpomU:IsA("BillboardGui")then
 local gui30=_WQuWlqpomU:FindFirstChildWhichIsA("TextLabel",true)
 if gui30 then
gui30.Text=QMxQWH_uM
 end
 end
 end
end
local gui31=qnxNHwOoMvHX1Q:FindFirstChildOfClass("Humanoid")
if gui31 then
pcall(
 function()gui31.DisplayDistanceType=Enum.HumanoidDisplayDistanceType.Limit
end
)
end
end
function MainState.WQWzx(HwUvOD1vpO)
local inst81=PlayerGui:FindFirstChild("Survivor-mob")
if not inst81 then
 return nil
end
local inst82=inst81:FindFirstChild("Frame")
if not inst82 then
 return nil
end
for omXDOvpulUxWl=1,5 do
 local gui32=inst82:FindFirstChild("Survivor"..omXDOvpulUxWl)
 if gui32 and gui32:GetAttribute("UserId")==HwUvOD1vpO then
 return gui32:FindFirstChild("TextLabel")
 end
end
return nil
end
function MainState.W_vpz(uozOZ)
local gui33=(uozOZ==LocalPlayer)
local gui34=MainState._ouxzuoxpIb_n(uozOZ)
if not gui33 then
 if ESPState.espObjects[uozOZ]then
ESPState.espObjects[uozOZ].nameLabel.Text=gui34
 end
 if uozOZ.Character then
MainState.qMpmWHOmoNvm(uozOZ.Character,gui34)
 end
end
local gui35=MainState.WQWzx(uozOZ.UserId)
if gui35 then
gui35.Text=gui34
end
if not gui33 and not ESPState.pnameNameConns[uozOZ]then
ESPState.pnameNameConns[uozOZ]=uozOZ.CharacterAdded:Connect(
 function(HHNWnHp)
 if not ESPState.pnameEnabledthen
 return
end
local gui36=MainState._ouxzuoxpIb_n(uozOZ)task.wait(0.5)MainState.qMpmWHOmoNvm(HHNWnHp,gui36)
if ESPState.espObjects[uozOZ]then
ESPState.espObjects[uozOZ].nameLabel.Text=gui36
end
local p1w1px=MainState.WQWzx(uozOZ.UserId)
if p1w1px then
p1w1px.Text=gui36
end
end
)
end
end
function MainState.HpnnwXmlxZ1(bvIZZmqHzqlIU)
local gui37=(bvIZZmqHzqlIU==LocalPlayer)
local gui38=bvIZZmqHzqlIU.Nameif not gui37 then
 if ESPState.espObjects[bvIZZmqHzqlIU]then
ESPState.espObjects[bvIZZmqHzqlIU].nameLabel.Text=gui38
 end
 if bvIZZmqHzqlIU.Character then
MainState.vwmHN1nIDm0X(bvIZZmqHzqlIU.Character,gui38)
 end
 if ESPState.pnameNameConns[bvIZZmqHzqlIU]then
ESPState.pnameNameConns[bvIZZmqHzqlIU]:Disconnect()ESPState.pnameNameConns[bvIZZmqHzqlIU]=nil
 end
end
local conn12=MainState.WQWzx(bvIZZmqHzqlIU.UserId)
if conn12 then
conn12.Text=gui38
end
end
function MainState.DMMn1nInqXml(poHnqZxmQnbq,qovnuZ)
local conn13=poHnqZxmQnbq.Name
if ESPState.pnameSlotConns[conn13]then
ESPState.pnameSlotConns[conn13]:Disconnect()ESPState.pnameSlotConns[conn13]=nil
end
local conn14=poHnqZxmQnbq:GetAttribute("UserId")
if not conn14 then
 return
end
local conn15
for vxqq0QI0,OHOqnmx in ipairs(Players.GetPlayers(Players))do
 if OHOqnmx.UserId==conn14 then
conn15=OHOqnmx;
break
 end
end
if not conn15 then
 return
end
local conn16=MainState._ouxzuoxpIb_n(conn15)ESPState.pnameSlotConns[conn13]=qovnuZ:GetPropertyChangedSignal("Text"):Connect(
function()
if not ESPState.pnameEnabled then
 return
end
local conn17=poHnqZxmQnbq:GetAttribute("UserId")
if not conn17 then
 return
end
local tbl32
for puMwpQol,MwxvlzupIWQbQ in ipairs(Players.GetPlayers(Players))do
 if MwxvlzupIWQbQ.UserId==conn17 then
tbl32=MwxvlzupIWQbQ;
break
 end
end
if not tbl32 then
 return
end
local gui39=MainState._ouxzuoxpIb_n(tbl32)
if qovnuZ.Text~=gui39 then
qovnuZ.Text=gui39
end
end
)
end
function MainState.q0vOXnXpp0qUQQ()
for Q0nXbqlOx,_WpwQ0zpwM1l in pairs(ESPState.pnameSlotConns)do
_WpwQ0zpwM1l.Disconnect(_WpwQ0zpwM1l)ESPState.pnameSlotConns[Q0nXbqlOx]=nil
end
local inst83=PlayerGui:FindFirstChild("Survivor-mob")
if not inst83 then
 return
end
local inst84=inst83:FindFirstChild("Frame")
if not inst84 then
 return
end
for QnHoI_b=1,5 do
 local gui40=inst84:FindFirstChild("Survivor"..QnHoI_b)
 if gui40 then
 local gui41=gui40:FindFirstChild("TextLabel")
 if gui41 then
MainState.DMMn1nInqXml(gui40,gui41)
 end
 end
end
end
function MainState.QwZpNwn()ESPState.pnameEnabled=true
for OwMpNNWxxunMpZ,_l0NZUbzZIXWWn in ipairs(Players.GetPlayers(Players))do
MainState.W_vpz(_l0NZUbzZIXWWn)
end
MainState.q0vOXnXpp0qUQQ()
if not ESPState.pnameWatchConnthen ESPState.pnameWatchConn=PlayerGui.ChildAdded:Connect(
function(O_HQZHW)
if O_HQZHW.Name=="Survivor-mob"then
task.wait(0.2)
 if ESPState.pnameEnabledthen MainState.q0vOXnXpp0qUQQ()
 for Q1MUwn,IulHOZWx in ipairs(Players.GetPlayers(Players))do
MainState.W_vpz(IulHOZWx)
 end
end
end
end
)
end
if not ESPState.pnameAddedConnthen ESPState.pnameAddedConn=Players.PlayerAdded:Connect(
function(IqO0xXDuuuv)
if ESPState.pnameEnabled then
task.wait(1)MainState.W_vpz(IqO0xXDuuuv)MainState.q0vOXnXpp0qUQQ()
end
end
)
end
end
function MainState.lOqqxMquzxn_()ESPState.pnameEnabled=false
for OUqpx,HZuZOlDQ0xW in pairs(ESPState.pnameSlotConns)do
HZuZOlDQ0xW.Disconnect(HZuZOlDQ0xW)ESPState.pnameSlotConns[OUqpx]=nil
end
if ESPState.pnameWatchConnthen ESPState.pnameWatchConn:Disconnect()ESPState.pnameWatchConn=nil
end
for HZUvoZ1l00lHqm,_UpuNvX in ipairs(Players.GetPlayers(Players))do
MainState.HpnnwXmlxZ1(_UpuNvX)
end
ESPState.pnameFakeNames={}
if ESPState.pnameAddedConnthen ESPState.pnameAddedConn:Disconnect()ESPState.pnameAddedConn=nil
end
end
function MainState.oqWmXqpHU(lWquoZN)
lWquoZN=lWquoZN or false
local cam11=Workspace.CurrentCameralocal conn18=ESPState.skipEndScreenConnslocal tbl33=false
local cam12=false
local conn19=false pcall(
function()
local inst85=ReplicatedStorage:FindFirstChild("Remotes")
if not inst85 then
 return
end
local
function vXqQwb_N(BlxbvHpU)
if BlxbvHpU and BlxbvHpU:IsA("RemoteEvent")then
 for vwX0p_bIm_Uv,QoDbHvpw1b in ipairs(getconnections(BlxbvHpU.OnClientEvent))do
QoDbHvpw1b.Disable(QoDbHvpw1b)QoDbHvpw1b:Disconnect()
 end
end
end
local inst86=inst85:FindFirstChild("Game")
if inst86 then
 for WOHQQHZQo,qvlZuZZQUwOX in ipairs({"cutscene","cutsceneEnd","cutsceneEnd2","endscreencutscene","cutsceneEndwithownchar","shake"})do
vXqQwb_N(inst86:FindFirstChild(qvlZuZZQUwOX))
 end
end
local inst87=inst85:FindFirstChild("Killers")
if inst87 then
vXqQwb_N(inst87:FindFirstChild("Startmori"))
end
if lWquoZN then
vXqQwb_N(inst85:FindFirstChild("Darkness2"))
end
end
)
local
function WvxNv0n()
if not cam11 then
 return
end
if cam11.CameraType==Enum.CameraType.Scriptablethen tbl33=true cam11.CameraType=Enum.CameraType.Custom tbl33=false
end
end
if cam11 then
WvxNv0n()table.insert(conn18,cam11:GetPropertyChangedSignal("CameraType"):Connect(
 function()
 if not tbl33 then
WvxNv0n()
 end
end
))table.insert(conn18,cam11:GetPropertyChangedSignal("FieldOfView"):Connect(
function()
if cam12 or Settings.lockFovEnabled then
 return
end
if cam11.FieldOfView~=70 then
cam12=true cam11.FieldOfView=70 cam12=false
end
end
))
end
table.insert(conn18,Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(
function()
cam11=Workspace.CurrentCameraif cam11 then
WvxNv0n()
end
end
))table.insert(conn18,LocalPlayer:GetAttributeChangedSignal("isspectating"):Connect(
function()
if conn19 then
 return
end
if LocalPlayer:GetAttribute("isspectating")then
conn19=true LocalPlayer:SetAttribute("isspectating",false)
conn19=false
end
end
))table.insert(conn18,LocalPlayer:GetAttributeChangedSignal("killerend"):Connect(
function()
if conn19 then
 return
end
if LocalPlayer:GetAttribute("killerend")then
conn19=true LocalPlayer:SetAttribute("killerend",false)
conn19=false
end
end
))
local
function ONMOlOHl()
local inst88=Workspace:FindFirstChild("Map")
if inst88 then
 local inst89=inst88:FindFirstChild("endscreen")
 if inst89 then
pcall(
 function()inst89.Parent=nil
 end
)
end
end
local inst90=Workspace:FindFirstChild("BackgroundSounds")
if inst90 then
pcall(
 function()inst90:Destroy()
end
)
end
end
ONMOlOHl()table.insert(conn18,Workspace.DescendantAdded:Connect(
function(wzNnNH)
if wzNnNH.Name=="endscreen"and wzNnNH.Parent and wzNnNH.Parent.Name=="Map"then
task.wait(0.01)pcall(
 function()wzNnNH.Parent=nil
end
)
elseif wzNnNH.Name=="BackgroundSounds"then
pcall(
 function()wzNnNH:Destroy()
end
)
end
end
))
local
function gui3_func(NMMoDNmv1Iz1o)
if not NMMoDNmv1Iz1o or not NMMoDNmv1Iz1o.Parentthen
return
end
pcall(
function()
if lWquoZN and NMMoDNmv1Iz1o.Name=="Darkness"and NMMoDNmv1Iz1o:IsA("ScreenGui")then
NMMoDNmv1Iz1o.Enabled=false
end
for vqwOp,WONuHmwUDU0O in ipairs(NMMoDNmv1Iz1o.GetDescendants(NMMoDNmv1Iz1o))do
 if WONuHmwUDU0O:IsA("VideoFrame")then
WONuHmwUDU0O.Destroy(WONuHmwUDU0O)
 elseif WONuHmwUDU0O:IsA("Frame")and(WONuHmwUDU0O.Name=="Frame2"or WONuHmwUDU0O.Name=="blackout")then
WONuHmwUDU0O.BackgroundTransparency=1
 if lWquoZN then
WONuHmwUDU0O.Visible=false WONuHmwUDU0O:GetPropertyChangedSignal("BackgroundTransparency"):Connect(
 function()
 if WONuHmwUDU0O.BackgroundTransparency<1 then
WONuHmwUDU0O.BackgroundTransparency=1
 end
 end
)WONuHmwUDU0O:GetPropertyChangedSignal("Visible"):Connect(
 function()
 if WONuHmwUDU0O.Visible then
WONuHmwUDU0O.Visible=false
 end
 end
)
end
elseif WONuHmwUDU0O:IsA("ParticleEmitter")or WONuHmwUDU0O:IsA("Beam")or WONuHmwUDU0O:IsA("Trail")then
WONuHmwUDU0O.Enabled=false
end
end
end
)
end
for uvuZn1xzp1,wozm_ in ipairs(PlayerGui.GetChildren(PlayerGui))do
 local tbl34=wozm_.Name
 if tbl34=="Darkness"or tbl34=="EndScreen"or tbl34=="Cutscene"or tbl34=="Results"then
gui3_func(wozm_)
 end
end
table.insert(conn18,PlayerGui.ChildAdded:Connect(
function(uWzlDzNNHHXImM)
local conn20=uWzlDzNNHHXImM.Nameif conn20=="Darkness"or conn20=="EndScreen"or conn20=="Cutscene"or conn20=="Results"then
task.wait(0.05)gui3_func(uWzlDzNNHHXImM)
end
end
))
end
function MainState.Wb0x1XpWv()
for pDWH_oX,M1oqpNNIzXw in ipairs(ESPState.skipEndScreenConns)do
pcall(
 function()M1oqpNNIzXw:Disconnect()
end
)
end
table.clear(ESPState.skipEndScreenConns)
end
do
MainState.DUpNoHpX0DZv={[78432063483146]=true,[121216847022485]=true,[74968262036854]=true,[132817836308238]=true,[82666958311998]=true,[111920872708571]=true,[106871536134254]=true,[109402730355822]=true,[130593238885843]=true,[138720291317243]=true,[139369275981139]=true,[133963973694098]=true,[78935059863801]=true}MainState.BOouUDMI0x={[118907603246885]=true,[135002183282873]=true,[113255068724446]=true,[129784271201071]=true,[105374834496520]=true,[117070354890871]=true,[115244153053858]=true,[110355011987939]=true,[117042998468241]=true,[122812055447896]=true}MainState.IxW_Dmx_ZxU1Uv={}
 for vWpqDlOU,DbvDb in pairs(MainState.DUpNoHpX0DZv)do
MainState.IxW_Dmx_ZxU1Uv["rbxassetid://"..vWpqDlOU]="attack"
 end
 for BvMIwlOuzI,l0mUwom in pairs(MainState.BOouUDMI0x)do
MainState.IxW_Dmx_ZxU1Uv["rbxassetid://"..BvMIwlOuzI]="lungehold"
 end
 function MainState.MQQuzxZ(BoupqvXnz_x1p,BwM_obqOH)
 if not BoupqvXnz_x1p or not BwM_obqOH then
 return nil
 end
 if BoupqvXnz_x1p==LocalPlayer then
 local lzxnow=LocalPlayer:GetAttribute("SelectedKiller")
 if lzxnow then
 return lzxnow
 end
 end
 local QMlo_,IOwmIw0XqnN=pcall(
 function()
 return BwM_obqOH:WaitForChild("Values",2)
end
)
if QMlo_ and IOwmIw0XqnN then
 local inst91=IOwmIw0XqnN:FindFirstChild("KillerName")
 if inst91 and inst91:IsA("StringValue")then
 return inst91.Value
 end
end
local inst92=BoupqvXnz_x1p:GetAttribute("SelectedKiller")
if inst92 then
 return inst92
end
return nil
end
function MainState.pqpqo_mIXXOmqz()
if not ESPState.autoParryEnabledthen
return
end
if tick()-ESPState.lastParryTime<0.15 then
 return
end
ESPState.lastParryTime=tick()
local inst93=LocalPlayer.Character
if not inst93 then
 return
end
local inst94=PlayerGui:FindFirstChild("Survivor-mob")
local inst95=inst94 and inst94:FindFirstChild("Controls")
local inst96=inst95 and inst95:FindFirstChild("Gui-mob")
if inst96 and inst96:IsA("ImageButton")then
firesignal(inst96.MouseButton1Down)task.delay(0.05,
 function()
 if inst96 and inst96.Parentthen firesignal(inst96.MouseButton1Up)
end
end
)
else
local QMwHUl,WH_Up=pcall(
function()
local inst97=Instance.new("InputObject")inst97.UserInputType=Enum.UserInputType.MouseButton2 inst97.UserInputState=Enum.UserInputState.Beginreturn inst97
end
)
if QMwHUl and WH_Up then
 for p__omXqm_1,vHouMQob in getconnections(UIS2.InputBegan)do
vHouMQob:Fire(WH_Up,false)
 end
else VirtualInputManager:SendMouseButtonEvent(0,0,1,true,game,0)
end
end
local char74=inst93:FindFirstChild("HumanoidRootPart")
if char74 then
task.defer(
 function()pcall(
 function()
 if CollectionService:HasTag(char74,"doing action")then
CollectionService:RemoveTag(char74,"doing action")
 end
end
)
end
)
end
end
function MainState.omXXOoIZHO1(l0quv,p_IIuz0Oz1)
local char75=LocalPlayer.Characterif not char75 then
 return
end
local NmzOx=char75:FindFirstChild("HumanoidRootPart")
if not NmzOx then
 return
end
local char76=l0quv:FindFirstChild("HumanoidRootPart")
if not char76 then
 return
end
local char77=Players.LocalPlayer:GetNetworkPing()
local char78=math.clamp(char77,0,0.3)
local char79=char76.AssemblyLinearVelocity
local val27=Vector3.new(char79.X,0,char79.Z)
local val28=char76.Position+(val27*char78)
local part12=NmzOx.Position-val28
local val29=part12.Magnitudelocal val30=ESPState.autoParryRadius+2
if val29>val30 then
 return
end
local val31=(NmzOx.Position-char76.Position).Unit
if val27.Magnitude>8 then
 local val32=val27.Unit:Dot(val31)
 if val32<-0.1 then
 return
 end
end
if val29>=15 then
 local ray1=RaycastParams.new()ray1.FilterDescendantsInstances={char75,l0quv}ray1.FilterType=Enum.RaycastFilterType.Exclude
 local ray2=Workspace:Raycast(char76.Position,part12,ray1)
 if ray2 and ray2.Instanceand not ray2.Instance:IsDescendantOf(char75)then
 return
 end
end
MainState.pqpqo_mIXXOmqz()
end
function MainState.uzDHHIvzqz(bzHw1N,WwXoZ)
if bzHw1N==LocalPlayer then
 return
end
task.wait(0.5)
if not WwXoZ.Parent then
 return
end
local str7=MainState.MQQuzxZ(bzHw1N,WwXoZ)
if str7 or(bzHw1N.Team and bzHw1N.Team.Name:lower():find("killer"))then
 local conn21=str7 or"Unknown Killer"
 local anim1=WwXoZ:WaitForChild("Humanoid",3)
 if anim1 then
 local DwopNwppQp=anim1:WaitForChild("Animator",3)
 if DwopNwppQp then
DwopNwppQp.AnimationPlayed:Connect(
 function(lvUXZu)
 if not ESPState.autoParryEnabledthen
 return
 end
 if lvUXZu and lvUXZu.Animationthen
 local conn22=MainState.IxW_Dmx_ZxU1Uv[lvUXZu.Animation.AnimationId]
 if conn22 then
ESPState.activeAttackers[WwXoZ]={name=conn21,track=lvUXZu,type=conn22}
 if conn22=="attack"then
MainState.omXXOoIZHO1(WwXoZ,conn21)
 end
 local IXvnz IXvnz=lvUXZu.Stopped:Connect(
 function()
 if IXvnz then
IXvnz.Disconnect(IXvnz)
 end
task.delay(0.3,
 function()
 if ESPState.activeAttackers[WwXoZ]and ESPState.activeAttackers[WwXoZ].track==lvUXZu then
ESPState.activeAttackers[WwXoZ]=nil
 end
 end
)
 end
)
end
end
end
)
end
end
end
end
function MainState._qM_on(WQOIXUMQQ)
if WQOIXUMQQ==LocalPlayer then
 return
end
if WQOIXUMQQ.Characterthen task.spawn(
function()MainState.uzDHHIvzqz(WQOIXUMQQ,WQOIXUMQQ.Character)
end
)
end
WQOIXUMQQ.CharacterAdded:Connect(
function(QqMHw_UW0)task.spawn(
function()MainState.uzDHHIvzqz(WQOIXUMQQ,QqMHw_UW0)
end
)
end
)
end
for qoU0IW,lvmOIMXW in ipairs(Players.GetPlayers(Players))do
 if lvmOIMXW~=LocalPlayer then
MainState._qM_on(lvmOIMXW)
 end
end
Players.PlayerAdded:Connect(MainState._qM_on)CreateESPEntry("AttackersMonitor",0,
function()
if not ESPState.autoParryEnabledthen
return
end
if next(ESPState.activeAttackers)==nil then
 return
end
for wlo1W0q0XuqX,OWzxxIm_ in pairs(ESPState.activeAttackers)do
 if not wlo1W0q0XuqX or not wlo1W0q0XuqX.Parent or not OWzxxIm_.track then
ESPState.activeAttackers[wlo1W0q0XuqX]=nil
 else
 if not OWzxxIm_.track.IsPlaying then
ESPState.activeAttackers[wlo1W0q0XuqX]=nil
 else
 if OWzxxIm_.type=="attack"then
 if OWzxxIm_.track.TimePosition<0.25 then
MainState.omXXOoIZHO1(wlo1W0q0XuqX,OWzxxIm_.name)
 end
 elseif OWzxxIm_.type=="lungehold"then
 local char80=LocalPlayer.Character
 local char81=char80 and char80:FindFirstChild("HumanoidRootPart")
 local char82=wlo1W0q0XuqX:FindFirstChild("HumanoidRootPart")
 if char81 and char82 then
 local char83=(char82.Position-char81.Position).Magnitudeif char83<=ESPState.autoParryRadius*0.8 then
MainState.omXXOoIZHO1(wlo1W0q0XuqX,OWzxxIm_.name)
 end
 end
 end
end
end
end
end
)MainState.vQbOXZmp_={}MainState.lwIb11vxW=nil MainState.BMO1q={}MainState._MHzo1Zq=32 MainState.uWXOlqNMoNMI=-1
function MainState.qI_mZo0lWzH()
for WQvumQoM,uDnHU_01x in ipairs(MainState.vQbOXZmp_)do
 if uDnHU_01x and uDnHU_01x.Parentthen uDnHU_01x.Destroy(uDnHU_01x)
end
end
MainState.vQbOXZmp_={}MainState.BMO1q={}
local val33=(2*math.pi)/MainState._MHzo1Zq
for Nl0Iu_l=1,MainState._MHzo1Zq do
 local inst98=val33*(Nl0Iu_l-1)
 local inst99=val33*Nl0Iu_l MainState.BMO1q[Nl0Iu_l]={cx=math.cos(inst98),cz=math.sin(inst98),nx=math.cos(inst99),nz=math.sin(inst99),}
 local color17=Instance.new("Part")color17.Shape=Enum.PartType.BlockOqXoMQ.Anchored=true color17.CanCollide=false color17.CanQuery=false color17.CastShadow=false color17.Material=Enum.Material.Neon color17.Color=Color3.fromRGB(255,60,60)color17.Transparency=0.15 color17.Size=Vector3.new(0.08,0.08,0.1)color17.Name="BolongESP_Seg"color17.Parent=Workspace MainState.vQbOXZmp_[Nl0Iu_l]=color17
end
end
function MainState.I_XOXx0pqZolpo(MvNMNIo)
local inst100=(2*math.pi*MvNMNIo)/MainState._MHzo1Zq
for wXoZHI_n,DbQZu in ipairs(MainState.vQbOXZmp_)do
 if DbQZu and DbQZu.Parent then
DbQZu.Size=Vector3.new(0.08,0.08,inst100+0.02)
 end
end
end
function MainState.lWMxxOX()
for qvX_MqWlDlQ1WH,wO0_mbu in ipairs(MainState.vQbOXZmp_)do
 if wO0_mbu and wO0_mbu.Parent then
wO0_mbu.Destroy(wO0_mbu)
 end
end
MainState.vQbOXZmp_={}MainState.BMO1q={}MainState.uWXOlqNMoNMI=-1
end
function MainState.onDxz1o(vXI0x1m1HW)
if vXI0x1m1HW then
MainState.qI_mZo0lWzH()MainState.lwIb11vxW=RunService.RenderStepped:Connect(
 function()
 if not LocalPlayer.Character then
 return
 end
 local char84=LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
 if not char84 then
 return
 end
 local part13=ESPState.autoParryRadiusif part13~=MainState.uWXOlqNMoNMI then
MainState.I_XOXx0pqZolpo(part13)MainState.uWXOlqNMoNMI=part13
 end
 local part14=char84.Position-Vector3.new(0,char84.Size.Y/2+1.5,0)
 for uvW0m,HbQmuWxQxoIW in ipairs(MainState.vQbOXZmp_)do
 if HbQmuWxQxoIW and HbQmuWxQxoIW.Parentthen
 local part15=MainState.BMO1q[uvW0m]
 local vec1=part14+Vector3.new(part15.cx*part13,0,part15.cz*part13)
 local part16=part14+Vector3.new(part15.nx*part13,0,part15.nz*part13)HbQmuWxQxoIW.CFrame=CFrame.lookAt(vec1,part16)*CFrame.new(0,0,-HbQmuWxQxoIW.Size.Z/2)
 end
end
end
)
else
if MainState.lwIb11vxW then
MainState.lwIb11vxW.Disconnect(MainState.lwIb11vxW);
MainState.lwIb11vxW=nil
end
MainState.lWMxxOX()
end
end
end
function MainState.lHZlWupp()
for QzwoMnWO,plz0Iv0D1bMuIq in ipairs(ESPState.cachedMapObjects.Gates)do
wz0qHHnO(plz0Iv0D1bMuIq,ESPState.ghostGateEnabled)
end
end
function MainState._XDNw()
local char85=LocalPlayer.Character
local char86=char85 and char85:FindFirstChild("HumanoidRootPart")
if not char86 then
ShowNotify("Teleport","Karakter tidak ditemukan!",2);
 return
end
local ray3=workspace:FindFirstChild("Fininshline",true)
if not ray3 then
ShowNotify("Teleport","Fininshline tidak ditemukan di map!",2);
 return
end
local ray4=ray3.Position
local ray5=RaycastParams.new()ray5.FilterType=Enum.RaycastFilterType.Exclude ray5.FilterDescendantsInstances={char85,ray3.Parent}
local part17=nil
local Imqzm=ray4+Vector3.new(0,10,0)
local ray6=workspace:Raycast(Imqzm,Vector3.new(0,-30,0),ray5)
if ray6 then
 local ray7=workspace:Raycast(ray6.Position+Vector3.new(0,5,0),Vector3.new(0,5,0),ray5)
 if not ray7 then
part17=ray6.Position+Vector3.new(0,3,0)
 end
end
if part17 then
pcall(
 function()char86.CFrame=CFrame.new(part17)
end
)
else pcall(
function()char86.CFrame=ray3.CFrameend)
end
end
do
do
 local gui42=46*(0+1-1)
 local gui43=gui42+302-302
 end
MainState._Q1MmIbx0x="80411309607666"
 function MainState.DNHmxOz0wXm(WDNbX)
 if not WDNbX then
 return ""
 end
 return tostring(WDNbX):match("%d+")or""
end
function MainState.NIlvNOODX()
local inst101=LocalPlayer:FindFirstChild("PlayerGui")
if not inst101 then
 return nil
end
local inst102=inst101:FindFirstChild("Survivor-mob")
if not inst102 then
 return nil
end
local inst103=inst102:FindFirstChild("Controls")
if not inst103 then
 return nil
end
local inst104=inst103:FindFirstChild("crouch")
if inst104 and inst104:IsA("GuiButton")then
 return inst104
end
return nil
end
function MainState.uuMqxOzluob(WbvomoHupl)
if ESPState.autoCrouchIsCrouching~=WbvomoHupl then
ESPState.autoCrouchIsCrouching=WbvomoHupl
 local char87=LocalPlayer.Characterif char87 then
char87:SetAttribute("Crouchingserver",WbvomoHupl)char87:SetAttribute("Crouching",WbvomoHupl)
 end
pcall(
 function()ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouchingserver",WbvomoHupl)ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouching",WbvomoHupl)
end
)
local remote10=not UIS2.TouchEnabled and UIS2.KeyboardEnabledif remote10 then
if0>(481)then
 local remote11=307+481
 local flag17=remote11*2
 end
VirtualInputManager:SendKeyEvent(WbvomoHupl,Enum.KeyCode.C,false,game)VirtualInputManager:SendKeyEvent(WbvomoHupl,Enum.KeyCode.LeftControl,false,game)
else
local btn5=MainState.NIlvNOODX()
if btn5 and type(firesignal)=="function"then
 if WbvomoHupl then
firesignal(btn5.MouseButton1Down)
 if btn5.MouseButton1Clickthen firesignal(btn5.MouseButton1Click)
 end
else firesignal(btn5.MouseButton1Up)
if btn5.MouseButton1Clickthen firesignal(btn5.MouseButton1Click)
end
end
end
end
end
end
function MainState.uqH_ZIQnzH_u(BNIvXQwIq_oq)
if not BNIvXQwIq_oq then
 return
end
local char88=BNIvXQwIq_oq:FindFirstChildOfClass("Humanoid")
if not char88 then
 return
end
if ESPState.autoCrouchAnimConns[char88]then
 return
end
ESPState.autoCrouchAnimConns[char88]=char88.AnimationPlayed:Connect(
function(DZWIHb)
if not Settings.autoCrouchEnabled then
 return
end
local conn23=DZWIHb.Animationif conn23 then
 local NWX_10XMN=MainState.DNHmxOz0wXm(conn23.AnimationId)
 if NWX_10XMN==MainState._Q1MmIbx0x then
ESPState.autoCrouchActiveSlashers[BNIvXQwIq_oq]=true DZWIHb.Stopped:Connect(
 function()task.wait(0.2)ESPState.autoCrouchActiveSlashers[BNIvXQwIq_oq]=nil
 end
)
end
end
end
)char88.Died:Connect(
function()ESPState.autoCrouchActiveSlashers[BNIvXQwIq_oq]=nil
end
)
end
CreateESPEntry("AutoCrouch",0,
function()
if not Settings.autoCrouchEnabled then
 return
end
local char89=LocalPlayer.Characterif not char89 then
 return
end
local char90=char89:FindFirstChild("HumanoidRootPart")
if not char90 then
 return
end
local char91=false
for bDMQZ,HDbUNv0uQMZW in pairs(ESPState.autoCrouchActiveSlashers)do
 if bDMQZ and bDMQZ.Parentthen
 local char92=bDMQZ:FindFirstChild("HumanoidRootPart")
 local char93=bDMQZ:FindFirstChildOfClass("Humanoid")
 if char92 and char93 and char93.Health>0 then
 local char94=(char92.Position-char90.Position).Magnitudeif char94<=Settings.autoCrouchRadiusthen char91=true break
 end
end
else ESPState.autoCrouchActiveSlashers[bDMQZ]=nil
end
end
MainState.uuMqxOzluob(char91)
end
)
for OmuImNmbDzqo1I,HIvWvODwzzu_p in ipairs(Players.GetPlayers(Players))do
 if HIvWvODwzzu_p~=LocalPlayer and HIvWvODwzzu_p.Characterthen MainState.uqH_ZIQnzH_u(HIvWvODwzzu_p.Character)
end
if HIvWvODwzzu_p~=LocalPlayer then
HIvWvODwzzu_p.CharacterAdded:Connect(
 function(wXz_XuD)task.wait(1)MainState.uqH_ZIQnzH_u(wXz_XuD)
end
)
end
end
Players.PlayerAdded:Connect(
function(HqvZ0WXWIZU)HqvZ0WXWIZU.CharacterAdded:Connect(
function(BmqZDmDu1pnn)task.wait(1)
if Settings.autoCrouchEnabled then
MainState.uqH_ZIQnzH_u(BmqZDmDu1pnn)
end
end
)
end
)
end
function MainState.vzImqwp(vnqDZuQ0XQ)
if not vnqDZuQ0XQ or vnqDZuQ0XQ:gsub("%s+","")==""then
 return
end
vnqDZuQ0XQ=vnqDZuQ0XQ:gsub("%s+","")task.spawn(
function()
local num1=tonumber(vnqDZuQ0XQ)
if not num1 then
 local num2=pcall(
 function()
num1=Players:GetUserIdFromNameAsync(vnqDZuQ0XQ)
end
)
if not num2 or not num1 then
 return
end
end
local inst105=LocalPlayer.Character
local char95=inst105 and inst105:FindFirstChildOfClass("Humanoid")
if not inst105 or not char95 then
 return
end
local char96=Players:GetHumanoidDescriptionFromUserId(num1)
if not char96 then
 return
end
local inst106=Players:CreateHumanoidModelFromDescription(char96,char95.RigType)
if not inst106 then
 return
end
for bMwXIob00,Qx_UXQb_N in ipairs(inst105.GetChildren(inst105))do
 if Qx_UXQb_N:IsA("Accessory")or Qx_UXQb_N:IsA("Shirt")or Qx_UXQb_N:IsA("Pants")or Qx_UXQb_N:IsA("ShirtGraphic")or Qx_UXQb_N:IsA("BodyColors")or Qx_UXQb_N:IsA("CharacterMesh")then
Qx_UXQb_N.Destroy(Qx_UXQb_N)
 end
end
for w0qzpxmvu,MWzUWQqDZnOHmW in ipairs(inst105.GetChildren(inst105))do
 if MWzUWQqDZnOHmW:IsA("BasePart")then
 for p0ozMOZ,pbmxO1WZI in ipairs(MWzUWQqDZnOHmW.GetChildren(MWzUWQqDZnOHmW))do
 if pbmxO1WZI:IsA("SpecialMesh")or pbmxO1WZI:IsA("Decal")or pbmxO1WZI:IsA("Texture")or pbmxO1WZI:IsA("SurfaceAppearance")then
pbmxO1WZI.Destroy(pbmxO1WZI)
 end
 end
 end
end
local color18=inst106:FindFirstChildOfClass("BodyColors")
if color18 then
color18.Clone(color18).Parent=inst105
 local inst107={Head=color18.HeadColor3,Torso=color18.TorsoColor3,["Left Arm"]=color18.LeftArmColor3,["Right Arm"]=color18.RightArmColor3,["Left Leg"]=color18.LeftLegColor3,["Right Leg"]=color18.RightLegColor3,UpperTorso=color18.TorsoColor3,LowerTorso=color18.TorsoColor3,LeftHand=color18.LeftArmColor3,RightHand=color18.RightArmColor3,LeftLowerArm=color18.LeftArmColor3,RightLowerArm=color18.RightArmColor3,LeftUpperArm=color18.LeftArmColor3,RightUpperArm=color18.RightArmColor3,LeftFoot=color18.LeftLegColor3,RightFoot=color18.RightLegColor3,LeftLowerLeg=color18.LeftLegColor3,RightLowerLeg=color18.RightLegColor3,LeftUpperLeg=color18.LeftLegColor3,RightUpperLeg=color18.RightLegColor3,}
 for oIW0OxMHIZH,QuqHOQ1lQ_zQv in pairs(inst107)do
 local color19=inst105:FindFirstChild(oIW0OxMHIZH)
 if color19 then
pcall(
 function()color19.Color=QuqHOQ1lQ_zQv
 end
)
 end
end
end
for wllqZxm,wIl1lxpxZlHnMo in ipairs(inst106.GetChildren(inst106))do
 if wIl1lxpxZlHnMo:IsA("Shirt")or wIl1lxpxZlHnMo:IsA("Pants")or wIl1lxpxZlHnMo:IsA("ShirtGraphic")or wIl1lxpxZlHnMo:IsA("CharacterMesh")then
wIl1lxpxZlHnMo.Clone(wIl1lxpxZlHnMo).Parent=inst105
 end
end
for _xv1qbQwpp,NvuqulXXlbzn in ipairs(inst106.GetChildren(inst106))do
 if NvuqulXXlbzn:IsA("BasePart")then
 local part18=inst105:FindFirstChild(NvuqulXXlbzn.Name)
 if part18 and part18:IsA("BasePart")then
 if NvuqulXXlbzn:IsA("MeshPart")and part18:IsA("MeshPart")then
pcall(
 function()part18.MeshId=NvuqulXXlbzn.MeshIdwmQzDQ_Qm01b.TextureID=NvuqulXXlbzn.TextureIDwmQzDQ_Qm01b.Color=NvuqulXXlbzn.ColorwmQzDQ_Qm01b.Transparency=NvuqulXXlbzn.Transparencyend)
 end
 for HWMnXMIWo0w,MIM_Oxx in ipairs(NvuqulXXlbzn.GetChildren(NvuqulXXlbzn))do
 if MIM_Oxx:IsA("SpecialMesh")or MIM_Oxx:IsA("Decal")or MIM_Oxx:IsA("Texture")or MIM_Oxx:IsA("SurfaceAppearance")then
MIM_Oxx.Clone(MIM_Oxx).Parent=part18
 end
 end
 end
 end
end
local
function _HHzNQXb(OpXUnWomU)
local inst108=OpXUnWomU.Clone(OpXUnWomU)inst108.Parent=inst105
local inst109=inst108:FindFirstChild("Handle")
if not inst109 then
 return
end
inst109.Anchored=false inst109.CanCollide=false pcall(
function()inst109.Massless=true
end
)
for ln_ov,lXO0Qo in ipairs(inst109.GetChildren(inst109))do
 if lXO0Qo:IsA("Weld")or lXO0Qo:IsA("WeldConstraint")or lXO0Qo:IsA("Motor6D")then
lXO0Qo.Destroy(lXO0Qo)
 end
end
pcall(
function()char95:AddAccessory(inst108)
end
)
local inst110=false
for BuHqDzx,obZNZ1UIQXMm in ipairs(inst109.GetChildren(inst109))do
 if(obZNZ1UIQXMm:IsA("Weld")or obZNZ1UIQXMm:IsA("WeldConstraint"))and obZNZ1UIQXMm.Part1 and obZNZ1UIQXMm.Part1:IsDescendantOf(inst105)then
inst110=true break
 end
end
if not inst110 then
 local inst111=inst109:FindFirstChildOfClass("Attachment")
 local inst112=nil
 local inst113=nil
 if inst111 then
 for DpOunw__0b_pb,QQ1mZxn in ipairs(inst105.GetDescendants(inst105))do
 if QQ1mZxn:IsA("Attachment")and QQ1mZxn.Name==inst111.Name then
inst112=QQ1mZxn.ParentHOIvqoQ1W0v_o=QQ1mZxn break
 end
 end
 end
 if not inst112 then
inst112=inst105:FindFirstChild("Head")or inst105:FindFirstChild("HumanoidRootPart")
 end
 if inst112 then
 if inst113 and inst111 then
inst109.CFrame=inst112.CFrame*inst113.CFrame*inst111.CFrame:Inverse()
 else inst109.CFrame=inst112.CFrameend
 local inst114=Instance.new("WeldConstraint")inst114.Name="BolongWeld"inst114.Part0=inst109 inst114.Part1=inst112 inst114.Parent=inst109
 end
end
end
for OpWHzNmv0n,WzNZNDWoUMm in ipairs(inst106.GetChildren(inst106))do
 if WzNZNDWoUMm:IsA("Accessory")then
pcall(
 function()_HHzNQXb(WzNZNDWoUMm)
 end
)
end
end
inst106.Destroy(inst106)
end
)
end
MainState.owxoOMxxHWu={Ambient=Lighting.Ambient,OutdoorAmbient=Lighting.OutdoorAmbient,ColorShift_Bottom=Lighting.ColorShift_Bottom,ColorShift_Top=Lighting.ColorShift_Top,Brightness=Lighting.Brightness,ClockTime=Lighting.ClockTime,GlobalShadows=Lighting.GlobalShadows,FogStart=Lighting.FogStart,FogEnd=Lighting.FogEnd,FogColor=Lighting.FogColor,ExposureCompensation=Lighting.ExposureCompensation,EnvironmentDiffuseScale=Lighting.EnvironmentDiffuseScale,EnvironmentSpecularScale=Lighting.EnvironmentSpecularScale,}MainState.HwQWWqQUWpIl1N={}
function MainState.p_01zM1nQ()Lighting.Ambient=Color3.fromRGB(178,178,178)Lighting.OutdoorAmbient=Color3.fromRGB(178,178,178)Lighting.ColorShift_Bottom=Color3.new(0,0,0)Lighting.ColorShift_Top=Color3.new(0,0,0)Lighting.Brightness=3;
Lighting.ClockTime=12;
Lighting.GlobalShadows=false Lighting.FogStart=9e9;
Lighting.FogEnd=9e9;
Lighting.ExposureCompensation=0 Lighting.EnvironmentDiffuseScale=0;
Lighting.EnvironmentSpecularScale=0
end
function MainState.un10pxvlDoWQlp()
for uMMbHHO,u0pWQHvI in pairs(MainState.owxoOMxxHWu)do
pcall(
 function()Lighting[uMMbHHO]=u0pWQHvI
end
)
end
end
function MainState.NZ0MOpIIxM_0()MainState.HwQWWqQUWpIl1N={}
for pO11wzpH,WHNHqXnl1ZQ0bH in ipairs(Lighting.GetChildren(Lighting))do
 if WHNHqXnl1ZQ0bH:IsA("PostEffect")or WHNHqXnl1ZQ0bH:IsA("Clouds")or WHNHqXnl1ZQ0bH:IsA("Atmosphere")or WHNHqXnl1ZQ0bH:IsA("Sky")then
MainState.HwQWWqQUWpIl1N[WHNHqXnl1ZQ0bH]={Enabled=WHNHqXnl1ZQ0bH.Enabled,Parent=WHNHqXnl1ZQ0bH.Parent}pcall(
 function()
 if WHNHqXnl1ZQ0bH:IsA("Sky")then
WHNHqXnl1ZQ0bH.Parent=nil
 else WHNHqXnl1ZQ0bH.Enabled=false
 end
end
)
end
end
end
function MainState.WwMOwDZWQxwXD()
for bIuOM_u,_ZWNNo0MHO in pairs(MainState.HwQWWqQUWpIl1N)do
 if bIuOM_u then
pcall(
 function()
 if bIuOM_u:IsA("Sky")then
bIuOM_u.Parent=_ZWNNo0MHO.Parentelse bIuOM_u.Enabled=_ZWNNo0MHO.Enabled
 end
 end
)
end
end
MainState.HwQWWqQUWpIl1N={}
end
CreateESPEntry("LightingEnforcer",0.5,
function()
if ESPState.fullbrightEnabled then
MainState.p_01zM1nQ()
end
if ESPState.removeVfxEnabledthen
for pwvU1bHz,_DDlOw1ZI in ipairs(Lighting.GetChildren(Lighting))do
 if _DDlOw1ZI:IsA("PostEffect")or _DDlOw1ZI:IsA("Clouds")or _DDlOw1ZI:IsA("Atmosphere")or _DDlOw1ZI:IsA("Sky")then
pcall(
 function()
 if _DDlOw1ZI:IsA("Sky")then
 if _DDlOw1ZI.Parentthen _DDlOw1ZI.Parent=nil
 end
 else
 if _DDlOw1ZI.Enabled then
_DDlOw1ZI.Enabled=false
 end
end
end
)
end
end
end
end
)Lighting.ChildAdded:Connect(
function(u0xH0O0UD_)
if ESPState.removeVfxEnabled then
 if u0xH0O0UD_:IsA("PostEffect")or u0xH0O0UD_:IsA("Clouds")or u0xH0O0UD_:IsA("Atmosphere")or u0xH0O0UD_:IsA("Sky")then
task.spawn(
 function()pcall(
 function()
 if u0xH0O0UD_:IsA("Sky")then
u0xH0O0UD_.Parent=nil
 else u0xH0O0UD_.Enabled=false
 end
end
)
end
)
end
end
end
)do
 function MainState.DlDv_DxHml()
 local inst115=Instance.new("ScreenGui")inst115.Name="BolongFOV";
inst115.ResetOnSpawn=false;
inst115.DisplayOrder=999999 pcall(
 function()inst115.Parent=(gethui and gethui()or game:GetService("CoreGui"))
end
)
if not inst115.Parent then
inst115.Parent=PlayerGui
end
ESPState.FOVCircle=Instance.new("Frame")ESPState.FOVCircle.Size=UDim2.new(0,Settings.silentAimFovRadius*2,0,Settings.silentAimFovRadius*2)ESPState.FOVCircle.Position=UDim2.new(0.5,0,0.5,0)ESPState.FOVCircle.AnchorPoint=Vector2.new(0.5,0.5)ESPState.FOVCircle.BackgroundColor3=Color3.fromRGB(255,255,255)ESPState.FOVCircle.BackgroundTransparency=1;
ESPState.FOVCircle.Visible=false ESPState.FOVCircle.Parent=inst115
local inst116=Instance.new("UICorner");
inst116.CornerRadius=UDim.new(1,0);
inst116.Parent=ESPState.FOVCircle
local inst117=Instance.new("UIStroke")inst117.Color=NotifyColor;
inst117.Thickness=2;
inst117.Transparency=0.2;
inst117.Parent=ESPState.FOVCircle
end
MainState.DlDv_DxHml()
function MainState.DM_lMDIIqlpw(oxvvNv)
if not oxvvNv then
 return nil
end
local inst118=oxvvNv:FindFirstChild("UpperTorso")
if inst118 and inst118:IsA("BasePart")then
 return inst118.Positionend
 local char97=oxvvNv:FindFirstChild("Torso")
 if char97 and char97:IsA("BasePart")then
 return char97.Positionend
 local char98=oxvvNv:FindFirstChild("HumanoidRootPart")
 if char98 then
 return char98.Positionend
 return nil
 end
 function MainState.lwHZx()
 local inst119=LocalPlayer.Character
 if not inst119 then
 return nil
 end
 local Inst5,HvlIxqz=pcall(
 function()
 return inst119:FindFirstChild("Twist of Fate"):FindFirstChild("Right Arm"):FindFirstChild("gun"):FindFirstChild("gun")
 end
)
 if Inst5 and HvlIxqz and HvlIxqz:IsA("BasePart")then
 return HvlIxqz.Positionend
 local inst120=inst119:FindFirstChild("Right Arm")or inst119:FindFirstChild("RightHand")
 if inst120 then
 return inst120.Position
 end
 return nil
 end
MainState.wOM_Wn=ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Items"):WaitForChild("Twist of Fate"):WaitForChild("Fire")pcall(
 function()MainState.BDvWIwNMuDUoz0=hookmetamethod(game,"__namecall",
 function(WqMm0W,..)
 local remote12=getnamecallmethod()
 if remote12=="FireServer"and rawequal(WqMm0W,MainState.wOM_Wn)then
 local flag18=table.pack(...)
 if ESPState.silentAimEnabled and typeof(ESPState.silentAimLookVector)=="Vector3"then
 if flag18.n>=3 and typeof(flag18[3])=="Vector3"then
flag18[3]=ESPState.silentAimLookVectorif ESPState.laserEspEnabledthen ESPState.triggerLaser=true
 end
 elseif flag18.n>=2 and typeof(flag18[2])=="Vector3"then
flag18[2]=ESPState.silentAimLookVector
 if ESPState.laserEspEnabledthen ESPState.triggerLaser=true
 end
 end
end
return MainState.BDvWIwNMuDUoz0(WqMm0W,table.unpack(flag18,1,flag18.n))
end
return MainState.BDvWIwNMuDUoz0(WqMm0W,..)
end
)
end
)CreateESPEntry("UpdateSilentAimTarget",0.05,
function()
if ESPState.FOVCircle then
ESPState.FOVCircle.Visible=ESPState.silentAimFovVisiblelocal gui44=Settings.silentAimFovRadius*2
 if ESPState.FOVCircle.Size.X.Offset~=gui44 then
ESPState.FOVCircle.Size=UDim2.new(0,gui44,0,gui44)
 end
end
if not ESPState.silentAimEnabledthen ESPState.silentAimTarget=nil;
ESPState.silentAimLookVector=nil;
return
end
local char99=LocalPlayer.Character
if not char99 then
 return
end
local char100=char99:FindFirstChild("HumanoidRootPart")
if not char100 then
 return
end
local cam13=workspace.CurrentCamera
if not cam13 then
 return
end
local char101=nil
local char102=math.hugefor BwNW_o,Bw0M_ in ipairs(Players.GetPlayers(Players))do
 if Bw0M_~=LocalPlayer and GetPlayerRole(Bw0M_)=="killer"then
 local char103=Bw0M_.Character
 if char103 then
 local char104=char103:FindFirstChildOfClass("Humanoid")
 local char105=MainState.DM_lMDIIqlpw(char103)
 if char104 and char104.Health>0 and typeof(char105)=="Vector3"then
 local char106=(char105-char100.Position).Magnitudeif char106<char102 then
char102=char106;
char101=Bw0M_
 end
 end
 end
 end
end
if char101 and char101.Character then
 local cam14=MainState.DM_lMDIIqlpw(char101.Character)
 if typeof(cam14)=="Vector3"then
 local flag19=true
 local Flag2,bDWoxolNOmnXz=cam13:WorldToViewportPoint(cam14)
 if bDWoxolNOmnXz then
 local cam15=Vector2.new(cam13.ViewportSize.X/2,cam13.ViewportSize.Y/2)
 local cam16=(Vector2.new(Flag2.X,Flag2.Y)-cam15).Magnitude
 if cam16>Settings.silentAimFovRadius then
flag19=false
 end
 else flag19=false
 end
 if flag19 then
 local gui45=MainState.lwHZx()
 if typeof(gui45)~="Vector3"then
gui45=cam13.CFrame.Positionend
 local esp39=cam14-gui45
 local esp40=esp39.Magnitudeif esp40>0.1 then
ESPState.silentAimTarget=cam14 ESPState.silentAimLookVector=Vector3.new(esp39.X/esp40,esp39.Y/esp40,esp39.Z/esp40)ESPState.currentMuzzlePos=gui45;
ESPState.currentTargetPos=cam14
 else ESPState.silentAimTarget=nil;
ESPState.silentAimLookVector=nil
 end
 else ESPState.silentAimTarget=nil;
ESPState.silentAimLookVector=nil
end
else ESPState.silentAimTarget=nil;
ESPState.silentAimLookVector=nil
end
else ESPState.silentAimTarget=nil;
ESPState.silentAimLookVector=nil
end
end
)CreateESPEntry("DrawLaserESP",0,
function()
if not ESPState.triggerLaser then
 return
end
ESPState.triggerLaser=false
local inst121=ESPState.currentMuzzlePos
local inst122=ESPState.currentTargetPos
if typeof(inst121)~="Vector3"or typeof(inst122)~="Vector3"then
 return
end
local inst123=(inst121-inst122).Magnitude
if inst123<0.1 then
 return
end
local part19=Instance.new("Part")part19.Name="SilentLaser";
part19.Anchored=true;
part19.CanCollide=false part19.Material=Enum.Material.Neon;
part19.Color=Color3.fromRGB(255,0,0)part19.Transparency=0.3;
part19.Size=Vector3.new(0.15,0.15,inst123)part19.CFrame=CFrame.new(inst121,inst122)*CFrame.new(0,0,-inst123/2)part19.Parent=workspace task.delay(0.4,
function()
if part19 then
part19.Destroy(part19)
end
end
)
end
)
end
do
 function MainState.ppmDZmUwpIop(uZzNlz)
 if not uZzNlz then
 return nil
 end
 local inst124=uZzNlz:FindFirstChild("UpperTorso")
 if inst124 and inst124:IsA("BasePart")then
 return inst124.Position
 end
 local inst125=uZzNlz:FindFirstChild("Torso")
 if inst125 and inst125:IsA("BasePart")then
 return inst125.Position
 end
 local char107=uZzNlz:FindFirstChild("HumanoidRootPart")
 if char107 then
 return char107.Position+Vector3.new(0,0.5,0)
 end
 return nil
end
function MainState._vMo1mZ1l(qxxuWHnX_p0,wv1lblzM,D_UInxMv)
local Val1,q01XnvuZX=qxxuWHnX_p0:WorldToViewportPoint(wv1lblzM)
if not q01XnvuZX then
 return false
end
local cam17=Vector2.new(qxxuWHnX_p0.ViewportSize.X/2,qxxuWHnX_p0.ViewportSize.Y/2)
local cam18=Vector2.new(Val1.X,Val1.Y)
local inst126=(cam18-cam17).Magnitudereturn inst126<=D_UInxMv
end
function MainState._ONZmmHUz()
local inst127=Instance.new("ScreenGui")inst127.Name="BolongSpearFOV";
inst127.ResetOnSpawn=false;
inst127.DisplayOrder=999999 pcall(
function()inst127.Parent=(gethui and gethui()or game:GetService("CoreGui"))
end
)
if not inst127.Parent then
inst127.Parent=PlayerGui
end
ESPState.SpearFOVCircle=Instance.new("Frame")ESPState.SpearFOVCircle.Size=UDim2.new(0,Settings.spearFovRadius*2,0,Settings.spearFovRadius*2)ESPState.SpearFOVCircle.Position=UDim2.new(0.5,0,0.5,0)ESPState.SpearFOVCircle.AnchorPoint=Vector2.new(0.5,0.5)ESPState.SpearFOVCircle.BackgroundColor3=Color3.fromRGB(255,255,255)ESPState.SpearFOVCircle.BackgroundTransparency=1;
ESPState.SpearFOVCircle.Visible=false ESPState.SpearFOVCircle.Parent=inst127
local inst128=Instance.new("UICorner");
inst128.CornerRadius=UDim.new(1,0);
inst128.Parent=ESPState.SpearFOVCirclelocal inst129=Instance.new("UIStroke")inst129.Color=NotifyColor;
inst129.Thickness=2;
inst129.Transparency=0.2;
inst129.Parent=ESPState.SpearFOVCircleend MainState._ONZmmHUz()
function MainState.Bvolu1()
local inst130=Instance.new("ScreenGui")inst130.Name="SpearIndicatorUI";
inst130.ResetOnSpawn=false;
inst130.Enabled=false inst130.DisplayOrder=999998;
inst130.IgnoreGuiInset=true pcall(
function()inst130.Parent=(gethui and gethui()or game:GetService("CoreGui"))
end
)
if not inst130.Parent then
inst130.Parent=PlayerGui
end
ESPState.SpearMainFrame=Instance.new("Frame")ESPState.SpearMainFrame.Name="MainFrame"ESPState.SpearMainFrame.Size=UDim2.new(0,180,0,42)ESPState.SpearMainFrame.Position=UDim2.new(0.5,0,0.82,0)ESPState.SpearMainFrame.AnchorPoint=Vector2.new(0.5,0.5)ESPState.SpearMainFrame.BackgroundColor3=Color3.fromRGB(20,20,25)ESPState.SpearMainFrame.BackgroundTransparency=0.1 ESPState.SpearMainFrame.BorderSizePixel=0 ESPState.SpearMainFrame.Parent=inst130
local inst131=Instance.new("UICorner");
inst131.CornerRadius=UDim.new(0,8);
inst131.Parent=ESPState.SpearMainFramelocal Tmp2=Instance.new("UIStroke")Tmp2.Color=Color3.fromRGB(45,45,55);
Tmp2.Thickness=1;
Tmp2.Transparency=0.2;
Tmp2.Parent=ESPState.SpearMainFrame
local color20=Instance.new("UIGradient")color20.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(35,35,40)),ColorSequenceKeypoint.new(1,Color3.fromRGB(15,15,20))})color20.Rotation=90;
color20.Parent=ESPState.SpearMainFrame ESPState.SpearAccentBar=Instance.new("Frame")ESPState.SpearAccentBar.Name="AccentBar"ESPState.SpearAccentBar.Size=UDim2.new(0,3,1,-12)ESPState.SpearAccentBar.Position=UDim2.new(0,6,0,6)ESPState.SpearAccentBar.BackgroundColor3=Color3.fromRGB(200,200,200)ESPState.SpearAccentBar.BorderSizePixel=0;
ESPState.SpearAccentBar.Parent=ESPState.SpearMainFrame
local gui46=Instance.new("UICorner");
gui46.CornerRadius=UDim.new(1,0);
gui46.Parent=ESPState.SpearAccentBarESPState.SpearStatusText=Instance.new("TextLabel")ESPState.SpearStatusText.Name="StatusText"ESPState.SpearStatusText.Size=UDim2.new(1,-18,0,18)ESPState.SpearStatusText.Position=UDim2.new(0,14,0,5)ESPState.SpearStatusText.BackgroundTransparency=1 HM1uHIZZl0.SpearStatusText.Text="NO TARGET"ESPState.SpearStatusText.TextColor3=Color3.fromRGB(255,255,255)ESPState.SpearStatusText.TextSize=13;
ESPState.SpearStatusText.Font=Enum.Font.GothamBoldESPState.SpearStatusText.TextXAlignment=Enum.TextXAlignment.LeftESPState.SpearStatusText.TextTruncate=Enum.TextTruncate.AtEndESPState.SpearStatusText.Parent=ESPState.SpearMainFrame ESPState.SpearInfoText=Instance.new("TextLabel")ESPState.SpearInfoText.Name="InfoText"ESPState.SpearInfoText.Size=UDim2.new(1,-18,0,14)ESPState.SpearInfoText.Position=UDim2.new(0,14,0,23)ESPState.SpearInfoText.BackgroundTransparency=1 HM1uHIZZl0.SpearInfoText.Text="Aim to Survivor"ESPState.SpearInfoText.TextColor3=Color3.fromRGB(160,160,170)ESPState.SpearInfoText.TextSize=10;
ESPState.SpearInfoText.Font=Enum.Font.Gotham ESPState.SpearInfoText.TextXAlignment=Enum.TextXAlignment.Left ESPState.SpearInfoText.TextTruncate=Enum.TextTruncate.AtEnd ESPState.SpearInfoText.Parent=ESPState.SpearMainFrameESPState.SpearIndicatorGui=inst130
end
MainState.Bvolu1()
function MainState.Bznqp()ESPState.SnapLineGui=Instance.new("ScreenGui")ESPState.SnapLineGui.Name="SpearVeil_SnapLine"ESPState.SnapLineGui.IgnoreGuiInset=true;
ESPState.SnapLineGui.ResetOnSpawn=false ESPState.SnapLineGui.DisplayOrder=999999 pcall(
function()ESPState.SnapLineGui.Parent=(gethui and gethui()or game:GetService("CoreGui"))
end
)
if not ESPState.SnapLineGui.Parentthen ESPState.SnapLineGui.Parent=PlayerGui
end
ESPState.SnapLineFrame=Instance.new("Frame")ESPState.SnapLineFrame.Name="Line"ESPState.SnapLineFrame.AnchorPoint=Vector2.new(0.5,0.5)ESPState.SnapLineFrame.BorderSizePixel=0 HM1uHIZZl0.SnapLineFrame.BackgroundColor3=Color3.fromRGB(255,220,0)ESPState.SnapLineFrame.BackgroundTransparency=0.35 ESPState.SnapLineFrame.Visible=false;
ESPState.SnapLineFrame.Parent=ESPState.SnapLineGui ESPState.SnapLineDot=Instance.new("Frame")ESPState.SnapLineDot.Name="Dot"ESPState.SnapLineDot.AnchorPoint=Vector2.new(0.5,0.5)ESPState.SnapLineDot.BorderSizePixel=0 ESPState.SnapLineDot.BackgroundColor3=Color3.fromRGB(255,220,0)ESPState.SnapLineDot.BackgroundTransparency=0 ESPState.SnapLineDot.Size=UDim2.fromOffset(4,4)ESPState.SnapLineDot.Visible=false;
ESPState.SnapLineDot.Parent=ESPState.SnapLineGuilocal gui47=Instance.new("UICorner");
gui47.CornerRadius=UDim.new(1,0);
gui47.Parent=ESPState.SnapLineDot ESPState.SnapLineTextLabel=Instance.new("TextLabel")ESPState.SnapLineTextLabel.Name="InfoText"ESPState.SnapLineTextLabel.AnchorPoint=Vector2.new(0.5,1)ESPState.SnapLineTextLabel.Size=UDim2.new(0,200,0,16)ESPState.SnapLineTextLabel.BackgroundTransparency=1 ESPState.SnapLineTextLabel.Text=""ESPState.SnapLineTextLabel.TextColor3=Color3.fromRGB(255,255,255)ESPState.SnapLineTextLabel.TextSize=12;
ESPState.SnapLineTextLabel.Font=Enum.Font.GothamBoldESPState.SnapLineTextLabel.TextStrokeTransparency=0 HM1uHIZZl0.SnapLineTextLabel.TextStrokeColor3=Color3.new(0,0,0)ESPState.SnapLineTextLabel.TextXAlignment=Enum.TextXAlignment.Center ESPState.SnapLineTextLabel.TextTruncate=Enum.TextTruncate.AtEndESPState.SnapLineTextLabel.Visible=false;
ESPState.SnapLineTextLabel.Parent=ESPState.SnapLineGuiend MainState.Bznqp()
function MainState.Wlx1W0xW(WpUuO1bQbqvqOW,BH_lz_O1D_QU,MODqwXnbn1Iz,qUxWlwvHZX)
local gui48=math.cos(BH_lz_O1D_QU)
if gui48<=0.015 then
 return nil,nil
end
local val34=WpUuO1bQbqvqOW/(MODqwXnbn1Iz*gui48)
if val34~=val34 or val34<=0 then
 return nil,nil
end
local val35=1/60
local val36=0.5*qUxWlwvHZX*val35*val34
local val37=MODqwXnbn1Iz*math.sin(BH_lz_O1D_QU)*val34-(0.5*qUxWlwvHZX*val34*val34)-val36
return val37,val34
end
function MainState.oIO1v(pOMWuuQm,bZ00l,pmIHpDvpplMp,lMpMW,HUqXuvXuWXu_)
local Val2,lv_NWuq_pDX0l=MainState.Wlx1W0xW(pOMWuuQm,pmIHpDvpplMp,lMpMW,HUqXuvXuWXu_)
if not Val2 or not lv_NWuq_pDX0l then
 return nil
end
if lv_NWuq_pDX0l<0.025 or lv_NWuq_pDX0l>5 then
 return nil
end
local val38=math.abs(Val2-bZ00l)
local val39=math.max(pmIHpDvpplMp-Angle42,0)*0.35
local NwMqv=math.max(lv_NWuq_pDX0l-1.3,0)*0.25
return val38+val39+NwMqv,val38,lv_NWuq_pDX0l
end
function MainState.MqHuIln(qDWnbvupq,vlW1OHDx,MXMWUZn,MIlmOQHI)
if MXMWUZn<=0 then
MXMWUZn=142.5
end
if MIlmOQHI<=0 then
MIlmOQHI=196.2
end
local val40=vlW1OHDx-qDWnbvupq
local val41=Vector3.new(val40.X,0,val40.Z)
local Iopppl=val41.Magnitudelocal val42=val40.Y
if val40.Magnitude<=0.001 then
 return nil
end
if Iopppl<=0.35 or MIlmOQHI<=0.001 then
 return val40.Unit,math.clamp(val40.Magnitude/MXMWUZn,0.025,5)
end
local val43=val41.Unitlocal val44=math.atan2(val42,Iopppl)
local val45=math.max(-Angle28,val44-Angle18)
local val46=Angle72
local Val3,IoXwDmzowvXbU,QxlObm0WO,bzlz1QD1DXvW=nil,math.huge,math.huge,nil
local val47=30 do
 local val48=bit32.band(369,0)
 local val49=bit32.bor(val48,571)-571
end
for pzWN01unm=0,val47 do
 local v2=val45+(val46-val45)*(pzWN01unm/val47)
 local Var1,ql_pn,lONQu=MainState.oIO1v(Iopppl,val42,v2,MXMWUZn,MIlmOQHI)
 if Var1 and Var1<IoXwDmzowvXbU then
IoXwDmzowvXbU,QxlObm0WO,Val3,bzlz1QD1DXvW=Var1,ql_pn,v2,lONQu
 if QxlObm0WO<SmallOffset then
break
 end
 end
end
if Val3 then
 local HMNMN=(val46-val45)/val47*2.5
 local val50=(QxlObm0WO<SmallOffset)and 1 or 4
 for NwvmmmvvoWw=1,val50 do
 local Var2,_on_z,DxNXwp1xOOU,w_nUqDWxW=Val3,IoXwDmzowvXbU,QxlObm0WO,bzlz1QD1DXvW
 for pZzwNxD=-3,3 do
 local val51=math.clamp(Val3+HMNMN*(pZzwNxD/3),val45,val46)
 local Val4,Mu0xw1ul1vQ,wN1qup1xQ1U=MainState.oIO1v(Iopppl,val42,val51,MXMWUZn,MIlmOQHI)
 if Val4 and Val4<_on_z then
_on_z,DxNXwp1xOOU,Var2,w_nUqDWxW=Val4,Mu0xw1ul1vQ,val51,wN1qup1xQ1U
 end
 end
Val3,IoXwDmzowvXbU,QxlObm0WO,bzlz1QD1DXvW=Var2,_on_z,DxNXwp1xOOU,w_nUqDWxW
 if QxlObm0WO<SmallOffset then
break
 end
HMNMN=HMNMN*0.38
 end
end
if not Val3 then
 local val52=math.clamp(Iopppl/MXMWUZn,0.025,5)
 local val53=vlW1OHDx+Vector3.new(0,0.5*MIlmOQHI*val52*val52,0)
 local val54=val53-qDWnbvupq
 if val54.Magnitude<=0.001 then
 return nil
 end
 return val54.Unit,val52
end
local val55=val43*math.cos(Val3)+Vector3.new(0,math.sin(Val3),0)
if val55.Magnitude<=0.001 then
 if(0>1)then
 if(221<497)then
 local val56=221+497
 end
 end
 return nil
end
return val55.Unit,bzlz1QD1DXvW
end
function MainState.vpDvmUq(q00HInHX0,_qZ0xw,NOwXIDzvXX,wDzZmp_p0m_oo)
if NOwXIDzvXX<=0 or wDzZmp_p0m_oo<=0 then
 return false
end
local vb0qllMol1,uvoumZnNuNXoI,v0NQ1wOumuHvw,_XoQIuUzz0NW=q00HInHX0,_qZ0xw,NOwXIDzvXX,wDzZmp_p0m_oo
local v3=(_XoQIuUzz0NW*vb0qllMol1*vb0qllMol1)/(2*v0NQ1wOumuHvw*v0NQ1wOumuHvw)
if v3<=0 then
 return false
end
local Flag3,qxWb0NlMHXbmNv,NpoNDMMpwx=v3,-vb0qllMol1,uvoumZnNuNXoI+v3
return(qxWb0NlMHXbmNv*qxWb0NlMHXbmNv-4*Flag3*NpoNDMMpwx)>=0
end
function MainState.BQOObX(qnNUMI,BlzQl0,q_x_WUQUoO_v)
for WumzQw=0.1,3.0,0.05 do
 local val57=23
 if WumzQw<1 then
val57=math.max(23,WumzQw*150)
 elseif WumzQw<2 then
val57=142.5
 else val57=165
end
if MainState.vpDvmUq(qnNUMI,BlzQl0,val57,q_x_WUQUoO_v)then
 return WumzQw
end
end
return nil
end
do
MainState.vbbz0lv=ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Killers"):WaitForChild("Veil"):WaitForChild("Spearthrow")MainState.u0uHqHxm0DHI=ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Mechanics"):WaitForChild("visualize")MainState.u0uHqHxm0DHI.OnClientEvent:Connect(
 function(NQ1nvw,BXZl_,NWMIwUoHQOZo_W,NnubI0U0oOm)
 if NQ1nvw==LocalPlayer.Character then
 if type(NWMIwUoHQOZo_W)=="number"and NWMIwUoHQOZo_W>0 then
ESPState.lastSpearSpeed=NWMIwUoHQOZo_W
 end
 if type(NnubI0U0oOm)=="number"and NnubI0U0oOm>=0 then
ESPState.lastGravityMult=NnubI0U0oOm
 end
 end
end
)MainState.N_ulNqbOqbD0=hookmetamethod(game,"__namecall",
function(...)
local remote13=getnamecallmethod()
if remote13=="FireServer"then
 local esp41=table.pack(...)
 local remote14=esp41[1]
 if typeof(remote14)=="Instance"and rawequal(remote14,MainState.vbbz0lv)then
 if ESPState.silentSpearEnabledand typeof(ESPState.silentSpearLookVector)=="Vector3"then
 if esp41.n>=4 and typeof(esp41[2])=="Vector3"and typeof(esp41[4])=="Vector3"then
esp41[2]=ESPState.silentSpearLookVector
 return MainState.N_ulNqbOqbD0(table.unpack(esp41,1,esp41.n))
 end
 end
 end
end
return MainState.N_ulNqbOqbD0(...)
end
)MainState.IOqIuMI=hookmetamethod(game,"__index",
function(bNwvpn_MwU,bqQDnmuN)
if bqQDnmuN=="FireServer"and typeof(bNwvpn_MwU)=="Instance"and rawequal(bNwvpn_MwU,MainState.vbbz0lv)then
 return newcclosure(
 function(...)
 local esp42=table.pack(...)
 if ESPState.silentSpearEnabled and typeof(ESPState.silentSpearLookVector)=="Vector3"then
 if esp42.n>=4 and typeof(esp42[2])=="Vector3"and typeof(esp42[4])=="Vector3"then
esp42[2]=ESPState.silentSpearLookVectorend
 end
 return MainState.IOqIuMI(bNwvpn_MwU,bqQDnmuN)(table.unpack(esp42,1,esp42.n))
 end
)
end
return MainState.IOqIuMI(bNwvpn_MwU,bqQDnmuN)
end
)
end
do
MainState.vnQWv={}
 function MainState.WuuUo(lxQbWWOzw,qU_xzUvb0vx)
 local inst132=lxQbWWOzw and lxQbWWOzw.Parentwhile inst132 do
 if inst132.Name==qU_xzUvb0vx then
 return true
 end
inst132=inst132.Parent
 end
 return false
end
function MainState.NluUIOonNHv(Hb_HNXDuwbN)
if not(Hb_HNXDuwbN and Hb_HNXDuwbN:IsA("GuiButton"))then
 return false
end
if Hb_HNXDuwbN.Name~="attack"and Hb_HNXDuwbN.Name~="Gui-mob"then
 return false
end
if not MainState.WuuUo(Hb_HNXDuwbN,"Slasher-mob")and not MainState.WuuUo(Hb_HNXDuwbN,"Survivor-mob")then
 return false
end
if not MainState.WuuUo(Hb_HNXDuwbN,"Control")and not MainState.WuuUo(Hb_HNXDuwbN,"Controls")then
 return false
end
return true
end
function MainState.uqXMUqx(WXmwQqQX)
if not MainState.NluUIOonNHv(WXmwQqQX)then
 return
end
if MainState.vnQWv[WXmwQqQX]then
 return
end
MainState.vnQWv[WXmwQqQX]=true WXmwQqQX.InputBegan:Connect(
function(wUbqNonzq)
local conn24=wUbqNonzq.UserInputTypeif conn24~=Enum.UserInputType.Touchand conn24~=Enum.UserInputType.MouseButton1 then
 return
end
local conn25=LocalPlayer.Character
if conn25 and conn25:GetAttribute("spearmode")then
ESPState.spearIsHolding=true;
ESPState.spearHoldStartTime=tick()
end
end
)WXmwQqQX.InputEnded:Connect(
function(MbWHWUbwwoI)
local conn26=MbWHWUbwwoI.UserInputType
if conn26~=Enum.UserInputType.Touch and conn26~=Enum.UserInputType.MouseButton1 then
 return
end
ESPState.spearIsHolding=false;
ESPState.spearHoldStartTime=nil
end
)
end
function MainState.olonnon()
local inst133=LocalPlayer:FindFirstChildOfClass("PlayerGui")or PlayerGui
if not inst133 then
 return
end
pcall(
function()
for l0zz0Z,pMW1_OxbqD in ipairs(inst133.GetDescendants(inst133))do
MainState.uqXMUqx(pMW1_OxbqD)
end
end
)inst133.DescendantAdded:Connect(
function(lIvIqWHNN)MainState.uqXMUqx(lIvIqWHNN)
end
)
end
UIS2.InputBegan:Connect(
function(pHxlmuU,w1zMwI)
if pHxlmuU.UserInputType==Enum.UserInputType.MouseButton1then
local conn27=LocalPlayer.Characterif conn27 and conn27:GetAttribute("spearmode")then
ESPState.spearIsHolding=true;
ESPState.spearHoldStartTime=tick()
end
end
end
)UIS2.InputEnded:Connect(
function(oluzZHmXm0pzuM)
if oluzZHmXm0pzuM.UserInputType==Enum.UserInputType.MouseButton1then ESPState.spearIsHolding=false;
ESPState.spearHoldStartTime=nil
end
end
)MainState.olonnon()
end
CreateESPEntry("Spear_UpdateSnapLine",0,
function(vvo_Wqm0mw)
local flag20=ESPState.SPEAR_SNAPLINEif not flag20.enabledthen
if ESPState.SnapLineFramethen ESPState.SnapLineFrame.Visible=false
end
if ESPState.SnapLineDot then
ESPState.SnapLineDot.Visible=false
end
if ESPState.SnapLineTextLabelthen ESPState.SnapLineTextLabel.Visible=false
end
flag20.locked=false;
flag20.lockedTarget=nil;
flag20.lockedPlayerName=""
return
end
local gui49=Workspace.CurrentCameraif not gui49 then
 if ESPState.SnapLineFramethen ESPState.SnapLineFrame.Visible=false
end
if ESPState.SnapLineDot then
ESPState.SnapLineDot.Visible=false
end
if ESPState.SnapLineTextLabel then
ESPState.SnapLineTextLabel.Visible=false
end
return
end
local gui50=LocalPlayer.Characterlocal gui51=gui50 and gui50:GetAttribute("spearmode")
if not gui51 then
 if ESPState.SnapLineFramethen ESPState.SnapLineFrame.Visible=false
end
if ESPState.SnapLineDotthen ESPState.SnapLineDot.Visible=false
end
if ESPState.SnapLineTextLabel then
ESPState.SnapLineTextLabel.Visible=false
end
return
end
local HvHvMlXv=gui49.ViewportSizelocal gui52=Vector2.new(HvHvMlXv.X/2,HvHvMlXv.Y/2)
local char108=gui50 and gui50:FindFirstChild("HumanoidRootPart")
local
function lvHDz()
local char109=nil
local HIDN0=math.hugelocal char110=math.huge
for D_xMx,loxlI_o in ipairs(Players.GetPlayers(Players))do
 if loxlI_o~=LocalPlayer and GetPlayerRole(loxlI_o)=="survivor"then
 local char111=loxlI_o.Character
 if char111 then
 local char112=char111:FindFirstChildOfClass("Humanoid")
 local char113=MainState.ppmDZmUwpIop(char111)
 if char113 and char112 and char112.Health>0 and char112.Health>50 and not char111:GetAttribute("IsHooked")then
 local val58=char108 and(char113-char108.Position).Magnitude or0
 if val58<=Settings.spearSnaplineMaxDistancethen
 local D0b1xbl,DxMZHvUNN=gui49:WorldToViewportPoint(char113)
 if DxMZHvUNN then
 local cam19=(Vector2.new(D0b1xbl.X,D0b1xbl.Y)-gui52).Magnitude
 if cam19<=Settings.spearFovRadiusthen
 if cam19<HIDN0 then
HIDN0=cam19;
char110=val58;
char109=loxlI_o
 end
 end
 end
 end
 end
end
end
end
return char109,HIDN0,char110
end
if ESPState.spearIsHoldingand not flag20.lockedthen
local Flag4,NDuxlDnvw,QZqzuNnNI=lvHDz()
if Flag4 then
flag20.locked=true;
flag20.lockedTarget=Flag4 flag20.lockedPlayerName=Flag4.Name;
flag20.currentNearestDist=QZqzuNnNI
end
end
if not ESPState.spearIsHolding then
flag20.locked=false;
flag20.lockedTarget=nil;
flag20.lockedPlayerName=""
end
local flag21=false
local flag22=nil
local flag23=0
local flag24=nil
if flag20.lockedand flag20.lockedTarget then
 local char114=flag20.lockedTarget.Characterif char114 then
 local char115=char114:FindFirstChildOfClass("Humanoid")
 local DxMnDox=MainState.ppmDZmUwpIop(char114)
 if DxMnDox and char115 and char115.Health>50 and not char114:GetAttribute("IsHooked")then
 local Nq0xn,l0lOop1=gui49:WorldToViewportPoint(DxMnDox)
 if l0lOop1 then
 local cam20=(Vector2.new(Nq0xn.X,Nq0xn.Y)-gui52).Magnitudeif cam20<=Settings.spearFovRadius*1.15 then
flag22=Vector2.new(Nq0xn.X,Nq0xn.Y)
flag23=char108 and(DxMnDox-char108.Position).Magnitudeor 0 flag24=DxMnDox;
flag21=true flag20.currentNearestDist=flag23
 end
 end
 end
 end
 if not flag21 then
flag20.locked=false;
flag20.lockedTarget=nil;
flag20.lockedPlayerName=""
 end
end
local cam21=nil
local gui53=0
local flag25=nil
local esp43=nil
if not flag20.lockedthen
local DxlXb,IuMqN1DNOlp,p0mQINu=lvHDz()
if DxlXb then
 local cam22=MainState.ppmDZmUwpIop(DxlXb.Character)
 local Hw0UQ,OuUuHnNN1o=gui49:WorldToViewportPoint(cam22)
cam21=Vector2.new(Hw0UQ.X,Hw0UQ.Y)
gui53=p0mQINu;
flag25=cam22 esp43=DxlXb;
flag20.currentNearestDist=p0mQINu
end
end
local gui54=false
if ESPState.spearIsHolding and ESPState.spearHoldStartTime and char108 then
 local part20=flag24 or(esp43 and MainState.ppmDZmUwpIop(esp43.Character))
 if part20 then
 local part21=gui49.CFrame.Position
 local part22=part20-part21
 local part23=Vector3.new(part22.X,0,part22.Z)
 local part24=part23.Magnitudelocal esp44=part22.Y
 local esp45=Workspace.Gravity*(ESPState.lastGravityMultor 1)
 local flag26=MainState.BQOObX(part24,esp44,esp45)
 if flag26 then
 local HZI__U=tick()-ESPState.spearHoldStartTimeif HZI__U>=flag26 then
gui54=true
 end
 end
 end
end
local Qoxwm=nil
local gui55=""
local gui56=0
if flag20.lockedand flag21 then
Qoxwm=flag22;
gui55=flag20.lockedPlayerName gui56=flag23
elseif cam21 then
Qoxwm=cam21;
gui55=esp43 and esp43.Nameor""gui56=gui53
end
local gui57=pcall(
function()
if not ESPState.SnapLineFrame or not ESPState.SnapLineDotor not ESPState.SnapLineTextLabelor not gui49 then
 if ESPState.SnapLineFramethen ESPState.SnapLineFrame.Visible=false
end
if ESPState.SnapLineDotthen ESPState.SnapLineDot.Visible=false
end
if ESPState.SnapLineTextLabelthen ESPState.SnapLineTextLabel.Visible=false
end
return
end
if not Qoxwm then
ESPState.SnapLineFrame.Visible=false;
ESPState.SnapLineDot.Visible=false ESPState.SnapLineTextLabel.Visible=false;
flag20.currentNearestDist=math.hugereturn
end
local NWO1I=gui52;
local gui58=Qoxwm
local gui59=gui58-NWO1I;
local gui60=gui59.Magnitude
if gui60<2 then
ESPState.SnapLineFrame.Visible=false;
ESPState.SnapLineDot.Visible=false ESPState.SnapLineTextLabel.Visible=false;
 return
end
local gui61=gui54
local gui62=gui61 and Color3.fromRGB(0,255,120)or Color3.fromRGB(255,220,0)
local gui63=gui61 and 0.08 or 0.35 ESPState.SnapLineFrame.BackgroundColor3=gui62 ESPState.SnapLineFrame.BackgroundTransparency=gui63 ESPState.SnapLineFrame.Size=UDim2.fromOffset(gui60,gui61 and2 or 1)ESPState.SnapLineFrame.Position=UDim2.fromOffset((NWO1I.X+gui58.X)*0.5,(NWO1I.Y+gui58.Y)*0.5)ESPState.SnapLineFrame.Rotation=math.deg(math.atan2(gui59.Y,gui59.X))ESPState.SnapLineFrame.Visible=true ESPState.SnapLineDot.BackgroundColor3=gui62 ESPState.SnapLineDot.Position=UDim2.fromOffset(gui58.X,gui58.Y)ESPState.SnapLineDot.Visible=true
if Settings.spearSnaplineShowText and gui55~=""then
ESPState.SnapLineTextLabel.Text=string.format("%s [%dm]",gui55,math.floor(gui56))ESPState.SnapLineTextLabel.TextColor3=gui62 ESPState.SnapLineTextLabel.Position=UDim2.fromOffset(gui58.X,gui58.Y-14)ESPState.SnapLineTextLabel.Visible=true
else ESPState.SnapLineTextLabel.Visible=false
end
end
)
if not gui57 then
 if ESPState.SnapLineFrame then
ESPState.SnapLineFrame.Visible=false
 end
 if ESPState.SnapLineDot then
ESPState.SnapLineDot.Visible=false
 end
 if ESPState.SnapLineTextLabelthen ESPState.SnapLineTextLabel.Visible=false
end
end
end
)CreateESPEntry("Spear_UpdateSpearSystem",0,
function()
if ESPState.SpearFOVCircle then
ESPState.SpearFOVCircle.Visible=ESPState.spearFovCircleEnabledlocal Tmp1=Settings.spearFovRadius*2
 if ESPState.SpearFOVCircle.Size.X.Offset~=Tmp1 then
ESPState.SpearFOVCircle.Size=UDim2.new(0,Tmp1,0,Tmp1)
 end
end
if not ESPState.silentSpearEnabled then
ESPState.silentSpearTargetTorso=nil;
ESPState.silentSpearLookVector=nil
end
local char116=LocalPlayer.Character
local flag27=char116 and char116:GetAttribute("spearmode")
if not ESPState.spearIndicatorEnabledor not flag27 then
 if ESPState.SpearIndicatorGui then
ESPState.SpearIndicatorGui.Enabled=false
 end
 if not ESPState.silentSpearEnabled or not flag27 then
 return
 end
end
local DDW1X=char116 and char116:FindFirstChild("HumanoidRootPart")
if not DDW1X then
 return
end
local p1oov=workspace.CurrentCameraif not p1oov then
 return
end
if ESPState.spearIndicatorEnabledand flag27 and ESPState.SpearIndicatorGuithen ESPState.SpearIndicatorGui.Enabled=true
end
local upxqloop=nil
local flag28=math.huge
local flag29=math.hugelocal flag30=false
local cam23=Vector2.new(p1oov.ViewportSize.X/2,p1oov.ViewportSize.Y/2)
for lWIHb_1,H_HUX0oZmvoxI in ipairs(Players.GetPlayers(Players))do
 if H_HUX0oZmvoxI~=LocalPlayer and GetPlayerRole(H_HUX0oZmvoxI)=="survivor"then
 local char117=H_HUX0oZmvoxI.Characterif char117 then
 local char118=char117:FindFirstChildOfClass("Humanoid")
 local char119=MainState.ppmDZmUwpIop(char117)
 local char120=char117:FindFirstChild("HumanoidRootPart")
 if char118 and char118.Health>50 and typeof(char119)=="Vector3"and char120 and not char117:GetAttribute("IsHooked")then
 local char121=(char119-DDW1X.Position).Magnitude
 local NuzNU,DxlO1=p1oov:WorldToViewportPoint(char119)
 if DxlO1 then
 local cam24=(Vector2.new(NuzNU.X,NuzNU.Y)-cam23).Magnitudeif cam24<=Settings.spearFovRadius then
 if cam24<flag28 then
flag28=cam24;
flag29=char121 upxqloop=H_HUX0oZmvoxI;
flag30=true
 end
 elseif not flag30 and char121<flag29 then
flag29=char121;
upxqloop=H_HUX0oZmvoxI
 end
 elseif not flag30 and char121<flag29 then
flag29=char121;
upxqloop=H_HUX0oZmvoxI
 end
 end
 end
 end
end
if upxqloop and upxqloop.Character then
 local char122=MainState.ppmDZmUwpIop(upxqloop.Character)
 if char122 then
flag30=MainState._vMo1mZ1l(p1oov,char122,Settings.spearFovRadius)
 end
end
if ESPState.spearIndicatorEnabled and flag27 then
 if not upxqloop or not upxqloop.Characterthen ESPState.SpearStatusText.Text="NO TARGET"ESPState.SpearStatusText.TextColor3=Color3.fromRGB(200,200,200)ESPState.SpearAccentBar.BackgroundColor3=Color3.fromRGB(80,80,80)ESPState.SpearInfoText.Text="Aim to Survivor";
 return
end
local color21=MainState.ppmDZmUwpIop(upxqloop.Character)
local part25=p1oov.CFrame.Position
local part26=color21-part25
local part27=Vector3.new(part26.X,0,part26.Z)
local gui64=part27.Magnitudelocal esp46=part26.Ylocal color22=part26.Magnitudelocal str8=Workspace.Gravity*(ESPState.lastGravityMultor 1)
local color23=MainState.BQOObX(gui64,esp46,str8)
local color24=upxqloop.Name
local color25=string.format("%.0f",color22)
if not color23 then
ESPState.SpearStatusText.Text="OUT OF RANGE"ESPState.SpearStatusText.TextColor3=Color3.fromRGB(255,80,80)ESPState.SpearAccentBar.BackgroundColor3=Color3.fromRGB(255,50,50)ESPState.SpearInfoText.Text=string.format("%s | %s studs",color24,color25)
elseif not flag30 then
ESPState.SpearStatusText.Text="AIM AT TARGET"ESPState.SpearStatusText.TextColor3=Color3.fromRGB(255,150,150)ESPState.SpearAccentBar.BackgroundColor3=Color3.fromRGB(255,100,100)
 local Color2,W0IlZNQMzHW_Iz=p1oov:WorldToViewportPoint(color21)
 local cam25=Vector2.new(p1oov.ViewportSize.X/2,p1oov.ViewportSize.Y/2)
 local cam26=(Vector2.new(Color2.X,Color2.Y)-cam25).Magnitude
 local o100vmw=string.format("%.0f",cam26-Settings.spearFovRadius)
 if not W0IlZNQMzHW_Iz then
ESPState.SpearInfoText.Text="Target di belakang kamera"
 else ESPState.SpearInfoText.Text=string.format("Masuk FOV: %s px lagi",o100vmw)
end
elseif not ESPState.spearIsHoldingthen ESPState.SpearStatusText.Text="READY"ESPState.SpearStatusText.TextColor3=Color3.fromRGB(255,255,255)ESPState.SpearAccentBar.BackgroundColor3=Color3.fromRGB(150,150,200)ESPState.SpearInfoText.Text=string.format("%s | %s studs | Hold: %ss",color24,color25,string.format("%.2f",color23))
else
local color26=tick()-ESPState.spearHoldStartTimelocal color27=string.format("%.2f",color26)
local color28=string.format("%.2f",color23)
local color29=MainState._vMo1mZ1l(p1oov,color21,Settings.spearFovRadius)
if not color29 then
ESPState.SpearStatusText.Text="AIM AT TARGET"ESPState.SpearStatusText.TextColor3=Color3.fromRGB(255,150,150)ESPState.SpearAccentBar.BackgroundColor3=Color3.fromRGB(255,100,100)ESPState.SpearInfoText.Text="Target keluar FOV!"
elseif color26>=color23 then
ESPState.SpearStatusText.Text="RELEASE!"ESPState.SpearStatusText.TextColor3=Color3.fromRGB(80,255,120)ESPState.SpearAccentBar.BackgroundColor3=Color3.fromRGB(50,255,100)ESPState.SpearInfoText.Text=string.format("Hold: %ss | Ideal: %ss",color27,color28)
else ESPState.SpearStatusText.Text="HOLD..."ESPState.SpearStatusText.TextColor3=Color3.fromRGB(255,220,100)ESPState.SpearAccentBar.BackgroundColor3=Color3.fromRGB(255,200,50)ESPState.SpearInfoText.Text=string.format("Hold: %ss | Ideal: %ss",color27,color28)
end
end
end
if ESPState.silentSpearEnabledand flag27 and upxqloop and upxqloop.Characterthen
local char123=MainState.ppmDZmUwpIop(upxqloop.Character)
local char124=upxqloop.Character:FindFirstChild("HumanoidRootPart")
if typeof(char123)=="Vector3"and char124 then
 local char125=MainState._vMo1mZ1l(p1oov,char123,Settings.spearFovRadius)
 if char125 then
 local val59=p1oov.CFrame.Positionlocal gui65=char123-val59
 local gui66=gui65.Magnitude
 if gui66>0.1 then
 local esp47=142.5
 if ESPState.spearIsHolding and ESPState.spearHoldStartTime then
 local esp48=tick()-ESPState.spearHoldStartTime
 if esp48>=2 then
esp47=165
 elseif esp48>=1 then
esp47=142.5
 else esp47=math.max(23,esp48*150)
 end
 end
 local esp49=Workspace.Gravity*(ESPState.lastGravityMultor 1)
 local val60=char124.AssemblyLinearVelocitylocal val61=Vector3.new(val60.X,0,val60.Z)
 if val61.Magnitude>65 then
val61=val61.Unit*65
 end
ESPState.silentSpearTargetVel=val61
 local ESP1,QnwzNlvHWXuwb0=MainState.MqHuIln(val59,char123,esp47,esp49)
 if ESP1 and QnwzNlvHWXuwb0 then
 local esp50=ESPState.silentSpearTargetVel*QnwzNlvHWXuwb0
 local esp51=char123+esp50
 local ESP2,QOvzmllUM=MainState.MqHuIln(val59,esp51,esp47,esp49)
 if ESP2 then
ESPState.silentSpearTargetTorso=esp51;
ESPState.silentSpearLookVector=ESP2
 else ESPState.silentSpearTargetTorso=nil;
ESPState.silentSpearLookVector=nil
 end
 else ESPState.silentSpearTargetTorso=nil;
ESPState.silentSpearLookVector=nil
end
else ESPState.silentSpearTargetTorso=nil;
ESPState.silentSpearLookVector=nil
end
else ESPState.silentSpearTargetTorso=nil;
ESPState.silentSpearLookVector=nil
end
else ESPState.silentSpearTargetTorso=nil;
ESPState.silentSpearLookVector=nil
end
else ESPState.silentSpearTargetTorso=nil;
ESPState.silentSpearLookVector=nil
end
end
)
end
do
 function MainState.bX_UINwW0NZ(HoHxxlzq,INxbwvxx_DNUw)
 if HoHxxlzq==LocalPlayer then
 return
 end
 if not INxbwvxx_DNUw or not INxbwvxx_DNUw.Parentor HoHxxlzq.Character~=INxbwvxx_DNUw then
 return
 end
esp27_func(HoHxxlzq,INxbwvxx_DNUw)Oqpmb(HoHxxlzq,INxbwvxx_DNUw)
 if Settings.hitboxEnabled then
task.wait(0.3)
 if HoHxxlzq.Character==INxbwvxx_DNUw and INxbwvxx_DNUw.Parent then
esp17_func(HoHxxlzq,INxbwvxx_DNUw)
 end
 end
 if Settings.hitboxEspEnabledthen esp21_func(HoHxxlzq,INxbwvxx_DNUw)
end
if ESPState.autoParryEnabledor(AP_State and AP_State.Enabled)then
 if AP_HookKiller then
AP_HookKiller(HoHxxlzq,INxbwvxx_DNUw)
 end
end
end
function MainState.NuMzNx(HpwX0vQxDo1Wpo)
if HpwX0vQxDo1Wpo==LocalPlayer then
 return
end
IsPlayerAlive(HpwX0vQxDo1Wpo)esp6_func(HpwX0vQxDo1Wpo)wxouub(HpwX0vQxDo1Wpo)HpwX0vQxDo1Wpo:GetPropertyChangedSignal("Team"):Connect(
function()IsPlayerAlive(HpwX0vQxDo1Wpo)task.wait(0.2)
if ESPState.autoParryEnabled or(AP_State and AP_State.Enabled)then
 if AP_HookKiller then
AP_HookKiller(HpwX0vQxDo1Wpo)
 end
end
end
)
if HpwX0vQxDo1Wpo.Characterthen task.spawn(
function()MainState.bX_UINwW0NZ(HpwX0vQxDo1Wpo,HpwX0vQxDo1Wpo.Character)
end
)
end
HpwX0vQxDo1Wpo.CharacterAdded:Connect(
function(MwZx_mq)task.spawn(
function()MainState.bX_UINwW0NZ(HpwX0vQxDo1Wpo,MwZx_mq)
end
)
end
)
end
function MainState.MnZvvMbQvnOzu(IuXvZp)MXwU1D0(IuXvZp)esp14_func(IuXvZp)
if IuXvZp.Character then
esp10_func(IuXvZp,IuXvZp.Character)
end
end
Players.PlayerAdded:Connect(MainState.NuMzNx)Players.PlayerRemoving:Connect(MainState.MnZvvMbQvnOzu)
for w0zmvpUIn,MND0WOn in ipairs(Players.GetPlayers(Players))do
 if MND0WOn~=LocalPlayer then
MainState.NuMzNx(MND0WOn)
 end
end
function MainState.pzZMm(ODOwMO)ESPState.HoldLockActive=false;
ESPState.godLastHP=nil ESPState.CV_HoldingPC=false;
ESPState.CV_HoldingMobile=false ResetCameraVeil()
if ESPState.CV_Enabled then
task.defer(TempFlag)
end
task.spawn(ox0Np,ODOwMO)
if ESPState.godEnabledthen task.wait(0.3);
esp5_func();
esp2_func()
end
if Settings.lockFovEnabledthen task.wait(0.1);
ESPState.originalFOV=nil;
MainState.BWQoHbUwlp0MZb(Settings.customFovValue)
end
if Settings.cameraZoomEnabledthen task.wait(0.1);
ESPState.originalMaxZoom=nil;
MainState.w_vnXUZ(Settings.cameraZoomValue)
end
end
if LocalPlayer.Character then
task.spawn(MainState.pzZMm,LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(
function(Nb_bQvlImbwUW)task.spawn(MainState.pzZMm,Nb_bQvlImbwUW)
end
)RunService.Heartbeat:Connect(
function(QpQDqWu)
for IXmHQmXHHqno=1,#ESPEntries do
 local conn28=ESPEntries[IXmHQmXHHqno]conn28.timer=conn28.timer+QpQDqWu
 if conn28.timer>=conn28.intervalthen conn28.timer=0 conn28.fn(QpQDqWu)
end
end
end
)MainState.p0WOU0IM=UILib:Window({Title="BOLONG-HUB",Image="84034353458936",Footer="Violence District",Author="Discord.gg/pWpgqVGxNK",Color=NotifyColor,Version=1,Search=true,})MainState.WXDOInoUOHpw=MainState.p0WOU0IM.AddTab(MainState.p0WOU0IM,{Name="Exclusive",Icon="sparkles"})MainState.uXo1oQQNM=MainState.p0WOU0IM.AddTab(MainState.p0WOU0IM,{Name="Killer",Icon="swords"})MainState.DO_nopuz=MainState.p0WOU0IM.AddTab(MainState.p0WOU0IM,{Name="Survivor",Icon="user"})MainState._Q_UQwvznNuxzH=MainState.p0WOU0IM.AddTab(MainState.p0WOU0IM,{Name="Visual",Icon="eye"})MainState.p0N1pxWHmq=MainState.p0WOU0IM.AddTab(MainState.p0WOU0IM,{Name="Misc",Icon="settings"})MainState.ODQQmq=MainState.p0WOU0IM.AddTab(MainState.p0WOU0IM,{Name="Config",Icon="save"})do
MainState.Mqqznm=MainState.WXDOInoUOHpw.AddSection(MainState.WXDOInoUOHpw,"Auto Parry",nil)MainState.Opoxb=MainState.Mqqznm.AddHStack(MainState.Mqqznm)MainState.Opoxb:AddToggle({Title="Auto Parry",Default=false,Callback=
 function(OqoZW)ESPState.autoParryEnabled=OqoZW
end
,})MainState.Opoxb:AddToggle({Title="Radius ESP",Default=false,Callback=
function(BW1HZvUHupMn)ESPState.autoParryRadiusEsp=BW1HZvUHupMn
if MainState.onDxz1o then
MainState.onDxz1o(BW1HZvUHupMn)
end
end
,})MainState.Mqqznm:AddSlider({Title="Parry Radius (Stud)",Min=4,Max=40,Default=11,Increment=1,Callback=
function(_ZNz0W_1)ESPState.autoParryRadius=_ZNz0W_1
end
,})MainState.BlDnnQHIqXvO=MainState.WXDOInoUOHpw.AddSection(MainState.WXDOInoUOHpw,"God Mode",nil)MainState.BlDnnQHIqXvO:AddParagraph({Title="God Mode",Content="Instant Heal + Anti Knock/Down.\nSangat Cocok Jika Digunakan Untuk Main Pistol-pistolan."})MainState.BlDnnQHIqXvO:AddToggle({Title="Enable God Mode",Default=false,Callback=
function(MoInqnm1_W)
if MoInqnm1_W then
esp2_func()
else esp5_func()
end
end
,})MainState.uWO1p1noQnlWm=MainState.WXDOInoUOHpw.AddSection(MainState.WXDOInoUOHpw,"Aim Lock (Legit)",nil)MainState.uWO1p1noQnlWm:AddToggle({Title="Enable Aim Lock",Default=false,Callback=
function(pwHM_pI_mU0)Settings.cameralockEnabled=pwHM_pI_mU0
if pwHM_pI_mU0 then
MainState.vMvvZ()
else MainState.Hq1wbQvMzoz()
end
end
,})MainState.uWO1p1noQnlWm:AddDropdown({Title="Target Type",Options={"Survivor","Killer"},Default="Survivor",Callback=
function(uUxQl)Settings.cameralockTargetType=uUxQl
end
,})MainState.uWO1p1noQnlWm:AddDropdown({Title="Aim Part",Options={"Torso","Head"},Default="Torso",Callback=
function(v0lz_olwppOvMO)Settings.cameralockAimPart=v0lz_olwppOvMO
end
,})MainState.uWO1p1noQnlWm:AddDropdown({Title="Lock Mode",Content="Recommended Use: Hold to Lock (PC: Right Click / Mobile: Slasher Attack Button)",Options={"Always Lock","Hold to Lock"},Default="Always Lock",Callback=
function(uunXv)Settings.cameralockLockMode=uunXv
end
,})MainState.uWO1p1noQnlWm:AddSlider({Title="Max Distance",Content="Maximum distance to lock target (studs)",Min=20,Max=700,Default=Settings.cameralockMaxDistance,Increment=5,Callback=
function(bMHXx_M0O_)Settings.cameralockMaxDistance=bMHXx_M0O_
end
,})MainState.uWO1p1noQnlWm:AddSlider({Title="Camera Smoothness",Min=0.01,Max=1,Default=Settings.cameralockSmoothness,Increment=0.01,Callback=
function(BmuH1ZbqWb_vw)Settings.cameralockSmoothness=BmuH1ZbqWb_vw
end
,})MainState.uvmnv=MainState.WXDOInoUOHpw.AddSection(MainState.WXDOInoUOHpw,"Camera Veil (Legit)",nil)MainState.uvmnv:AddToggle({Title="Camera Veil",Default=false,Callback=
function(omUvvM)Settings.cameraVeilEnabled=omUvvM
local flag31=pcall(
function()
if omUvvM then
GuiHolder()
else esp1_func()
end
end
)
if not flag31 then
Settings.cameraVeilEnabled=false ShowNotify("Camera Veil","Gagal mengaktifkan Camera Veil",2)
end
end
,})MainState.uvmnv:AddToggle({Title="SnapLine ESP",Default=false,Callback=
function(OUXwqZ)Settings.cameraVeilSnapLine=OUXwqZ
if not OUXwqZ then
 if ESPState.CV_SnapLine then
ESPState.CV_SnapLine.Visible=false
 end
 if ESPState.CV_SnapDot then
ESPState.CV_SnapDot.Visible=false
 end
end
end
,})MainState.WoM_lmuoD_0o=MainState.WXDOInoUOHpw.AddSection(MainState.WXDOInoUOHpw,"Crosshair",nil)MainState.WoM_lmuoD_0o:AddToggle({Title="Enable Crosshair",Default=false,Callback=
function(wHpbvZXX)MainState.Iw0_ov:SetEnabled(wHpbvZXX)
end
,})MainState.WoM_lmuoD_0o:AddDropdown({Title="Style / Model",Options=CROSSHAIR_STYLES,Default="Dot",Callback=
function(NDHwuN)MainState.Iw0_ov:SetStyle(NDHwuN)
end
,})MainState.WoM_lmuoD_0o:AddSlider({Title="Size",Min=1,Max=100,Default=20,Increment=1,Callback=
function(pz1moxHIvW)MainState.Iw0_ov:SetSize(pz1moxHIvW)
end
,})MainState.WoM_lmuoD_0o:AddSlider({Title="Opacity",Min=0,Max=100,Default=100,Increment=1,Callback=
function(QpW0MuX)MainState.Iw0_ov:SetOpacity(QpW0MuX/100)
end
,})MainState.WoM_lmuoD_0o:AddInput({Title="Position X (px)",Default="0",Placeholder="Offset from center (positive = right)",Callback=
function(lOMxw)
local num3=tonumber(lOMxw)
if num3 then
MainState.Iw0_ov.SetOffsetX(MainState.Iw0_ov,math.clamp(num3,-1000,1000))
end
end
,})MainState.WoM_lmuoD_0o:AddInput({Title="Position Y (px)",Default="0",Placeholder="Offset from center (positive = down)",Callback=
function(QDmx0zDW1)
local num4=tonumber(QDmx0zDW1)
if num4 then
MainState.Iw0_ov.SetOffsetY(MainState.Iw0_ov,math.clamp(num4,-1000,1000))
end
end
,})MainState.WoM_lmuoD_0o:AddColorPicker({Title="Crosshair Color",Default=Color3.fromRGB(255,255,255),Callback=
function(WW0XZ)MainState.Iw0_ov:SetColor(WW0XZ)
end
,})MainState.bI0nxwpvnN=MainState.WXDOInoUOHpw.AddSection(MainState.WXDOInoUOHpw,"Silent Spear (Veil)",nil)MainState.bI0nxwpvnN:AddParagraph({Title="Aim Guide",Content="[ID] Saat Indikator/Snapline berubah hijau atau menampilkan \"RELEASE\", itu adalah waktu paling akurat untuk melepaskan SPEAR (90% kena target jika target diam).\n\n[EN] When the Indicator/Snapline turns green or shows \"RELEASE\", it is the most accurate time to release the SPEAR (90% hit chance if the target is stationary)."})MainState.bI0nxwpvnN:AddToggle({Title="Silent Spear",Default=false,Callback=
function(WoDXOquvmOOw1)ESPState.silentSpearEnabled=WoDXOquvmOOw1
end
,})MainState.OplOpzllnHuMnb=MainState.bI0nxwpvnN.AddHStack(MainState.bI0nxwpvnN)MainState.oZwUx1zxp1v=MainState.bI0nxwpvnN.AddHStack(MainState.bI0nxwpvnN)MainState.OplOpzllnHuMnb:AddToggle({Title="FOV Circle",Default=false,Callback=
function(bqMu0bzmz0Qvop)ESPState.spearFovCircleEnabled=bqMu0bzmz0Qvop
end
,})MainState.OplOpzllnHuMnb:AddToggle({Title="Aim Indicator",Default=false,Callback=
function(QDDXHQQlX)ESPState.spearIndicatorEnabled=QDDXHQQlX
end
,})MainState.oZwUx1zxp1v:AddToggle({Title="SnapLine",Default=false,Callback=
function(Buxumn)ESPState.SPEAR_SNAPLINE.enabled=Buxumn
end
,})MainState.oZwUx1zxp1v:AddToggle({Title="Show Name/Studs",Default=true,Callback=
function(pXznlnqoZNW)Settings.spearSnaplineShowText=pXznlnqoZNW
end
,})MainState.bI0nxwpvnN:AddSlider({Title="Spear FOV Radius",Min=30,Max=500,Default=150,Step=5,Callback=
function(uXOuxINNU)Settings.spearFovRadius=uXOuxINNU
end
,})MainState.OpxnOIHWnOImW=MainState.WXDOInoUOHpw.AddSection(MainState.WXDOInoUOHpw,"Silent Aim (Twist of Fate)",nil)MainState.OpxnOIHWnOImW:AddToggle({Title="Silent Aim",Default=false,Callback=
function(bwImUDQXoqz01w)ESPState.silentAimEnabled=bwImUDQXoqz01w
end
,})MainState.unnpoH=MainState.OpxnOIHWnOImW.AddHStack(MainState.OpxnOIHWnOImW)MainState.unnpoH:AddToggle({Title="FOV Circle",Default=false,Callback=
function(lqmxbQ_mv)ESPState.silentAimFovVisible=lqmxbQ_mv
end
,})MainState.unnpoH:AddToggle({Title="Laser ESP",Default=false,Callback=
function(q1NnQUpX)ESPState.laserEspEnabled=q1NnQUpX
end
,})MainState.OpxnOIHWnOImW:AddSlider({Title="Aim FOV Radius",Min=30,Max=500,Default=150,Step=5,Callback=
function(_nIUNWm)Settings.silentAimFovRadius=_nIUNWm
end
,})
end
do
MainState.vx1OlOw=MainState.uXo1oQQNM.AddSection(MainState.uXo1oQQNM,"Hitbox Modifier",nil)MainState.vx1OlOw:AddToggle({Title="Enable Hitbox Modifier",Default=false,Callback=
 function(Ozq0nXOI)Settings.hitboxEnabled=Ozq0nXOI
 if Ozq0nXOI then
pIWIOMWp()
 else vXQHOzmuNXl()
end
end
,})MainState.blXvQx=MainState.vx1OlOw.AddSlider(MainState.vx1OlOw,{Title="Survivor Hitbox Size (%)",Content="Ukuran hitbox Survivor (100% = normal)",Min=100,Max=700,Default=100,Increment=5,Callback=
function(OXZQzq1l_HxWQ)Settings.survivorHitboxSize=OXZQzq1l_HxWQ
if Settings.hitboxEnabledthen pIWIOMWp()
end
end
,})MainState.BpZnQ1wbw1Nz=MainState.vx1OlOw.AddSlider(MainState.vx1OlOw,{Title="Killer Hitbox Size (%)",Content="Ukuran hitbox Killer (100% = normal)",Min=100,Max=700,Default=100,Increment=5,Callback=
function(WXZmZ_uIl)Settings.killerHitboxSize=WXZmZ_uIl
if Settings.hitboxEnabled then
pIWIOMWp()
end
end
,})MainState._HxmI=MainState.vx1OlOw.AddHStack(MainState.vx1OlOw)MainState._HxmI:AddButton({Title="Default",Callback=
function()MainState.blXvQx:Set(100);
MainState.BpZnQ1wbw1Nz.Set(MainState.BpZnQ1wbw1Nz,100)
if Settings.hitboxEnabledthen pIWIOMWp()
end
ShowNotify("Hitbox Preset","Reset ke Default (100%)",1.5)
end
,})MainState._HxmI:AddButton({Title="Big (200%)",Callback=
function()MainState.blXvQx:Set(200);
MainState.BpZnQ1wbw1Nz.Set(MainState.BpZnQ1wbw1Nz,200)
if Settings.hitboxEnabled then
pIWIOMWp()
end
ShowNotify("Hitbox Preset","Big Hitbox aktif (200%)",1.5)
end
,})MainState.vx1OlOw:AddToggle({Title="Enable Hitbox ESP",Default=false,Callback=
function(_uuXp)Settings.hitboxEspEnabled=_uuXp
if _uuXp then
pNzHND()
else esp25_func()
end
end
,})MainState.vx1OlOw:AddSlider({Title="Fill Transparency",Min=0,Max=100,Default=50,Increment=5,Callback=
function(QNOon)Settings.hitboxEspTransparency=QNOon/100
if not Settings.hitboxEspOutlineOnly then
WxWMzlH()
end
end
,})MainState.MqpZOwDQ1nZ=MainState.vx1OlOw.AddHStack(MainState.vx1OlOw)MainState.MqpZOwDQ1nZ:AddColorPicker({Title="Hitbox Survivor Color",Default=Settings.hitboxEspSurvivorColor,Callback=
function(_IwDIQxXQ)Settings.hitboxEspSurvivorColor=_IwDIQxXQ;
WxWMzlH()
end
,})MainState.MqpZOwDQ1nZ:AddColorPicker({Title="HitBox Killer Color",Default=Settings.hitboxEspKillerColor,Callback=
function(bIXDDvxZb1)Settings.hitboxEspKillerColor=bIXDDvxZb1;
WxWMzlH()
end
,})MainState.qIWWoZNx1v_b=MainState.uXo1oQQNM.AddSection(MainState.uXo1oQQNM,"Killer No Cooldown",nil)MainState.qIWWoZNx1v_b:AddToggle({Title="Enable No Cooldown Bypass",Content="Hidden, Abysswalker, Masked, More",Default=false,Callback=
function(uXDomMOO_OOo)
AntiAFKActive=uXDomMOO_OOo
if uXDomMOO_OOo then
RemoveESPEntry()
else ClearAllESP()
end
end
})MainState.BN1nvpWmHb=MainState.qIWWoZNx1v_b.AddHStack(MainState.qIWWoZNx1v_b)MainState.BN1nvpWmHb:AddButton({Title="Fire Corrupt (Abyss)",Callback=
function()pcall(
function()
local remote15=game:GetService("ReplicatedStorage").Remotes.Killers.Abysswalker.corruptlxunQ:FireServer()
end
)
end
})MainState.BN1nvpWmHb:AddButton({Title="Fire Slash (Abyss)",Callback=
function()pcall(
function()
local remote16=game:GetService("ReplicatedStorage").Remotes.Attacks.BasicAttackBWmqXX:FireServer(true)
end
)
end
})MainState._MxlZloZbMNlX=MainState.qIWWoZNx1v_b.AddHStack(MainState.qIWWoZNx1v_b)MainState._MxlZloZbMNlX:AddButton({Title="Fire Leap (Hidden)",Callback=
function()pcall(
function()
local remote17=game:GetService("ReplicatedStorage").Remotes.Killers.Hidden.LeapN0pxXlzxOQ:FireServer(true)
end
)
end
})MainState._MxlZloZbMNlX:AddButton({Title="Fire M2 (Hidden)",Callback=
function()pcall(
function()
local remote18=game:GetService("ReplicatedStorage").Remotes.Killers.Hidden.M2 remote18:FireServer({},false)
end
)
end
})MainState.OupN1u_wmZpzn=MainState.uXo1oQQNM.AddSection(MainState.uXo1oQQNM,"Masked Skill Spammer",nil)MainState.Wqm1UMUv="Cobra"MainState.OupN1u_wmZpzn.AddDropdown(MainState.OupN1u_wmZpzn,{Title="Select Mask Power",Options={"Alex","Brandon","Cobra","Rabbit","Richter","Tony"},Default="Cobra",Callback=
function(N_ZDWopxpxoUH)MainState.Wqm1UMUv=N_ZDWopxpxoUH
end
})MainState.DnpuM=MainState.OupN1u_wmZpzn.AddHStack(MainState.OupN1u_wmZpzn)MainState.DnpuM:AddButton({Title="Activate Power",Callback=
function()pcall(
function()
local remote19=game:GetService("ReplicatedStorage").Remotes.Killers.Masked.ActivatepowerQpuXmbb0wH:FireServer(MainState.Wqm1UMUv)
end
)ShowNotify("Masked","Power Activated: "..MainState.Wqm1UMUv,1.5)
end
})MainState.DnpuM:AddButton({Title="Deactivate Power",Callback=
function()pcall(
function()
local remote20=game:GetService("ReplicatedStorage").Remotes.Killers.Masked.Deactivatepower remote20:FireServer()
end
)ShowNotify("Masked","Power Deactivated",1.5)
end
})MainState.HoZvH=MainState.uXo1oQQNM.AddSection(MainState.uXo1oQQNM,"Anti Blind",nil)MainState.HoZvH:AddToggle({Title="Anti Flashlight Blind",Content="Mencegah kamu terkena efek buta (Blinded) dari senter Survivor",Default=false,Callback=
function(vZpupHuOXNMx)Settings.antiBlindEnabled=vZpupHuOXNMx
end
,})MainState.oz_H1NbwmH_wM=MainState.uXo1oQQNM.AddSection(MainState.uXo1oQQNM,"Anti Looping",nil)MainState.oz_H1NbwmH_wM:AddToggle({Title="Anti Loop Window",Content="Membuat semua window di map tidak bisa digunakan untuk looping",Default=false,Callback=
function(uQqmnvUqoID)ESPState.antiLoopWindowEnabled=uQqmnvUqoID
if uQqmnvUqoID then
vlmOH1_X()
else remote1_func()
end
end
})MainState.oz_H1NbwmH_wM:AddButton({Title="Auto Drop All Pallets",Callback=
function()esp33_func()
end
})
end
do
MainState.w_IX1=MainState.DO_nopuz.AddSection(MainState.DO_nopuz,"Auto Generator",nil)MainState.w_IX1:AddToggle({Title="Auto Generator",Default=Settings.autoGenerator,Callback=
 function(OWllluOD)Settings.autoGenerator=OWllluOD
end
,})MainState.w_IX1:AddDropdown({Title="Mode",Content="Normal = safe zone | Perfect = zona Perfect | Instant = 😈 | Random = Succes/Neutral",Options={"Instant","Perfect","Normal","Random"},Default=Settings.autoGeneratorMode,Callback=
function(v_Z_QZlWnxZmU)Settings.autoGeneratorMode=v_Z_QZlWnxZmU
end
,})MainState.lzoOZm=MainState.DO_nopuz.AddSection(MainState.DO_nopuz,"Anti Fall Slow",nil)MainState.lzoOZm:AddToggle({Title="Anti Fall Slow",Content="Mencegah karakter melambat saat mendarat / jatuh dari ketinggian berapa pun",Default=false,Callback=
function(Wxz1Zw1Mp)ESPState.AntiFallSlow=Wxz1Zw1Mp
local char126=LocalPlayer.Characterlocal wuvbv1=char126 and char126:FindFirstChildOfClass("Humanoid")
if Wxz1Zw1Mp then
esp11_func(wuvbv1)
else vZW11Xq1xZD_(wuvbv1)
end
end
,})MainState._pnvvou0uvl1Mz=MainState.DO_nopuz.AddSection(MainState.DO_nopuz,"Movement Modification",nil)MainState._pnvvou0uvl1Mz:AddToggle({Title="No Slowdown",Default=false,Callback=
function(qwwomlzo_zu)ESPState.NoSlowdown=qwwomlzo_zu
local char127=LocalPlayer.Character
local char128=char127 and char127:FindFirstChildOfClass("Humanoid")
if qwwomlzo_zu then
vqQoXU(char128)
else _StopNoSlowdown()
end
end
,})MainState._pnvvou0uvl1Mz:AddToggle({Title="Speed Boost",Default=false,Callback=
function(HX1mDmbDQ)ESPState.SpeedBoostInit=HX1mDmbDQ
if not HX1mDmbDQ then
 local char129=LocalPlayer.Characterlocal char130=char129 and char129:FindFirstChildOfClass("Humanoid")
 if char130 then
qNMQXII(char130,MagicConst)
 end
else
local char131=LocalPlayer.Characterlocal char132=char131 and char131:FindFirstChildOfClass("Humanoid")
if not ESPState.safeModeSpeedor(char132 and char132.Health>50 and not(char131:GetAttribute("IsHooked")or char131:GetAttribute("IsCarried")))then
qNMQXII(char132,esp18_func())
end
end
end
,})MainState._pnvvou0uvl1Mz:AddToggle({Title="Safe Mode (Speed)",Content="Speed Boost & No Slowdown otomatis nonaktif saat Knockdown, Hook, dll.",Default=true,Callback=
function(_1HHmI0ooN)ESPState.safeModeSpeed=_1HHmI0ooN
end
,})MainState._pnvvou0uvl1Mz:AddSlider({Title="Boost Amount (%)",Min=0,Max=100,Default=50,Callback=
function(qpbQoMuNNlw1w)ESPState.BoostPercent=qpbQoMuNNlw1w
end
,})MainState.DzNvHWmzIxDmmu=MainState.DO_nopuz.AddSection(MainState.DO_nopuz,"Auto Crouch (Abyss)",nil)MainState.DzNvHWmzIxDmmu:AddToggle({Title="Auto Crouch",Default=false,Callback=
function(_npU_pDIxzxuHU)Settings.autoCrouchEnabled=_npU_pDIxzxuHU
if not _npU_pDIxzxuHU then
MainState.uuMqxOzluob(false)
end
end
})MainState.DzNvHWmzIxDmmu:AddSlider({Title="Crouch Radius (Stud)",Min=4,Max=40,Default=18,Increment=1,Callback=
function(O0zwIbuImDZZu)Settings.autoCrouchRadius=O0zwIbuImDZZu
end
,})MainState.vlIOU10MzvW=MainState.DO_nopuz.AddSection(MainState.DO_nopuz,"Auto Drop Nearby Pallet",nil)MainState.vlIOU10MzvW:AddToggle({Title="Auto Drop Nearby Pallet",Default=false,Callback=
function(BQWOMlDOM1Il)ESPState.autoDropNearbyPallets=BQWOMlDOM1Il
if BQWOMlDOM1Il then
ESPState.palletPointsCache=nil
end
end
})MainState.Ox_OoNDZDOUplX=MainState.DO_nopuz.AddSection(MainState.DO_nopuz,"Moonwalk",nil)MainState.Ox_OoNDZDOUplX:AddToggle({Title="Enable Moonwalk (Mobile GUI)",Default=false,Callback=
function(WOlQub0IInIp0)Settings.moonwalkEnabled=WOlQub0IInIp0
if WOlQub0IInIp0 then
NubHIl()
 if ESPState.moonwalkGuithen ESPState.moonwalkGui.Enabled=true
end
else
if ESPState.moonwalkGuithen ESPState.moonwalkGui.Enabled=false
end
ESPState.moonwalkMobileDir=0 HM1uHIZZl0.moonwalkPCForward=false ESPState.moonwalkPCBackward=false
end
end
})MainState.Ox_OoNDZDOUplX:AddKeybind({Title="PC Lock Forward Key",Default=Enum.KeyCode.Unknown,Callback=
function()
if Settings.moonwalkEnabled then
ESPState.moonwalkPCForward=not ESPState.moonwalkPCForward
 if ESPState.moonwalkPCForwardthen ESPState.moonwalkPCBackward=false
end
end
end
})MainState.Ox_OoNDZDOUplX:AddKeybind({Title="PC Lock Backward Key",Default=Enum.KeyCode.Unknown,Callback=
function()
if Settings.moonwalkEnabled then
ESPState.moonwalkPCBackward=not ESPState.moonwalkPCBackwardif ESPState.moonwalkPCBackward then
ESPState.moonwalkPCForward=false
 end
end
end
})MainState.WZpWIzxOMuD=MainState.DO_nopuz.AddSection(MainState.DO_nopuz,"Escape Gate",nil)MainState.WZpWIzxOMuD:AddButton({Title="Auto Escape (Teleport)",Callback=
function()MainState._XDNw()
end
})MainState.WZpWIzxOMuD:AddToggle({Title="Ghost Gate (Legit Mode)",Default=false,Callback=
function(ImZMoux)ESPState.ghostGateEnabled=ImZMoux MainState.lHZlWupp()
end
})MainState.OmlqwO0Z=MainState.DO_nopuz.AddSection(MainState.DO_nopuz,"Lock FOV",nil)MainState.OmlqwO0Z:AddToggle({Title="Lock FOV",Default=Settings.lockFovEnabled,Callback=
function(pzQXnNU0_lH)Settings.lockFovEnabled=pzQXnNU0_lH
if pzQXnNU0_lH then
MainState.BWQoHbUwlp0MZb(Settings.customFovValue)
else MainState.bxOlDXWlooNM()
end
end
,})MainState.OmlqwO0Z:AddSlider({Title="FOV Value",Min=30,Max=120,Default=Settings.customFovValue,Increment=1,Callback=
function(qHwMWp0vwvp)Settings.customFovValue=qHwMWp0vwvp
if Settings.lockFovEnabledthen MainState.BWQoHbUwlp0MZb(qHwMWp0vwvp)
end
end
,})
end
do
MainState.NvOXM=MainState._Q_UQwvznNuxzH.AddSection(MainState._Q_UQwvznNuxzH,"Killer ESP",nil)MainState.pwQOzxOmU00Oq=MainState.NvOXM.AddHStack(MainState.NvOXM)MainState.pwQOzxOmU00Oq:AddToggle({Title="Show Name",Default=Settings.killerShowName,Callback=
 function(vqubnXmvXI)Settings.killerShowName=vqubnXmvXI;
esp30_func()
end
,})MainState.pwQOzxOmU00Oq:AddToggle({Title="Show Outline",Default=Settings.killerShowOutline,Callback=
function(HWXWbMQo)Settings.killerShowOutline=HWXWbMQo;
esp30_func()
end
,})MainState.NvOXM:AddColorPicker({Title="Killer Color",Default=Settings.killerColor,Callback=
function(qWwbub_lpU1)Settings.killerColor=qWwbub_lpU1;
esp30_func()
end
,})MainState.vIZuUHO1=MainState._Q_UQwvznNuxzH.AddSection(MainState._Q_UQwvznNuxzH,"Survivor ESP",nil)MainState.loHWU=MainState.vIZuUHO1.AddHStack(MainState.vIZuUHO1)MainState.loHWU:AddToggle({Title="Show Name",Default=Settings.survivorShowName,Callback=
function(uz1wZNHpoQzZ1I)Settings.survivorShowName=uz1wZNHpoQzZ1I;
esp30_func()
end
,})MainState.loHWU:AddToggle({Title="Show Outline",Default=Settings.survivorShowOutline,Callback=
function(vQqmuZHD)Settings.survivorShowOutline=vQqmuZHD;
esp30_func()
end
,})MainState.vIZuUHO1:AddColorPicker({Title="Survivor Color",Default=Settings.survivorColor,Callback=
function(wzZmD0_uOvHUn)Settings.survivorColor=wzZmD0_uOvHUn;
esp30_func()
end
,})MainState.vlbbmUHO0DqzX=MainState._Q_UQwvznNuxzH.AddSection(MainState._Q_UQwvznNuxzH,"Show Item Survivor",nil)MainState.vlbbmUHO0DqzX:AddToggle({Title="Show Equipped Item",Default=false,Callback=
function(p1zvlbW)Settings.espItemEnabled=p1zvlbW
end
,})MainState.MQOoHpooND=MainState._Q_UQwvznNuxzH.AddSection(MainState._Q_UQwvznNuxzH,"Outline Settings",nil)MainState.MQOoHpooND:AddToggle({Title="Outline Only",Content="Tampilkan outline saja tanpa fill (berlaku untuk Killer & Survivor)",Default=Settings.killerOutlineOnly,Callback=
function(bXMOOon)Settings.killerOutlineOnly=bXMOOon;
Settings.survivorOutlineOnly=bXMOOon esp30_func()
end
,})MainState.qwXOxuX=MainState._Q_UQwvznNuxzH.AddSection(MainState._Q_UQwvznNuxzH,"Object ESP",nil)MainState.bwZzbozHD=MainState.qwXOxuX.AddHStack(MainState.qwXOxuX)MainState.bwZzbozHD:AddToggle({Title="ESP Generator",Default=Settings.espGeneratorEnabled,Callback=
function(q1uDuD10X0HH_u)Settings.espGeneratorEnabled=q1uDuD10X0HH_u;
esp22_func()
end
,})MainState.bwZzbozHD:AddToggle({Title="Progress Gen",Default=Settings.espGeneratorProgressGen,Callback=
function(BIWbZZNnpOwXWv)Settings.espGeneratorProgressGen=BIWbZZNnpOwXWv
for _1WmxNbNzI0wz_,uIpD1QXm in ipairs(ESPState.cachedMapObjects.Generators)do
 if uIpD1QXm and uIpD1QXm.Parentthen uIpD1QXm:SetAttribute("__BolongGenLastPct__",nil)
 if not BIWbZZNnpOwXWv then
 local inst134=uIpD1QXm:FindFirstChild("__BolongGenProgress__")
 if inst134 then
inst134.Destroy(inst134)
 end
 end
end
end
esp22_func()
end
,})MainState.qwXOxuX:AddToggle({Title="Show Generator Info",Default=Settings.espGenShowPK,Content="Player & Break",Callback=
function(NMIv0lNxwIoq)Settings.espGenShowPK=NMIv0lNxwIoq
for HvInNnz,ln0_pIZQu1W in ipairs(ESPState.cachedMapObjects.Generators)do
 if ln0_pIZQu1W and ln0_pIZQu1W.Parent then
ln0_pIZQu1W:SetAttribute("__BolongGenLastPct__",nil)
 end
end
end
,})MainState.MN0XuxIQDDnl=MainState.qwXOxuX.AddHStack(MainState.qwXOxuX)MainState.MN0XuxIQDDnl:AddToggle({Title="ESP Window",Default=Settings.espWindowEnabled,Callback=
function(IbnIbWnQw)Settings.espWindowEnabled=IbnIbWnQw esp22_func()
end
,})MainState.MN0XuxIQDDnl:AddToggle({Title="ESP Pallet",Default=Settings.espPalletEnabled,Callback=
function(wMZx_0__MIuDZ)Settings.espPalletEnabled=wMZx_0__MIuDZ;
esp22_func()
end
,})MainState.wlWM_qQbD=MainState.qwXOxuX.AddHStack(MainState.qwXOxuX)MainState.wlWM_qQbD:AddToggle({Title="ESP Hook",Default=Settings.espHookEnabled,Callback=
function(NlNllmM0oWqp)Settings.espHookEnabled=NlNllmM0oWqp;
esp22_func()
end
,})MainState.wlWM_qQbD:AddToggle({Title="ESP Gate",Default=Settings.espGateEnabled,Callback=
function(bOlI1m1Xm)Settings.espGateEnabled=bOlI1m1Xm;
esp22_func()
end
,})MainState.uMUI0QpIl=MainState.qwXOxuX.AddHStack(MainState.qwXOxuX)MainState.uMUI0QpIl:AddColorPicker({Title="Generator Color",Default=Settings.espGeneratorColor,Callback=
function(voH1Q1O1Zw)Settings.espGeneratorColor=voH1Q1O1Zw
if Settings.espGeneratorEnabledthen
for HxbWnI11z,W0xbx in ipairs(ESPState.cachedMapObjects.Generators)do
 if W0xbx and W0xbx.Parent then
 local esp52=W0xbx:FindFirstChild("__BolongHL__")
 if esp52 then
esp52.FillColor=voH1Q1O1Zw;
esp52.OutlineColor=voH1Q1O1Zw
 end
 end
end
end
end
,})MainState.uMUI0QpIl:AddColorPicker({Title="Window Color",Default=Settings.espWindowColor,Callback=
function(NoXbob)Settings.espWindowColor=NoXbob
for HU0WzpN1Hbb_Z,wqvWQNlmlXp1z in pairs(ESPState.windowEspObjects)do
 if wqvWQNlmlXp1z and wqvWQNlmlXp1z.Parentthen pcall(
 function()wqvWQNlmlXp1z.Color3=NoXbob
end
)
end
end
end
,})MainState.NMXN0uvm=MainState.qwXOxuX.AddHStack(MainState.qwXOxuX)MainState.NMXN0uvm:AddColorPicker({Title="Pallet Color",Default=Settings.espPalletColor,Callback=
function(Bn_00)Settings.espPalletColor=Bn_00
for Ww1oxIwuOp,HDlwqHn in ipairs(ESPState.cachedMapObjects.Pallets)do
 if HDlwqHn then
 local esp53=HDlwqHn:FindFirstChild("__BolongHL__")
 if esp53 then
esp53.FillColor=Bn_00;
esp53.OutlineColor=Bn_00
 end
 end
end
end
,})MainState.NMXN0uvm:AddColorPicker({Title="Hook Color",Default=Settings.espHookColor,Callback=
function(DQppNwUwoZonn)Settings.espHookColor=DQppNwUwoZonn
for wNbz1IOzoNH,MNuMZD_UNozz in ipairs(ESPState.cachedMapObjects.Hooks)do
 if MNuMZD_UNozz and MNuMZD_UNozz.Parentthen
 local esp54=ESPState.cachedHookMeshParts[MNuMZD_UNozz]
 if esp54 then
 for QzzqQOlvmoxbqX,qDbQWxMlN_ in ipairs(esp54)do
 local esp55=qDbQWxMlN_:FindFirstChild("__BolongHL__")
 if esp55 then
esp55.FillColor=DQppNwUwoZonn;
esp55.OutlineColor=DQppNwUwoZonn
 end
 end
 end
end
end
end
,})MainState.bWnD000QvNl=MainState.qwXOxuX.AddHStack(MainState.qwXOxuX)MainState.bWnD000QvNl:AddColorPicker({Title="Gate Color",Default=Settings.espGateColor,Callback=
function(O1UN1lZX)Settings.espGateColor=O1UN1lZX
for lZQzuMbno,oIWxwzwbOQ in ipairs(ESPState.cachedMapObjects.Gates)do
 if oIWxwzwbOQ and oIWxwzwbOQ.Parent then
 local esp56=oIWxwzwbOQ:FindFirstChild("__BolongHL__")
 if esp56 then
esp56.FillColor=O1UN1lZX;
esp56.OutlineColor=O1UN1lZX
 end
 end
end
end
,})MainState.bXI_Dz0vqn=MainState._Q_UQwvznNuxzH.AddSection(MainState._Q_UQwvznNuxzH,"Prediction Map&Killer",nil)MainState.bXI_Dz0vqn:AddToggle({Title="Show Prediction Monitor",Default=false,Callback=
function(vbomNWnIn)
if vbomNWnIn then
MainState.HuQnoUuWpwo()
else MainState.lboDUI()
end
end
,})MainState.vmo_0N=MainState._Q_UQwvznNuxzH.AddSection(MainState._Q_UQwvznNuxzH,"World Settings",nil)MainState.vmo_0N:AddToggle({Title="Fullbright",Default=false,Callback=
function(MINOIvOXwOlxwz)ESPState.fullbrightEnabled=MINOIvOXwOlxwz
if MINOIvOXwOlxwz then
MainState.p_01zM1nQ()
else MainState.un10pxvlDoWQlp()
end
end
,})MainState.vmo_0N:AddToggle({Title="Remove Visual Effects",Content="BoostFps",Default=false,Callback=
function(_WvWZDm)ESPState.removeVfxEnabled=_WvWZDm
if _WvWZDm then
MainState.NZ0MOpIIxM_0()
else MainState.WwMOwDZWQxwXD()
end
end
,})
end
do
MainState.BHWwUOqxM=MainState.p0N1pxWHmq.AddSection(MainState.p0N1pxWHmq,"Anti AFK",nil)MainState.BHWwUOqxM:AddToggle({Title="Enable Anti AFK",Default=false,Callback=
 function(vWz_pZnWxv)SetupAntiAFK(vWz_pZnWxv)
end
,})MainState.ol_p1qopNxquwo=MainState.p0N1pxWHmq.AddSection(MainState.p0N1pxWHmq,"Killer Warn",nil)MainState.ol_p1qopNxquwo:AddToggle({Title="Enable Killer Warn",Content="The ! sign above your head when the killer is around you",Default=Settings.warnEnabled,Callback=
function(bplwwZI)Settings.warnEnabled=bplwwZI
end
,})MainState.loXWx0_lU_0H=MainState.p0N1pxWHmq.AddSection(MainState.p0N1pxWHmq,"Performance Monitor",nil)MainState.loXWx0_lU_0H:AddToggle({Title="Show Performance Window",Default=false,Callback=
function(Q1XMnDoIOQunD)
if Q1XMnDoIOQunD then
MainState.lUwpXW()
else MainState.p_X0zlUul()
end
end
,})MainState._MvbqpNQIo_X1I=MainState.p0N1pxWHmq.AddSection(MainState.p0N1pxWHmq,"Camera Zoom",nil)MainState._MvbqpNQIo_X1I:AddToggle({Title="Max Camera Zoom",Default=Settings.cameraZoomEnabled,Callback=
function(HMW0U)Settings.cameraZoomEnabled=HMW0U
if HMW0U then
MainState.w_vnXUZ(Settings.cameraZoomValue)
else MainState.Ww1z_Ob0vX()
end
end
,})MainState.u__Q_xlxpoxwxO=MainState.p0N1pxWHmq.AddSection(MainState.p0N1pxWHmq,"Force Cursor (PC Only)",nil)MainState.IlQXmXmuW=MainState.u__Q_xlxpoxwxO.AddToggle(MainState.u__Q_xlxpoxwxO,{Title="Force Mouse Cursor",Content="Forces the mouse cursor to always appear on the screen.",Default=false,Callback=
function(OIuvD)Settings.forceCursorEnabled=OIuvD
if OIuvD then
MainState.vvw0v_lDxx()ShowNotify("Force Cursor","Mouse cursor forced to appear!",2)
else MainState.Bu0oXoOlbI()
end
end
,})MainState.u__Q_xlxpoxwxO:AddKeybind({Title="Toggle Keybind",Default=Enum.KeyCode.Y,Callback=
function()
local tgl1=not Settings.forceCursorEnabledMainState.IlQXmXmuW:Set(tgl1)
end
})do
 local flag32=bit32.band(23,0)
 local flag33=bit32.bor(flag32,110)-110
end
MainState.MnDwxvu=MainState.p0N1pxWHmq.AddSection(MainState.p0N1pxWHmq,"Protect Name",nil)MainState.MnDwxvu:AddToggle({Title="Enable Protect Name",Default=false,Callback=
function(BnlOmXmbozz)
if BnlOmXmbozz then
MainState.QwZpNwn()
else MainState.lOqqxMquzxn_()
end
end
,})MainState.OppMnHnZv=MainState.p0N1pxWHmq.AddSection(MainState.p0N1pxWHmq,"Skip Cutscene",nil)MainState.NzXpUbznz=false MainState.bxUOQ=MainState.OppMnHnZv.AddToggle(MainState.OppMnHnZv,{Title="Skip End Screen",Default=false,Callback=
function(Dm1IuI0oDn)
if MainState.NzXpUbznz then
 return
end
Settings.skipEndScreenEnabled=Dm1IuI0oDn
if Dm1IuI0oDn then
MainState.NzXpUbznz=true Settings.skipLoadEndScreenEnabled=false
 if MainState.pXHb0oo then
MainState.pXHb0oo.Set(MainState.pXHb0oo,false)
 end
MainState.NzXpUbznz=false MainState.Wb0x1XpWv()MainState.oqWmXqpHU(false)
else MainState.Wb0x1XpWv()
end
end
,})MainState.pXHb0oo=MainState.OppMnHnZv.AddToggle(MainState.OppMnHnZv,{Title="Skip Loading & End Screen",Default=false,Callback=
function(pmnozwuqZwwUQ)
if MainState.NzXpUbznz then
 return
end
Settings.skipLoadEndScreenEnabled=pmnozwuqZwwUQ
if pmnozwuqZwwUQ then
MainState.NzXpUbznz=true Settings.skipEndScreenEnabled=false
 if MainState.bxUOQ then
MainState.bxUOQ.Set(MainState.bxUOQ,false)
 end
MainState.NzXpUbznz=false MainState.Wb0x1XpWv()MainState.oqWmXqpHU(true)
else MainState.Wb0x1XpWv()
end
end
,})MainState.NN_xb=MainState.p0N1pxWHmq.AddSection(MainState.p0N1pxWHmq,"Avatar Copy (Visual)",nil)MainState.NN_xb:AddPresetManager({Title="Profile Avatar By Username / ID",Placeholder="Jandel / 1234...",Default="",Presets={Boy1="kiicaine",Boy2="444jamesss",Boy3="KiLouo14",Girl1="9kinb",Girl2="winterilous",Girl3="ellea_893"},Callback=
function(uD_xIzH_)
currentAvatarInput=uD_xIzH_
end
})MainState.NN_xb:AddButton({Title="Copy Avatar",Callback=
function()
if currentAvatarInput and currentAvatarInput~=""then
MainState.vzImqwp(currentAvatarInput)
else ShowNotify("BolongHub","Masukkan Username/ID terlebih dahulu!",2)
end
end
})MainState.WHZomMMH=MainState.ODQQmq.AddSection(MainState.ODQQmq,"Configuration",true)MainState.WHZomMMH:AddConfig()
end
print("BOLONGHUB LOADED!")
