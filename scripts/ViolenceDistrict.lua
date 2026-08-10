local MainState = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")
local GuiService = game:GetService("GuiService")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local UIS2 = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local RadAngle30 = math.rad(30)
local RadAngle45 = math.rad(45)
local Angle42 = math.rad(42)
local Angle28 = math.rad(28)
local Angle18 = math.rad(18)
local Angle72 = math.rad(72)
local MinClamp = -0.95
local MaxClamp = 0.95
local Gravity = Workspace.Gravity
local DefaultHeight = 2
local DefaultSpeed = 1.5
local SmallOffset = 0.15
local DefaultCount = 3
local UILib = loadstring(game:HttpGet("https://raw.githubusercontent.com/pozzi300-droid/violence-script/main/libs/b0lngUi.lua"))()
local ScriptVersion = "v4.1.1"
local NotifyColor = Color3.fromRGB(255, 255, 255)
local function ShowNotify(Title, Message, Duration) UILib:MakeNotify({ Title = Title or "BOLONG-HUB", Description = "Info", Content = Message or "", Color = NotifyColor, Time = 0.4, Delay = Duration or 2,})
end
local Settings = { killerShowName = false, killerShowOutline = true, killerOutlineOnly = true, killerColor = Color3.fromRGB(255, 60, 60), survivorShowName = false, survivorShowOutline = true, survivorOutlineOnly = true, survivorColor = Color3.fromRGB(60, 200, 255), maxDistance = 500, fillTransparency = 0.6, cameraZoomEnabled = false, cameraZoomValue = 1000, warnEnabled = false, warnDist1 = 60, warnDist2 = 40, warnDist3 = 20, customFovValue = 70, lockFovEnabled = false, autoGenerator = true, autoGeneratorMode = "Instant", espGenShowPK = false, cameralockEnabled = false, cameralockTargetType = "All", cameralockMaxDistance = 700, cameralockSmoothness = 1, cameralockLockMode = "Always Lock", cameralockAimPart = "Torso", hitboxEnabled = false, survivorHitboxSize = 100, killerHitboxSize = 100, hitboxEspEnabled = false, hitboxEspSurvivorColor = Color3.fromRGB(0, 255, 120), hitboxEspKillerColor = Color3.fromRGB(255, 60, 60), hitboxEspTransparency = 0.5, hitboxEspOutlineOnly = false, espGeneratorEnabled = false, espGeneratorProgressGen = false, espGeneratorColor = Color3.fromRGB(200, 100, 0), espWindowEnabled = false, espWindowColor = Color3.fromRGB(255, 223, 0), espPalletEnabled = false, espPalletColor = Color3.fromRGB(53, 189, 166), espHookEnabled = false, espHookColor = Color3.fromRGB(252, 116, 116), espGateEnabled = false, espGateColor = Color3.fromRGB(255, 255, 255), cameraVeilEnabled = false, cameraVeilSnapLine = false, cameraVeilMaxDistance = 175, cameraVeilSmoothness = 1, cameraVeilSpearSpeed = 220, cameraVeilGravityMult = 1, cameraVeilTargetType = "Survivor", skipEndScreenEnabled = false, skipLoadEndScreenEnabled = false, silentAimFovRadius = 150, spearFovRadius = 150, spearSnaplineMaxDistance = 400, spearSnaplineShowText = true, autoCrouchEnabled = false, autoCrouchRadius = 18, antiBlindEnabled = false, espItemEnabled = false, forceCursorEnabled = false, moonwalkEnabled = false,}
local ESPState = { espObjects = {}, outlineObjects = {}, playerRoles = {}, playerTeamConns = {}, playerCharConns = {}, cachedMapObjects = { Generators = {}, Pallets = {}, Hooks = {}, Gates = {}}, cachedPalletMeta = {}, cachedHookMeshParts = {}, completedGenerators = {}, genIndices = {}, nextGenIndex = 1, objEspInitialized = false, windowEspObjects = {}, NoSlowdown = false, SpeedBoostInit = false, BoostPercent = 50, AntiFallSlow = false, safeModeSpeed = true, autoParryEnabled = false, autoParryRadiusEsp = false, autoParryRadius = 10, lastParryTime = 0, activeAttackers = {}, HoldLockActive = false, godEnabled = false, godLastHP = nil, hitboxOriginalSizes = {}, hitboxEspObjects = {}, instantLastVisible = false, lastPressTime = 0, lastSkillHit = 0, randomIsNeutral = false, originalMaxZoom = nil, originalFOV = nil, cursorBackupIcon = nil, cursorBackupBehavior = nil, forceCursorConn1 = nil, forceCursorConn2 = nil, originalMouseIconEnabled = nil, originalMouseBehavior = nil, perfGui = nil, pnameEnabled = false, pnameFakeNames = {}, pnameNameConns = {}, pnameSlotConns = {}, pnameWatchConn = nil, pnameAddedConn = nil, CV_Enabled = false, CV_CurrentTarget = nil, CV_WasHolding = false, CV_HoldingPC = false, CV_HoldingMobile = false, CV_LastStableDir = nil, CV_SnapGui = nil, CV_SnapLine = nil, CV_SnapDot = nil, CV_LastSpearSpeed = nil, CV_LastGravityMult = nil, CV_frameCount = 0, CV_snapLineFrame = -99, CV_cachedSpearMode = false, CV_spearModeFrame = -99, CV_acquireStartFrame = nil, CV_ballisticFrame = -99, CV_lastSolvedHeadPos = nil, CV_lastSolvedDir = nil, CV_lastSolvedPredicted = nil, CV_lastSolvedTime = nil, CV_Connections = {}, CV_InputBeganConn = nil, CV_InputEndedConn = nil, CV_WatchConn = nil, CV_VisualConn = nil, CV_HookedButtons = {}, CV_RenderStepName = "BOLONGHUB_CameraVeil", skipEndScreenConns = {}, fullbrightEnabled = false, removeVfxEnabled = false, silentAimEnabled = false, silentAimTarget = nil, silentAimLookVector = nil, laserEspEnabled = true, triggerLaser = false, currentMuzzlePos = nil, currentTargetPos = nil, FOVCircle = nil, silentAimFovVisible = false, silentSpearEnabled = false, silentSpearTargetTorso = nil, silentSpearTargetVel = Vector3.new(0, 0, 0), silentSpearLookVector = nil, spearIndicatorEnabled = false, spearFovCircleEnabled = false, spearIsHolding = false, spearHoldStartTime = nil, lastSpearSpeed = 142.5, lastGravityMult = 1, SPEAR_SNAPLINE = { enabled = false, locked = false, lockedTarget = nil, lockedPlayerName = "", currentNearestDist = math.huge, lockPulse = 0,}, SpearFOVCircle = nil, SpearIndicatorGui = nil, SpearStatusText = nil, SpearInfoText = nil, SpearAccentBar = nil, SpearMainFrame = nil, SnapLineGui = nil, SnapLineFrame = nil, SnapLineDot = nil, SnapLineTextLabel = nil, autoCrouchIsCrouching = false, autoCrouchActiveSlashers = {}, autoCrouchAnimConns = {}, _jitterFlip = false, _hookedMobButtons = {}, _hookedSlasherButtons = {}, _perfElapsed = 0, _perfFrames = 0, _perfActive = false, ghostGateEnabled = false, movConns = { antiFall = nil, noSlow = nil}, aimConn = nil, aimTargetCache = nil, aimTargetT = 0, aimLastStableDir = nil, ghostGateOriginals = {}, antiLoopWindowEnabled = false, predGui = nil, predInfoLabel = nil, predActive = false, predMapName = "Unknown", predLastPos = nil, predMapInfoConn = nil, autoDropNearbyPallets = false, palletPointsCache = nil, lastPalletPointScan = 0, autoDropCooldown = false, moonwalkMobileDir = 0, moonwalkPCForward = false, moonwalkPCBackward = false, moonwalkGui = nil,}
local ItemIcons = {["Adrenaline Shot"]="rbxassetid://135388781922226", Bandage = "rbxassetid://97791520639443", Flashlight = "rbxassetid://103299939715311", Gate = "rbxassetid://131249244284700",["Holy Water"]="rbxassetid://86130208614143",["Motion Tracker"]="rbxassetid://92303584765773",["Parrying Dagger"]="rbxassetid://76822757630703",["Riot Shield"]="rbxassetid://95718705901699",["Shadow Clone"]="rbxassetid://134088840518889",["Twist of Fate"]="rbxassetid://98397448432071",["WaxBound Candle"]="rbxassetid://110413686590821",}
local function func1(TypeStr)
if not TypeStr or type(TypeStr)~="string" then
 return nil
end
TypeStr = TypeStr:match("^%s*(.-)%s*$")
local Icon = ItemIcons[TypeStr]
if Icon then
 return Icon
end
for StringLib, IconUrl in pairs(ItemIcons) do
 if StringLib.lower(StringLib)== TypeStr.lower(TypeStr) then
 return IconUrl
 end
end
return nil
end
local MagicConst = 17
local ESPFolder = {"BOLONGHUB"}
local ESPFramesFolder = Instance.new("Folder")
ESPFramesFolder.Name = "__BolongESP__" ESPFramesFolder.Parent = workspace
local ESPEntries = {}
local function CreateESPEntry(EntryName, EntryInterval, EntryCallback) ESPEntries[#ESPEntries+ 1]={ name = EntryName, interval = EntryInterval, timer = 0, fn = EntryCallback}
end
local AntiAFKActive = false
local TaskDelayHook
local SpeedMultipliers = {[25]= true,[17]= true,[30]= true,[67.8]= true}
local function RemoveESPEntry()
if TaskDelayHook then
 return
end
pcall(
function()
TaskDelayHook = hookfunction(task.delay, newcclosure(
function(DelayArg, CallbackArg)
if not AntiAFKActive then
 return TaskDelayHook(DelayArg, CallbackArg)
end
if SpeedMultipliers[DelayArg] then
 return TaskDelayHook(0, CallbackArg)
end
return TaskDelayHook(DelayArg, CallbackArg)
end))
end)
end
local function ClearAllESP()
if TaskDelayHook then
pcall(restorefunction, task.delay)
TaskDelayHook = nil
end
end
local function GetPlayerRole(Player)
return ESPState.playerRoles[Player] or "survivor"
end
local function IsPlayerAlive(IdleConn)
local PcallOk, TeamName = pcall(
function()
return IdleConn.Teamand IdleConn.Team.Name:lower() or ""
end)
ESPState.playerRoles[IdleConn]=(PcallOk and TeamName:find("killer")) and "killer" or "survivor"
end
local AgainstVal
local function UpdateAntiBlind()
task.spawn(
function()
local FindOk, FindResult = pcall(
function()
return ReplicatedStorage:WaitForChild("Remotes", 10):WaitForChild("Items", 10):WaitForChild("Flashlight", 10):WaitForChild("GotBlinded", 10)
end)
if not FindOk or not FindResult then
 return
end
AgainstVal = FindResult
local OrigNamecall OrigNamecall = hookmetamethod(game,"__namecall",
function(...)
local Method = getnamecallmethod()
local CallArgs = table.pack(...)
local CheckVal = CallArgs[1]
if Method=="FireServer" and typeof(CheckVal)=="Instance" and rawequal(CheckVal, AgainstVal) then
 if Settings.antiBlindEnabledand CallArgs[2]== true then
 return
 end
end
return OrigNamecall(...)
end)
local OrigIndex OrigIndex = hookmetamethod(game,"__index",
function(CheckVal2, PropName)
if not checkcaller() and PropName=="FireServer" and typeof(CheckVal2)=="Instance" and rawequal(CheckVal2, AgainstVal) then
 return newcclosure(
 function(...)
 local HookArgs = table.pack(...)
 if Settings.antiBlindEnabled and HookArgs[2]== true then
 return
 end
return OrigIndex(CheckVal2, PropName)(...)
end)
end
return OrigIndex(CheckVal2, PropName)
end)
end)
end
UpdateAntiBlind() CreateESPEntry("AntiBlindForce", 0.2,
function()
if not Settings.antiBlindEnabledthen
return
end
for _, Desc in ipairs(PlayerGui.GetDescendants(PlayerGui)) do
 if Desc.Name=="Blind" then
 if Desc:IsA("ScreenGui") then
 if Desc.Enabled then
Desc.Enabled = false
 end
elseif Desc:IsA("GuiObject") then
 if Desc.Visible then
Desc.Visible = false
 end
if Desc.BackgroundTransparency< 1 then
Desc.BackgroundTransparency = 1
 end
end
 end
end
end)
local IdleConn2
local function SetupAntiAFK(Enable)
if Enable then
 if not IdleConn2 then
IdleConn2 = LocalPlayer.Idled:Connect(
 function() VirtualUser:CaptureController() VirtualUser:ClickButton2(Vector2.new())
 end)
end
else
if IdleConn2 then
IdleConn2.Disconnect(IdleConn2)
IdleConn2 = nil
end
end
end
local GuiHolder, AntiAFKConn2, TempFlag, ResetCameraVeil do
 local function GetExploitGui()
 local GetHuiOk, GetHuiResult = pcall(
 function()
 if gethui then
 return gethui()
 end
return game:GetService("CoreGui")
end)
return(GetHuiOk and GetHuiResult) or PlayerGui
end
local function GetTargetPosition(Char)
if not Char then
 return nil
end
local Head = Char:FindFirstChild("Head")
if Head then
 return Head.Position
end
local Root = Char:FindFirstChild("HumanoidRootPart")
if Root then
 return Root.Positionend
 local UpperTorso = Char:FindFirstChild("UpperTorso")
 if UpperTorso then
 return UpperTorso.Position
 end
local Torso = Char:FindFirstChild("Torso")
 if Torso then
 return Torso.Positionend
 return Char.PrimaryPart and Char.PrimaryPart.Positionor nil
 end
local function GetFlatVelocity(VelChar)
 if not VelChar then
 return Vector3.new(0, 0, 0)
 end
local Vel = VelChar.AssemblyLinearVelocitylocal FlatVel = Vector3.new(Vel.X, 0, Vel.Z)
 if FlatVel.Magnitude> 65 then
FlatVel = FlatVel.Unit* 65
 end
return FlatVel
end
local function GetCameraOrigin()
local MyChar = LocalPlayer.Characterlocal MyRoot = MyChar and MyChar:FindFirstChild("HumanoidRootPart")
if not MyRoot then
 return nil
end
local Cam = Workspace.CurrentCamera
local LookDir = (Cam and Cam.CFrame.LookVector) or MyRoot.CFrame.LookVectorreturn MyRoot.Position+ LookDir* 3+ Vector3.new(0, 1.5, 0)
end
local function CalcSpearSpeed(TargetChar)
local ClampedVal = tonumber(ESPState.CV_LastSpearSpeed) or tonumber(Settings.cameraVeilSpearSpeed) or 220
return math.clamp(ClampedVal, 35, 800)
end
local function BallisticSolve(Dist, Angle, Spd, Grav)
local CosA = math.cos(Angle)
if CosA<= 0.015 then
 return nil, nil
end
local T = Dist/(Spd* CosA)
if T~= T or T<= 0 then
 return nil, nil
end
local DT = 1/ 60
local GravDrop = 0.5* Grav* DT* T
local PredY = Spd* math.sin(Angle)* T-(0.5* Grav* T* T)- GravDrop
return PredY, T
end
local function ScoreBallistic(Src, VertDist, PitchAngle, Spd2, GravM)
local HorizDist, TT = BallisticSolve(Src, PitchAngle, Spd2, GravM)
if not HorizDist or not TT then
 return nil
end
if TT< 0.025 or TT> 4 then
 return nil
end
local Score1 = math.abs(HorizDist- VertDist)
local AbsVertDist = math.max(PitchAngle- Angle42, 0)* 0.35
local Score2 = math.max(TT- 1.3, 0)* 0.25
return Score1+ AbsVertDist+ Score2, Score1, TT
end
local function PredictShot(From, To, Spd3, GravF)
local Delta = To- From
local FlatDelta = Vector3.new(Delta.X, 0, Delta.Z)
local FlatDist2 = FlatDelta.Magnitude
local YDelta = Delta.Yif Delta.Magnitude<= 0.001 then
 return nil
end
if FlatDist2<= 0.35 or GravF<= 0.001 then
 return Delta.Unit, math.clamp(Delta.Magnitude/ Spd3, 0.025, 4)
end
local FlatDir = FlatDelta.Unit
local MinPitch = math.atan2(YDelta, FlatDist2)
local LowPitch = math.max(- Angle28, MinPitch- Angle18)
local HighPitch = Angle72
local BaseY, BestScore, BestTime, BestTT = nil, math.huge, math.huge, nil
local Steps2 = 24
for Step = 0, Steps2 do
 local TestAngle = LowPitch+(HighPitch- LowPitch)*(Step/ Steps2)
 local TestScore, TestTime, TestTT = ScoreBallistic(FlatDist2, YDelta, TestAngle, Spd3, GravF)
 if TestScore and TestScore< BestScore then
BestScore, BestTime, BaseY, BestTT = TestScore, TestTime, TestAngle, TestTT
 if BestTime< SmallOffset then
break
 end
end
end
if BaseY then
 local GravityMul = (HighPitch- LowPitch)/ Steps2* 2.5
 local RefinePasses = (BestTime< SmallOffset) and 1 or 3
 for Pass = 1, RefinePasses do
 local RefBestAngle, RefBestScore, RefBestTime, RefBestTT = BaseY, BestScore, BestTime, BestTT
 for Steps = -3, 3 do
 local SubAngle = math.clamp(BaseY+ GravityMul*(Steps/ 3), LowPitch, HighPitch)
 local SubScore, SubTime, SubTT = ScoreBallistic(FlatDist2, YDelta, SubAngle, Spd3, GravF)
 if SubScore and SubScore< RefBestScore then
RefBestScore, RefBestTime, RefBestAngle, RefBestTT = SubScore, SubTime, SubAngle, SubTT
 end
end BaseY, BestScore, BestTime, BestTT = RefBestAngle, RefBestScore, RefBestTime, RefBestTT
 if BestTime< SmallOffset then
break
 end
GravityMul = GravityMul* 0.38
 end
end
if not BaseY then
 local FallbackTime = math.clamp(FlatDist2/ Spd3, 0.025, 4)
 local FallbackPos = To+ Vector3.new(0, 0.5* GravF* FallbackTime* FallbackTime, 0)
 local FallbackDir = FallbackPos- From
 if FallbackDir.Magnitude<= 0.001 then
 return nil
 end
return FallbackDir.Unit, FallbackTime
end
local FinalDir = FlatDir* math.cos(BaseY)+ Vector3.new(0, math.sin(BaseY), 0)
if FinalDir.Magnitude<= 0.001 then
 return nil
end
return FinalDir.Unit, BestTT
end
local function CameraVeilSolve(TargetHeadPos)
local CamOrigin = GetCameraOrigin()
if not CamOrigin or not TargetHeadPos then
 return nil
end
local SpearSpd = CalcSpearSpeed((TargetHeadPos- CamOrigin).Magnitude)
local GravMult2 = math.max(tonumber(ESPState.CV_LastGravityMult) or tonumber(Settings.cameraVeilGravityMult) or1, 0)
local EffectiveGrav = Gravity* GravMult2
return PredictShot(CamOrigin, TargetHeadPos, SpearSpd, EffectiveGrav)
end
local function CameraVeilPredict(HeadPos, Velocity2)
if not HeadPos then
 return nil
end
local CamPos = GetCameraOrigin()
if CamPos then
 local CamToHead = HeadPos- CamPos
 local DistToHead = CamToHead.Magnitudeif DistToHead< 6 then
 if DistToHead< 0.001 then
 return nil
 end
local SpearSpd2 = tonumber(ESPState.CV_LastSpearSpeed) or tonumber(Settings.cameraVeilSpearSpeed) or220
 return CamToHead.Unit, HeadPos, math.clamp(DistToHead/ math.max(SpearSpd2, 1), 0.01, 1)
 end
end
local FrameNum = ESPState.CV_frameCountlocal FramesSinceBallistic = FrameNum- ESPState.CV_ballisticFramelocal CloseToLast = ESPState.CV_lastSolvedHeadPos and(HeadPos- ESPState.CV_lastSolvedHeadPos).Magnitude< DefaultSpeed
if FramesSinceBallistic< DefaultHeight and CloseToLast and ESPState.CV_lastSolvedDir then
 return ESPState.CV_lastSolvedDir, ESPState.CV_lastSolvedPredicted, ESPState.CV_lastSolvedTimeend
 local PredictedHead = HeadPos
 local AimDir, AimTime = CameraVeilSolve(PredictedHead)
 if AimDir and AimTime and Velocity2 and Velocity2.Magnitude> 1.25 then
 local LeadFactor = math.clamp(AimTime* 0.68, 0, 1.1)
 local LeadOffset = Velocity2* LeadFactor
 if LeadOffset.Magnitude> 32 then
LeadOffset = LeadOffset.Unit* 32
 end
local LeadedPos = HeadPos+ LeadOffset
 local LeadDir, LeadTT = CameraVeilSolve(LeadedPos)
 if LeadDir and LeadTT then
AimDir, AimTime, PredictedHead = LeadDir, LeadTT, LeadedPos
 end
end ESPState.CV_ballisticFrame = FrameNum ESPState.CV_lastSolvedHeadPos = HeadPos ESPState.CV_lastSolvedDir = AimDir ESPState.CV_lastSolvedPredicted = PredictedHead ESPState.CV_lastSolvedTime = AimTime
 return AimDir, PredictedHead, AimTime
end
local IsSpearModeActive
local function FindBestSurvivor()
local Cam2 = Workspace.CurrentCameraif not Cam2 then
 return nil
end
local CamPos2, CamLook = Cam2.CFrame.Position, Cam2.CFrame.LookVector
local BestTarget, BestAngle2 = nil, RadAngle30
local MyChar2 = LocalPlayer.Character
local MyRoot2 = MyChar2 and MyChar2:FindFirstChild("HumanoidRootPart")
if not MyRoot2 then
 return nil
end
for _, Plr in ipairs(Players.GetPlayers(Players)) do
 if Plr~= LocalPlayer then
 local Role = GetPlayerRole(Plr)
 if Role=="survivor" then
 local PlrChar = Plr.Characterlocal PlrHum = PlrChar and PlrChar:FindFirstChildOfClass("Humanoid")
 if PlrChar and PlrHum and PlrHum.Health> 0 then
 local PlrPos = GetTargetPosition(PlrChar)
 if PlrPos then
 local PlrDist = (PlrPos- MyRoot2.Position).Magnitude
 if PlrDist<= Settings.cameraVeilMaxDistancethen
 local CamToPlr = PlrPos- CamPos2
 if CamToPlr.Magnitude> 0.001 then
 local AngleDiff = math.acos(math.clamp(CamLook:Dot(CamToPlr.Unit),- 1, 1))
 if AngleDiff< BestAngle2 then
BestAngle2 = AngleDiff;
BestTarget = Plr
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
local function AutoGen()
if ESPState.CV_SnapGui and ESPState.CV_SnapGui.Parentand ESPState.CV_SnapLineand ESPState.CV_SnapLine.Parentand ESPState.CV_SnapDotand ESPState.CV_SnapDot.Parentthen
return
end
local SnapGui = Instance.new("ScreenGui")
SnapGui.Name = "CameraVeil_SnapLine" SnapGui.IgnoreGuiInset = true;
SnapGui.ResetOnSpawn = false;
SnapGui.Parent = GetExploitGui()
local SnapLine = Instance.new("Frame")
SnapLine.Name = "Line";
SnapLine.AnchorPoint = Vector2.new(0.5, 0.5);
SnapLine.BorderSizePixel = 0 SnapLine.BackgroundColor3 = Color3.fromRGB(0, 255, 120);
SnapLine.BackgroundTransparency = 0.08 SnapLine.Visible = false;
SnapLine.Parent = SnapGui
local SnapDot = Instance.new("Frame")
SnapDot.Name = "Dot";
SnapDot.AnchorPoint = Vector2.new(0.5, 0.5);
SnapDot.BorderSizePixel = 0 SnapDot.BackgroundColor3 = Color3.fromRGB(0, 255, 120);
SnapDot.BackgroundTransparency = 0 SnapDot.Size = UDim2.fromOffset(7, 7);
SnapDot.Visible = false;
SnapDot.Parent = SnapGui
local DotCorner = Instance.new("UICorner");
DotCorner.CornerRadius = UDim.new(1, 0);
DotCorner.Parent = SnapDot ESPState.CV_SnapGui = SnapGui;
ESPState.CV_SnapLine = SnapLine;
ESPState.CV_SnapDot = SnapDot
end
local function UpdateSnapLine(TargetPos)
if not Settings.cameraVeilSnapLine or not ESPState.CV_Enabledthen
if ESPState.CV_SnapLinethen ESPState.CV_SnapLine.Visible = false
end
if ESPState.CV_SnapDot then
ESPState.CV_SnapDot.Visible = false
end
return
end
if not IsSpearModeActive() then
 if ESPState.CV_SnapLine then
ESPState.CV_SnapLine.Visible = false
 end
if ESPState.CV_SnapDot then
ESPState.CV_SnapDot.Visible = false
 end
return
end
local CurFrame = ESPState.CV_frameCountif TargetPos and(CurFrame- ESPState.CV_snapLineFrame)< 2 then
 return
end
ESPState.CV_snapLineFrame = CurFrame
local SnapOk = pcall(
function() AutoGen()
local LineFrame = ESPState.CV_SnapLine;
local DotFrame = ESPState.CV_SnapDot;
local Cam3 = Workspace.CurrentCameraif not LineFrame or not Cam3 then
 if LineFrame then
LineFrame.Visible = false
 end
if DotFrame then
DotFrame.Visible = false
 end
return
end
local DotPos = TargetPos
local IsHolding = (ESPState.CV_CurrentTarget~= nil and ESPState.CV_WasHolding)
if not IsHolding then
 local Survivor = FindBestSurvivor()
 if Survivor then
 local SurvivorChar = Survivor.Characterif SurvivorChar then
DotPos = GetTargetPosition(SurvivorChar)
 end
else DotPos = nil
end
end
if not DotPos then
LineFrame.Visible = false;
 if DotFrame then
DotFrame.Visible = false
 end
return
end
local ScreenPos, OnScreen = Cam3:WorldToViewportPoint(DotPos)
if not OnScreen or ScreenPos.Z<= 0 then
LineFrame.Visible = false;
 if DotFrame then
DotFrame.Visible = false
 end
return
end
local ViewportSize = Cam3.ViewportSizelocal ScreenCenter = Vector2.new(ViewportSize.X* 0.5, ViewportSize.Y* 0.5)
local TargetScreen = Vector2.new(ScreenPos.X, ScreenPos.Y)
local ScreenDelta = TargetScreen- ScreenCenter;
local ScreenDist = ScreenDelta.Magnitudeif ScreenDist< 2 then
LineFrame.Visible = false;
 if DotFrame then
DotFrame.Visible = false
 end
return
end
local LineColor = IsHolding and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(255, 220, 0)
local LineAlpha = IsHolding and 0.08 or 0.35 LineFrame.BackgroundColor3 = LineColor;
LineFrame.BackgroundTransparency = LineAlpha LineFrame.Size = UDim2.fromOffset(ScreenDist, IsHolding and 2 or 1)
LineFrame.Position = UDim2.fromOffset((ScreenCenter.X+ TargetScreen.X)* 0.5,(ScreenCenter.Y+ TargetScreen.Y)* 0.5)
LineFrame.Rotation = math.deg(math.atan2(ScreenDelta.Y, ScreenDelta.X));
LineFrame.Visible = true
if DotFrame then
DotFrame.BackgroundColor3 = LineColor;
DotFrame.Position = UDim2.fromOffset(TargetScreen.X, TargetScreen.Y);
DotFrame.Visible = true
end
end)
if not SnapOk then
 if ESPState.CV_SnapLinethen ESPState.CV_SnapLine.Visible = false
end
if ESPState.CV_SnapDotthen ESPState.CV_SnapDot.Visible = false
end
end
end
function ResetCameraVeil()
ESPState.CV_CurrentTarget = nil;
ESPState.CV_WasHolding = false ESPState.CV_LastStableDir = nil;
ESPState.CV_acquireStartFrame = nil UpdateSnapLine(nil)
end
IsSpearModeActive = function()
local FrameCheck = ESPState.CV_frameCount
if FrameCheck== ESPState.CV_spearModeFramethen
return ESPState.CV_cachedSpearMode
end
ESPState.CV_spearModeFrame = FrameCheck
local TargetInst = LocalPlayer.Characterlocal gui1 = false
if TargetInst then
 local Wnvz0Ql, qQHuQH = pcall(TargetInst.GetAttribute, TargetInst,"spearmode")
gui1 = Wnvz0Ql and qQHuQH== true
end
ESPState.CV_cachedSpearMode = gui1
return gui1
end
local function IsSpearMode()
if not IsSpearModeActive() then
 return false
end
return ESPState.CV_HoldingPCor ESPState.CV_HoldingMobileend
local function SetupCameraVeil()
ESPState.CV_frameCount = ESPState.CV_frameCount+ 1
if not ESPState.CV_Enabledthen
return
end
local cam1 = IsSpearMode()
if not cam1 then
 if ESPState.CV_WasHoldingthen ResetCameraVeil()
else UpdateSnapLine(nil)
end
return
end
if not ESPState.CV_WasHolding then
ESPState.CV_LastStableDir = nil ESPState.CV_CurrentTarget = FindBestSurvivor()
ESPState.CV_WasHolding = true ESPState.CV_acquireStartFrame = ESPState.CV_frameCount
end
if ESPState.CV_acquireStartFrameand(ESPState.CV_frameCount- ESPState.CV_acquireStartFrame)< DefaultCount then
 local gui2 = FindBestSurvivor()
 if gui2 then
ESPState.CV_CurrentTarget = gui2
 end
end
local inst1 = ESPState.CV_CurrentTarget
if not inst1 then
ESPState.CV_WasHolding = false;
 return
end
local inst2 = inst1.Character
local inst3 = inst2 and inst2:FindFirstChildOfClass("Humanoid")
local char1 = GetPlayerRole(inst1)
if not inst2 or not inst3 or inst3.Health<= 0 or char1~="survivor" then
ESPState.CV_WasHolding = false;
ESPState.CV_CurrentTarget = nil;
 return
end
local SnapTarget = GetTargetPosition(inst2)
if not SnapTarget then
ESPState.CV_WasHolding = false;
ESPState.CV_CurrentTarget = nil;
 return
end
local CamPart = Workspace.CurrentCameralocal inst4 = LocalPlayer.Character
local inst5 = inst4 and inst4:FindFirstChild("HumanoidRootPart")
if not CamPart or not inst5 then
 return
end
if(SnapTarget- inst5.Position).Magnitude> Settings.cameraVeilMaxDistance then
ESPState.CV_WasHolding = false;
ESPState.CV_CurrentTarget = nil;
 return
end
local cam2 = GetFlatVelocity(inst2:FindFirstChild("HumanoidRootPart"))
local val1 = CameraVeilPredict(SnapTarget, cam2)
local val2 = val1 and val1.Magnitude> 0.001 and val1.Y< MaxClamp and val1.Y> MinClamp
if val2 then
 if ESPState.CV_LastStableDir then
 local WlqwnmNm = math.acos(math.clamp(ESPState.CV_LastStableDir:Dot(val1.Unit),- 1, 1))
 if WlqwnmNm< RadAngle45 then
ESPState.CV_LastStableDir = val1.Unitend
 else ESPState.CV_LastStableDir = val1.Unitend val1 = ESPState.CV_LastStableDirelseif ESPState.CV_LastStableDirthen val1 = ESPState.CV_LastStableDir
 else val1 = CamPart.CFrame.LookVectorend
 local SolveOrigin = CamPart.CFrame.Position
 local cam3 = math.clamp(Settings.cameraVeilSmoothnessor 1, 0.05, 1)
 local SolveDir = CamPart.CFrame.LookVector:Lerp(val1, cam3)
 if SolveDir.Magnitude> 0.001 then
CamPart.CFrame = CFrame.new(SolveOrigin, SolveOrigin+ SolveDir.Unit) UpdateSnapLine(SnapTarget)
 end
end
local function CleanupCameraVeil(Obj, AncestorName)
local Ancestor = Obj and Obj.Parentwhile Ancestor do
 if Ancestor.Name== AncestorName then
 return true
 end
Ancestor = Ancestor.Parentend
 return false
end
local function SetupEndScreenSkip(Button)
if not(Button and Button:IsA("GuiButton")) then
 return false
end
if Button.Name~="attack" then
 return false
end
if not CleanupCameraVeil(Button,"Slasher-mob") then
 return false
end
if not CleanupCameraVeil(Button,"Control") and not CleanupCameraVeil(Button,"Controls") then
 return false
end
return true
end
local function SetupSilentAim(Button2)
if not SetupEndScreenSkip(Button2) then
 return
end
if ESPState.CV_HookedButtons[Button2] then
 return
end
ESPState.CV_HookedButtons[Button2]= true
local function SetupMoonwalk()
if not ESPState.CV_Enabledor not IsSpearModeActive() then
 return
end
ESPState.CV_HoldingMobile = true
end
local function SetupSpeedBoost()
ESPState.CV_HoldingMobile = false
end
local NewConn = Button2.InputBegan:Connect(
function(InputObj)
local InputType = InputObj.UserInputTypeif InputType~= Enum.UserInputType.Touch and InputType~= Enum.UserInputType.MouseButton1 then
 return
end
SetupMoonwalk()
local EndedConn EndedConn = UIS2.InputEnded:Connect(
function(EndedInput)
if EndedInput== InputObj then
SetupSpeedBoost();
 if EndedConn then
EndedConn.Disconnect(EndedConn)
 end
end
end)
end)
table.insert(ESPState.CV_Connections, NewConn)
local EndedConn2 = Button2.InputEnded:Connect(
function(InputObj2)
local InputType2 = InputObj2.UserInputTypeif InputType2~= Enum.UserInputType.Touch and InputType2~= Enum.UserInputType.MouseButton1 then
 return
end
SetupSpeedBoost()
end)
table.insert(ESPState.CV_Connections, EndedConn2)
end
function TempFlag()
local GuiFolder = LocalPlayer:FindFirstChildOfClass("PlayerGui") or PlayerGui
if not GuiFolder then
 return
end
pcall(
function()
for ConnKey, ConnVal in ipairs(GuiFolder.GetDescendants(GuiFolder)) do
SetupSilentAim(ConnVal)
end
end)
if ESPState.CV_WatchConnthen ESPState.CV_WatchConn:Disconnect()
end
ESPState.CV_WatchConn = GuiFolder.DescendantAdded:Connect(SetupSilentAim)
table.insert(ESPState.CV_Connections, ESPState.CV_WatchConn)
end
local function func2()
if ESPState.CV_VisualConnthen
return
end
local PcallOk2, RemoteObj = pcall(
function()
local RS = game:GetService("ReplicatedStorage")
local Remotes = RS:FindFirstChild("Remotes")
local Mechanics = Remotes and Remotes:FindFirstChild("Mechanics")
return Mechanics and Mechanics:FindFirstChild("visualize")
end)
if PcallOk2 and RemoteObj and RemoteObj:IsA("RemoteEvent") then
ESPState.CV_VisualConn = RemoteObj.OnClientEvent:Connect(
 function(PlayerChar, _, IsNumber, IsPositive)
 if PlayerChar~= LocalPlayer.Characterthen
 return
end
if type(IsNumber)=="number" and IsNumber> 0 then
ESPState.CV_LastSpearSpeed = IsNumber
end
if type(IsPositive)=="number" and IsPositive>= 0 then
ESPState.CV_LastGravityMult = IsPositive
end
end)
table.insert(ESPState.CV_Connections, ESPState.CV_VisualConn)
end
end
function GuiHolder()
if ESPState.CV_Enabled then
 return
end
ESPState.CV_Enabled = true ESPState.CV_HoldingPC = false;
ESPState.CV_HoldingMobile = false ResetCameraVeil();
func2();
TempFlag()
ESPState.CV_InputBeganConn = UIS2.InputBegan:Connect(
function(InputObj3)
if InputObj3.UserInputType== Enum.UserInputType.MouseButton2 and IsSpearModeActive() then
ESPState.CV_HoldingPC = true
end
end)
table.insert(ESPState.CV_Connections, ESPState.CV_InputBeganConn)
ESPState.CV_InputEndedConn = UIS2.InputEnded:Connect(
function(InputObj4)
if InputObj4.UserInputType== Enum.UserInputType.MouseButton2 then
ESPState.CV_HoldingPC = false
end
end)
table.insert(ESPState.CV_Connections, ESPState.CV_InputEndedConn) pcall(
function() RunService:UnbindFromRenderStep(ESPState.CV_RenderStepName)
end) pcall(
function() RunService:BindToRenderStep(ESPState.CV_RenderStepName, Enum.RenderPriority.Camera.Value+ 2, SetupCameraVeil)
end)
end
function AntiAFKConn2()
ESPState.CV_Enabled = false ESPState.CV_HoldingPC = false;
ESPState.CV_HoldingMobile = false ResetCameraVeil()
ESPState.CV_frameCount = 0;
ESPState.CV_snapLineFrame = -99;
ESPState.CV_spearModeFrame = -99;
ESPState.CV_cachedSpearMode = false ESPState.CV_ballisticFrame = -99;
ESPState.CV_lastSolvedHeadPos = nil;
ESPState.CV_lastSolvedDir = nil ESPState.CV_lastSolvedPredicted = nil;
if 0>(730) then
 local gui3 = 381+ 730
 local gui4 = gui3* 2
end
ESPState.CV_lastSolvedTime = nil pcall(
function() RunService:UnbindFromRenderStep(ESPState.CV_RenderStepName)
end)
for oUNoI, v_UMbvvnzpopql in ipairs(ESPState.CV_Connections) do
pcall(
 function() v_UMbvvnzpopql:Disconnect()
end)
end
ESPState.CV_Connections = {};
ESPState.CV_HookedButtons = {} ESPState.CV_InputBeganConn = nil;
ESPState.CV_InputEndedConn = nil;
ESPState.CV_WatchConn = nil;
ESPState.CV_VisualConn = nil
end
end
local function func3(wxbXbI, QnvbX00QlovM, wUNI_u, BwM0wo)
local gui5 = Instance.new("BillboardGui")
gui5.AlwaysOnTop = true;
gui5.Size = wUNI_u or UDim2.new(0, 40, 0, 40);
gui5.StudsOffset = Vector3.new(0, 3.5, 0)
local color1 = Instance.new("TextLabel")
color1.Name = "Label";
color1.Size = UDim2.new(1, 0, 1, 0);
color1.BackgroundTransparency = 1 color1.Text = wxbXbI;
color1.TextColor3 = QnvbX00QlovM;
color1.TextStrokeTransparency = 0 _WHxwDXUx.TextStrokeColor3 = Color3.new(0, 0, 0);
color1.TextSize = BwM0wo or 22 color1.Font = Enum.Font.GothamBold;
color1.RichText = true;
color1.Parent = gui5
return gui5
end
local function func4()
for uNpoqHmX, HasESP in pairs(ESPState.espObjects) do
 if HasESP and HasESP.billboard and HasESP.billboard.Parentthen
 local v1 = GetPlayerRole(uNpoqHmX);
 local v2 = v1=="killer" HasESP.nameLabel.Visible = (v2 and Settings.killerShowName) or(not v2 and Settings.survivorShowName)
HasESP.nameLabel.Text = ESPState.pnameEnabled and(ESPState.pnameFakeNames[uNpoqHmX] or uNpoqHmX.Name) or uNpoqHmX.NameHasESP.billboard.MaxDistance = Settings.maxDistanceend
end
for bDZWWwpUHIOnM, HasOutline in pairs(ESPState.outlineObjects) do
 if HasOutline and HasOutline.Parentthen
 local v3 = GetPlayerRole(bDZWWwpUHIOnM);
 local v4 = v3=="killer"
 local v5 = v4 and Settings.killerColoror Settings.survivorColorlocal inst6 = (v4 and Settings.killerShowOutline) or(not v4 and Settings.survivorShowOutline)
 local inst7 = (v4 and Settings.killerOutlineOnly) or(not v4 and Settings.survivorOutlineOnly)
HasOutline.FillColor = v5;
HasOutline.OutlineColor = v5;
HasOutline.Enabled = inst6 HasOutline.FillTransparency = inst7 and1 or Settings.fillTransparency
end
end
end
local function func5(MQ00Dw1nI0bZml, WOQq_)
local inst8 = ESPState.espObjects[MQ00Dw1nI0bZml]
if not inst8 then
 return
end
if not WOQq_ or not WOQq_.Parentor MQ00Dw1nI0bZml.Character~= WOQq_ then
 return
end
local char2 = WOQq_:FindFirstChild("HumanoidRootPart") or WOQq_:FindFirstChild("Torso") or WOQq_:FindFirstChild("UpperTorso") or WOQq_:FindFirstChild("Head")
if not char2 then
task.spawn(
 function()
 local QwbwpWpxwqXpW, _p0nO = pcall(
 function()
 return WOQq_:WaitForChild("HumanoidRootPart", 3)
end)
if QwbwpWpxwqXpW and _p0nO and _p0nO.Parent and WOQq_.Parentand MQ00Dw1nI0bZml.Character== WOQq_ then
 if inst8.billboard then
inst8.billboard.Adornee = _p0nO inst8.billboard.Enabled = true
 end
if inst8.itemBillboardthen inst8.itemBillboard.Adornee = _p0nO inst8.itemBillboard.Enabled = true
end
end
end)
return
end
if inst8.billboardthen inst8.billboard.Adornee = char2 inst8.billboard.Enabled = true
end
if inst8.itemBillboardthen inst8.itemBillboard.Adornee = char2 inst8.itemBillboard.Enabled = true
end
local v6 = GetPlayerRole(MQ00Dw1nI0bZml);
local v7 = v6=="killer" inst8.nameLabel.Visible = (v7 and Settings.killerShowName) or(not v7 and Settings.survivorShowName)
inst8.nameLabel.Text = ESPState.pnameEnabled and(ESPState.pnameFakeNames[MQ00Dw1nI0bZml] or MQ00Dw1nI0bZml.Name) or MQ00Dw1nI0bZml.Nameend
local function func6(HM0pbqmvOM)
if ESPState.espObjects[HM0pbqmvOM] then
 if ESPState.espObjects[HM0pbqmvOM].billboardthen ESPState.espObjects[HM0pbqmvOM].billboard:Destroy()
end
if ESPState.espObjects[HM0pbqmvOM].itemBillboardthen ESPState.espObjects[HM0pbqmvOM].itemBillboard:Destroy()
end
ESPState.espObjects[HM0pbqmvOM]= nil
end
if ESPState.outlineObjects[HM0pbqmvOM] then
ESPState.outlineObjects[HM0pbqmvOM]:Destroy();
ESPState.outlineObjects[HM0pbqmvOM]= nil
end
ESPState.playerRoles[HM0pbqmvOM]= nil
if ESPState.playerTeamConns[HM0pbqmvOM] then
ESPState.playerTeamConns[HM0pbqmvOM]:Disconnect();
ESPState.playerTeamConns[HM0pbqmvOM]= nil
end
end
local function Oqpmb(DQvmwUI0, puNHplqx)
local esp1 = ESPState.outlineObjects[DQvmwUI0]
if not esp1 then
 return
end
if not puNHplqx or not puNHplqx.Parentor DQvmwUI0.Character~= puNHplqx then
 return
end
local esp2 = GetPlayerRole(DQvmwUI0);
local v8 = esp2=="killer"
local v9 = v8 and Settings.killerColoror Settings.survivorColorlocal char3 = (v8 and Settings.killerShowOutline) or(not v8 and Settings.survivorShowOutline)
local char4 = (v8 and Settings.killerOutlineOnly) or(not v8 and Settings.survivorOutlineOnly)
esp1.Adornee = puNHplqx esp1.FillColor = v9 esp1.OutlineColor = v9 esp1.FillTransparency = char4 and 1 or Settings.fillTransparency esp1.OutlineTransparency = 0 esp1.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop esp1.Enabled = char3
end
local function func7(v_xQlDHqM_)
if v_xQlDHqM_== LocalPlayer then
 return
end
if not v_xQlDHqM_ or not v_xQlDHqM_.Parent then
 return
end
local flag1 = ESPState.espObjects[v_xQlDHqM_]
local flag2 = ESPState.outlineObjects[v_xQlDHqM_]
if not flag1 and not flag2 then
 return
end
local vlo_lu = v_xQlDHqM_.Character
if not vlo_lu or not vlo_lu.Parentthen
if flag1 and flag1.billboardthen flag1.billboard.Adornee = nil
end
if flag1 and flag1.itemBillboard then
flag1.itemBillboard.Adornee = nil
end
if flag2 then
flag2.Adornee = nil;
flag2.Enabled = false
end
return
end
local v10 = vlo_lu:FindFirstChild("HumanoidRootPart") or vlo_lu:FindFirstChild("Torso") or vlo_lu:FindFirstChild("UpperTorso") or vlo_lu:FindFirstChild("Head")
if not v10 then
 return
end
if flag1 and flag1.billboard then
 if flag1.billboard.Adornee~= v10 then
flag1.billboard.Adornee = v10
 end
if not flag1.billboard.Enabledthen flag1.billboard.Enabled = true
end
end
if flag1 and flag1.itemBillboard then
 if flag1.itemBillboard.Adornee~= v10 then
flag1.itemBillboard.Adornee = v10
 end
if not flag1.itemBillboard.Enabled then
flag1.itemBillboard.Enabled = true
 end
end
if flag2 then
 if flag2.Adornee~= vlo_lu then
Oqpmb(v_xQlDHqM_, vlo_lu)
 else
 if not flag2.Enabledthen
 local color2 = GetPlayerRole(v_xQlDHqM_);
 local color3 = color2=="killer"
 local v11 = (color3 and Settings.killerShowOutline) or(not color3 and Settings.survivorShowOutline)
flag2.Enabled = v11
end
end
end
end
local function func8(M_qXM)
if M_qXM== LocalPlayer then
 return
end
IsPlayerAlive(M_qXM)
local inst9 = GetPlayerRole(M_qXM)
local inst10 = Instance.new("BillboardGui")
inst10.Name = "ESP_BB_"..M_qXM.Name;
inst10.AlwaysOnTop = true inst10.Size = UDim2.new(0, 150, 0, 18)
inst10.StudsOffset = Vector3.new(0, 3.5, 0)
inst10.MaxDistance = Settings.maxDistance;
inst10.Parent = ESPFramesFolder
local gui6 = Instance.new("TextLabel")
gui6.Name = "NameLabel";
gui6.Size = UDim2.new(1, 0, 1, 0)
gui6.BackgroundTransparency = 1 gui6.TextColor3 = Color3.fromRGB(255, 255, 255);
gui6.TextStrokeTransparency = 0 gui6.TextStrokeColor3 = Color3.new(0, 0, 0);
gui6.TextSize = 12 gui6.Font = Enum.Font.GothamBoldM_nM_w.Text = ESPState.pnameEnabledand(ESPState.pnameFakeNames[M_qXM] or M_qXM.Name) or M_qXM.Name gui6.Visible = (inst9=="killer" and Settings.killerShowName) or(inst9~="killer" and Settings.survivorShowName)
gui6.Parent = inst10
local inst11 = Instance.new("BillboardGui")
inst11.Name = "ESP_Item_"..M_qXM.Name inst11.AlwaysOnTop = true inst11.Size = UDim2.new(1.5, 0, 1.5, 0)
inst11.StudsOffset = Vector3.new(0,- 5, 0)
inst11.MaxDistance = Settings.maxDistance inst11.Parent = ESPFramesFolder
local inst12 = Instance.new("ImageLabel")
inst12.Name = "ItemImage" inst12.Size = UDim2.new(1, 0, 1, 0)
inst12.BackgroundTransparency = 1 _MxUNnNZuzM.Visible = false inst12.Parent = inst11 ESPState.espObjects[M_qXM]={ billboard = inst10, nameLabel = gui6, itemBillboard = inst11, itemImage = inst12}
if M_qXM.Character then
func5(M_qXM, M_qXM.Character)
end
if not ESPState.playerTeamConns[M_qXM] then
ESPState.playerTeamConns[M_qXM]= M_qXM:GetPropertyChangedSignal("Team"):Connect(
 function() IsPlayerAlive(M_qXM) func4()
task.delay(0.5,
 function() func7(M_qXM)
end)
task.delay(2,
function() func7(M_qXM)
end)
end)
end
end
local function wxouub(qpuXO_xp1QqO_)
if qpuXO_xp1QqO_== LocalPlayer then
 return
end
local flag3 = Instance.new("Highlight");
flag3.Parent = ESPFramesFolder ESPState.outlineObjects[qpuXO_xp1QqO_]= flag3
if qpuXO_xp1QqO_.Character then
Oqpmb(qpuXO_xp1QqO_, qpuXO_xp1QqO_.Character)
end
end
local function func9(ValueToCheck, __DWvwowb)
if typeof(ValueToCheck)~="Instance" then
 return nil
end
local gen1 = ValueToCheck:GetAttribute(__DWvwowb)
if gen1~= nil then
 return gen1
end
local gen2 = ValueToCheck:FindFirstChild(__DWvwowb)
if gen2 and gen2:IsA("ValueBase") then
 return gen2.Valueend
 return nil
end
local function func10(DUZuDNN, ubUlQIO0W_XuXz)
if not DUZuDNN or not DUZuDNN.Parent then
 return
end
local inst13 = DUZuDNN:FindFirstChild("__BolongHL__")
if not inst13 then
inst13 = Instance.new("Highlight");
inst13.Name = "__BolongHL__";
inst13.Adornee = DUZuDNN inst13.FillTransparency = 1;
inst13.OutlineTransparency = 0;
inst13.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop inst13.FillColor = ubUlQIO0W_XuXz;
inst13.OutlineColor = ubUlQIO0W_XuXz;
inst13.Parent = DUZuDNN;
 return
end
if inst13.FillColor~= ubUlQIO0W_XuXz then
inst13.FillColor = ubUlQIO0W_XuXz;
inst13.OutlineColor = ubUlQIO0W_XuXz
end
if not inst13.Enabledthen inst13.Enabled = true
end
end
local function func11(wMuuQUW)
if not wMuuQUW then
 return
end
local gen3 = wMuuQUW:FindFirstChild("__BolongHL__")
if gen3 then
gen3.Destroy(gen3)
end
end
local function func12(GeneratorPart)
if not GeneratorPart or not GeneratorPart.Parentthen
return true
end
if ESPState.completedGenerators[GeneratorPart] then
 return true
end
local Progress = GeneratorPart:GetAttribute("RepairProgress") or GeneratorPart:GetAttribute("Progress") or 0
local gen4 = (Progress>= 100) or(GeneratorPart:GetAttribute("Completed")== true) or(GeneratorPart:GetAttribute("IsCompleted")== true) or(GeneratorPart:GetAttribute("Done")== true)
local gen5 = GeneratorPart:FindFirstChild("__BolongGenProgress__")
if gen4 then
 if gen5 then
gen5.Destroy(gen5)
 end
func11(GeneratorPart) GeneratorPart:SetAttribute("__BolongGenLastPct__", nil) GeneratorPart:SetAttribute("__BolongGenLastInfo__", nil)
ESPState.completedGenerators[GeneratorPart]= true ESPState.genIndices[GeneratorPart]= nil
 return gen4
end
if Settings.espGeneratorEnabledthen func10(GeneratorPart, Settings.espGeneratorColor)
else func11(GeneratorPart)
end
if Settings.espGeneratorProgressGen then
 local CoordY = GeneratorPart:GetAttribute("PlayersRepairingCount") or0
 local CoordZ = GeneratorPart:GetAttribute("kickcount") or 0 do
 local inst14 = 279*(0+ 1- 1)
 local inst15 = inst14+ 495- 495
 end
local CoordX = math.floor(Progress+ 0.5)
 local GeneratorModel = GeneratorPart:GetAttribute("__BolongGenLastPct__")
 local MZ00U = GeneratorPart:GetAttribute("__BolongGenLastInfo__")
 local GenNum = ESPState.genIndices[GeneratorPart] or 1
 local v12 = string.format("%d_%d_%d_%s_%d", CoordX, CoordY, CoordZ, tostring(Settings.espGenShowPK), GenNum)
 if GeneratorModel== CoordX and MZ00U== v12 and gen5 then
 return false
 end
GeneratorPart:SetAttribute("__BolongGenLastPct__", CoordX) GeneratorPart:SetAttribute("__BolongGenLastInfo__", v12)
 local inst16 = math.clamp(Progress, 0, 100)
 local gen6 = (inst16< 50) and Settings.espGeneratorColor:Lerp(Color3.fromRGB(255, 200, 0), inst16/ 50) or Color3.fromRGB(255, 200, 0):Lerp(Color3.fromRGB(100, 255, 80),(inst16- 50)/ 50)
 local gui7 = gen6.ToHex(gen6)
 local gui8 = string.format("GEN%d", GenNum)
 local gui9 = string.format("%d%%", CoordX)
 local color4 = GeneratorPart:FindFirstChild("GeneratorBody", true) or GeneratorPart:FindFirstChild("defaultMaterial", true) or(GeneratorPart:IsA("Model") and GeneratorPart.PrimaryPart) or GeneratorPart:FindFirstChildWhichIsA("BasePart", true)
 if not color4 then
 return false
 end
local color5 = "F4D03F"
 local color6 = string.format("<font size = \"9\" color = \"#%s\">%s</font> <font color = \"#555555\">│</font> <font color = \"#%s\">%s</font>", color5, gui8, gui7, gui9)
 if Settings.espGenShowPKthen color6 = color6..string.format(" <font color = \"#555555\">│</font> <font color = \"#76D7C4\">P:%d</font> <font color = \"#555555\">│</font> <font color = \"#FF6B6B\">K:%d</font>", CoordY, CoordZ)
end
if not gen5 then
gen5 = Instance.new("BillboardGui")
gen5.Name = "__BolongGenProgress__" gen5.Adornee = color4 gen5.AlwaysOnTop = true gen5.LightInfluence = 0 gen5.ResetOnSpawn = false gen5.MaxDistance = 260 vu0MWq0nn.Size = UDim2.new(0, 100, 0, 14)
 local gen7 = (color4.Size.Y/ 2)+ 3.5 gen5.StudsOffset = Vector3.new(0, gen7, 0)
gen5.Parent = GeneratorPart
 local conn1 = Instance.new("TextLabel")
conn1.Name = "Label" conn1.BackgroundTransparency = 1 conn1.Size = UDim2.new(1, 0, 1, 0)
conn1.Position = UDim2.new(0, 0, 0, 0)
conn1.Font = Enum.Font.GothamBlack_1Xm1boDQ.TextSize = 11 conn1.RichText = true conn1.Text = color6 conn1.TextColor3 = Color3.fromRGB(255, 255, 255)
conn1.TextXAlignment = Enum.TextXAlignment.Center conn1.Parent = gen5
 local pallet1 = Instance.new("UIStroke")
pallet1.Thickness = 0.8 pallet1.Transparency = 0.4 pallet1.Color = Color3.new(0, 0, 0)
pallet1.Parent = conn1
else
if gen5.Adornee~= color4 then
gen5.Adornee = color4
end
local pallet2 = (color4.Size.Y/ 2)+ 3.5 gen5.StudsOffset = Vector3.new(0, pallet2, 0)
local conn2 = gen5:FindFirstChild("Label")
if conn2 then
conn2.Text = color6
end
end
else
if gen5 then
gen5.Destroy(gen5) GeneratorPart:SetAttribute("__BolongGenLastPct__", nil) GeneratorPart:SetAttribute("__BolongGenLastInfo__", nil)
end
end
return false
end
local function func13(uQwnIWq)
local function func14()
if not Settings.espGeneratorEnabledand not Settings.espGeneratorProgressGenthen
return
end
func12(uQwnIWq)
end
pcall(
function() uQwnIWq:GetAttributeChangedSignal("RepairProgress"):Connect(func14) uQwnIWq:GetAttributeChangedSignal("Progress"):Connect(func14) uQwnIWq:GetAttributeChangedSignal("Completed"):Connect(func14) uQwnIWq:GetAttributeChangedSignal("IsCompleted"):Connect(func14) uQwnIWq:GetAttributeChangedSignal("PlayersRepairingCount"):Connect(func14) uQwnIWq:GetAttributeChangedSignal("kickcount"):Connect(func14)
end)
end
local function func15(ollbxU, bmIvxUmw)
local function wzxpnp()
local flag4 = func9(ollbxU,"Dropped") or func9(ollbxU,"IsDropped")
local gen8 = func9(ollbxU,"Broken") or func9(ollbxU,"IsBroken") or func9(ollbxU,"Destroyed")
if flag4 or gen8 or bmIvxUmw.isFake then
func11(ollbxU)
 for vZoIuz1ZMIbQv, _Xqln_ in ipairs(ESPState.cachedMapObjects.Pallets) do
 if _Xqln_== ollbxU then
table.remove(ESPState.cachedMapObjects.Pallets, vZoIuz1ZMIbQv);
break
 end
end ESPState.cachedPalletMeta[ollbxU]= nil
end
end
for qq1bWop, DMXux in ipairs({"Dropped","IsDropped","Broken","IsBroken","Destroyed"}) do
ollbxU:GetAttributeChangedSignal(DMXux):Connect(wzxpnp)
end
ollbxU.ChildAdded:Connect(
function(lwNxm0XbH)
if lwNxm0XbH:IsA("ValueBase") and(lwNxm0XbH.Name=="Dropped" or lwNxm0XbH.Name=="IsDropped" or lwNxm0XbH.Name=="Broken" or lwNxm0XbH.Name=="IsBroken" or lwNxm0XbH.Name=="Destroyed") then
lwNxm0XbH.Changed:Connect(wzxpnp)
end
end)
end
local function func16(_XUDb, ubWxl)
if not _XUDb or not _XUDb.Parentthen
return
end
local v13 = _XUDb:IsA("BasePart") and{ _XUDb} or _XUDb.GetDescendants(_XUDb)
for NmwpxIuzZH, lpXboQo1 in ipairs(v13) do
 if lpXboQo1:IsA("BasePart") then
 if ubWxl then
 if not ESPState.ghostGateOriginals[lpXboQo1] then
ESPState.ghostGateOriginals[lpXboQo1]={ CanCollide = lpXboQo1.CanCollide, Transparency = lpXboQo1.Transparency}
 end
lpXboQo1.CanCollide = false lpXboQo1.Transparency = 0.6
 else
 if ESPState.ghostGateOriginals[lpXboQo1] then
lpXboQo1.CanCollide = ESPState.ghostGateOriginals[lpXboQo1].CanCollidelpXboQo1.Transparency = ESPState.ghostGateOriginals[lpXboQo1].Transparency
 end
end
end
end
end
local function func17(TargetModel)
local inst17 = TargetModel.Name
if inst17=="Generator" then
table.insert(ESPState.cachedMapObjects.Generators, TargetModel)
 if not ESPState.genIndices[TargetModel] then
 if next(ESPState.genIndices)== nil then
ESPState.nextGenIndex = 1
 end
ESPState.genIndices[TargetModel]= ESPState.nextGenIndex ESPState.nextGenIndex = ESPState.nextGenIndex+ 1
 end
if Settings.espGeneratorEnabledthen func12(TargetModel);
func13(TargetModel)
end
elseif inst17=="Hook" then
table.insert(ESPState.cachedMapObjects.Hooks, TargetModel)
 local MapParts = {}
 local ModelChild = TargetModel:FindFirstChild("Model")
 if ModelChild then
 for Idx, Child in ipairs(ModelChild.GetDescendants(ModelChild)) do
 if Child:IsA("MeshPart") then
table.insert(MapParts, Child)
 end
end
 end
ESPState.cachedHookMeshParts[TargetModel]= MapParts
 if Settings.espHookEnabled then
 if#MapParts> 0 then
 for _HuHwZQ, wuqvv1bQ0X0 in ipairs(MapParts) do
func10(wuqvv1bQ0X0, Settings.espHookColor)
 end
else func10(TargetModel, Settings.espHookColor)
 end
end
elseif inst17=="Gate" then
table.insert(ESPState.cachedMapObjects.Gates, TargetModel)
 if Settings.espGateEnabled then
func10(TargetModel, Settings.espGateColor)
 end
if ESPState.ghostGateEnabledthen func16(TargetModel, true)
end
elseif inst17=="Pallet" or inst17=="Palletwrong" then
table.insert(ESPState.cachedMapObjects.Pallets, TargetModel)
 local v14 = inst17.lower(inst17)
 local PalletPart = (TargetModel:IsA("Model") and TargetModel.PrimaryPart) or TargetModel:FindFirstChildWhichIsA("BasePart", true) or(TargetModel:IsA("BasePart") and TargetModel)
 local IsFakePallet = v14:find("fake") or v14:find("broken") or v14:find("destroyed")
 local PalletMeta = { part = PalletPart, isFake = IsFakePallet and true or false} ESPState.cachedPalletMeta[TargetModel]= PalletMeta
 if Settings.espPalletEnabledand not PalletMeta.isFakethen func10(TargetModel, Settings.espPalletColor)
end
func15(TargetModel, PalletMeta)
end
end
local function func18(Nl_mM)
local gen9 = Nl_mM.Name
if gen9=="Generator" then
 for _nmDHDuX1, uoooznUZz in ipairs(ESPState.cachedMapObjects.Generators) do
 if uoooznUZz== Nl_mM then
table.remove(ESPState.cachedMapObjects.Generators, _nmDHDuX1);
break
 end
end ESPState.genIndices[Nl_mM]= nil ESPState.completedGenerators[Nl_mM]= nil func11(Nl_mM)
 local conn3 = Nl_mM:FindFirstChild("__BolongGenProgress__")
 if conn3 then
conn3.Destroy(conn3)
 end
if next(ESPState.genIndices)== nil then
ESPState.nextGenIndex = 1
 end
elseif gen9=="Hook" then
 for W1ovqUnu1D, lWuoDQ1 in ipairs(ESPState.cachedMapObjects.Hooks) do
 if lWuoDQ1== Nl_mM then
table.remove(ESPState.cachedMapObjects.Hooks, W1ovqUnu1D);
break
 end
end
 local esp3 = ESPState.cachedHookMeshParts[Nl_mM]
 if esp3 then
 for ImbDbD, llu_UloD_1 in ipairs(esp3) do
func11(llu_UloD_1)
 end
else func11(Nl_mM)
end
ESPState.cachedHookMeshParts[Nl_mM]= nil
elseif gen9=="Gate" then
 for OxqIZolbnpUIX, o1bo0wObZH1pb in ipairs(ESPState.cachedMapObjects.Gates) do
 if o1bo0wObZH1pb== Nl_mM then
table.remove(ESPState.cachedMapObjects.Gates, OxqIZolbnpUIX);
break
 end
end func11(Nl_mM)
elseif gen9=="Pallet" or gen9=="Palletwrong" then
 for qIw1vDn0W1bz1, vQIwx in ipairs(ESPState.cachedMapObjects.Pallets) do
 if vQIwx== Nl_mM then
table.remove(ESPState.cachedMapObjects.Pallets, qIw1vDn0W1bz1);
break
 end
end func11(Nl_mM)
ESPState.cachedPalletMeta[Nl_mM]= nil
end
end
local function func19(bpZ1ZlIDDIUIw)
if not bpZ1ZlIDDIUIw then
 return
end
ESPState.cachedMapObjects = { Generators = {}, Pallets = {}, Hooks = {}, Gates = {}} ESPState.cachedPalletMeta = {};
ESPState.cachedHookMeshParts = {};
ESPState.completedGenerators = {} ESPState.genIndices = {};
ESPState.nextGenIndex = 1
for lvwMZ1w1, WvDoZIbMW in ipairs(bpZ1ZlIDDIUIw.GetDescendants(bpZ1ZlIDDIUIw)) do
func17(WvDoZIbMW)
end
end
local function func20(bquDOpnb)
if not bquDOpnb then
 return
end
func19(bquDOpnb)
bquDOpnb.DescendantAdded:Connect(func17)
bquDOpnb.DescendantRemoving:Connect(func18)
ESPState.objEspInitialized = true
end
ESPState.windowEspObjects = {}
local function func21(lwxXvqNU)
if not lwxXvqNU or not lwxXvqNU.Parent or ESPState.windowEspObjects[lwxXvqNU] then
 return
end
local OzUwz = Settings.espWindowColorlocal v15 = Instance.new("BoxHandleAdornment")
v15.Name = "WindowESP_Box" v15.Adornee = lwxXvqNU v15.Color3 = OzUwz v15.Transparency = 0.3 v15.Size = lwxXvqNU.Size v15.AlwaysOnTop = true v15.ZIndex = 10 v15.Parent = ESPFramesFolder ESPState.windowEspObjects[lwxXvqNU]= v15
end
local function func22(ObnHuZq)
local gen10 = ESPState.windowEspObjects[ObnHuZq]
if gen10 then
pcall(
 function() gen10:Destroy()
end)
ESPState.windowEspObjects[ObnHuZq]= nil
end
end
local function func23(wb1oq1)
if typeof(wb1oq1)~="Instance" then
 return nil
end
local gen11 = string.lower(wb1oq1.Name)
if gen11=="window" and wb1oq1:IsA("Model") then
 local inst18 = wb1oq1:FindFirstChild("Bottom", true)
 if inst18 and inst18:IsA("BasePart") then
 return inst18
 end
return wb1oq1.PrimaryPartend
 if gen11=="bottom" and wb1oq1:IsA("BasePart") then
 if wb1oq1.Parentand string.lower(wb1oq1.Parent.Name)=="window" then
 return wb1oq1
 end
end
 return nil
end
local function func24(IXUuzUWoDmXN)
local pallet3 = func23(IXUuzUWoDmXN)
if pallet3 then
 if Settings.espWindowEnabledand not ESPState.windowEspObjects[pallet3] then
func21(pallet3)
 end
end
end
Workspace.DescendantAdded:Connect(
function(ImOQ0XH1m) func24(ImOQ0XH1m)
end)
Workspace.DescendantRemoving:Connect(
function(Ov1pxpO1vlIbQ)
local pallet4 = func23(Ov1pxpO1vlIbQ) or Ov1pxpO1vlIbQ
if ESPState.windowEspObjects[pallet4] then
func22(pallet4)
end
end)
local function func25()
for IzWqxqvHvlZ0N_, wvQovQ_UmZ in pairs(ESPState.windowEspObjects) do
 if not IzWqxqvHvlZ0N_ or not IzWqxqvHvlZ0N_.Parent then
func22(IzWqxqvHvlZ0N_)
 end
end
if Settings.espWindowEnabled then
 for DHpolb, qZzX1UU in ipairs(Workspace.GetDescendants(Workspace)) do
func24(qZzX1UU)
 end
end
end
task.spawn(
function()
task.wait(3) func25()
end)
local function func26()
if not ESPState.objEspInitialized then
 return
end
local v16 = Settings.espGeneratorEnabled or Settings.espGeneratorProgressGen
if v16 then
 local v17 = {}
 for vnumNM0N, _UzWHvUnmIOMm in ipairs(ESPState.cachedMapObjects.Generators) do
 if _UzWHvUnmIOMm and _UzWHvUnmIOMm.Parentthen
 local v18 = func12(_UzWHvUnmIOMm)
 if not v18 then
table.insert(v17, _UzWHvUnmIOMm)
 end
end
end
ESPState.cachedMapObjects.Generators = v17
else
for MqunID, MbDUu1 in ipairs(ESPState.cachedMapObjects.Generators) do
 if MbDUu1 and MbDUu1.Parentthen func11(MbDUu1)
 local qnm1q = MbDUu1:FindFirstChild("__BolongGenProgress__")
 if qnm1q then
qnm1q.Destroy(qnm1q)
 end
MbDUu1:SetAttribute("__BolongGenLastPct__", nil)
end
end
end
if Settings.espPalletEnabled then
 for pDox0wQ__, HX1OUpNlDmxQl in ipairs(ESPState.cachedMapObjects.Pallets) do
 if HX1OUpNlDmxQl and HX1OUpNlDmxQl.Parent then
 local inst19 = ESPState.cachedPalletMeta[HX1OUpNlDmxQl]
 if inst19 and not inst19.isFakethen func10(HX1OUpNlDmxQl, Settings.espPalletColor)
 end
end
end
else
for bOHqqWIbxXDIX, WDpuWDZuwNv in ipairs(ESPState.cachedMapObjects.Pallets) do
 if WDpuWDZuwNv then
func11(WDpuWDZuwNv)
 end
end
end
if Settings.espHookEnabled then
 for v0WlDvl, bMmzqquHlp1u in ipairs(ESPState.cachedMapObjects.Hooks) do
 if bMmzqquHlp1u and bMmzqquHlp1u.Parentthen
 local tbl1 = ESPState.cachedHookMeshParts[bMmzqquHlp1u]
 if tbl1 then
 for D0HXHNZqZZ0I, oxwMo in ipairs(tbl1) do
func10(oxwMo, Settings.espHookColor)
 end
else func10(bMmzqquHlp1u, Settings.espHookColor)
 end
end
end
else
for D0NNI1OZ, _pIWI1pqn in ipairs(ESPState.cachedMapObjects.Hooks) do
 if _pIWI1pqn and _pIWI1pqn.Parent then
 local inst20 = ESPState.cachedHookMeshParts[_pIWI1pqn]
 if inst20 then
 for uHq1WmmODzU0, DDZpWH in ipairs(inst20) do
func11(DDZpWH)
 end
else func11(_pIWI1pqn)
 end
end
end
end
if Settings.espGateEnabledthen
for qMWOo, MUDbQmnUUIUqZ in ipairs(ESPState.cachedMapObjects.Gates) do
 if MUDbQmnUUIUqZ and MUDbQmnUUIUqZ.Parent then
func10(MUDbQmnUUIUqZ, Settings.espGateColor)
 end
end
else
for QmuwobOow__N1, lz_XNIUz in ipairs(ESPState.cachedMapObjects.Gates) do
 if lz_XNIUz and lz_XNIUz.Parent then
func11(lz_XNIUz)
 end
end
end
if Settings.espWindowEnabledthen func25()
for _qWD_1, _NnnN in pairs(ESPState.windowEspObjects) do
 if _qWD_1 and _qWD_1.Parentand _NnnN and _NnnN.Parent then
pcall(
 function()
 local remote1 = Settings.espWindowColor_NnnN.Color3 = remote1 _NnnN.Size = _qWD_1.Size
 end)
else func22(_qWD_1)
end
end
else
for H0zOZZuMN11, bmvQoqMx in pairs(ESPState.windowEspObjects) do
func22(H0zOZZuMN11)
end
end
end
local function func27()
local inst21 = {}
local inst22 = workspace:FindFirstChild("Map")
if inst22 then
 for WbXZIID, bpquZbWbm1QNn in ipairs(inst22.GetDescendants(inst22)) do
 if(bpquZbWbm1QNn.Name=="Window" or bpquZbWbm1QNn.Name=="VaultPoint" or string.find(bpquZbWbm1QNn.Name,"Window")) then
 if bpquZbWbm1QNn:IsA("BasePart") or bpquZbWbm1QNn:IsA("Model") then
table.insert(inst21, bpquZbWbm1QNn)
 end
end
 end
end
for HXonvQmoQvMDu, WoHDm in ipairs(CollectionService:GetTagged("VaultPoint")) do
table.insert(inst21, WoHDm)
end
return inst21
end
local function func28()
if not ESPState.antiLoopWindowEnabledthen
return
end
local WwlXu = ReplicatedStorage:FindFirstChild("Remotes")
if not WwlXu then
 return
end
local gen12 = WwlXu:FindFirstChild("Window")
if not gen12 then
 return
end
local gen13 = gen12:FindFirstChild("VaultEvent")
if not gen13 then
 return
end
task.spawn(
function()
task.wait(1)
local gen14 = func27()
for WMO0QDwO1, I0Qm1Z_ in ipairs(gen14) do
task.spawn(
 function() pcall(
 function() gen13:FireServer(I0Qm1Z_, true)
end)
end)
task.wait(0.05)
end
end)
end
local function func29()
local inst23 = ReplicatedStorage:FindFirstChild("Remotes")
if not inst23 then
 return
end
local inst24 = inst23:FindFirstChild("Window")
if not inst24 then
 return
end
local pallet5 = inst24:FindFirstChild("VaultCompleteEvent")
local pallet6 = inst24:FindFirstChild("VaultCompleteEventpart1")
task.spawn(
function()
local pallet7 = func27()
for MIHUbUuNWN0M, QwH0plnlq1pbZ in ipairs(pallet7) do
task.spawn(
 function() pcall(
 function()
 if pallet5 then
pallet5:FireServer(QwH0plnlq1pbZ, false)
 end
if pallet6 then
pallet6.FireServer(pallet6)
 end
end)
end)
task.wait(0.05)
end
end)
end
do
 local pallet8 = workspace:FindFirstChild("Map")
 if pallet8 then
func20(pallet8) func28()
 end
workspace.ChildAdded:Connect(
 function(vmuxlQOU_bMz)
 if vmuxlQOU_bMz.Name=="Map" then
task.wait(2) func20(vmuxlQOU_bMz) func28()
 end
end)
workspace.ChildRemoved:Connect(
function(pMoQmlzpxvZ)
if pMoQmlzpxvZ.Name=="Map" then
ESPState.cachedMapObjects = { Generators = {}, Pallets = {}, Hooks = {}, Gates = {}} ESPState.cachedPalletMeta = {};
ESPState.cachedHookMeshParts = {} ESPState.completedGenerators = {};
ESPState.objEspInitialized = false ESPState.genIndices = {};
ESPState.nextGenIndex = 1
end
end)
end
CreateESPEntry("GenESPUpdater", 0.2,
function()
if not Settings.espGeneratorEnabled and not Settings.espGeneratorProgressGenthen
return
end
for lImD_QD_wnX0M, I_uWOH1lQMwD in ipairs(ESPState.cachedMapObjects.Generators) do
 if I_uWOH1lQMwD and I_uWOH1lQMwD.Parent and not ESPState.completedGenerators[I_uWOH1lQMwD] then
func12(I_uWOH1lQMwD)
 end
end
end)
local function func30()
if not getnilinstances then
ShowNotify("Error","Executor tidak support getnilinstances()", 2)
 return
end
task.spawn(
function()
local pallet9 = ReplicatedStorage:FindFirstChild("Remotes")
if not pallet9 then
 return
end
local pallet10 = pallet9:FindFirstChild("Pallet")
pallet10 = pallet10 and pallet10:FindFirstChild("PalletDropEvent")
if not pallet10 then
 return
end
local pallet11 = {}
local pallet12 = {}
local oIzQXNnZ, b1HUvOU = pcall(getnilinstances)
if oIzQXNnZ and type(b1HUvOU)=="table" then
 for poU0MQnUvvpw, BIvHI_OwoU1 in ipairs(b1HUvOU) do
 if typeof(BIvHI_OwoU1)=="Instance" then
 local tbl2 = BIvHI_OwoU1.Name
 if tbl2=="PalletPointSlide" or tbl2=="palletDropPoint" or tbl2=="PalletDropPoint" or tbl2=="PalletPoint" then
 if not pallet12[BIvHI_OwoU1] then
table.insert(pallet11, BIvHI_OwoU1) pallet12[BIvHI_OwoU1]= true
 end
end
 end
end
end
for oqDXw, pXzWqqH0mH in ipairs(workspace.GetDescendants(workspace)) do
 local val3 = pXzWqqH0mH.Name
 if val3=="PalletPointSlide" or val3=="palletDropPoint" or val3=="PalletDropPoint" or val3=="PalletPoint" then
 if not pallet12[pXzWqqH0mH] then
table.insert(pallet11, pXzWqqH0mH) pallet12[pXzWqqH0mH]= true
 end
end
end
if#pallet11== 0 then
 return
end
for bO0DbZUn, WD1XvmuQHIIDUU in ipairs(pallet11) do
pcall(
 function() pallet10:FireServer(WD1XvmuQHIIDUU)
end)
end
end)
end
CreateESPEntry("AutoDropNearbyPallets", 0.2,
function()
if not ESPState.autoDropNearbyPallets then
 return
end
if ESPState.autoDropCooldown then
 return
end
local inst25 = LocalPlayer.Characterif not inst25 then
 return
end
local remote2 = inst25:FindFirstChild("HumanoidRootPart")
if not remote2 then
 return
end
local remote3 = ReplicatedStorage:FindFirstChild("Remotes")
if not remote3 then
 return
end
local remote4 = remote3:FindFirstChild("Pallet")
remote4 = remote4 and remote4:FindFirstChild("PalletDropEvent")
if not remote4 then
 return
end
local tbl3 = remote2.Positionif not ESPState.palletPointsCache or(tick()- ESPState.lastPalletPointScan> 5) then
ESPState.lastPalletPointScan = tick()
ESPState.palletPointsCache = {}
 local function func31(QzUxX)
 if typeof(QzUxX)~="Instance" then
 return false
 end
local inst26 = QzUxX.Name
 if inst26=="PalletPointSlide" or inst26=="palletDropPoint" or inst26=="PalletDropPoint" or inst26=="PalletPoint" then
 return true
 end
return false
end
if getnilinstances then
 local vHXMDQl, OmUlmql_ = pcall(getnilinstances)
 if vHXMDQl and type(OmUlmql_)=="table" then
 for opNlIXw1WmuX, umn0lXxwqn in ipairs(OmUlmql_) do
 if func31(umn0lXxwqn) then
table.insert(ESPState.palletPointsCache, umn0lXxwqn)
 end
end
 end
end
for MxDZnMQNxnDIH1, wMbNZIo0Ww0wu in ipairs(workspace.GetDescendants(workspace)) do
 if func31(wMbNZIo0Ww0wu) then
table.insert(ESPState.palletPointsCache, wMbNZIo0Ww0wu)
 end
end
end
local inst27 = nil
local inst28 = math.huge
for HNXqD = #ESPState.palletPointsCache, 1,- 1 do
 local inst29 = ESPState.palletPointsCache[HNXqD]
 if not inst29 or not inst29.Parentthen table.remove(ESPState.palletPointsCache, HNXqD)
else
local pcall1 = nil pcall(
function()
if inst29:IsA("BasePart") then
pcall1 = inst29.Positionelseif inst29:IsA("Model") then
pcall1 = inst29.GetPivot(inst29).Positionelseif inst29:IsA("Attachment") then
pcall1 = inst29.WorldPositionend
 end)
 if not pcall1 then
 local char5 = inst29:FindFirstChildWhichIsA("BasePart", true)
 if char5 then
pcall1 = char5.Positionend
 end
if pcall1 then
 local inst30 = (pcall1- tbl3).Magnitude
 if inst30< inst28 then
inst28 = inst30 inst27 = inst29
 end
end
 end
end
 if inst27 and inst28<= 4 then
pcall(
 function() remote4:FireServer(inst27)
 end)
 for HqXHp, WpNv1W in ipairs(ESPState.palletPointsCache) do
 if WpNv1W== inst27 then
table.remove(ESPState.palletPointsCache, HqXHp) break
 end
end ESPState.autoDropCooldown = true task.delay(2,
 function()
ESPState.autoDropCooldown = false
end)
end
end)
local function func32(ubvQnDlpZXm0pH, pn0UOxNHUzlD)
if not Settings.hitboxEnabledthen
return
end
if not pn0UOxNHUzlD then
 return
end
local gui10 = GetPlayerRole(ubvQnDlpZXm0pH)
local gui11 = (gui10=="killer") and Settings.killerHitboxSize or Settings.survivorHitboxSize
local gui12 = gui11/ 100
local gui13 = pn0UOxNHUzlD:FindFirstChild("HumanoidRootPart")
if gui13 and gui13:IsA("BasePart") then
 if not ESPState.hitboxOriginalSizes[gui13] then
ESPState.hitboxOriginalSizes[gui13]= gui13.Sizeend
 local v19 = 2
 local v20 = Vector3.new(v19* gui12, v19* gui12, v19* gui12) pcall(
 function()
gui13.Size = v20 gui13.Transparency = 1 gui13.CanCollide = false
 end)
end
end
local function func33(Bo1Hp, I0WUnxn0Qb)
if not I0WUnxn0Qb then
 return
end
local color7 = I0WUnxn0Qb:FindFirstChild("HumanoidRootPart")
if color7 and color7:IsA("BasePart") then
 local char6 = ESPState.hitboxOriginalSizes[color7]
 if char6 then
pcall(
 function()
color7.Size = char6 color7.Transparency = 1
 end)
ESPState.hitboxOriginalSizes[color7]= nil
end
end
end
local function func34()
if not Settings.hitboxEnabled then
 return
end
for HowX_, wNW0I1Z in ipairs(Players.GetPlayers(Players)) do
 if wNW0I1Z~= LocalPlayer and wNW0I1Z.Characterthen func32(wNW0I1Z, wNW0I1Z.Character)
end
end
end
local function func35()
for pMXunI, O0lzqwl in ipairs(Players.GetPlayers(Players)) do
 if O0lzqwl~= LocalPlayer and O0lzqwl.Character then
func33(O0lzqwl, O0lzqwl.Character)
 end
end
end
local function func36(N_lZDH, Dlm1b)
if N_lZDH== LocalPlayer then
 return
end
local pcall2 = Dlm1b and Dlm1b:FindFirstChild("HumanoidRootPart")
if not pcall2 then
 return
end
local v21 = ESPState.hitboxEspObjects[N_lZDH]
if v21 and v21.Parentthen
if v21.Adornee== pcall2 then
 return
end
v21.Destroy(v21)
end
local remote5 = GetPlayerRole(N_lZDH)
local remote6 = (remote5=="killer") and Settings.hitboxEspKillerColor or Settings.hitboxEspSurvivorColorlocal remote7 = Instance.new("SelectionBox")
remote7.Adornee = pcall2;
remote7.Color3 = remote6;
remote7.LineThickness = 0.10 remote7.SurfaceTransparency = Settings.hitboxEspOutlineOnlyand1or Settings.hitboxEspTransparency remote7.SurfaceColor3 = remote6;
remote7.Parent = ESPFramesFolder ESPState.hitboxEspObjects[N_lZDH]= remote7
end
local function func37(W0D0OMWbUmvH)
local conn4 = ESPState.hitboxEspObjects[W0D0OMWbUmvH]
if conn4 then
pcall(
 function() conn4:Destroy()
end);
ESPState.hitboxEspObjects[W0D0OMWbUmvH]= nil
end
end
local function func38()
for wQXOnI, qHHpZ1zv_1_HUb in pairs(ESPState.hitboxEspObjects) do
 if qHHpZ1zv_1_HUb and qHHpZ1zv_1_HUb.Parentthen
 local char7 = GetPlayerRole(wQXOnI)
 local char8 = (char7=="killer") and Settings.hitboxEspKillerColoror Settings.hitboxEspSurvivorColorqHHpZ1zv_1_HUb.Color3 = char8;
qHHpZ1zv_1_HUb.SurfaceColor3 = char8 qHHpZ1zv_1_HUb.SurfaceTransparency = Settings.hitboxEspOutlineOnly and 1 or Settings.hitboxEspTransparency
end
end
end
local function func39()
for BmMHwNzupXMq, vmwQM in ipairs(Players.GetPlayers(Players)) do
 if vmwQM~= LocalPlayer and vmwQM.Character then
func36(vmwQM, vmwQM.Character)
 end
end
end
local function func40()
for WmzlpZ1NvQ_wl, u1vHO in pairs(ESPState.hitboxEspObjects) do
func37(WmzlpZ1NvQ_wl)
end
end
local function func41()
if ESPState.SpeedBoostInit then
 local char9 = math.clamp(ESPState.BoostPercent, 0, 100)* 2
 return MagicConst*(1+ char9/ 100)
end
return MagicConst
end
local function func42(uDx1MUnXNv, pnHwb)
if not uDx1MUnXNv or not uDx1MUnXNv.Parent then
 return
end
if math.abs(uDx1MUnXNv.WalkSpeed- pnHwb)> 0.05 then
pcall(
 function()
uDx1MUnXNv.WalkSpeed = pnHwb
end)
end
end
local function func43()
task.spawn(
function()
local QqOnNDxpnx, DwMnmDwQ = pcall(
function()
return game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 10):WaitForChild("Mechanics", 10):WaitForChild("Fall", 10)
end)
if not QqOnNDxpnx or not DwMnmDwQ then
 return
end
local qzwUuwzp qzwUuwzp = hookmetamethod(game,"__namecall",
function(OXZXZZO0WHNov,..)
local char10 = getnamecallmethod()
if ESPState.AntiFallSlow and char10=="FireServer" and rawequal(OXZXZZO0WHNov, DwMnmDwQ) then
 return
end
return qzwUuwzp(OXZXZZO0WHNov,..)
end)
end)
end
local function func44(NvxQWH)
if ESPState.movConns.antiFall then
ESPState.movConns.antiFall:Disconnect()
end
func43()
if not NvxQWH then
 return
end
pcall(
function() NvxQWH:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
end)
ESPState.movConns.antiFall = NvxQWH.StateChanged:Connect(
function(lMW0UbWUM_q, Mu1uO__bXOnmwU)
if not ESPState.AntiFallSlowthen
return
end
if Mu1uO__bXOnmwU== Enum.HumanoidStateType.Landed or Mu1uO__bXOnmwU== Enum.HumanoidStateType.GettingUp or Mu1uO__bXOnmwU== Enum.HumanoidStateType.FallingDownthen pcall(
function() NvxQWH:ChangeState(Enum.HumanoidStateType.Running)
end) func42(NvxQWH, func41())
end
end)
end
local function func45(MlmIp0v)
if ESPState.movConns.antiFall then
ESPState.movConns.antiFall:Disconnect();
ESPState.movConns.antiFall = nil
end
if MlmIp0v and MlmIp0v.Parentthen pcall(
function() MlmIp0v:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
end)
end
end
local function func46(NXwX1OX)
if ESPState.movConns.noSlow then
ESPState.movConns.noSlow:Disconnect();
ESPState.movConns.noSlow = nil
end
if not NXwX1OX then
 return
end
if GetPlayerRole(LocalPlayer)=="killer" then
 return
end
ESPState.movConns.noSlow = NXwX1OX:GetPropertyChangedSignal("WalkSpeed"):Connect(
function()
if not ESPState.NoSlowdownthen
return
end
if GetPlayerRole(LocalPlayer)=="killer" then
 return
end
local gui14 = LocalPlayer.Character
if ESPState.safeModeSpeedand gui14 and(gui14:GetAttribute("IsHooked") or gui14:GetAttribute("IsCarried") or NXwX1OX.Health<= 50) then
 return
end
local color8 = func41()
if NXwX1OX.WalkSpeed< color8- 0.05 then
pcall(
 function()
NXwX1OX.WalkSpeed = color8
end)
end
end)
end
local function func47(BlMboH)
if not BlMboH then
 return
end
local conn5 = BlMboH:WaitForChild("Humanoid", 5)
if not conn5 then
 return
end
if ESPState.AntiFallSlowthen func44(conn5)
end
if ESPState.NoSlowdownand GetPlayerRole(LocalPlayer)~="killer" then
func46(conn5)
end
if ESPState.SpeedBoostInitthen
local gui15 = func41()
task.wait(0.15)
if not ESPState.safeModeSpeedor(conn5.Health> 50 and not(BlMboH:GetAttribute("IsHooked") or BlMboH:GetAttribute("IsCarried"))) then
func42(conn5, gui15)
end
end
end
local function func48(Duo0IW)
if not Duo0IW then
 return
end
local gui16 = Duo0IW:WaitForChild("Humanoid", 5)
if not gui16 then
 return
end
if ESPState.AntiFallSlowthen func44(gui16)
end
if ESPState.NoSlowdown and GetPlayerRole(LocalPlayer)~="killer" then
func46(gui16)
end
if ESPState.SpeedBoostInit then
 local inst31 = func41()
task.wait(0.15) func42(gui16, inst31)
end
end LocalPlayer:GetPropertyChangedSignal("Team"):Connect(
function() IsPlayerAlive(LocalPlayer)
if GetPlayerRole(LocalPlayer)=="killer" and ESPState.movConns.noSlow then
ESPState.movConns.noSlow:Disconnect();
ESPState.movConns.noSlow = nil
end
end)
local function func49()
if ESPState.moonwalkGuithen
return
end
local inst32 = LocalPlayer:WaitForChild("PlayerGui")
local inst33 = Instance.new("ScreenGui")
inst33.Name = "BolongHubMoonwalk" inst33.ResetOnSpawn = false inst33.Enabled = false inst33.Parent = inst32
local inst34 = Instance.new("Frame")
inst34.Name = "MoonwalkBtns" inst34.AnchorPoint = Vector2.new(1, 1)
inst34.Position = UDim2.new(1,- 18, 1,- 170)
inst34.Size = UDim2.fromOffset(46, 96)
inst34.BackgroundTransparency = 1 inst34.Parent = inst33
local function func50(q_Uq__, unxuMXIw)
local WnoWx = Instance.new("ImageButton")
WnoWx.BackgroundTransparency = 1 WnoWx.BorderSizePixel = 0 WnoWx.AutoButtonColor = false WnoWx.AnchorPoint = Vector2.new(0.5, 0)
WnoWx.Position = UDim2.new(0.5, 0, 0, unxuMXIw)
WnoWx.Size = UDim2.fromOffset(42, 42)
WnoWx.Image = "rbxassetid://125598796341580" WnoWx.ScaleType = Enum.ScaleType.SliceWnoWx.ImageColor3 = Color3.fromRGB(170, 170, 170)
WnoWx.ImageTransparency = 0.25 WnoWx.Rotation = q_Uq__ WnoWx.Parent = inst34
return WnoWx
end
local gui17 = func50(- 90, 0)
local gui18 = func50(90, 50)
local function func51(vovUMqlqwwQO, upHxIppzXMmDo)
vovUMqlqwwQO.InputBegan:Connect(
function(uUIwHuXlp)
if uUIwHuXlp.UserInputType== Enum.UserInputType.Touch or uUIwHuXlp.UserInputType== Enum.UserInputType.MouseButton1 then
ESPState.moonwalkMobileDir = upHxIppzXMmDo vovUMqlqwwQO.ImageColor3 = Color3.fromRGB(255, 255, 255)
vovUMqlqwwQO.ImageTransparency = 0
end
end)
vovUMqlqwwQO.InputEnded:Connect(
function(D_zlDHMpM1Qm)
if D_zlDHMpM1Qm.UserInputType== Enum.UserInputType.Touch or D_zlDHMpM1Qm.UserInputType== Enum.UserInputType.MouseButton1then ESPState.moonwalkMobileDir = 0 vovUMqlqwwQO.ImageColor3 = Color3.fromRGB(170, 170, 170)
vovUMqlqwwQO.ImageTransparency = 0.25
end
end)
end
func51(gui17, 1) func51(gui18,- 1)
ESPState.moonwalkGui = inst33
end
local function func52(M0QznbDpv)
if M0QznbDpv:FindFirstChild("BolongMoonwalkAlign") then
 return M0QznbDpv:FindFirstChild("BolongMoonwalkAlign")
end
local char11 = Instance.new("Attachment")
char11.Name = "BolongMoonwalkAtt" char11.Parent = M0QznbDpv
local char12 = Instance.new("AlignOrientation")
char12.Name = "BolongMoonwalkAlign" char12.Mode = Enum.OrientationAlignmentMode.OneAttachmentbXHIObpxqm0QO.Attachment0 = char11 char12.MaxTorque = 1000000 bXHIObpxqm0QO.Responsiveness = 15 char12.Parent = M0QznbDpv
return char12
end
local function func53(QUopDNNZIznDu)
local char13 = QUopDNNZIznDu:FindFirstChild("BolongMoonwalkAlign")
local char14 = QUopDNNZIznDu:FindFirstChild("BolongMoonwalkAtt")
if char13 then
char13.Destroy(char13)
end
if char14 then
char14.Destroy(char14)
end
end CreateESPEntry("MoonwalkLock", 0,
function(uzvIm1Nbnq0HNn)
if not Settings.moonwalkEnabledthen
return
end
local char15 = LocalPlayer.Character
local char16 = char15 and char15:FindFirstChildOfClass("Humanoid")
local char17 = char15 and char15:FindFirstChild("HumanoidRootPart")
local inst35 = Workspace.CurrentCameraif not char16 or not char17 or not inst35 then
 return
end
local inst36 = 0
if ESPState.moonwalkPCForwardthen inst36 = 1
end
if ESPState.moonwalkPCBackwardthen inst36 = -1
end
if ESPState.moonwalkMobileDir~= 0 then
inst36 = ESPState.moonwalkMobileDir
end
if inst36== 0 then
 if not char16.AutoRotate then
char16.AutoRotate = true
 end
func53(char17)
 return
end
char16.AutoRotate = false
local inst37 = func52(char17)
local inst38 = inst35.CFrame.LookVector
local inst39 = Vector3.new(inst38.X, 0, inst38.Z)
if inst39.Magnitude> 0.001 then
inst39 = inst39.Unit
 local inst40 = (inst36== 1) and inst39 or- inst39
 local inst41 = CFrame.lookAt(Vector3.new(0, 0, 0), inst40)
inst37.CFrame = inst41
end
end)
local function func54()
ESPState.godEnabled = true;
ESPState.godLastHP = nil pcall(
function()
local inst42 = LocalPlayer.Character
if inst42 then
 local inst43 = inst42:FindFirstChildOfClass("Humanoid")
 if inst43 then
inst43:SetStateEnabled(Enum.HumanoidStateType.Dead, false) inst43:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false) inst43:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
 end
end
end)
end
local function func55()
ESPState.godEnabled = false;
ESPState.godLastHP = nil pcall(
function()
local gui19 = LocalPlayer.Character
if not gui19 then
 return
end
local inst44 = gui19:FindFirstChildOfClass("Humanoid")
if not inst44 then
 return
end
inst44:SetStateEnabled(Enum.HumanoidStateType.Dead, true) inst44:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true) inst44:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
end)
end
CreateESPEntry("GodMode", 0.2,
function()
if not ESPState.godEnabledthen
return
end
local gui20 = LocalPlayer.Characterif not gui20 then
 return
end
local gui21 = gui20:FindFirstChildOfClass("Humanoid")
if not gui21 then
 return
end
local gui22 = gui21.MaxHealthlocal gui23 = gui21.Healthif ESPState.godLastHP~= nil and gui23< ESPState.godLastHPand gui23> 0 then
pcall(
 function()
gui21.Health = gui22
end)
end
ESPState.godLastHP = gui21.Healthpcall(
function()
local gen15 = gui21.GetState(gui21)
if gen15== Enum.HumanoidStateType.Deadthen gui21.Health = gui22;
gui21:ChangeState(Enum.HumanoidStateType.Running);
ESPState.godLastHP = gui22
elseif gen15== Enum.HumanoidStateType.Ragdoll or gen15== Enum.HumanoidStateType.FallingDownthen gui21:ChangeState(Enum.HumanoidStateType.GettingUp)
end
end)
end)
local flag5 = { active = false, target = nil, generator = nil}
local gen16 = ReplicatedStorage.Remotes.KillerPerks.kingscourge:WaitForChild("KingScourgeStart")
local gen17 = ReplicatedStorage.Remotes.KillerPerks.kingscourge:WaitForChild("KingScourgeEnd")
gen16.OnClientEvent:Connect(
function(WOHbMonN, MOqXmo, _DzI0UblIDqXnU)
flag5.active = true;
flag5.target = MOqXmo;
flag5.generator = WOHbMonN
end)
gen17.OnClientEvent:Connect(
function()
flag5.active = false;
flag5.target = nil;
flag5.generator = nil
end)
local function func56()
for HDbNWQzIpQMvXl, QXuowX_bv in ipairs({"SkillCheckPromptGui","SkillCheckPromptGui-con"}) do
 local gen18 = PlayerGui:FindFirstChild(QXuowX_bv, true)
 if gen18 then
 local gen19 = gen18:FindFirstChild("Check", true)
 if gen19 and gen19.Visiblethen
 return gen19:FindFirstChild("Line", true), gen19:FindFirstChild("Goal", true)
 end
end
end
end
local gen20 = nil
local function func57()
if gen20 and gen20.Parentthen
return gen20
end
local v22 = PlayerGui:FindFirstChild("Survivor-mob", true)
if not v22 then
 return nil
end
local v23 = v22:FindFirstChild("Controls", true)
if not v23 then
 return nil
end
local gen21 = v23:FindFirstChild("action")
if gen21 and gen21:IsA("GuiButton") then
gen20 = gen21;
 return gen21
end
gen21 = v23:FindFirstChild("Gui-mob")
if gen21 and gen21:IsA("GuiButton") then
gen20 = gen21;
 return gen21
end
return nil
end
local function func58()
local char18 = func57()
if char18 and type(firesignal)=="function" then
firesignal(char18.MouseButton1Down)
task.delay(0.05,
 function()
 if char18 and char18.Parentthen firesignal(char18.MouseButton1Up) firesignal(char18.MouseButton1Click)
end
end)
return
end
local plplxbp = PlayerGui:FindFirstChild("check", true)
if plplxbp and plplxbp:IsA("GuiObject") and plplxbp.Visible then
 local inst45 = plplxbp.AbsolutePosition;
 local inst46 = plplxbp.AbsoluteSize
 local inst47 = GuiService.GetGuiInset(GuiService)
 local inst48 = inst45.X+(inst46.X/ 2)+ inst47.X;
 local inst49 = inst45.Y+(inst46.Y/ 2)+ inst47.Ypcall(
 function() VirtualInputManager:SendMouseButtonEvent(inst48, inst49, 0, true, game, 1)
task.wait(0.01) VirtualInputManager:SendMouseButtonEvent(inst48, inst49, 0, false, game, 1)
end)
else VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait() VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
end
end CreateESPEntry("Generator", 0,
function()
if not Settings.autoGeneratorthen
return
end
local lOUpNUZWxo, bvq0NXowOHZO_ = func56()
if not(lOUpNUZWxo and bvq0NXowOHZO_) then
ESPState.instantLastVisible = false ESPState.lastGoalRot = nil ESPState.prevLr = nil
 return
end
local gui24 = bvq0NXowOHZO_.Rotationlocal gui25 = lOUpNUZWxo.Rotationlocal gui26 = tick()
local gui27 = flag5.activeand 0.05 or 0.1
if gui26- ESPState.lastPressTime< gui27 then
ESPState.prevLr = gui25
 return
end
if Settings.autoGeneratorMode=="Instant" then
 if not ESPState.instantLastVisible or gui24~= ESPState.lastGoalRotthen lOUpNUZWxo.Rotation = gui24+ 109 ESPState.lastGoalRot = gui24 ESPState.instantLastVisible = true ESPState.lastPressTime = gui26 ESPState.lastSkillHit = gui26 func58()
end
else
local flag6 = (gui25- gui24)% 360
local char19 = -1
if ESPState.prevLrand ESPState.lastGoalRot== gui24 then
char19 = (ESPState.prevLr- gui24)% 360
end
ESPState.lastGoalRot = gui24
local pqxWvZp1Q, _lpIZ1OX
if Settings.autoGeneratorMode=="Perfect" then
pqxWvZp1Q = 102 _lpIZ1OX = 116
elseif Settings.autoGeneratorMode=="Normal" then
pqxWvZp1Q = 116 _lpIZ1OX = 159
elseif Settings.autoGeneratorMode=="Random" then
 if not ESPState.randomIsNeutralthen pqxWvZp1Q = 102;
_lpIZ1OX = 116
else pqxWvZp1Q = 116;
_lpIZ1OX = 159
end
else
return
end
local char20 = flag6>= pqxWvZp1Q and flag6<= _lpIZ1OX
local char21 = char19>= 0 and char19< pqxWvZp1Q and flag6> _lpIZ1OX
if char20 or char21 then
 if char21 then
lOUpNUZWxo.Rotation = gui24+(pqxWvZp1Q+ _lpIZ1OX)/ 2
 end
ESPState.lastPressTime = gui26 ESPState.lastSkillHit = gui26 func58()
 if Settings.autoGeneratorMode=="Random" then
ESPState.randomIsNeutral = not ESPState.randomIsNeutral
 end
end
end
ESPState.prevLr = gui25
end) CreateESPEntry("GenBtnRefresh", 2.0,
function()
if not Settings.autoGenerator then
 return
end
if not gen20 or not gen20.Parent then
func57()
end
end) CreateESPEntry("KillerWarn", 0.1,
function()
if not Settings.warnEnabledthen
local inst50 = LocalPlayer.Character
local inst51 = inst50 and inst50:FindFirstChild("HumanoidRootPart")
if inst51 then
 local inst52 = inst51:FindFirstChild("KillerWarn")
 if inst52 then
inst52.Destroy(inst52)
 end
end
return
end
local val4 = LocalPlayer.Character
local val5 = val4 and val4:FindFirstChild("HumanoidRootPart")
if not val5 then
 return
end
local flag7 = math.huge
for u01Mv, Q1ZWqnvWDm in pairs(ESPState.espObjects) do
 if u01Mv and u01Mv.Parentthen
 local flag8 = GetPlayerRole(u01Mv)
 if flag8=="killer" then
 local char22 = u01Mv.Character
 local inst53 = char22 and char22:FindFirstChild("HumanoidRootPart")
 if inst53 then
 local inst54 = (inst53.Position- val5.Position).Magnitude
 if inst54< flag7 then
flag7 = inst54
 end
end
 end
end
end
local inst55 = val5:FindFirstChild("KillerWarn")
if flag7<= Settings.warnDist1then
local bODN0xqNUQ, Im1ZObOzIZO
if flag7<= Settings.warnDist3then bODN0xqNUQ = "!!!";
Im1ZObOzIZO = Color3.fromRGB(255, 0, 0)
elseif flag7<= Settings.warnDist2then bODN0xqNUQ = "!!";
Im1ZObOzIZO = Color3.fromRGB(255, 80, 0)
else bODN0xqNUQ = "!";
Im1ZObOzIZO = Color3.fromRGB(255, 160, 0)
end
if not inst55 then
inst55 = func3(bODN0xqNUQ, Im1ZObOzIZO, UDim2.new(0, 40, 0, 40), 22)
inst55.Name = "KillerWarn";
inst55.Parent = val5
else inst55.Label.Text = bODN0xqNUQ;
inst55.Label.TextColor3 = Im1ZObOzIZO
end
elseif inst55 then
inst55.Destroy(inst55)
end
end) CreateESPEntry("ESPValidator", 1,
function()
for IoO1qDW0, IZ1ZDvo_Z in pairs(ESPState.espObjects) do
func7(IoO1qDW0)
end
for HwDwQDNNN1lwZ, onIwXWqmUM in pairs(ESPState.outlineObjects) do
 if not ESPState.espObjects[HwDwQDNNN1lwZ] then
func7(HwDwQDNNN1lwZ)
 end
end
end) CreateESPEntry("ItemESP", 0.2,
function()
if not Settings.espItemEnabledthen
for uWXIZMUXZbXb_z, WHpQlnxX1qN in pairs(ESPState.espObjects) do
 if WHpQlnxX1qN and WHpQlnxX1qN.itemImageand WHpQlnxX1qN.itemImage.Visiblethen WHpQlnxX1qN.itemImage.Visible = false
end
end
return
end
local gui28 = LocalPlayer.Characterlocal gui29 = gui28 and gui28:FindFirstChild("HumanoidRootPart")
for pNvDMOUUwD, Ol_HX0HwnQ in pairs(ESPState.espObjects) do
 if Ol_HX0HwnQ and Ol_HX0HwnQ.billboard and Ol_HX0HwnQ.billboard.Parent and Ol_HX0HwnQ.itemBillboardthen
 if GetPlayerRole(pNvDMOUUwD)=="killer" then
 if Ol_HX0HwnQ.itemImage.Visiblethen Ol_HX0HwnQ.itemImage.Visible = false
 end
continue
end
local flag9 = pNvDMOUUwD.Characterlocal gui30 = nil
if flag9 then
 local gui31 = flag9:GetAttribute("EquippedItem") or flag9:GetAttribute("Equippedltem")
 if type(gui31)=="string" then
gui30 = gui31
 elseif typeof(gui31)=="Instance" then
gui30 = gui31.Nameend
 end
if not gui30 then
 local flag10 = pNvDMOUUwD:GetAttribute("EquippedItem") or pNvDMOUUwD:GetAttribute("Equippedltem")
 if type(flag10)=="string" then
gui30 = flag10
 elseif typeof(flag10)=="Instance" then
gui30 = flag10.Nameend
 end
local conn6 = func1(gui30)
 if conn6 then
 if Ol_HX0HwnQ.itemImage.Image~= conn6 then
Ol_HX0HwnQ.itemImage.Image = conn6
 end
if gui29 and flag9 then
 local conn7 = flag9:FindFirstChild("HumanoidRootPart")
 if conn7 then
 local conn8 = (gui29.Position- conn7.Position).Magnitude
 local gui32 = 1.5+((conn8/ 200)* 2)
gui32 = math.clamp(gui32, 1.5, 3.5)
Ol_HX0HwnQ.itemBillboard.Size = UDim2.new(gui32, 0, gui32, 0)
 end
end Ol_HX0HwnQ.itemImage.Visible = true
 else
 if Ol_HX0HwnQ.itemImage.Visible then
Ol_HX0HwnQ.itemImage.Visible = false
 end
end
elseif Ol_HX0HwnQ and Ol_HX0HwnQ.itemImage then
 if Ol_HX0HwnQ.itemImage.Visible then
Ol_HX0HwnQ.itemImage.Visible = false
 end
end
end
end) CreateESPEntry("SpeedBoostInit", 0,
function()
if not ESPState.SpeedBoostInitthen
return
end
local inst56 = LocalPlayer.Character
if not inst56 then
 return
end
local inst57 = inst56:FindFirstChildOfClass("Humanoid")
if not inst57 then
 return
end
if ESPState.safeModeSpeedand(inst56:GetAttribute("IsHooked") or inst56:GetAttribute("IsCarried") or inst57.Health<= 50) then
 return
end
local gui33 = func41()
if gui33<= 0 then
 return
end
local gui34 = MagicConst*(math.clamp(ESPState.BoostPercent, 0, 100)/ 100)
ESPState._jitterFlip = not ESPState._jitterFliplocal gui35 = ESPState._jitterFlipand(gui33+ gui34) or gui33
if math.abs(inst57.WalkSpeed- gui35)> 0.1 then
pcall(
 function()
inst57.WalkSpeed = gui35
end)
end
end)
local function func59(lUzXI1W_MDzp, bM110)
if not lUzXI1W_MDzp or not lUzXI1W_MDzp.Parentthen
return false
end
local gui36 = lUzXI1W_MDzp.AbsolutePosition;
local gui37 = lUzXI1W_MDzp.AbsoluteSize
local RoleName = gui36.X+ gui37.X/ 2;
local char23 = gui36.Y+ gui37.Y/ 2
local inst58 = math.min(gui37.X, gui37.Y)/ 2* 0.8
local inst59 = bM110.X- RoleName;
local inst60 = bM110.Y- char23
return(inst59* inst59+ inst60* inst60)<=(inst58* inst58)
end
local function func60(MlnmUOplZvIu)
if not MlnmUOplZvIu:IsA("ImageButton") then
 return
end
if MlnmUOplZvIu.Name~="Gui-mob" then
 return
end
if ESPState._hookedMobButtons[MlnmUOplZvIu] then
 return
end
ESPState._hookedMobButtons[MlnmUOplZvIu]= true UIS2.InputBegan:Connect(
function(boZzNnz0zQ)
if boZzNnz0zQ.UserInputType~= Enum.UserInputType.Touchthen
return
end
if not func59(MlnmUOplZvIu, boZzNnz0zQ.Position) then
 return
end
ESPState.HoldLockActive = true
local pHqMIqnwv pHqMIqnwv = UIS2.InputEnded:Connect(
function(u1X0Dp)
if u1X0Dp== boZzNnz0zQ then
ESPState.HoldLockActive = false pHqMIqnwv.Disconnect(pHqMIqnwv)
end
end)
end)
end
local char24 = {["Slasher-mob"]= true,["Masked-mob"]= true,["Hidden-mob"]= true,["Killer-mob"]= true,}
local function func61(O_vMx_)
if not(O_vMx_ and O_vMx_:IsA("GuiButton")) then
 return false
end
if O_vMx_.Name~="attack" then
 return false
end
local NXQnN, bHWbl = false, false
local inst61 = O_vMx_.Parent
while inst61 do
 if char24[inst61.Name] then
NXQnN = true
 end
if inst61.Name=="Controls" or inst61.Name=="Control" then
bHWbl = true
 end
inst61 = inst61.Parent
end
return NXQnN and bHWbl
end
local function func62(uuo1Iq1IOz)
if ESPState._hookedSlasherButtons[uuo1Iq1IOz] then
 return
end
ESPState._hookedSlasherButtons[uuo1Iq1IOz]= true uuo1Iq1IOz.InputBegan:Connect(
function(Mn0wNOv1)
if Mn0wNOv1.UserInputType== Enum.UserInputType.Touchor Mn0wNOv1.UserInputType== Enum.UserInputType.MouseButton1 then
ESPState.HoldLockActive = true
end
end)
uuo1Iq1IOz.InputEnded:Connect(
function(DmDlQ01zoQ0pMm)
if DmDlQ01zoQ0pMm.UserInputType== Enum.UserInputType.Touchor DmDlQ01zoQ0pMm.UserInputType== Enum.UserInputType.MouseButton1 then
ESPState.HoldLockActive = false
end
end)
end
local function BlmXw(qq1OIDUm0WUZ)
for MwqUbIb, wbHHUMmu0 in ipairs(qq1OIDUm0WUZ.GetDescendants(qq1OIDUm0WUZ)) do
 if wbHHUMmu0:IsA("ImageButton") and wbHHUMmu0.Name=="Gui-mob" then
func60(wbHHUMmu0)
 end
if func61(wbHHUMmu0) then
func62(wbHHUMmu0)
 end
end qq1OIDUm0WUZ.DescendantAdded:Connect(
function(NvuuxwIw11)
if NvuuxwIw11:IsA("ImageButton") and NvuuxwIw11.Name=="Gui-mob" then
func60(NvuuxwIw11)
end
if func61(NvuuxwIw11) then
func62(NvuuxwIw11)
end
end)
end
task.spawn(
function()
local val6 = LocalPlayer:WaitForChild("PlayerGui") BlmXw(val6)
end)
UIS2.InputBegan:Connect(
function(D1bHZDoOp, Nw_OOvII)
local val7 = GetPlayerRole(LocalPlayer)=="killer"
if val7 then
 if D1bHZDoOp.UserInputType== Enum.UserInputType.MouseButton1 then
ESPState.HoldLockActive = true
 end
else
if not Nw_OOvII and D1bHZDoOp.UserInputType== Enum.UserInputType.MouseButton2then ESPState.HoldLockActive = true
end
end
if not Nw_OOvII and D1bHZDoOp.UserInputType== Enum.UserInputType.Gamepad1and D1bHZDoOp.KeyCode== Enum.KeyCode.ButtonL2then ESPState.HoldLockActive = true
end
end)
UIS2.InputEnded:Connect(
function(qq1nlXWlMxvWqv)
if qq1nlXWlMxvWqv.UserInputType== Enum.UserInputType.MouseButton1or qq1nlXWlMxvWqv.UserInputType== Enum.UserInputType.MouseButton2then ESPState.HoldLockActive = false
end
if qq1nlXWlMxvWqv.UserInputType== Enum.UserInputType.Gamepad1 and qq1nlXWlMxvWqv.KeyCode== Enum.KeyCode.ButtonL2then ESPState.HoldLockActive = false
end
end) CreateESPEntry("HoldLock", 0.2,
function()
if not Settings.cameralockEnabledthen
return
end
if ESPState.HoldLockActivethen
return
end
local inst62 = LocalPlayer.Characterif inst62 and inst62:GetAttribute("Aiming")== true then
ESPState.HoldLockActive = true
end
end)
local function func63(pZZlXw_W)
if not pZZlXw_W then
 return nil
end
if Settings.cameralockAimPart=="Head" then
 local inst63 = pZZlXw_W:FindFirstChild("Head")
 if inst63 then
 return inst63.Position
 end
end
local gui38 = pZZlXw_W:FindFirstChild("UpperTorso")
if gui38 then
 return gui38.Positionend
 local gui39 = pZZlXw_W:FindFirstChild("Torso")
 if gui39 then
 return gui39.Position
 end
local gui40 = pZZlXw_W:FindFirstChild("HumanoidRootPart")
 if gui40 then
 return gui40.Position+(Settings.cameralockAimPart=="Head" and Vector3.new(0, 2.5, 0) or Vector3.new(0, 1.2, 0))
 end
return nil
end
function MainState.IxWX0_XNwuzw(oUXqlDUX, HNmZDb, MZ_wIn)
if not HNmZDb or not MZ_wIn or MZ_wIn.Health<= 0 then
 return false
end
if MZ_wIn.Health< 50 then
 return false
end
if HNmZDb:GetAttribute("IsHooked") then
 return false
end
if HNmZDb:GetAttribute("IsCarried") then
 return false
end
if oUXqlDUX:GetAttribute("IsHooked") then
 return false
end
if oUXqlDUX:GetAttribute("IsCarried") then
 return false
end
local inst64 = MZ_wIn.GetState(MZ_wIn)
if inst64== Enum.HumanoidStateType.PlatformStanding then
 return false
end
if inst64== Enum.HumanoidStateType.Physicsand MZ_wIn.PlatformStandthen
return false
end
local gui41 = HNmZDb:FindFirstChild("HumanoidRootPart")
if gui41 and gui41.Anchoredthen
return false
end
return true
end
function MainState._I_mHX_DbX(wZHX1lquluQ)
local gui42 = LocalPlayer.Characterlocal gui43 = gui42 and gui42:FindFirstChild("HumanoidRootPart")
if not gui43 then
 return nil
end
local gui44 = gui43.Positionlocal gui45 = 0.1
local gui46 = nil
local gui47 = Settings.cameralockMaxDistance
if wZHX1lquluQ and wZHX1lquluQ.Characterthen
local gui48 = wZHX1lquluQ.Character
local v24 = gui48:FindFirstChildOfClass("Humanoid")
local cam4 = func63(gui48)
if MainState.IxWX0_XNwuzw(wZHX1lquluQ, gui48, v24) and cam4 then
gui46 = wZHX1lquluQ gui47 = (cam4- gui44).Magnitude- gui45
end
end
for WXwlQDm0DpqNq, BDODNH_X in ipairs(Players.GetPlayers(Players)) do
 if BDODNH_X== LocalPlayer then
continue
 end
local cam5 = BDODNH_X.Characterif not cam5 then
continue
 end
local cam6 = cam5:FindFirstChildOfClass("Humanoid")
 if not MainState.IxWX0_XNwuzw(BDODNH_X, cam5, cam6) then
continue
 end
local cam7 = func63(cam5)
 if not cam7 then
continue
 end
local cam8 = GetPlayerRole(BDODNH_X)
 if Settings.cameralockTargetType=="Killer" and cam8~="killer" then
continue
 end
if Settings.cameralockTargetType=="Survivor" and cam8~="survivor" then
continue
 end
local cam9 = (cam7- gui44).Magnitude
 if cam9< gui47 then
gui47 = cam9;
gui46 = BDODNH_X
 end
end
return gui46
end
function MainState.vMvvZ()
if ESPState.aimConnthen ESPState.aimConn:Disconnect()
end
ESPState.aimTargetCache = nil;
ESPState.aimTargetT = 0;
ESPState.aimLastStableDir = nil ESPState.aimConn = RunService.RenderStepped:Connect(
function(o1ZuNZqQvU)
if not Settings.cameralockEnabled then
 return
end
if Settings.cameralockLockMode=="Hold to Lock" and not ESPState.HoldLockActive then
ESPState.aimTargetCache = nil;
ESPState.aimLastStableDir = nil;
 return
end
local flag11 = LocalPlayer.Character
if not flag11 then
 return
end
local flag12 = flag11:FindFirstChild("HumanoidRootPart")
if not flag12 then
 return
end
ESPState.aimTargetT = ESPState.aimTargetT+ o1ZuNZqQvU
if ESPState.aimTargetT>= 0.15 then
ESPState.aimTargetT = 0 ESPState.aimTargetCache = MainState._I_mHX_DbX(ESPState.aimTargetCache)
end
local conn9 = ESPState.aimTargetCache
if not conn9 then
ESPState.aimLastStableDir = nil;
 return
end
local conn10 = conn9.Characterif not conn10 then
ESPState.aimTargetCache = nil;
ESPState.aimLastStableDir = nil;
 return
end
local conn11 = conn10:FindFirstChildOfClass("Humanoid")
if not MainState.IxWX0_XNwuzw(conn9, conn10, conn11) then
ESPState.aimTargetCache = nil;
ESPState.aimLastStableDir = nil;
 return
end
local v25 = func63(conn10)
if not v25 then
ESPState.aimTargetCache = nil;
ESPState.aimLastStableDir = nil;
 return
end
local v26 = workspace.CurrentCameraif not v26 then
 return
end
local v27 = v26.CFrame
local v28 = v27.Positionlocal v29 = v27.LookVectorlocal flag13 = Settings.cameralockSmoothness
local vo_pz = v25- v28
local flag14 = vo_pz.Magnitude
local inst65 = (v25- flag12.Position).Magnitude
local inst66 = 4.0
local vOWnw1
if flag14>= inst66 and inst65>= 1.5 then
vOWnw1 = vo_pz.Unit;
ESPState.aimLastStableDir = vOWnw1
elseif ESPState.aimLastStableDir then
vOWnw1 = ESPState.aimLastStableDirelse vOWnw1 = v29
end
local gui49 = v29:Lerp(vOWnw1, flag13)
if gui49.Magnitude< 0.001 then
 return
end
v26.CFrame = CFrame.new(v28, v28+ gui49)
local inst67 = flag11:FindFirstChildOfClass("Humanoid")
if inst67 and not inst67.AutoRotate then
 local inst68 = v26.CFrame.LookVector
 local inst69 = flag12.Positionlocal DlDqmwXux = Vector3.new(inst68.X, 0, inst68.Z)
 if DlDqmwXux.Magnitude> 0.001 then
 local inst70 = math.atan2(flag12.CFrame.LookVector.X, flag12.CFrame.LookVector.Z)
 local gui50 = math.atan2(DlDqmwXux.X, DlDqmwXux.Z)
 local color9 = gui50- inst70 color9 = ((color9+ math.pi)%(2* math.pi))- math.pilocal color10 = inst70+ color9* 0.15
 local flag15 = math.sin(color10)
 local flag16 = math.cos(color10)
 local flag17 = inst69+ Vector3.new(flag15, 0, flag16)* 900 flag12.CFrame = CFrame.new(inst69, Vector3.new(flag17.X, inst69.Y, flag17.Z))
 end
end
end)
end
function MainState.Hq1wbQvMzoz()
if ESPState.aimConn then
ESPState.aimConn:Disconnect();
ESPState.aimConn = nil
end
ESPState.aimTargetCache = nil;
ESPState.aimLastStableDir = nil
end
function MainState.w_vnXUZ(wnMNU0bQnlX1)
if ESPState.originalMaxZoom== nil then
ESPState.originalMaxZoom = LocalPlayer.CameraMaxZoomDistance
end
LocalPlayer.CameraMaxZoomDistance = wnMNU0bQnlX1
end
function MainState.Ww1z_Ob0vX()
if ESPState.originalMaxZoom~= nil then
LocalPlayer.CameraMaxZoomDistance = ESPState.originalMaxZoom
end
ESPState.originalMaxZoom = nil
end
function MainState.BWQoHbUwlp0MZb(QQXuQ)
local v30 = workspace.CurrentCameraif not v30 then
 return
end
if ESPState.originalFOV== nil then
ESPState.originalFOV = v30.FieldOfView
end
v30.FieldOfView = QQXuQ
end
function MainState.bxOlDXWlooNM()
local gui51 = workspace.CurrentCameraif gui51 and ESPState.originalFOV then
gui51.FieldOfView = ESPState.originalFOV
end
ESPState.originalFOV = nil
end
LocalPlayer:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(
function()
if Settings.cameraZoomEnabledand LocalPlayer.CameraMaxZoomDistance~= Settings.cameraZoomValuethen LocalPlayer.CameraMaxZoomDistance = Settings.cameraZoomValueend
end)
function MainState.v_NpDbxz()
local inst71 = workspace.CurrentCamera
if not inst71 then
 return
end
inst71:GetPropertyChangedSignal("FieldOfView"):Connect(
function()
if Settings.lockFovEnabled and inst71.FieldOfView~= Settings.customFovValue then
inst71.FieldOfView = Settings.customFovValue
end
end)
end
MainState.v_NpDbxz()
function MainState.vvw0v_lDxx()
if UIS2.TouchEnabledand not UIS2.KeyboardEnabled then
 return
end
ESPState.originalMouseIconEnabled = UIS2.MouseIconEnabledESPState.originalMouseBehavior = UIS2.MouseBehaviorUIS2.MouseIconEnabled = true UIS2.MouseBehavior = Enum.MouseBehavior.Defaultif ESPState.forceCursorConn1 then
ESPState.forceCursorConn1:Disconnect()
end
if ESPState.forceCursorConn2 then
ESPState.forceCursorConn2:Disconnect()
end
ESPState.forceCursorConn1 = UIS2:GetPropertyChangedSignal("MouseIconEnabled"):Connect(
function()
if Settings.forceCursorEnabled and not UIS2.MouseIconEnabledthen UIS2.MouseIconEnabled = true
end
end)
ESPState.forceCursorConn2 = UIS2:GetPropertyChangedSignal("MouseBehavior"):Connect(
function()
if Settings.forceCursorEnabledand UIS2.MouseBehavior== Enum.MouseBehavior.LockCenter then
UIS2.MouseBehavior = Enum.MouseBehavior.Defaultend
end)
end
function MainState.Bu0oXoOlbI()
if ESPState.forceCursorConn1 then
ESPState.forceCursorConn1:Disconnect()
ESPState.forceCursorConn1 = nil
end
if ESPState.forceCursorConn2then ESPState.forceCursorConn2:Disconnect()
ESPState.forceCursorConn2 = nil
end
if ESPState.originalMouseIconEnabled~= nil then
UIS2.MouseIconEnabled = ESPState.originalMouseIconEnabledESPState.originalMouseIconEnabled = nil
end
if ESPState.originalMouseBehavior~= nil then
UIS2.MouseBehavior = ESPState.originalMouseBehaviorESPState.originalMouseBehavior = nil
end
end
function MainState.lpZNv1HZpDo()
local inst72 = Instance.new("ScreenGui")
inst72.Name = "BolongPerfMon";
inst72.ResetOnSpawn = false inst72.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
inst72.IgnoreGuiInset = false;
inst72.Parent = PlayerGui
local v31 = Instance.new("Frame")
v31.Name = "PerfFrame";
v31.Size = UDim2.fromOffset(160, 28)
v31.AnchorPoint = Vector2.new(1, 0);
v31.Position = UDim2.new(1,- 10, 0, 10)
v31.BackgroundColor3 = Color3.fromRGB(10, 10, 14);
v31.BorderSizePixel = 0 v31.Active = true;
v31.Parent = inst72
local MunOnDvpolHq = Instance.new("UICorner");
MunOnDvpolHq.CornerRadius = UDim.new(0, 8);
MunOnDvpolHq.Parent = v31
local color11 = Instance.new("UIStroke");
color11.Color = Color3.fromRGB(60, 60, 75)
color11.Thickness = 1;
color11.Parent = v31
local conn12 = Instance.new("TextLabel")
conn12.Name = "InfoLabel";
conn12.Size = UDim2.new(1, 0, 1, 0)
conn12.BackgroundTransparency = 1;
conn12.Text = "FPS — | PING —" conn12.TextColor3 = Color3.fromRGB(200, 200, 210);
conn12.TextSize = 12 conn12.Font = Enum.Font.GothamBold;
conn12.TextXAlignment = Enum.TextXAlignment.Center conn12.TextYAlignment = Enum.TextYAlignment.Center;
conn12.RichText = true;
conn12.Parent = v31
local oDpwnX_M0, pZMUWX0vIvo, WZQxOWUppWIN_ v31.InputBegan:Connect(
function(MW1pNmnNNnzH_Z)
if MW1pNmnNNnzH_Z.UserInputType== Enum.UserInputType.MouseButton1or MW1pNmnNNnzH_Z.UserInputType== Enum.UserInputType.Touchthen oDpwnX_M0 = true;
pZMUWX0vIvo = MW1pNmnNNnzH_Z.Position;
WZQxOWUppWIN_ = v31.Position
end
end)
v31.InputEnded:Connect(
function(oQvqXq_ZHQwq0m)
if oQvqXq_ZHQwq0m.UserInputType== Enum.UserInputType.MouseButton1 or oQvqXq_ZHQwq0m.UserInputType== Enum.UserInputType.Touchthen oDpwnX_M0 = false
end
end)
UIS2.InputChanged:Connect(
function(pD0wWUNNxNw1nl)
if oDpwnX_M0 and(pD0wWUNNxNw1nl.UserInputType== Enum.UserInputType.MouseMovement or pD0wWUNNxNw1nl.UserInputType== Enum.UserInputType.Touch) then
 local inst73 = pD0wWUNNxNw1nl.Position- pZMUWX0vIvo v31.Position = UDim2.new(1, WZQxOWUppWIN_.X.Offset+ inst73.X, 0, WZQxOWUppWIN_.Y.Offset+ inst73.Y)
end
end)
return inst72, conn12
end
CreateESPEntry("PerfMonitor", 0.5,
function()
if not ESPState._perfActive then
 return
end
local OqIqzx = math.floor(ESPState._perfFrames/ math.max(ESPState._perfElapsed, 0.001))
local v32 = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
local OwZuQz = OqIqzx>= 50 and "rgb(80,220,100)" or OqIqzx>= 30 and "rgb(255,200,60)" or "rgb(255,70,70)"
local inst74 = v32<= 80 and "rgb(80,220,100)" or v32<= 150 and "rgb(255,200,60)" or "rgb(255,70,70)"
if ESPState.perfGuiand ESPState.perfGui.Parent then
 local oln_x = ESPState.perfGui:FindFirstChild("PerfFrame"):FindFirstChild("InfoLabel")
 if oln_x then
oln_x.Text = string.format("<font color = \"%s\">FPS %d</font> <font color = \"rgb(60,60,75)\">|</font> <font color = \"%s\">PING %d</font>", OwZuQz, OqIqzx, inst74, v32)
 end
end ESPState._perfElapsed = 0;
ESPState._perfFrames = 0
end) CreateESPEntry("PerfCounter", 0,
function(DIbMZOlUq)
if ESPState._perfActivethen ESPState._perfFrames = ESPState._perfFrames+ 1 ESPState._perfElapsed = ESPState._perfElapsed+ DIbMZOlUq
end
end)
function MainState.lUwpXW()
if ESPState.perfGuithen ESPState.perfGui:Destroy()
end
local N_q1oHobZ, bZXnUXWW = MainState.lpZNv1HZpDo()
ESPState.perfGui = N_q1oHobZ;
ESPState._perfActive = true ESPState._perfElapsed = 0;
ESPState._perfFrames = 0
end
function MainState.p_X0zlUul()
ESPState._perfActive = false
if ESPState.perfGui then
ESPState.perfGui:Destroy();
ESPState.perfGui = nil
end
end
function MainState.M1INum0lnUMMI(BDM1MoZv, Wun_Qbl1)
if not BDM1MoZv then
 return nil
end
local flag18 = BDM1MoZv:GetAttribute(Wun_Qbl1)
if flag18~= nil then
 return flag18
end
local flag19 = BDM1MoZv:FindFirstChild(Wun_Qbl1)
if flag19 then
 local OXnw0bl, vNMUowwZHZ = pcall(
 function()
 return flag19.Valueend)
 if OXnw0bl then
 return vNMUowwZHZ
 end
end
return nil
end
function MainState.HM0v1q1I1Ix()
local v33 = Instance.new("ScreenGui")
v33.Name = "BolongPrediction" v33.ResetOnSpawn = false v33.IgnoreGuiInset = true v33.DisplayOrder = 9999999 v33.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
local v34 = nil pcall(
function()
v34 = gethui()
end)
if not v34 then
pcall(
 function()
v34 = game:GetService("CoreGui")
end)
end
if not v34 then
v34 = PlayerGui
end
v33.Parent = v34
local gui52 = Instance.new("TextLabel")
gui52.Name = "InfoLabel" gui52.AnchorPoint = Vector2.new(0.5, 0)
if ESPState.predLastPos then
gui52.Position = ESPState.predLastPos
else gui52.Position = UDim2.new(0.5, 0, 0, 50)
end
gui52.BackgroundTransparency = 1 gui52.AutomaticSize = Enum.AutomaticSize.XY gui52.Text = "Map: — | Killer: —" gui52.TextColor3 = Color3.fromRGB(252, 235, 229)
gui52.TextSize = 14 p_mWOQlv_mpnbU.Font = Enum.Font.GothamBold gui52.TextXAlignment = Enum.TextXAlignment.Centerp_mWOQlv_mpnbU.TextYAlignment = Enum.TextYAlignment.Centerp_mWOQlv_mpnbU.RichText = true gui52.Active = true gui52.Parent = v33
local val8 = Instance.new("UIStroke")
val8.Name = "Outline" val8.Color = Color3.new(0, 0, 0)
val8.Thickness = 1 NUplUXvW_n1.Transparency = 0.2 val8.Parent = gui52
local val9 = false
local val10 = Vector2.new()
local val11 = UDim2.new()
gui52.InputBegan:Connect(
function(OxXUWWNx)
if OxXUWWNx.UserInputType== Enum.UserInputType.MouseButton1or OxXUWWNx.UserInputType== Enum.UserInputType.Touchthen val9 = true val10 = OxXUWWNx.Position val11 = gui52.Position
end
end)
gui52.InputEnded:Connect(
function(Wvb1qz1nbu0DHD)
if Wvb1qz1nbu0DHD.UserInputType== Enum.UserInputType.MouseButton1 or Wvb1qz1nbu0DHD.UserInputType== Enum.UserInputType.Touchthen val9 = false
end
end)
UIS2.InputChanged:Connect(
function(bWI0_ZwlxDnuIz)
if val9 and(bWI0_ZwlxDnuIz.UserInputType== Enum.UserInputType.MouseMovementor bWI0_ZwlxDnuIz.UserInputType== Enum.UserInputType.Touch) then
 local val12 = bWI0_ZwlxDnuIz.Position- val10
 local val13 = UDim2.new(val11.X.Scale, val11.X.Offset+ val12.X, val11.Y.Scale, val11.Y.Offset+ val12.Y)
gui52.Position = val13 ESPState.predLastPos = val13
end
end)
return v33, gui52
end
function MainState.IuxHvXo()
if ESPState.predMapInfoConnthen
return
end
task.spawn(
function()
local bUmxXOoXWvW, BoxunQbqXpN = pcall(
function()
return ReplicatedStorage:WaitForChild("Remotes", 10):WaitForChild("Messages", 10):WaitForChild("Mapinfo", 10)
end)
if bUmxXOoXWvW and BoxunQbqXpN and BoxunQbqXpN:IsA("RemoteEvent") then
ESPState.predMapInfoConn = BoxunQbqXpN.OnClientEvent:Connect(
 function(pOOxbvQ, OMqmMuMlM)
 if type(pOOxbvQ)=="string" and pOOxbvQ~="" then
ESPState.predMapName = pOOxbvQ
 end
end)
end
end)
end
CreateESPEntry("PredictionMonitor", 1,
function()
if not ESPState.predActivethen
return
end
if not ESPState.predGuior not ESPState.predGui.Parent then
 if ESPState.predGuithen ESPState.predGui:Destroy()
end
local HqwXx, lQlwQp = MainState.HM0v1q1I1Ix()
ESPState.predGui = HqwXx ESPState.predInfoLabel = lQlwQp
end
local inst75 = ESPState.predGui:FindFirstChild("InfoLabel")
if not inst75 then
 return
end
local inst76 = Players.GetPlayers(Players)
table.sort(inst76,
function(wwqnIom, HqXQOX0Z)
local inst77 = MainState.M1INum0lnUMMI(wwqnIom,"AllowKiller")
local v35 = MainState.M1INum0lnUMMI(HqXQOX0Z,"AllowKiller")
local inst78 = (inst77== false)
local inst79 = (v35== false)
if inst78~= inst79 then
 return not inst78
end
if not inst78 and not inst79 then
 return(MainState.M1INum0lnUMMI(wwqnIom,"KillerChance") or 0)>(MainState.M1INum0lnUMMI(HqXQOX0Z,"KillerChance") or 0)
end
return(MainState.M1INum0lnUMMI(wwqnIom,"KillerChance") or0)<(MainState.M1INum0lnUMMI(HqXQOX0Z,"KillerChance") or 0)
end)
local val14 = inst76[1]
local val15 = "<font color = \"rgb(100,110,130)\">—</font>"
if val14 then
 local val16 = val14.Name
 local inst80 = MainState.M1INum0lnUMMI(val14,"SelectedKiller")
 local inst81 = MainState.M1INum0lnUMMI(val14,"AllowKiller")
 if val14== LocalPlayer then
val16 = "YOU"
 end
local _UvMwO___
 if inst81== false then
_UvMwO___ = "rgb(255,0,30)"
 else _UvMwO___ = "rgb(252,235,229)"
end
if inst80 and type(inst80)=="string" and inst80~="" then
val15 = string.format("<font color = \"%s\">%s</font> <font color = \"rgb(255,0,30)\">(%s)</font>", _UvMwO___, val16, inst80)
else val15 = string.format("<font color = \"%s\">%s</font>", _UvMwO___, val16)
end
end
local inst82 = ESPState.predMapName or "—" inst75.Text = string.format("<font color = \"rgb(255,210,60)\">Map:</font> <font color = \"rgb(252,235,229)\">%s</font> <font color = \"rgb(80,80,85)\">|</font> <font color = \"rgb(255,210,60)\">Killer:</font> %s", inst82, val15)
end)
function MainState.HuQnoUuWpwo()
if ESPState.predGuithen ESPState.predGui:Destroy()
end
ESPState.predMapName = nil MainState.IuxHvXo()
local lHpXvDmmnIH_, MH0Qb_oDOxnz = MainState.HM0v1q1I1Ix()
ESPState.predGui = lHpXvDmmnIH_ ESPState.predInfoLabel = MH0Qb_oDOxnz ESPState.predActive = true
end
function MainState.lboDUI()
ESPState.predActive = false
if ESPState.predMapInfoConn then
pcall(
 function()
ESPState.predMapInfoConn:Disconnect()
end)
ESPState.predMapInfoConn = nil
end
if ESPState.predGuithen ESPState.predGui:Destroy()
ESPState.predGui = nil
end
end CROSSHAIR_STYLES = {"Dot","Circle","Circle + Dot","Plus","Cross (X)","T-Shape","Square"} do
MainState.HUvmUM1Uu = 80 MainState.qqQHNWzvmq = MainState.HUvmUM1Uu/ 2 b0W0wpHoxmHDWX.bwDoXvvnnDOn = {}
 function MainState.Dq_W0bDW0(ONWD0x_HoHIm, lDH1_zWD, uXwUONoHZ, D1xwNvNl, QpIn_qbIzoUO, D0xzqUnHp, WZqOuqX1owO, wovbwZWqUq_)
 local tbl4 = Instance.new("Frame")
tbl4.Name = wovbwZWqUq_ or "CH_Part" tbl4.BackgroundColor3 = D0xzqUnHp tbl4.BackgroundTransparency = WZqOuqX1owO tbl4.BorderSizePixel = 0 tbl4.Size = UDim2.fromOffset(math.max(1, math.round(uXwUONoHZ)), math.max(1, math.round(D1xwNvNl)))
tbl4.AnchorPoint = Vector2.new(0.5, 0.5)
tbl4.Position = UDim2.fromOffset(math.round(ONWD0x_HoHIm), math.round(lDH1_zWD))
 if QpIn_qbIzoUO~= 0 then
tbl4.Rotation = QpIn_qbIzoUO
 end
return tbl4
end
function MainState.HIXMnml1M(u1wpZMHv)
return 0.3+(math.clamp(u1wpZMHv, 1, 100)/ 100)* 2.2
end
MainState.bwDoXvvnnDOn.Plus = function(w_uw_N1IWH, WwlpxwHDMownH, omqbDb)
local tbl5 = {}
local tbl6 = MainState.HIXMnml1M(w_uw_N1IWH)
local tbl7 = math.max(2, math.round(2* tbl6))
local tbl8 = math.max(8, math.round(25* tbl6))
local tbl9 = MainState.qqQHNWzvmq table.insert(tbl5, MainState.Dq_W0bDW0(tbl9, tbl9, tbl7, tbl8, 0, WwlpxwHDMownH, omqbDb))
table.insert(tbl5, MainState.Dq_W0bDW0(tbl9, tbl9, tbl8, tbl7, 0, WwlpxwHDMownH, omqbDb))
return tbl5,{},{}
end
MainState.bwDoXvvnnDOn["Cross (X)"]=
function(woMbvvmW0zI, bOXDMW, w0DXINqwM_)
local tbl10 = {}
local tbl11 = MainState.HIXMnml1M(woMbvvmW0zI)
local tbl12 = math.max(2, math.round(2* tbl11))
local tbl13 = math.max(8, math.round(25* tbl11))
local NxHvq = MainState.qqQHNWzvmq table.insert(tbl10, MainState.Dq_W0bDW0(NxHvq, NxHvq, tbl12, tbl13, 45, bOXDMW, w0DXINqwM_))
table.insert(tbl10, MainState.Dq_W0bDW0(NxHvq, NxHvq, tbl12, tbl13,- 45, bOXDMW, w0DXINqwM_))
return tbl10,{},{}
end
MainState.bwDoXvvnnDOn.Dot = function(pmzxDvbvOp, bzbxxzMzboM, _lonX)
local color12 = {}
local color13 = MainState.HIXMnml1M(pmzxDvbvOp)
local color14 = math.max(3, math.round(8* color13))
local flag20 = MainState.qqQHNWzvmq
local v36 = MainState.Dq_W0bDW0(flag20, flag20, color14, color14, 0, bzbxxzMzboM, _lonX,"CH_Dot")
local pcall3 = Instance.new("UICorner")
pcall3.CornerRadius = UDim.new(1, 0)
pcall3.Parent = v36 table.insert(color12, v36)
return color12,{},{}
end
MainState.bwDoXvvnnDOn.Circle = function(QmDbvzNOX, BZHHu, WXIuowDoX)
local Bx0nN, B_DQQN = {},{}
local pcall4 = MainState.HIXMnml1M(QmDbvzNOX)
local inst83 = math.max(4, math.round(12* pcall4))
local inst84 = math.max(2, math.round(2* pcall4))
local inst85 = MainState.qqQHNWzvmq
local inst86 = Instance.new("Frame")
inst86.Name = "CH_Ring" inst86.BackgroundTransparency = 1 inst86.Size = UDim2.fromOffset(inst83* 2, inst83* 2)
inst86.AnchorPoint = Vector2.new(0.5, 0.5)
inst86.Position = UDim2.fromOffset(inst85, inst85)
local gui53 = Instance.new("UICorner")
gui53.CornerRadius = UDim.new(1, 0)
gui53.Parent = inst86
local gui54 = Instance.new("UIStroke")
gui54.Name = "CH_Stroke" gui54.Color = BZHHu gui54.Thickness = inst84 gui54.Transparency = WXIuowDoX gui54.Parent = inst86 table.insert(Bx0nN, inst86)
table.insert(B_DQQN, gui54)
return Bx0nN, B_DQQN,{}
end
MainState.bwDoXvvnnDOn["Circle + Dot"]=
function(MUHbWq, BHnuQH, WvWuvI)
local qp_zZHqNqHu, qOX1v, WNvNbnnunM0 = {},{},{}
local pcall5 = MainState.HIXMnml1M(MUHbWq)
local pcall6 = math.max(4, math.round(12* pcall5))
local v37 = math.max(2, math.round(2* pcall5))
local v38 = math.max(2, math.round(4* pcall5))
local tbl14 = MainState.qqQHNWzvmq
local tbl15 = Instance.new("Frame")
tbl15.Name = "CH_Ring" tbl15.BackgroundTransparency = 1 tbl15.Size = UDim2.fromOffset(pcall6* 2, pcall6* 2)
tbl15.AnchorPoint = Vector2.new(0.5, 0.5)
tbl15.Position = UDim2.fromOffset(tbl14, tbl14)
local Bunuw = Instance.new("UICorner")
Bunuw.CornerRadius = UDim.new(1, 0)
Bunuw.Parent = tbl15
local color15 = Instance.new("UIStroke")
color15.Name = "CH_Stroke" color15.Color = BHnuQH color15.Thickness = v37 color15.Transparency = WvWuvI color15.Parent = tbl15 table.insert(qp_zZHqNqHu, tbl15)
table.insert(qOX1v, color15)
local inst87 = MainState.Dq_W0bDW0(tbl14, tbl14, v38, v38, 0, BHnuQH, WvWuvI,"CH_Dot")
local v39 = Instance.new("UICorner")
v39.CornerRadius = UDim.new(1, 0)
v39.Parent = inst87 table.insert(qp_zZHqNqHu, inst87)
table.insert(WNvNbnnunM0, inst87)
return qp_zZHqNqHu, qOX1v, WNvNbnnunM0
end
MainState.bwDoXvvnnDOn["T-Shape"]=
function(qomNzQ, I1H_pbqZIpxlM, oOzw1QZm)
local cam10 = {}
local cam11 = MainState.HIXMnml1M(qomNzQ)
local cam12 = math.max(2, math.round(2* cam11))
local cam13 = math.max(8, math.round(25* cam11))
local conn13 = MainState.qqQHNWzvmq
local conn14 = math.round(cam13* 0.25)
table.insert(cam10, MainState.Dq_W0bDW0(conn13, conn13- conn14, cam13, cam12, 0, I1H_pbqZIpxlM, oOzw1QZm))
table.insert(cam10, MainState.Dq_W0bDW0(conn13, conn13- conn14+ cam13/ 2, cam12, cam13, 0, I1H_pbqZIpxlM, oOzw1QZm))
return cam10,{},{}
end
MainState.bwDoXvvnnDOn.Square = function(OnWmXnQw0_ZIWl, BqQII0QM, uq1Huw)
local conn15 = {}
local conn16 = MainState.HIXMnml1M(OnWmXnQw0_ZIWl)
local conn17 = math.max(2, math.round(2* conn16))
local conn18 = math.max(8, math.round(22* conn16))
local conn19 = math.max(3, math.round(conn18* 0.4))
local conn20 = MainState.qqQHNWzvmq
local conn21 = conn18/ 2 table.insert(conn15, MainState.Dq_W0bDW0(conn20- conn21+ conn19/ 2, conn20- conn21, conn19, conn17, 0, BqQII0QM, uq1Huw))
table.insert(conn15, MainState.Dq_W0bDW0(conn20- conn21, conn20- conn21+ conn19/ 2, conn17, conn19, 0, BqQII0QM, uq1Huw))
table.insert(conn15, MainState.Dq_W0bDW0(conn20+ conn21- conn19/ 2, conn20- conn21, conn19, conn17, 0, BqQII0QM, uq1Huw))
table.insert(conn15, MainState.Dq_W0bDW0(conn20+ conn21, conn20- conn21+ conn19/ 2, conn17, conn19, 0, BqQII0QM, uq1Huw))
table.insert(conn15, MainState.Dq_W0bDW0(conn20- conn21+ conn19/ 2, conn20+ conn21, conn19, conn17, 0, BqQII0QM, uq1Huw))
table.insert(conn15, MainState.Dq_W0bDW0(conn20- conn21, conn20+ conn21- conn19/ 2, conn17, conn19, 0, BqQII0QM, uq1Huw))
table.insert(conn15, MainState.Dq_W0bDW0(conn20+ conn21- conn19/ 2, conn20+ conn21, conn19, conn17, 0, BqQII0QM, uq1Huw))
table.insert(conn15, MainState.Dq_W0bDW0(conn20+ conn21, conn20+ conn21- conn19/ 2, conn17, conn19, 0, BqQII0QM, uq1Huw))
return conn15,{},{}
end
MainState.wIxwUXZxX = {} MainState.wIxwUXZxX.__index = MainState.wIxwUXZxX
function MainState.wIxwUXZxX.new()
local flag21 = setmetatable({}, MainState.wIxwUXZxX)
flag21.config = { enabled = false, style = "Plus", size = 1, opacity = 1.0, offsetX = 0, offsetY = 0, color = Color3.fromRGB(255, 255, 255), smooth = true, smoothSpeed = 0.25,} flag21.gui = nil flag21.container = nil flag21.parent = nil flag21.parts = { frames = {}, strokes = {}, dots = {}} flag21.connections = {} flag21.renderConn = nil flag21.currentOffset = Vector2.new(0, 0)
flag21.targetOffset = Vector2.new(0, 0)
flag21._frameCount = 0
return flag21
end
function MainState.qXo_llDnw()
local lDpQOQ1 pcall(
function()
if gethui then
lDpQOQ1 = gethui()
end
end)
if lDpQOQ1 and lDpQOQ1.Parent then
 return lDpQOQ1
end
pcall(
function()
lDpQOQ1 = game:GetService("CoreGui")
end)
if lDpQOQ1 and lDpQOQ1.Parentthen
return lDpQOQ1
end
return PlayerGui
end
function MainState.wIxwUXZxX:_createGui()
if self.guiand self.gui.Parentthen
return
end
local v40 = Instance.new("ScreenGui")
v40.Name = "BolongCrosshair" v40.ResetOnSpawn = false v40.ZIndexBehavior = Enum.ZIndexBehavior.SiblingwvvxMHXUum.IgnoreGuiInset = true v40.DisplayOrder = 999999
local pcall7 = MainState.qXo_llDnw()
v40.Parent = pcall7 self.parent = pcall7
local pcall8 = Instance.new("Frame")
pcall8.Name = "Container" pcall8.Size = UDim2.fromOffset(MainState.HUvmUM1Uu, MainState.HUvmUM1Uu)
pcall8.AnchorPoint = Vector2.new(0.5, 0.5)
pcall8.BackgroundTransparency = 1 bINvn.BorderSizePixel = 0 pcall8.Parent = v40 self.gui = v40 self.container = pcall8 self:_rebuild()
self.targetOffset = Vector2.new(self.config.offsetX, self.config.offsetY)
self.currentOffset = self.targetOffsetself:_updatePosition()
end
function MainState.wIxwUXZxX:_rebuild()
if not self.containerthen
return
end
for oWuUbuUWQqwD, pno_0qbOnqmlmX in ipairs(self.parts.frames) do
pcall(
 function() pno_0qbOnqmlmX:Destroy()
end)
end
self.parts = { frames = {}, strokes = {}, dots = {}}
local inst88 = MainState.bwDoXvvnnDOn[self.config.style]
if not inst88 then
 return
end
local inst89 = 1- self.config.opacity
local MxpHoNNZU, _bppDlWHZoUu, w0INlm000IoHn = inst88(self.config.size, self.config.color, inst89)
for I0NoNu_NMXMM, NpDOpZ in ipairs(MxpHoNNZU) do
NpDOpZ.Parent = self.containertable.insert(self.parts.frames, NpDOpZ)
end
for bDxlqmWQ0w0Xu, wbvUUQvXqZ in ipairs(_bppDlWHZoUu) do
table.insert(self.parts.strokes, wbvUUQvXqZ)
end
self.parts.dots = w0INlm000IoHn or{}
end
function MainState.wIxwUXZxX:_updateColors()
local inst90 = self.config.colorlocal inst91 = 1- self.config.opacity
local _mqo01v1_ = {}
for v_mIXzlq1DzO, OvqIIIWDl in ipairs(self.parts.dots) do
_mqo01v1_[OvqIIIWDl]= true
end
for MpM0pqwmo, NOuMMxIXNmZv in ipairs(self.parts.frames) do
 if NOuMMxIXNmZv and NOuMMxIXNmZv.Parentthen NOuMMxIXNmZv.BackgroundColor3 = _mqo01v1_[NOuMMxIXNmZv] and Color3.fromRGB(255, 255, 255) or inst90
 if not NOuMMxIXNmZv:FindFirstChildWhichIsA("UIStroke") then
NOuMMxIXNmZv.BackgroundTransparency = inst91
 end
end
end
for IwzQzX0Wwu0Xq, Iw1lZmWbl in ipairs(self.parts.strokes) do
 if Iw1lZmWbl and Iw1lZmWbl.Parent then
Iw1lZmWbl.Color = inst90 Iw1lZmWbl.Transparency = inst91
 end
end
end
function MainState.wIxwUXZxX:_updatePosition()
if not self.containerthen
return
end
local inst92 = workspace.CurrentCameraif not inst92 then
 return
end
local inst93 = inst92.ViewportSize self.container.Position = UDim2.fromOffset(inst93.X* 0.5+ self.currentOffset.X, inst93.Y* 0.5+ self.currentOffset.Y)
end
function MainState.wIxwUXZxX:_hookCamera()
if self.connections.camViewport then
self.connections.camViewport:Disconnect()
self.connections.camViewport = nil
end
local char25 = workspace.CurrentCameraif char25 then
self.connections.camViewport = char25:GetPropertyChangedSignal("ViewportSize"):Connect(
 function() self:_updatePosition()
end)
end
end
function MainState.wIxwUXZxX:_setupConnections() self:_hookCamera()
while(190* 0~= 0) do
 local gui55 = 416 break
end
if not self.connections.camChangethen self.connections.camChange = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(
function() self:_hookCamera() self:_updatePosition()
end)
end
if not self.connections.childRemoved then
self.connections.childRemoved = self.parent.ChildRemoved:Connect(
 function(DWwXIUzxXuMv_)
 if DWwXIUzxXuMv_== self.gui and self.config.enabled then
self.gui = nil self.container = nil self.parts = { frames = {}, strokes = {}, dots = {}} task.wait(0.05)
 if self.config.enabledthen self._createGui(self)
 end
end
end)
end
if not self.connections.touchChangedthen self.connections.touchChanged = UIS2:GetPropertyChangedSignal("TouchEnabled"):Connect(
function() self:_updatePosition()
end)
end
end
function MainState.wIxwUXZxX:_startRender()
if self.renderConn then
 return
end
self.renderConn = RunService.RenderStepped:Connect(
function(Dmmbu0N)
if not self.config.enabled then
 return
end
if not self.guior not self.gui.Parentthen self._createGui(self)
return
end
if not self.gui.Enabledthen self.gui.Enabled = true
end
self._frameCount = self._frameCount+ 1
if self._frameCount% 30== 0 then
 local v41 = false
 for lDZwwz, pDmO_wlQZxQ1D in ipairs(self.parts.frames) do
 if pDmO_wlQZxQ1D and pDmO_wlQZxQ1D.Parent then
v41 = true;
break
 end
end
 if not v41 and#self.parts.frames> 0 then
self._rebuild(self)
 end
end
if self.config.smooththen
local v42 = self.targetOffset- self.currentOffset
if v42.Magnitude> 0.01 then
 local v43 = 1- math.pow(1- self.config.smoothSpeed, Dmmbu0N* 60)
self.currentOffset = self.currentOffset:Lerp(self.targetOffset, v43) self:_updatePosition()
end
end
end)
end
function MainState.wIxwUXZxX:_stopRender()
if self.renderConnthen self.renderConn:Disconnect()
self.renderConn = nil
end
end
function MainState.wIxwUXZxX:SetEnabled(HHuNNHOwp)
self.config.enabled = HHuNNHOwp
if HHuNNHOwp then
 if not self.guior not self.gui.Parent then
self._createGui(self) self:_setupConnections()
 end
self.gui.Enabled = true self.targetOffset = Vector2.new(self.config.offsetX, self.config.offsetY)
self.currentOffset = self.targetOffsetself:_updatePosition() self:_startRender()
else self._stopRender(self)
if self.gui then
self.gui.Enabled = false
end
end
end
function MainState.wIxwUXZxX:SetStyle(_xxUlHNNMbqqQ)
self.config.style = _xxUlHNNMbqqQ
if self.config.enabledand self.guithen self._rebuild(self)
end
end
function MainState.wIxwUXZxX:SetSize(QZ0qbzZ)
self.config.size = QZ0qbzZ
if self.config.enabledand self.guithen self._rebuild(self)
end
end
function MainState.wIxwUXZxX:SetOpacity(bHn_0uUvQzbqlv)
self.config.opacity = bHn_0uUvQzbqlv
if self.config.enabledand self.gui then
self._updateColors(self)
end
end
function MainState.wIxwUXZxX:SetColor(Qbl0QXp)
self.config.color = Qbl0QXp
if self.config.enabled and self.guithen self._updateColors(self)
end
end
function MainState.wIxwUXZxX:SetOffsetX(QQoqq)
self.config.offsetX = QQoqq self.targetOffset = Vector2.new(QQoqq, self.config.offsetY)
if not self.config.smooth and self.config.enabled then
self.currentOffset = self.targetOffset self:_updatePosition()
end
end
function MainState.wIxwUXZxX:SetOffsetY(OzQwqO0)
self.config.offsetY = OzQwqO0 self.targetOffset = Vector2.new(self.config.offsetX, OzQwqO0)
if not self.config.smooth and self.config.enabledthen self.currentOffset = self.targetOffsetself:_updatePosition()
end
end
function MainState.wIxwUXZxX:Destroy()
self.config.enabled = false self._stopRender(self)
for pOWvxN_MOIuNMn, uDuwbQ in pairs(self.connections) do
pcall(
 function() uDuwbQ:Disconnect()
end)
end
self.connections = {}
if self.guithen pcall(
function()
self.gui:Destroy()
end)
end
self.gui = nil self.container = nil self.parts = { frames = {}, strokes = {}, dots = {}}
end
MainState.Iw0_ov = MainState.wIxwUXZxX.new()
end
function MainState._ouxzuoxpIb_n(HwW1m)
if not ESPState.pnameFakeNames[HwW1m] then
 local inst94 = (#ESPState.pnameFakeNames%#ESPFolder)+ 1 ESPState.pnameFakeNames[HwW1m]= ESPFolder[inst94]
end
return ESPState.pnameFakeNames[HwW1m]
end
function MainState.qMpmWHOmoNvm(H_qzHWHxv, qDpMbIZ0_opH)
if not H_qzHWHxv then
 return
end
local remote8 = H_qzHWHxv:FindFirstChild("Head")
if not remote8 then
 return
end
for b0OMuUo, _WqoMOHIIooZo in ipairs(remote8.GetChildren(remote8)) do
 if _WqoMOHIIooZo:IsA("BillboardGui") then
 local inst95 = _WqoMOHIIooZo:FindFirstChildWhichIsA("TextLabel", true)
 if inst95 then
inst95.Text = qDpMbIZ0_opH
 end
end
end
local inst96 = H_qzHWHxv:FindFirstChildOfClass("Humanoid")
if inst96 then
pcall(
 function()
inst96.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Noneend)
end
end
function MainState.vwmHN1nIDm0X(qnxNHwOoMvHX1Q, QMxQWH_uM)
if not qnxNHwOoMvHX1Q then
 return
end
local inst97 = qnxNHwOoMvHX1Q:FindFirstChild("Head")
if inst97 then
 for IZl_Xzbl, _WQuWlqpomU in ipairs(inst97.GetChildren(inst97)) do
 if _WQuWlqpomU:IsA("BillboardGui") then
 local cam14 = _WQuWlqpomU:FindFirstChildWhichIsA("TextLabel", true)
 if cam14 then
cam14.Text = QMxQWH_uM
 end
end
 end
end
local conn22 = qnxNHwOoMvHX1Q:FindFirstChildOfClass("Humanoid")
if conn22 then
pcall(
 function()
conn22.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Limit
end)
end
end
function MainState.WQWzx(HwUvOD1vpO)
local cam15 = PlayerGui:FindFirstChild("Survivor-mob")
if not cam15 then
 return nil
end
local conn23 = cam15:FindFirstChild("Frame")
if not conn23 then
 return nil
end
for omXDOvpulUxWl = 1, 5 do
 local conn24 = conn23:FindFirstChild("Survivor"..omXDOvpulUxWl)
 if conn24 and conn24:GetAttribute("UserId")== HwUvOD1vpO then
 return conn24:FindFirstChild("TextLabel")
 end
end
return nil
end
function MainState.W_vpz(uozOZ)
local tbl16 = (uozOZ== LocalPlayer)
local tbl17 = MainState._ouxzuoxpIb_n(uozOZ)
if not tbl16 then
 if ESPState.espObjects[uozOZ] then
ESPState.espObjects[uozOZ].nameLabel.Text = tbl17
 end
if uozOZ.Character then
MainState.qMpmWHOmoNvm(uozOZ.Character, tbl17)
 end
end
local inst98 = MainState.WQWzx(uozOZ.UserId)
if inst98 then
inst98.Text = tbl17
end
if not tbl16 and not ESPState.pnameNameConns[uozOZ] then
ESPState.pnameNameConns[uozOZ]= uozOZ.CharacterAdded:Connect(
 function(HHNWnHp)
 if not ESPState.pnameEnabledthen
 return
end
local conn25 = MainState._ouxzuoxpIb_n(uozOZ)
task.wait(0.5)
MainState.qMpmWHOmoNvm(HHNWnHp, conn25)
if ESPState.espObjects[uozOZ] then
ESPState.espObjects[uozOZ].nameLabel.Text = conn25
end
local p1w1px = MainState.WQWzx(uozOZ.UserId)
if p1w1px then
p1w1px.Text = conn25
end
end)
end
end
function MainState.HpnnwXmlxZ1(bvIZZmqHzqlIU)
local pcall9 = (bvIZZmqHzqlIU== LocalPlayer)
local pcall10 = bvIZZmqHzqlIU.Nameif not pcall9 then
 if ESPState.espObjects[bvIZZmqHzqlIU] then
ESPState.espObjects[bvIZZmqHzqlIU].nameLabel.Text = pcall10
 end
if bvIZZmqHzqlIU.Character then
MainState.vwmHN1nIDm0X(bvIZZmqHzqlIU.Character, pcall10)
 end
if ESPState.pnameNameConns[bvIZZmqHzqlIU] then
ESPState.pnameNameConns[bvIZZmqHzqlIU]:Disconnect()
ESPState.pnameNameConns[bvIZZmqHzqlIU]= nil
 end
end
local gui56 = MainState.WQWzx(bvIZZmqHzqlIU.UserId)
if gui56 then
gui56.Text = pcall10
end
end
function MainState.DMMn1nInqXml(poHnqZxmQnbq, qovnuZ)
local conn26 = poHnqZxmQnbq.Name
if ESPState.pnameSlotConns[conn26] then
ESPState.pnameSlotConns[conn26]:Disconnect()
ESPState.pnameSlotConns[conn26]= nil
end
local conn27 = poHnqZxmQnbq:GetAttribute("UserId")
if not conn27 then
 return
end
local DvXNQu
for vxqq0QI0, OHOqnmx in ipairs(Players.GetPlayers(Players)) do
 if OHOqnmx.UserId== conn27 then
DvXNQu = OHOqnmx;
break
 end
end
if not DvXNQu then
 return
end
local tbl18 = MainState._ouxzuoxpIb_n(DvXNQu)
ESPState.pnameSlotConns[conn26]= qovnuZ:GetPropertyChangedSignal("Text"):Connect(
function()
if not ESPState.pnameEnabled then
 return
end
local conn28 = poHnqZxmQnbq:GetAttribute("UserId")
if not conn28 then
 return
end
local DqUHDQ
for puMwpQol, MwxvlzupIWQbQ in ipairs(Players.GetPlayers(Players)) do
 if MwxvlzupIWQbQ.UserId== conn28 then
DqUHDQ = MwxvlzupIWQbQ;
break
 end
end
if not DqUHDQ then
 return
end
local pcall11 = MainState._ouxzuoxpIb_n(DqUHDQ)
if qovnuZ.Text~= pcall11 then
qovnuZ.Text = pcall11
end
end)
end
function MainState.q0vOXnXpp0qUQQ()
for Q0nXbqlOx, _WpwQ0zpwM1l in pairs(ESPState.pnameSlotConns) do
_WpwQ0zpwM1l.Disconnect(_WpwQ0zpwM1l)
ESPState.pnameSlotConns[Q0nXbqlOx]= nil
end
local flag22 = PlayerGui:FindFirstChild("Survivor-mob")
if not flag22 then
 return
end
local flag23 = flag22:FindFirstChild("Frame")
if not flag23 then
 return
end
for QnHoI_b = 1, 5 do
 local flag24 = flag23:FindFirstChild("Survivor"..QnHoI_b)
 if flag24 then
 local flag25 = flag24:FindFirstChild("TextLabel")
 if flag25 then
MainState.DMMn1nInqXml(flag24, flag25)
 end
end
end
end
function MainState.QwZpNwn()
ESPState.pnameEnabled = true
for OwMpNNWxxunMpZ, _l0NZUbzZIXWWn in ipairs(Players.GetPlayers(Players)) do
MainState.W_vpz(_l0NZUbzZIXWWn)
end
MainState.q0vOXnXpp0qUQQ()
if not ESPState.pnameWatchConnthen ESPState.pnameWatchConn = PlayerGui.ChildAdded:Connect(
function(O_HQZHW)
if O_HQZHW.Name=="Survivor-mob" then
task.wait(0.2)
 if ESPState.pnameEnabledthen MainState.q0vOXnXpp0qUQQ()
 for Q1MUwn, IulHOZWx in ipairs(Players.GetPlayers(Players)) do
MainState.W_vpz(IulHOZWx)
 end
end
end
end)
end
if not ESPState.pnameAddedConnthen ESPState.pnameAddedConn = Players.PlayerAdded:Connect(
function(IqO0xXDuuuv)
if ESPState.pnameEnabled then
task.wait(1)
MainState.W_vpz(IqO0xXDuuuv)
MainState.q0vOXnXpp0qUQQ()
end
end)
end
end
function MainState.lOqqxMquzxn_()
ESPState.pnameEnabled = false
for OUqpx, HZuZOlDQ0xW in pairs(ESPState.pnameSlotConns) do
HZuZOlDQ0xW.Disconnect(HZuZOlDQ0xW)
ESPState.pnameSlotConns[OUqpx]= nil
end
if ESPState.pnameWatchConnthen ESPState.pnameWatchConn:Disconnect()
ESPState.pnameWatchConn = nil
end
for HZUvoZ1l00lHqm, _UpuNvX in ipairs(Players.GetPlayers(Players)) do
MainState.HpnnwXmlxZ1(_UpuNvX)
end
ESPState.pnameFakeNames = {}
if ESPState.pnameAddedConnthen ESPState.pnameAddedConn:Disconnect()
ESPState.pnameAddedConn = nil
end
end
function MainState.oqWmXqpHU(lWquoZN)
lWquoZN = lWquoZN or false
local inst99 = Workspace.CurrentCameralocal gui57 = ESPState.skipEndScreenConnslocal inst100 = false
local inst101 = false
local inst102 = false pcall(
function()
local inst103 = ReplicatedStorage:FindFirstChild("Remotes")
if not inst103 then
 return
end
local function func64(BlxbvHpU)
if BlxbvHpU and BlxbvHpU:IsA("RemoteEvent") then
 for vwX0p_bIm_Uv, QoDbHvpw1b in ipairs(getconnections(BlxbvHpU.OnClientEvent)) do
QoDbHvpw1b.Disable(QoDbHvpw1b) QoDbHvpw1b:Disconnect()
 end
end
end
local inst104 = inst103:FindFirstChild("Game")
if inst104 then
 for WOHQQHZQo, qvlZuZZQUwOX in ipairs({"cutscene","cutsceneEnd","cutsceneEnd2","endscreencutscene","cutsceneEndwithownchar","shake"}) do
func64(inst104:FindFirstChild(qvlZuZZQUwOX))
 end
end
local inst105 = inst103:FindFirstChild("Killers")
if inst105 then
func64(inst105:FindFirstChild("Startmori"))
end
if lWquoZN then
func64(inst103:FindFirstChild("Darkness2"))
end
end)
local function func65()
if not inst99 then
 return
end
if inst99.CameraType== Enum.CameraType.Scriptablethen inst100 = true inst99.CameraType = Enum.CameraType.Custom inst100 = false
end
end
if inst99 then
func65()
table.insert(gui57, inst99:GetPropertyChangedSignal("CameraType"):Connect(
 function()
 if not inst100 then
func65()
 end
end))
table.insert(gui57, inst99:GetPropertyChangedSignal("FieldOfView"):Connect(
function()
if inst101 or Settings.lockFovEnabled then
 return
end
if inst99.FieldOfView~= 70 then
inst101 = true inst99.FieldOfView = 70 inst101 = false
end
end))
end
table.insert(gui57, Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(
function()
inst99 = Workspace.CurrentCameraif inst99 then
func65()
end
end))
table.insert(gui57, LocalPlayer:GetAttributeChangedSignal("isspectating"):Connect(
function()
if inst102 then
 return
end
if LocalPlayer:GetAttribute("isspectating") then
inst102 = true LocalPlayer:SetAttribute("isspectating", false)
inst102 = false
end
end))
table.insert(gui57, LocalPlayer:GetAttributeChangedSignal("killerend"):Connect(
function()
if inst102 then
 return
end
if LocalPlayer:GetAttribute("killerend") then
inst102 = true LocalPlayer:SetAttribute("killerend", false)
inst102 = false
end
end))
local function func66()
local inst106 = Workspace:FindFirstChild("Map")
if inst106 then
 local inst107 = inst106:FindFirstChild("endscreen")
 if inst107 then
pcall(
 function()
inst107.Parent = nil
 end)
end
end
local inst108 = Workspace:FindFirstChild("BackgroundSounds")
if inst108 then
pcall(
 function() inst108:Destroy()
end)
end
end func66()
table.insert(gui57, Workspace.DescendantAdded:Connect(
function(wzNnNH)
if wzNnNH.Name=="endscreen" and wzNnNH.Parent and wzNnNH.Parent.Name=="Map" then
task.wait(0.01) pcall(
 function()
wzNnNH.Parent = nil
end)
elseif wzNnNH.Name=="BackgroundSounds" then
pcall(
 function() wzNnNH:Destroy()
end)
end
end))
local function func67(NMMoDNmv1Iz1o)
if not NMMoDNmv1Iz1o or not NMMoDNmv1Iz1o.Parentthen
return
end
pcall(
function()
if lWquoZN and NMMoDNmv1Iz1o.Name=="Darkness" and NMMoDNmv1Iz1o:IsA("ScreenGui") then
NMMoDNmv1Iz1o.Enabled = false
end
for vqwOp, WONuHmwUDU0O in ipairs(NMMoDNmv1Iz1o.GetDescendants(NMMoDNmv1Iz1o)) do
 if WONuHmwUDU0O:IsA("VideoFrame") then
WONuHmwUDU0O.Destroy(WONuHmwUDU0O)
 elseif WONuHmwUDU0O:IsA("Frame") and(WONuHmwUDU0O.Name=="Frame2" or WONuHmwUDU0O.Name=="blackout") then
WONuHmwUDU0O.BackgroundTransparency = 1
 if lWquoZN then
WONuHmwUDU0O.Visible = false WONuHmwUDU0O:GetPropertyChangedSignal("BackgroundTransparency"):Connect(
 function()
 if WONuHmwUDU0O.BackgroundTransparency< 1 then
WONuHmwUDU0O.BackgroundTransparency = 1
 end
end) WONuHmwUDU0O:GetPropertyChangedSignal("Visible"):Connect(
 function()
 if WONuHmwUDU0O.Visible then
WONuHmwUDU0O.Visible = false
 end
end)
end
elseif WONuHmwUDU0O:IsA("ParticleEmitter") or WONuHmwUDU0O:IsA("Beam") or WONuHmwUDU0O:IsA("Trail") then
WONuHmwUDU0O.Enabled = false
end
end
end)
end
for uvuZn1xzp1, wozm_ in ipairs(PlayerGui.GetChildren(PlayerGui)) do
 local v44 = wozm_.Name
 if v44=="Darkness" or v44=="EndScreen" or v44=="Cutscene" or v44=="Results" then
func67(wozm_)
 end
end table.insert(gui57, PlayerGui.ChildAdded:Connect(
function(uWzlDzNNHHXImM)
local inst109 = uWzlDzNNHHXImM.Nameif inst109=="Darkness" or inst109=="EndScreen" or inst109=="Cutscene" or inst109=="Results" then
task.wait(0.05) func67(uWzlDzNNHHXImM)
end
end))
end
function MainState.Wb0x1XpWv()
for pDWH_oX, M1oqpNNIzXw in ipairs(ESPState.skipEndScreenConns) do
pcall(
 function() M1oqpNNIzXw:Disconnect()
end)
end
table.clear(ESPState.skipEndScreenConns)
end
do
MainState.DUpNoHpX0DZv = {[78432063483146]= true,[121216847022485]= true,[74968262036854]= true,[132817836308238]= true,[82666958311998]= true,[111920872708571]= true,[106871536134254]= true,[109402730355822]= true,[130593238885843]= true,[138720291317243]= true,[139369275981139]= true,[133963973694098]= true,[78935059863801]= true} MainState.BOouUDMI0x = {[118907603246885]= true,[135002183282873]= true,[113255068724446]= true,[129784271201071]= true,[105374834496520]= true,[117070354890871]= true,[115244153053858]= true,[110355011987939]= true,[117042998468241]= true,[122812055447896]= true} MainState.IxW_Dmx_ZxU1Uv = {}
 for vWpqDlOU, DbvDb in pairs(MainState.DUpNoHpX0DZv) do
MainState.IxW_Dmx_ZxU1Uv["rbxassetid://"..vWpqDlOU]="attack"
 end
for BvMIwlOuzI, l0mUwom in pairs(MainState.BOouUDMI0x) do
MainState.IxW_Dmx_ZxU1Uv["rbxassetid://"..BvMIwlOuzI]="lungehold"
 end
function MainState.MQQuzxZ(BoupqvXnz_x1p, BwM_obqOH)
 if not BoupqvXnz_x1p or not BwM_obqOH then
 return nil
 end
if BoupqvXnz_x1p== LocalPlayer then
 local lzxnow = LocalPlayer:GetAttribute("SelectedKiller")
 if lzxnow then
 return lzxnow
 end
end
 local QMlo_, IOwmIw0XqnN = pcall(
 function()
 return BwM_obqOH:WaitForChild("Values", 2)
end)
if QMlo_ and IOwmIw0XqnN then
 local v45 = IOwmIw0XqnN:FindFirstChild("KillerName")
 if v45 and v45:IsA("StringValue") then
 return v45.Value
 end
end
local conn29 = BoupqvXnz_x1p:GetAttribute("SelectedKiller")
if conn29 then
 return conn29
end
return nil
end
function MainState.pqpqo_mIXXOmqz()
if not ESPState.autoParryEnabledthen
return
end
if tick()- ESPState.lastParryTime< 0.15 then
 return
end
ESPState.lastParryTime = tick()
local inst110 = LocalPlayer.Character
if not inst110 then
 return
end
local char26 = PlayerGui:FindFirstChild("Survivor-mob")
local v46 = char26 and char26:FindFirstChild("Controls")
local v47 = v46 and v46:FindFirstChild("Gui-mob")
if v47 and v47:IsA("ImageButton") then
firesignal(v47.MouseButton1Down)
task.delay(0.05,
 function()
 if v47 and v47.Parentthen firesignal(v47.MouseButton1Up)
end
end)
else
local QMwHUl, WH_Up = pcall(
function()
local gui58 = Instance.new("InputObject")
gui58.UserInputType = Enum.UserInputType.MouseButton2 gui58.UserInputState = Enum.UserInputState.Beginreturn gui58
end)
if QMwHUl and WH_Up then
 for p__omXqm_1, vHouMQob in getconnections(UIS2.InputBegan) do
vHouMQob:Fire(WH_Up, false)
 end
else VirtualInputManager:SendMouseButtonEvent(0, 0, 1, true, game, 0)
end
end
local inst111 = inst110:FindFirstChild("HumanoidRootPart")
if inst111 then
task.defer(
 function() pcall(
 function()
 if CollectionService:HasTag(inst111,"doing action") then
CollectionService:RemoveTag(inst111,"doing action")
 end
end)
end)
end
end
function MainState.omXXOoIZHO1(l0quv, p_IIuz0Oz1)
local inst112 = LocalPlayer.Characterif not inst112 then
 return
end
local NmzOx = inst112:FindFirstChild("HumanoidRootPart")
if not NmzOx then
 return
end
local v48 = l0quv:FindFirstChild("HumanoidRootPart")
if not v48 then
 return
end
local v49 = Players.LocalPlayer:GetNetworkPing()
local v50 = math.clamp(v49, 0, 0.3)
local v51 = v48.AssemblyLinearVelocity
local v52 = Vector3.new(v51.X, 0, v51.Z)
local gui59 = v48.Position+(v52* v50)
local gui60 = NmzOx.Position- gui59
local gui61 = gui60.Magnitudelocal gui62 = ESPState.autoParryRadius+ 2
if gui61> gui62 then
 return
end
local gui63 = (NmzOx.Position- v48.Position).Unit
if v52.Magnitude> 8 then
 local inst113 = v52.Unit:Dot(gui63)
 if inst113<- 0.1 then
 return
 end
end
if gui61>= 15 then
 local inst114 = RaycastParams.new()
inst114.FilterDescendantsInstances = { inst112, l0quv} inst114.FilterType = Enum.RaycastFilterType.Exclude
 local inst115 = Workspace:Raycast(v48.Position, gui60, inst114)
 if inst115 and inst115.Instanceand not inst115.Instance:IsDescendantOf(inst112) then
 return
 end
end MainState.pqpqo_mIXXOmqz()
end
function MainState.uzDHHIvzqz(bzHw1N, WwXoZ)
if bzHw1N== LocalPlayer then
 return
end
task.wait(0.5)
if not WwXoZ.Parent then
 return
end
local char27 = MainState.MQQuzxZ(bzHw1N, WwXoZ)
if char27 or(bzHw1N.Team and bzHw1N.Team.Name:lower():find("killer")) then
 local char28 = char27 or "Unknown Killer"
 local char29 = WwXoZ:WaitForChild("Humanoid", 3)
 if char29 then
 local DwopNwppQp = char29:WaitForChild("Animator", 3)
 if DwopNwppQp then
DwopNwppQp.AnimationPlayed:Connect(
 function(lvUXZu)
 if not ESPState.autoParryEnabledthen
 return
 end
if lvUXZu and lvUXZu.Animationthen
 local remote9 = MainState.IxW_Dmx_ZxU1Uv[lvUXZu.Animation.AnimationId]
 if remote9 then
ESPState.activeAttackers[WwXoZ]={ name = char28, track = lvUXZu, type = remote9}
 if remote9=="attack" then
MainState.omXXOoIZHO1(WwXoZ, char28)
 end
local IXvnz IXvnz = lvUXZu.Stopped:Connect(
 function()
 if IXvnz then
IXvnz.Disconnect(IXvnz)
 end
task.delay(0.3,
 function()
 if ESPState.activeAttackers[WwXoZ] and ESPState.activeAttackers[WwXoZ].track== lvUXZu then
ESPState.activeAttackers[WwXoZ]= nil
 end
end)
 end)
end
end
end)
end
end
end
end
function MainState._qM_on(WQOIXUMQQ)
if WQOIXUMQQ== LocalPlayer then
 return
end
if WQOIXUMQQ.Characterthen task.spawn(
function()
MainState.uzDHHIvzqz(WQOIXUMQQ, WQOIXUMQQ.Character)
end)
end
WQOIXUMQQ.CharacterAdded:Connect(
function(QqMHw_UW0)
task.spawn(
function()
MainState.uzDHHIvzqz(WQOIXUMQQ, QqMHw_UW0)
end)
end)
end
for qoU0IW, lvmOIMXW in ipairs(Players.GetPlayers(Players)) do
 if lvmOIMXW~= LocalPlayer then
MainState._qM_on(lvmOIMXW)
 end
end Players.PlayerAdded:Connect(MainState._qM_on) CreateESPEntry("AttackersMonitor", 0,
function()
if not ESPState.autoParryEnabledthen
return
end
if next(ESPState.activeAttackers)== nil then
 return
end
for wlo1W0q0XuqX, OWzxxIm_ in pairs(ESPState.activeAttackers) do
 if not wlo1W0q0XuqX or not wlo1W0q0XuqX.Parent or not OWzxxIm_.track then
ESPState.activeAttackers[wlo1W0q0XuqX]= nil
 else
 if not OWzxxIm_.track.IsPlaying then
ESPState.activeAttackers[wlo1W0q0XuqX]= nil
 else
 if OWzxxIm_.type=="attack" then
 if OWzxxIm_.track.TimePosition< 0.25 then
MainState.omXXOoIZHO1(wlo1W0q0XuqX, OWzxxIm_.name)
 end
elseif OWzxxIm_.type=="lungehold" then
 local inst116 = LocalPlayer.Character
 local inst117 = inst116 and inst116:FindFirstChild("HumanoidRootPart")
 local inst118 = wlo1W0q0XuqX:FindFirstChild("HumanoidRootPart")
 if inst117 and inst118 then
 local inst119 = (inst118.Position- inst117.Position).Magnitudeif inst119<= ESPState.autoParryRadius* 0.8 then
MainState.omXXOoIZHO1(wlo1W0q0XuqX, OWzxxIm_.name)
 end
end
 end
end
end
end
end)
MainState.vQbOXZmp_ = {} MainState.lwIb11vxW = nil MainState.BMO1q = {} MainState._MHzo1Zq = 32 MainState.uWXOlqNMoNMI = -1
function MainState.qI_mZo0lWzH()
for WQvumQoM, uDnHU_01x in ipairs(MainState.vQbOXZmp_) do
 if uDnHU_01x and uDnHU_01x.Parentthen uDnHU_01x.Destroy(uDnHU_01x)
end
end MainState.vQbOXZmp_ = {} MainState.BMO1q = {}
local conn30 = (2* math.pi)/ MainState._MHzo1Zq
for Nl0Iu_l = 1, MainState._MHzo1Zq do
 local conn31 = conn30*(Nl0Iu_l- 1)
 local conn32 = conn30* Nl0Iu_l MainState.BMO1q[Nl0Iu_l]={ cx = math.cos(conn31), cz = math.sin(conn31), nx = math.cos(conn32), nz = math.sin(conn32),}
 local conn33 = Instance.new("Part")
conn33.Shape = Enum.PartType.BlockOqXoMQ.Anchored = true conn33.CanCollide = false conn33.CanQuery = false conn33.CastShadow = false conn33.Material = Enum.Material.Neon conn33.Color = Color3.fromRGB(255, 60, 60)
conn33.Transparency = 0.15 conn33.Size = Vector3.new(0.08, 0.08, 0.1)
conn33.Name = "BolongESP_Seg" conn33.Parent = Workspace MainState.vQbOXZmp_[Nl0Iu_l]= conn33
end
end
function MainState.I_XOXx0pqZolpo(MvNMNIo)
local inst120 = (2* math.pi* MvNMNIo)/ MainState._MHzo1Zq
for wXoZHI_n, DbQZu in ipairs(MainState.vQbOXZmp_) do
 if DbQZu and DbQZu.Parent then
DbQZu.Size = Vector3.new(0.08, 0.08, inst120+ 0.02)
 end
end
end
function MainState.lWMxxOX()
for qvX_MqWlDlQ1WH, wO0_mbu in ipairs(MainState.vQbOXZmp_) do
 if wO0_mbu and wO0_mbu.Parent then
wO0_mbu.Destroy(wO0_mbu)
 end
end MainState.vQbOXZmp_ = {} MainState.BMO1q = {} MainState.uWXOlqNMoNMI = -1
end
function MainState.onDxz1o(vXI0x1m1HW)
if vXI0x1m1HW then
MainState.qI_mZo0lWzH()
MainState.lwIb11vxW = RunService.RenderStepped:Connect(
 function()
 if not LocalPlayer.Character then
 return
 end
local char30 = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
 if not char30 then
 return
 end
local char31 = ESPState.autoParryRadiusif char31~= MainState.uWXOlqNMoNMI then
MainState.I_XOXx0pqZolpo(char31)
MainState.uWXOlqNMoNMI = char31
 end
local v53 = char30.Position- Vector3.new(0, char30.Size.Y/ 2+ 1.5, 0)
 for uvW0m, HbQmuWxQxoIW in ipairs(MainState.vQbOXZmp_) do
 if HbQmuWxQxoIW and HbQmuWxQxoIW.Parentthen
 local inst121 = MainState.BMO1q[uvW0m]
 local inst122 = v53+ Vector3.new(inst121.cx* char31, 0, inst121.cz* char31)
 local color16 = v53+ Vector3.new(inst121.nx* char31, 0, inst121.nz* char31)
HbQmuWxQxoIW.CFrame = CFrame.lookAt(inst122, color16)* CFrame.new(0, 0,- HbQmuWxQxoIW.Size.Z/ 2)
 end
end
end)
else
if MainState.lwIb11vxW then
MainState.lwIb11vxW.Disconnect(MainState.lwIb11vxW);
MainState.lwIb11vxW = nil
end
MainState.lWMxxOX()
end
end
end
function MainState.lHZlWupp()
for QzwoMnWO, plz0Iv0D1bMuIq in ipairs(ESPState.cachedMapObjects.Gates) do
func16(plz0Iv0D1bMuIq, ESPState.ghostGateEnabled)
end
end
function MainState._XDNw()
local inst123 = LocalPlayer.Character
local inst124 = inst123 and inst123:FindFirstChild("HumanoidRootPart")
if not inst124 then
ShowNotify("Teleport","Karakter tidak ditemukan!", 2);
 return
end
local inst125 = workspace:FindFirstChild("Fininshline", true)
if not inst125 then
ShowNotify("Teleport","Fininshline tidak ditemukan di map!", 2);
 return
end
local char32 = inst125.Position
local char33 = RaycastParams.new()
char33.FilterType = Enum.RaycastFilterType.Exclude char33.FilterDescendantsInstances = { inst123, inst125.Parent}
local inst126 = nil
local Imqzm = char32+ Vector3.new(0, 10, 0)
local inst127 = workspace:Raycast(Imqzm, Vector3.new(0,- 30, 0), char33)
if inst127 then
 local pcall12 = workspace:Raycast(inst127.Position+ Vector3.new(0, 5, 0), Vector3.new(0, 5, 0), char33)
 if not pcall12 then
inst126 = inst127.Position+ Vector3.new(0, 3, 0)
 end
end
if inst126 then
pcall(
 function()
inst124.CFrame = CFrame.new(inst126)
end)
else pcall(
function()
inst124.CFrame = inst125.CFrameend)
end
end do
do
 local v54 = 46*(0+ 1- 1)
 local v55 = v54+ 302- 302
 end
MainState._Q1MmIbx0x = "80411309607666"
 function MainState.DNHmxOz0wXm(WDNbX)
 if not WDNbX then
 return ""
 end
return tostring(WDNbX):match("%d+") or ""
end
function MainState.NIlvNOODX()
local inst128 = LocalPlayer:FindFirstChild("PlayerGui")
if not inst128 then
 return nil
end
local pcall13 = inst128:FindFirstChild("Survivor-mob")
if not pcall13 then
 return nil
end
local pcall14 = pcall13:FindFirstChild("Controls")
if not pcall14 then
 return nil
end
local pcall15 = pcall14:FindFirstChild("crouch")
if pcall15 and pcall15:IsA("GuiButton") then
 return pcall15
end
return nil
end
function MainState.uuMqxOzluob(WbvomoHupl)
if ESPState.autoCrouchIsCrouching~= WbvomoHupl then
ESPState.autoCrouchIsCrouching = WbvomoHupl
 local inst129 = LocalPlayer.Characterif inst129 then
inst129:SetAttribute("Crouchingserver", WbvomoHupl) inst129:SetAttribute("Crouching", WbvomoHupl)
 end
pcall(
 function()
ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouchingserver", WbvomoHupl)
ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouching", WbvomoHupl)
end)
local inst130 = not UIS2.TouchEnabled and UIS2.KeyboardEnabledif inst130 then
if0>(481) then
 local inst131 = 307+ 481
 local inst132 = inst131* 2
 end
VirtualInputManager:SendKeyEvent(WbvomoHupl, Enum.KeyCode.C, false, game) VirtualInputManager:SendKeyEvent(WbvomoHupl, Enum.KeyCode.LeftControl, false, game)
else
local inst133 = MainState.NIlvNOODX()
if inst133 and type(firesignal)=="function" then
 if WbvomoHupl then
firesignal(inst133.MouseButton1Down)
 if inst133.MouseButton1Clickthen firesignal(inst133.MouseButton1Click)
 end
else firesignal(inst133.MouseButton1Up)
if inst133.MouseButton1Clickthen firesignal(inst133.MouseButton1Click)
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
local v56 = BNIvXQwIq_oq:FindFirstChildOfClass("Humanoid")
if not v56 then
 return
end
if ESPState.autoCrouchAnimConns[v56] then
 return
end
ESPState.autoCrouchAnimConns[v56]= v56.AnimationPlayed:Connect(
function(DZWIHb)
if not Settings.autoCrouchEnabled then
 return
end
local v57 = DZWIHb.Animationif v57 then
 local NWX_10XMN = MainState.DNHmxOz0wXm(v57.AnimationId)
 if NWX_10XMN== MainState._Q1MmIbx0x then
ESPState.autoCrouchActiveSlashers[BNIvXQwIq_oq]= true DZWIHb.Stopped:Connect(
 function()
task.wait(0.2)
ESPState.autoCrouchActiveSlashers[BNIvXQwIq_oq]= nil
 end)
end
end
end)
v56.Died:Connect(
function()
ESPState.autoCrouchActiveSlashers[BNIvXQwIq_oq]= nil
end)
end
CreateESPEntry("AutoCrouch", 0,
function()
if not Settings.autoCrouchEnabled then
 return
end
local flag26 = LocalPlayer.Characterif not flag26 then
 return
end
local pcall16 = flag26:FindFirstChild("HumanoidRootPart")
if not pcall16 then
 return
end
local pcall17 = false
for bDMQZ, HDbUNv0uQMZW in pairs(ESPState.autoCrouchActiveSlashers) do
 if bDMQZ and bDMQZ.Parentthen
 local v58 = bDMQZ:FindFirstChild("HumanoidRootPart")
 local v59 = bDMQZ:FindFirstChildOfClass("Humanoid")
 if v58 and v59 and v59.Health> 0 then
 local pcall18 = (v58.Position- pcall16.Position).Magnitudeif pcall18<= Settings.autoCrouchRadiusthen pcall17 = true break
 end
end
else ESPState.autoCrouchActiveSlashers[bDMQZ]= nil
end
end MainState.uuMqxOzluob(pcall17)
end)
for OmuImNmbDzqo1I, HIvWvODwzzu_p in ipairs(Players.GetPlayers(Players)) do
 if HIvWvODwzzu_p~= LocalPlayer and HIvWvODwzzu_p.Characterthen MainState.uqH_ZIQnzH_u(HIvWvODwzzu_p.Character)
end
if HIvWvODwzzu_p~= LocalPlayer then
HIvWvODwzzu_p.CharacterAdded:Connect(
 function(wXz_XuD)
task.wait(1)
MainState.uqH_ZIQnzH_u(wXz_XuD)
end)
end
end Players.PlayerAdded:Connect(
function(HqvZ0WXWIZU)
HqvZ0WXWIZU.CharacterAdded:Connect(
function(BmqZDmDu1pnn)
task.wait(1)
if Settings.autoCrouchEnabled then
MainState.uqH_ZIQnzH_u(BmqZDmDu1pnn)
end
end)
end)
end
function MainState.vzImqwp(vnqDZuQ0XQ)
if not vnqDZuQ0XQ or vnqDZuQ0XQ:gsub("%s+","")=="" then
 return
end
vnqDZuQ0XQ = vnqDZuQ0XQ:gsub("%s+","")
task.spawn(
function()
local flag27 = tonumber(vnqDZuQ0XQ)
if not flag27 then
 local flag28 = pcall(
 function()
flag27 = Players:GetUserIdFromNameAsync(vnqDZuQ0XQ)
end)
if not flag28 or not flag27 then
 return
end
end
local pcall19 = LocalPlayer.Character
local inst134 = pcall19 and pcall19:FindFirstChildOfClass("Humanoid")
if not pcall19 or not inst134 then
 return
end
local inst135 = Players:GetHumanoidDescriptionFromUserId(flag27)
if not inst135 then
 return
end
local gui64 = Players:CreateHumanoidModelFromDescription(inst135, inst134.RigType)
if not gui64 then
 return
end
for bMwXIob00, Qx_UXQb_N in ipairs(pcall19.GetChildren(pcall19)) do
 if Qx_UXQb_N:IsA("Accessory") or Qx_UXQb_N:IsA("Shirt") or Qx_UXQb_N:IsA("Pants") or Qx_UXQb_N:IsA("ShirtGraphic") or Qx_UXQb_N:IsA("BodyColors") or Qx_UXQb_N:IsA("CharacterMesh") then
Qx_UXQb_N.Destroy(Qx_UXQb_N)
 end
end
for w0qzpxmvu, MWzUWQqDZnOHmW in ipairs(pcall19.GetChildren(pcall19)) do
 if MWzUWQqDZnOHmW:IsA("BasePart") then
 for p0ozMOZ, pbmxO1WZI in ipairs(MWzUWQqDZnOHmW.GetChildren(MWzUWQqDZnOHmW)) do
 if pbmxO1WZI:IsA("SpecialMesh") or pbmxO1WZI:IsA("Decal") or pbmxO1WZI:IsA("Texture") or pbmxO1WZI:IsA("SurfaceAppearance") then
pbmxO1WZI.Destroy(pbmxO1WZI)
 end
end
 end
end
local inst136 = gui64:FindFirstChildOfClass("BodyColors")
if inst136 then
inst136.Clone(inst136).Parent = pcall19
 local inst137 = { Head = inst136.HeadColor3, Torso = inst136.TorsoColor3,["Left Arm"]= inst136.LeftArmColor3,["Right Arm"]= inst136.RightArmColor3,["Left Leg"]= inst136.LeftLegColor3,["Right Leg"]= inst136.RightLegColor3, UpperTorso = inst136.TorsoColor3, LowerTorso = inst136.TorsoColor3, LeftHand = inst136.LeftArmColor3, RightHand = inst136.RightArmColor3, LeftLowerArm = inst136.LeftArmColor3, RightLowerArm = inst136.RightArmColor3, LeftUpperArm = inst136.LeftArmColor3, RightUpperArm = inst136.RightArmColor3, LeftFoot = inst136.LeftLegColor3, RightFoot = inst136.RightLegColor3, LeftLowerLeg = inst136.LeftLegColor3, RightLowerLeg = inst136.RightLegColor3, LeftUpperLeg = inst136.LeftLegColor3, RightUpperLeg = inst136.RightLegColor3,}
 for oIW0OxMHIZH, QuqHOQ1lQ_zQv in pairs(inst137) do
 local inst138 = pcall19:FindFirstChild(oIW0OxMHIZH)
 if inst138 then
pcall(
 function()
inst138.Color = QuqHOQ1lQ_zQv
 end)
 end
end
end
for wllqZxm, wIl1lxpxZlHnMo in ipairs(gui64.GetChildren(gui64)) do
 if wIl1lxpxZlHnMo:IsA("Shirt") or wIl1lxpxZlHnMo:IsA("Pants") or wIl1lxpxZlHnMo:IsA("ShirtGraphic") or wIl1lxpxZlHnMo:IsA("CharacterMesh") then
wIl1lxpxZlHnMo.Clone(wIl1lxpxZlHnMo).Parent = pcall19
 end
end
for _xv1qbQwpp, NvuqulXXlbzn in ipairs(gui64.GetChildren(gui64)) do
 if NvuqulXXlbzn:IsA("BasePart") then
 local remote10 = pcall19:FindFirstChild(NvuqulXXlbzn.Name)
 if remote10 and remote10:IsA("BasePart") then
 if NvuqulXXlbzn:IsA("MeshPart") and remote10:IsA("MeshPart") then
pcall(
 function()
remote10.MeshId = NvuqulXXlbzn.MeshIdwmQzDQ_Qm01b.TextureID = NvuqulXXlbzn.TextureIDwmQzDQ_Qm01b.Color = NvuqulXXlbzn.ColorwmQzDQ_Qm01b.Transparency = NvuqulXXlbzn.Transparencyend)
 end
for HWMnXMIWo0w, MIM_Oxx in ipairs(NvuqulXXlbzn.GetChildren(NvuqulXXlbzn)) do
 if MIM_Oxx:IsA("SpecialMesh") or MIM_Oxx:IsA("Decal") or MIM_Oxx:IsA("Texture") or MIM_Oxx:IsA("SurfaceAppearance") then
MIM_Oxx.Clone(MIM_Oxx).Parent = remote10
 end
end
 end
end
end
local function func68(OpXUnWomU)
local v60 = OpXUnWomU.Clone(OpXUnWomU)
v60.Parent = pcall19
local v61 = v60:FindFirstChild("Handle")
if not v61 then
 return
end
v61.Anchored = false v61.CanCollide = false pcall(
function()
v61.Massless = true
end)
for ln_ov, lXO0Qo in ipairs(v61.GetChildren(v61)) do
 if lXO0Qo:IsA("Weld") or lXO0Qo:IsA("WeldConstraint") or lXO0Qo:IsA("Motor6D") then
lXO0Qo.Destroy(lXO0Qo)
 end
end pcall(
function() inst134:AddAccessory(v60)
end)
local cam16 = false
for BuHqDzx, obZNZ1UIQXMm in ipairs(v61.GetChildren(v61)) do
 if(obZNZ1UIQXMm:IsA("Weld") or obZNZ1UIQXMm:IsA("WeldConstraint")) and obZNZ1UIQXMm.Part1 and obZNZ1UIQXMm.Part1:IsDescendantOf(pcall19) then
cam16 = true break
 end
end
if not cam16 then
 local inst139 = v61:FindFirstChildOfClass("Attachment")
 local char34 = nil
 local char35 = nil
 if inst139 then
 for DpOunw__0b_pb, QQ1mZxn in ipairs(pcall19.GetDescendants(pcall19)) do
 if QQ1mZxn:IsA("Attachment") and QQ1mZxn.Name== inst139.Name then
char34 = QQ1mZxn.ParentHOIvqoQ1W0v_o = QQ1mZxn break
 end
end
 end
if not char34 then
char34 = pcall19:FindFirstChild("Head") or pcall19:FindFirstChild("HumanoidRootPart")
 end
if char34 then
 if char35 and inst139 then
v61.CFrame = char34.CFrame* char35.CFrame* inst139.CFrame:Inverse()
 else v61.CFrame = char34.CFrameend
 local val17 = Instance.new("WeldConstraint")
val17.Name = "BolongWeld" val17.Part0 = v61 val17.Part1 = char34 val17.Parent = v61
 end
end
end
for OpWHzNmv0n, WzNZNDWoUMm in ipairs(gui64.GetChildren(gui64)) do
 if WzNZNDWoUMm:IsA("Accessory") then
pcall(
 function() func68(WzNZNDWoUMm)
 end)
end
end gui64.Destroy(gui64)
end)
end
MainState.owxoOMxxHWu = { Ambient = Lighting.Ambient, OutdoorAmbient = Lighting.OutdoorAmbient, ColorShift_Bottom = Lighting.ColorShift_Bottom, ColorShift_Top = Lighting.ColorShift_Top, Brightness = Lighting.Brightness, ClockTime = Lighting.ClockTime, GlobalShadows = Lighting.GlobalShadows, FogStart = Lighting.FogStart, FogEnd = Lighting.FogEnd, FogColor = Lighting.FogColor, ExposureCompensation = Lighting.ExposureCompensation, EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale, EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale,} MainState.HwQWWqQUWpIl1N = {}
function MainState.p_01zM1nQ()
Lighting.Ambient = Color3.fromRGB(178, 178, 178)
Lighting.OutdoorAmbient = Color3.fromRGB(178, 178, 178)
Lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
Lighting.ColorShift_Top = Color3.new(0, 0, 0)
Lighting.Brightness = 3;
Lighting.ClockTime = 12;
Lighting.GlobalShadows = false Lighting.FogStart = 9e9;
Lighting.FogEnd = 9e9;
Lighting.ExposureCompensation = 0 Lighting.EnvironmentDiffuseScale = 0;
Lighting.EnvironmentSpecularScale = 0
end
function MainState.un10pxvlDoWQlp()
for uMMbHHO, u0pWQHvI in pairs(MainState.owxoOMxxHWu) do
pcall(
 function() Lighting[uMMbHHO]= u0pWQHvI
end)
end
end
function MainState.NZ0MOpIIxM_0()
MainState.HwQWWqQUWpIl1N = {}
for pO11wzpH, WHNHqXnl1ZQ0bH in ipairs(Lighting.GetChildren(Lighting)) do
 if WHNHqXnl1ZQ0bH:IsA("PostEffect") or WHNHqXnl1ZQ0bH:IsA("Clouds") or WHNHqXnl1ZQ0bH:IsA("Atmosphere") or WHNHqXnl1ZQ0bH:IsA("Sky") then
MainState.HwQWWqQUWpIl1N[WHNHqXnl1ZQ0bH]={ Enabled = WHNHqXnl1ZQ0bH.Enabled, Parent = WHNHqXnl1ZQ0bH.Parent} pcall(
 function()
 if WHNHqXnl1ZQ0bH:IsA("Sky") then
WHNHqXnl1ZQ0bH.Parent = nil
 else WHNHqXnl1ZQ0bH.Enabled = false
 end
end)
end
end
end
function MainState.WwMOwDZWQxwXD()
for bIuOM_u, _ZWNNo0MHO in pairs(MainState.HwQWWqQUWpIl1N) do
 if bIuOM_u then
pcall(
 function()
 if bIuOM_u:IsA("Sky") then
bIuOM_u.Parent = _ZWNNo0MHO.Parentelse bIuOM_u.Enabled = _ZWNNo0MHO.Enabled
 end
end)
end
end MainState.HwQWWqQUWpIl1N = {}
end
CreateESPEntry("LightingEnforcer", 0.5,
function()
if ESPState.fullbrightEnabled then
MainState.p_01zM1nQ()
end
if ESPState.removeVfxEnabledthen
for pwvU1bHz, _DDlOw1ZI in ipairs(Lighting.GetChildren(Lighting)) do
 if _DDlOw1ZI:IsA("PostEffect") or _DDlOw1ZI:IsA("Clouds") or _DDlOw1ZI:IsA("Atmosphere") or _DDlOw1ZI:IsA("Sky") then
pcall(
 function()
 if _DDlOw1ZI:IsA("Sky") then
 if _DDlOw1ZI.Parentthen _DDlOw1ZI.Parent = nil
 end
else
 if _DDlOw1ZI.Enabled then
_DDlOw1ZI.Enabled = false
 end
end
end)
end
end
end
end)
Lighting.ChildAdded:Connect(
function(u0xH0O0UD_)
if ESPState.removeVfxEnabled then
 if u0xH0O0UD_:IsA("PostEffect") or u0xH0O0UD_:IsA("Clouds") or u0xH0O0UD_:IsA("Atmosphere") or u0xH0O0UD_:IsA("Sky") then
task.spawn(
 function() pcall(
 function()
 if u0xH0O0UD_:IsA("Sky") then
u0xH0O0UD_.Parent = nil
 else u0xH0O0UD_.Enabled = false
 end
end)
end)
end
end
end) do
 function MainState.DlDv_DxHml()
 local inst140 = Instance.new("ScreenGui")
inst140.Name = "BolongFOV";
inst140.ResetOnSpawn = false;
inst140.DisplayOrder = 999999 pcall(
 function()
inst140.Parent = (gethui and gethui() or game:GetService("CoreGui"))
end)
if not inst140.Parent then
inst140.Parent = PlayerGui
end
ESPState.FOVCircle = Instance.new("Frame")
ESPState.FOVCircle.Size = UDim2.new(0, Settings.silentAimFovRadius* 2, 0, Settings.silentAimFovRadius* 2)
ESPState.FOVCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
ESPState.FOVCircle.AnchorPoint = Vector2.new(0.5, 0.5)
ESPState.FOVCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ESPState.FOVCircle.BackgroundTransparency = 1;
ESPState.FOVCircle.Visible = false ESPState.FOVCircle.Parent = inst140
local gui65 = Instance.new("UICorner");
gui65.CornerRadius = UDim.new(1, 0);
gui65.Parent = ESPState.FOVCircle
local gui66 = Instance.new("UIStroke")
gui66.Color = NotifyColor;
gui66.Thickness = 2;
gui66.Transparency = 0.2;
gui66.Parent = ESPState.FOVCircle
end
MainState.DlDv_DxHml()
function MainState.DM_lMDIIqlpw(oxvvNv)
if not oxvvNv then
 return nil
end
local gui67 = oxvvNv:FindFirstChild("UpperTorso")
if gui67 and gui67:IsA("BasePart") then
 return gui67.Positionend
 local gui68 = oxvvNv:FindFirstChild("Torso")
 if gui68 and gui68:IsA("BasePart") then
 return gui68.Positionend
 local gui69 = oxvvNv:FindFirstChild("HumanoidRootPart")
 if gui69 then
 return gui69.Positionend
 return nil
 end
function MainState.lwHZx()
 local gui70 = LocalPlayer.Character
 if not gui70 then
 return nil
 end
local MqmoMU0MDXZlDm, HvlIxqz = pcall(
 function()
 return gui70:FindFirstChild("Twist of Fate"):FindFirstChild("Right Arm"):FindFirstChild("gun"):FindFirstChild("gun")
 end)
 if MqmoMU0MDXZlDm and HvlIxqz and HvlIxqz:IsA("BasePart") then
 return HvlIxqz.Positionend
 local inst141 = gui70:FindFirstChild("Right Arm") or gui70:FindFirstChild("RightHand")
 if inst141 then
 return inst141.Position
 end
return nil
 end
MainState.wOM_Wn = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Items"):WaitForChild("Twist of Fate"):WaitForChild("Fire") pcall(
 function()
MainState.BDvWIwNMuDUoz0 = hookmetamethod(game,"__namecall",
 function(WqMm0W,..)
 local inst142 = getnamecallmethod()
 if inst142=="FireServer" and rawequal(WqMm0W, MainState.wOM_Wn) then
 local gui71 = table.pack(...)
 if ESPState.silentAimEnabled and typeof(ESPState.silentAimLookVector)=="Vector3" then
 if gui71.n>= 3 and typeof(gui71[3])=="Vector3" then
gui71[3]= ESPState.silentAimLookVectorif ESPState.laserEspEnabledthen ESPState.triggerLaser = true
 end
elseif gui71.n>= 2 and typeof(gui71[2])=="Vector3" then
gui71[2]= ESPState.silentAimLookVector
 if ESPState.laserEspEnabledthen ESPState.triggerLaser = true
 end
end
end
return MainState.BDvWIwNMuDUoz0(WqMm0W, table.unpack(gui71, 1, gui71.n))
end
return MainState.BDvWIwNMuDUoz0(WqMm0W,..)
end)
end) CreateESPEntry("UpdateSilentAimTarget", 0.05,
function()
if ESPState.FOVCircle then
ESPState.FOVCircle.Visible = ESPState.silentAimFovVisiblelocal color17 = Settings.silentAimFovRadius* 2
 if ESPState.FOVCircle.Size.X.Offset~= color17 then
ESPState.FOVCircle.Size = UDim2.new(0, color17, 0, color17)
 end
end
if not ESPState.silentAimEnabledthen ESPState.silentAimTarget = nil;
ESPState.silentAimLookVector = nil;
return
end
local inst143 = LocalPlayer.Character
if not inst143 then
 return
end
local inst144 = inst143:FindFirstChild("HumanoidRootPart")
if not inst144 then
 return
end
local inst145 = workspace.CurrentCamera
if not inst145 then
 return
end
local inst146 = nil
local pcall20 = math.hugefor BwNW_o, Bw0M_ in ipairs(Players.GetPlayers(Players)) do
 if Bw0M_~= LocalPlayer and GetPlayerRole(Bw0M_)=="killer" then
 local inst147 = Bw0M_.Character
 if inst147 then
 local inst148 = inst147:FindFirstChildOfClass("Humanoid")
 local inst149 = MainState.DM_lMDIIqlpw(inst147)
 if inst148 and inst148.Health> 0 and typeof(inst149)=="Vector3" then
 local gui72 = (inst149- inst144.Position).Magnitudeif gui72< pcall20 then
pcall20 = gui72;
inst146 = Bw0M_
 end
end
 end
end
end
if inst146 and inst146.Character then
 local gui73 = MainState.DM_lMDIIqlpw(inst146.Character)
 if typeof(gui73)=="Vector3" then
 local color18 = true
 local HvQ0wb0wxOp_xq, bDWoxolNOmnXz = inst145:WorldToViewportPoint(gui73)
 if bDWoxolNOmnXz then
 local inst150 = Vector2.new(inst145.ViewportSize.X/ 2, inst145.ViewportSize.Y/ 2)
 local inst151 = (Vector2.new(HvQ0wb0wxOp_xq.X, HvQ0wb0wxOp_xq.Y)- inst150).Magnitude
 if inst151> Settings.silentAimFovRadius then
color18 = false
 end
else color18 = false
 end
if color18 then
 local inst152 = MainState.lwHZx()
 if typeof(inst152)~="Vector3" then
inst152 = inst145.CFrame.Positionend
 local gui74 = gui73- inst152
 local gui75 = gui74.Magnitudeif gui75> 0.1 then
ESPState.silentAimTarget = gui73 ESPState.silentAimLookVector = Vector3.new(gui74.X/ gui75, gui74.Y/ gui75, gui74.Z/ gui75)
ESPState.currentMuzzlePos = inst152;
ESPState.currentTargetPos = gui73
 else ESPState.silentAimTarget = nil;
ESPState.silentAimLookVector = nil
 end
else ESPState.silentAimTarget = nil;
ESPState.silentAimLookVector = nil
end
else ESPState.silentAimTarget = nil;
ESPState.silentAimLookVector = nil
end
else ESPState.silentAimTarget = nil;
ESPState.silentAimLookVector = nil
end
end) CreateESPEntry("DrawLaserESP", 0,
function()
if not ESPState.triggerLaser then
 return
end
ESPState.triggerLaser = false
local val18 = ESPState.currentMuzzlePos
local val19 = ESPState.currentTargetPos
if typeof(val18)~="Vector3" or typeof(val19)~="Vector3" then
 return
end
local val20 = (val18- val19).Magnitude
if val20< 0.1 then
 return
end
local val21 = Instance.new("Part")
val21.Name = "SilentLaser";
val21.Anchored = true;
val21.CanCollide = false val21.Material = Enum.Material.Neon;
val21.Color = Color3.fromRGB(255, 0, 0)
val21.Transparency = 0.3;
val21.Size = Vector3.new(0.15, 0.15, val20)
val21.CFrame = CFrame.new(val18, val19)* CFrame.new(0, 0,- val20/ 2)
val21.Parent = workspace task.delay(0.4,
function()
if val21 then
val21.Destroy(val21)
end
end)
end)
end
do
 function MainState.ppmDZmUwpIop(uZzNlz)
 if not uZzNlz then
 return nil
 end
local v62 = uZzNlz:FindFirstChild("UpperTorso")
 if v62 and v62:IsA("BasePart") then
 return v62.Position
 end
local val22 = uZzNlz:FindFirstChild("Torso")
 if val22 and val22:IsA("BasePart") then
 return val22.Position
 end
local val23 = uZzNlz:FindFirstChild("HumanoidRootPart")
 if val23 then
 return val23.Position+ Vector3.new(0, 0.5, 0)
 end
return nil
end
function MainState._vMo1mZ1l(qxxuWHnX_p0, wv1lblzM, D_UInxMv)
local HoM10xblpWb, q01XnvuZX = qxxuWHnX_p0:WorldToViewportPoint(wv1lblzM)
if not q01XnvuZX then
 return false
end
local val24 = Vector2.new(qxxuWHnX_p0.ViewportSize.X/ 2, qxxuWHnX_p0.ViewportSize.Y/ 2)
local val25 = Vector2.new(HoM10xblpWb.X, HoM10xblpWb.Y)
local v63 = (val25- val24).Magnitudereturn v63<= D_UInxMv
end
function MainState._ONZmmHUz()
local v64 = Instance.new("ScreenGui")
v64.Name = "BolongSpearFOV";
v64.ResetOnSpawn = false;
v64.DisplayOrder = 999999 pcall(
function()
v64.Parent = (gethui and gethui() or game:GetService("CoreGui"))
end)
if not v64.Parent then
v64.Parent = PlayerGui
end
ESPState.SpearFOVCircle = Instance.new("Frame")
ESPState.SpearFOVCircle.Size = UDim2.new(0, Settings.spearFovRadius* 2, 0, Settings.spearFovRadius* 2)
ESPState.SpearFOVCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
ESPState.SpearFOVCircle.AnchorPoint = Vector2.new(0.5, 0.5)
ESPState.SpearFOVCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ESPState.SpearFOVCircle.BackgroundTransparency = 1;
ESPState.SpearFOVCircle.Visible = false ESPState.SpearFOVCircle.Parent = v64
local v65 = Instance.new("UICorner");
v65.CornerRadius = UDim.new(1, 0);
v65.Parent = ESPState.SpearFOVCirclelocal val26 = Instance.new("UIStroke")
val26.Color = NotifyColor;
val26.Thickness = 2;
val26.Transparency = 0.2;
val26.Parent = ESPState.SpearFOVCircleend MainState._ONZmmHUz()
function MainState.Bvolu1()
local val27 = Instance.new("ScreenGui")
val27.Name = "SpearIndicatorUI";
val27.ResetOnSpawn = false;
val27.Enabled = false val27.DisplayOrder = 999998;
val27.IgnoreGuiInset = true pcall(
function()
val27.Parent = (gethui and gethui() or game:GetService("CoreGui"))
end)
if not val27.Parent then
val27.Parent = PlayerGui
end
ESPState.SpearMainFrame = Instance.new("Frame")
ESPState.SpearMainFrame.Name = "MainFrame" ESPState.SpearMainFrame.Size = UDim2.new(0, 180, 0, 42)
ESPState.SpearMainFrame.Position = UDim2.new(0.5, 0, 0.82, 0)
ESPState.SpearMainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
ESPState.SpearMainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ESPState.SpearMainFrame.BackgroundTransparency = 0.1 ESPState.SpearMainFrame.BorderSizePixel = 0 ESPState.SpearMainFrame.Parent = val27
local flag29 = Instance.new("UICorner");
flag29.CornerRadius = UDim.new(0, 8);
flag29.Parent = ESPState.SpearMainFramelocal Tmp2 = Instance.new("UIStroke")
Tmp2.Color = Color3.fromRGB(45, 45, 55);
Tmp2.Thickness = 1;
Tmp2.Transparency = 0.2;
Tmp2.Parent = ESPState.SpearMainFrame
local inst153 = Instance.new("UIGradient")
inst153.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 40)), ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 20))})
inst153.Rotation = 90;
inst153.Parent = ESPState.SpearMainFrame ESPState.SpearAccentBar = Instance.new("Frame")
ESPState.SpearAccentBar.Name = "AccentBar" ESPState.SpearAccentBar.Size = UDim2.new(0, 3, 1,- 12)
ESPState.SpearAccentBar.Position = UDim2.new(0, 6, 0, 6)
ESPState.SpearAccentBar.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
ESPState.SpearAccentBar.BorderSizePixel = 0;
ESPState.SpearAccentBar.Parent = ESPState.SpearMainFrame
local remote11 = Instance.new("UICorner");
remote11.CornerRadius = UDim.new(1, 0);
remote11.Parent = ESPState.SpearAccentBarESPState.SpearStatusText = Instance.new("TextLabel")
ESPState.SpearStatusText.Name = "StatusText" ESPState.SpearStatusText.Size = UDim2.new(1,- 18, 0, 18)
ESPState.SpearStatusText.Position = UDim2.new(0, 14, 0, 5)
ESPState.SpearStatusText.BackgroundTransparency = 1 HM1uHIZZl0.SpearStatusText.Text = "NO TARGET" ESPState.SpearStatusText.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPState.SpearStatusText.TextSize = 13;
ESPState.SpearStatusText.Font = Enum.Font.GothamBoldESPState.SpearStatusText.TextXAlignment = Enum.TextXAlignment.LeftESPState.SpearStatusText.TextTruncate = Enum.TextTruncate.AtEndESPState.SpearStatusText.Parent = ESPState.SpearMainFrame ESPState.SpearInfoText = Instance.new("TextLabel")
ESPState.SpearInfoText.Name = "InfoText" ESPState.SpearInfoText.Size = UDim2.new(1,- 18, 0, 14)
ESPState.SpearInfoText.Position = UDim2.new(0, 14, 0, 23)
ESPState.SpearInfoText.BackgroundTransparency = 1 HM1uHIZZl0.SpearInfoText.Text = "Aim to Survivor" ESPState.SpearInfoText.TextColor3 = Color3.fromRGB(160, 160, 170)
ESPState.SpearInfoText.TextSize = 10;
ESPState.SpearInfoText.Font = Enum.Font.Gotham ESPState.SpearInfoText.TextXAlignment = Enum.TextXAlignment.Left ESPState.SpearInfoText.TextTruncate = Enum.TextTruncate.AtEnd ESPState.SpearInfoText.Parent = ESPState.SpearMainFrameESPState.SpearIndicatorGui = val27
end
MainState.Bvolu1()
function MainState.Bznqp()
ESPState.SnapLineGui = Instance.new("ScreenGui")
ESPState.SnapLineGui.Name = "SpearVeil_SnapLine" ESPState.SnapLineGui.IgnoreGuiInset = true;
ESPState.SnapLineGui.ResetOnSpawn = false ESPState.SnapLineGui.DisplayOrder = 999999 pcall(
function()
ESPState.SnapLineGui.Parent = (gethui and gethui() or game:GetService("CoreGui"))
end)
if not ESPState.SnapLineGui.Parentthen ESPState.SnapLineGui.Parent = PlayerGui
end
ESPState.SnapLineFrame = Instance.new("Frame")
ESPState.SnapLineFrame.Name = "Line" ESPState.SnapLineFrame.AnchorPoint = Vector2.new(0.5, 0.5)
ESPState.SnapLineFrame.BorderSizePixel = 0 HM1uHIZZl0.SnapLineFrame.BackgroundColor3 = Color3.fromRGB(255, 220, 0)
ESPState.SnapLineFrame.BackgroundTransparency = 0.35 ESPState.SnapLineFrame.Visible = false;
ESPState.SnapLineFrame.Parent = ESPState.SnapLineGui ESPState.SnapLineDot = Instance.new("Frame")
ESPState.SnapLineDot.Name = "Dot" ESPState.SnapLineDot.AnchorPoint = Vector2.new(0.5, 0.5)
ESPState.SnapLineDot.BorderSizePixel = 0 ESPState.SnapLineDot.BackgroundColor3 = Color3.fromRGB(255, 220, 0)
ESPState.SnapLineDot.BackgroundTransparency = 0 ESPState.SnapLineDot.Size = UDim2.fromOffset(4, 4)
ESPState.SnapLineDot.Visible = false;
ESPState.SnapLineDot.Parent = ESPState.SnapLineGuilocal inst154 = Instance.new("UICorner");
inst154.CornerRadius = UDim.new(1, 0);
inst154.Parent = ESPState.SnapLineDot ESPState.SnapLineTextLabel = Instance.new("TextLabel")
ESPState.SnapLineTextLabel.Name = "InfoText" ESPState.SnapLineTextLabel.AnchorPoint = Vector2.new(0.5, 1)
ESPState.SnapLineTextLabel.Size = UDim2.new(0, 200, 0, 16)
ESPState.SnapLineTextLabel.BackgroundTransparency = 1 ESPState.SnapLineTextLabel.Text = "" ESPState.SnapLineTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPState.SnapLineTextLabel.TextSize = 12;
ESPState.SnapLineTextLabel.Font = Enum.Font.GothamBoldESPState.SnapLineTextLabel.TextStrokeTransparency = 0 HM1uHIZZl0.SnapLineTextLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
ESPState.SnapLineTextLabel.TextXAlignment = Enum.TextXAlignment.Center ESPState.SnapLineTextLabel.TextTruncate = Enum.TextTruncate.AtEndESPState.SnapLineTextLabel.Visible = false;
ESPState.SnapLineTextLabel.Parent = ESPState.SnapLineGuiend MainState.Bznqp()
function MainState.Wlx1W0xW(WpUuO1bQbqvqOW, BH_lz_O1D_QU, MODqwXnbn1Iz, qUxWlwvHZX)
local gui76 = math.cos(BH_lz_O1D_QU)
if gui76<= 0.015 then
 return nil, nil
end
local gui77 = WpUuO1bQbqvqOW/(MODqwXnbn1Iz* gui76)
if gui77~= gui77 or gui77<= 0 then
 return nil, nil
end
local gui78 = 1/ 60
local gui79 = 0.5* qUxWlwvHZX* gui78* gui77
local gui80 = MODqwXnbn1Iz* math.sin(BH_lz_O1D_QU)* gui77-(0.5* qUxWlwvHZX* gui77* gui77)- gui79
return gui80, gui77
end
function MainState.oIO1v(pOMWuuQm, bZ00l, pmIHpDvpplMp, lMpMW, HUqXuvXuWXu_)
local qDzpoH0qXNM1Wu, lv_NWuq_pDX0l = MainState.Wlx1W0xW(pOMWuuQm, pmIHpDvpplMp, lMpMW, HUqXuvXuWXu_)
if not qDzpoH0qXNM1Wu or not lv_NWuq_pDX0l then
 return nil
end
if lv_NWuq_pDX0l< 0.025 or lv_NWuq_pDX0l> 5 then
 return nil
end
local gui81 = math.abs(qDzpoH0qXNM1Wu- bZ00l)
local gui82 = math.max(pmIHpDvpplMp- Angle42, 0)* 0.35
local NwMqv = math.max(lv_NWuq_pDX0l- 1.3, 0)* 0.25
return gui81+ gui82+ NwMqv, gui81, lv_NWuq_pDX0l
end
function MainState.MqHuIln(qDWnbvupq, vlW1OHDx, MXMWUZn, MIlmOQHI)
if MXMWUZn<= 0 then
MXMWUZn = 142.5
end
if MIlmOQHI<= 0 then
MIlmOQHI = 196.2
end
local char36 = vlW1OHDx- qDWnbvupq
local inst155 = Vector3.new(char36.X, 0, char36.Z)
local Iopppl = inst155.Magnitudelocal inst156 = char36.Y
if char36.Magnitude<= 0.001 then
 return nil
end
if Iopppl<= 0.35 or MIlmOQHI<= 0.001 then
 return char36.Unit, math.clamp(char36.Magnitude/ MXMWUZn, 0.025, 5)
end
local char37 = inst155.Unitlocal char38 = math.atan2(inst156, Iopppl)
local char39 = math.max(- Angle28, char38- Angle18)
local val28 = Angle72
local QpwzDvQvX, IoXwDmzowvXbU, QxlObm0WO, bzlz1QD1DXvW = nil, math.huge, math.huge, nil
local val29 = 30 do
 local val30 = bit32.band(369, 0)
 local val31 = bit32.bor(val30, 571)- 571
end
for pzWN01unm = 0, val29 do
 local val32 = char39+(val28- char39)*(pzWN01unm/ val29)
 local Im1M_l11z0, ql_pn, lONQu = MainState.oIO1v(Iopppl, inst156, val32, MXMWUZn, MIlmOQHI)
 if Im1M_l11z0 and Im1M_l11z0< IoXwDmzowvXbU then
IoXwDmzowvXbU, QxlObm0WO, QpwzDvQvX, bzlz1QD1DXvW = Im1M_l11z0, ql_pn, val32, lONQu
 if QxlObm0WO< SmallOffset then
break
 end
end
end
if QpwzDvQvX then
 local HMNMN = (val28- char39)/ val29* 2.5
 local flag30 = (QxlObm0WO< SmallOffset) and 1 or 4
 for NwvmmmvvoWw = 1, flag30 do
 local pZumMoH0DzbUbD, _on_z, DxNXwp1xOOU, w_nUqDWxW = QpwzDvQvX, IoXwDmzowvXbU, QxlObm0WO, bzlz1QD1DXvW
 for pZzwNxD = -3, 3 do
 local inst157 = math.clamp(QpwzDvQvX+ HMNMN*(pZzwNxD/ 3), char39, val28)
 local pXxIUqDwzqU, Mu0xw1ul1vQ, wN1qup1xQ1U = MainState.oIO1v(Iopppl, inst156, inst157, MXMWUZn, MIlmOQHI)
 if pXxIUqDwzqU and pXxIUqDwzqU< _on_z then
_on_z, DxNXwp1xOOU, pZumMoH0DzbUbD, w_nUqDWxW = pXxIUqDwzqU, Mu0xw1ul1vQ, inst157, wN1qup1xQ1U
 end
end QpwzDvQvX, IoXwDmzowvXbU, QxlObm0WO, bzlz1QD1DXvW = pZumMoH0DzbUbD, _on_z, DxNXwp1xOOU, w_nUqDWxW
 if QxlObm0WO< SmallOffset then
break
 end
HMNMN = HMNMN* 0.38
 end
end
if not QpwzDvQvX then
 local val33 = math.clamp(Iopppl/ MXMWUZn, 0.025, 5)
 local val34 = vlW1OHDx+ Vector3.new(0, 0.5* MIlmOQHI* val33* val33, 0)
 local val35 = val34- qDWnbvupq
 if val35.Magnitude<= 0.001 then
 return nil
 end
return val35.Unit, val33
end
local flag31 = char37* math.cos(QpwzDvQvX)+ Vector3.new(0, math.sin(QpwzDvQvX), 0)
if flag31.Magnitude<= 0.001 then
 if(0> 1) then
 if(221< 497) then
 local char40 = 221+ 497
 end
end
 return nil
end
return flag31.Unit, bzlz1QD1DXvW
end
function MainState.vpDvmUq(q00HInHX0, _qZ0xw, NOwXIDzvXX, wDzZmp_p0m_oo)
if NOwXIDzvXX<= 0 or wDzZmp_p0m_oo<= 0 then
 return false
end
local vb0qllMol1, uvoumZnNuNXoI, v0NQ1wOumuHvw, _XoQIuUzz0NW = q00HInHX0, _qZ0xw, NOwXIDzvXX, wDzZmp_p0m_oo
local flag32 = (_XoQIuUzz0NW* vb0qllMol1* vb0qllMol1)/(2* v0NQ1wOumuHvw* v0NQ1wOumuHvw)
if flag32<= 0 then
 return false
end
local bumDuWQWQON, qxWb0NlMHXbmNv, NpoNDMMpwx = flag32,- vb0qllMol1, uvoumZnNuNXoI+ flag32
return(qxWb0NlMHXbmNv* qxWb0NlMHXbmNv- 4* bumDuWQWQON* NpoNDMMpwx)>= 0
end
function MainState.BQOObX(qnNUMI, BlzQl0, q_x_WUQUoO_v)
for WumzQw = 0.1, 3.0, 0.05 do
 local gui83 = 23
 if WumzQw< 1 then
gui83 = math.max(23, WumzQw* 150)
 elseif WumzQw< 2 then
gui83 = 142.5
 else gui83 = 165
end
if MainState.vpDvmUq(qnNUMI, BlzQl0, gui83, q_x_WUQUoO_v) then
 return WumzQw
end
end
return nil
end
do
MainState.vbbz0lv = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Killers"):WaitForChild("Veil"):WaitForChild("Spearthrow")
MainState.u0uHqHxm0DHI = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Mechanics"):WaitForChild("visualize")
MainState.u0uHqHxm0DHI.OnClientEvent:Connect(
 function(NQ1nvw, BXZl_, NWMIwUoHQOZo_W, NnubI0U0oOm)
 if NQ1nvw== LocalPlayer.Character then
 if type(NWMIwUoHQOZo_W)=="number" and NWMIwUoHQOZo_W> 0 then
ESPState.lastSpearSpeed = NWMIwUoHQOZo_W
 end
if type(NnubI0U0oOm)=="number" and NnubI0U0oOm>= 0 then
ESPState.lastGravityMult = NnubI0U0oOm
 end
end
end)
MainState.N_ulNqbOqbD0 = hookmetamethod(game,"__namecall",
function(...)
local gui84 = getnamecallmethod()
if gui84=="FireServer" then
 local gui85 = table.pack(...)
 local gui86 = gui85[1]
 if typeof(gui86)=="Instance" and rawequal(gui86, MainState.vbbz0lv) then
 if ESPState.silentSpearEnabledand typeof(ESPState.silentSpearLookVector)=="Vector3" then
 if gui85.n>= 4 and typeof(gui85[2])=="Vector3" and typeof(gui85[4])=="Vector3" then
gui85[2]= ESPState.silentSpearLookVector
 return MainState.N_ulNqbOqbD0(table.unpack(gui85, 1, gui85.n))
 end
end
 end
end
return MainState.N_ulNqbOqbD0(...)
end)
MainState.IOqIuMI = hookmetamethod(game,"__index",
function(bNwvpn_MwU, bqQDnmuN)
if bqQDnmuN=="FireServer" and typeof(bNwvpn_MwU)=="Instance" and rawequal(bNwvpn_MwU, MainState.vbbz0lv) then
 return newcclosure(
 function(...)
 local gui87 = table.pack(...)
 if ESPState.silentSpearEnabled and typeof(ESPState.silentSpearLookVector)=="Vector3" then
 if gui87.n>= 4 and typeof(gui87[2])=="Vector3" and typeof(gui87[4])=="Vector3" then
gui87[2]= ESPState.silentSpearLookVectorend
 end
return MainState.IOqIuMI(bNwvpn_MwU, bqQDnmuN)(table.unpack(gui87, 1, gui87.n))
 end)
end
return MainState.IOqIuMI(bNwvpn_MwU, bqQDnmuN)
end)
end
do
MainState.vnQWv = {}
 function MainState.WuuUo(lxQbWWOzw, qU_xzUvb0vx)
 local gui88 = lxQbWWOzw and lxQbWWOzw.Parentwhile gui88 do
 if gui88.Name== qU_xzUvb0vx then
 return true
 end
gui88 = gui88.Parent
 end
return false
end
function MainState.NluUIOonNHv(Hb_HNXDuwbN)
if not(Hb_HNXDuwbN and Hb_HNXDuwbN:IsA("GuiButton")) then
 return false
end
if Hb_HNXDuwbN.Name~="attack" and Hb_HNXDuwbN.Name~="Gui-mob" then
 return false
end
if not MainState.WuuUo(Hb_HNXDuwbN,"Slasher-mob") and not MainState.WuuUo(Hb_HNXDuwbN,"Survivor-mob") then
 return false
end
if not MainState.WuuUo(Hb_HNXDuwbN,"Control") and not MainState.WuuUo(Hb_HNXDuwbN,"Controls") then
 return false
end
return true
end
function MainState.uqXMUqx(WXmwQqQX)
if not MainState.NluUIOonNHv(WXmwQqQX) then
 return
end
if MainState.vnQWv[WXmwQqQX] then
 return
end
MainState.vnQWv[WXmwQqQX]= true WXmwQqQX.InputBegan:Connect(
function(wUbqNonzq)
local char41 = wUbqNonzq.UserInputTypeif char41~= Enum.UserInputType.Touchand char41~= Enum.UserInputType.MouseButton1 then
 return
end
local char42 = LocalPlayer.Character
if char42 and char42:GetAttribute("spearmode") then
ESPState.spearIsHolding = true;
ESPState.spearHoldStartTime = tick()
end
end)
WXmwQqQX.InputEnded:Connect(
function(MbWHWUbwwoI)
local inst158 = MbWHWUbwwoI.UserInputType
if inst158~= Enum.UserInputType.Touch and inst158~= Enum.UserInputType.MouseButton1 then
 return
end
ESPState.spearIsHolding = false;
ESPState.spearHoldStartTime = nil
end)
end
function MainState.olonnon()
local cam17 = LocalPlayer:FindFirstChildOfClass("PlayerGui") or PlayerGui
if not cam17 then
 return
end
pcall(
function()
for l0zz0Z, pMW1_OxbqD in ipairs(cam17.GetDescendants(cam17)) do
MainState.uqXMUqx(pMW1_OxbqD)
end
end)
cam17.DescendantAdded:Connect(
function(lIvIqWHNN)
MainState.uqXMUqx(lIvIqWHNN)
end)
end
UIS2.InputBegan:Connect(
function(pHxlmuU, w1zMwI)
if pHxlmuU.UserInputType== Enum.UserInputType.MouseButton1then
local inst159 = LocalPlayer.Characterif inst159 and inst159:GetAttribute("spearmode") then
ESPState.spearIsHolding = true;
ESPState.spearHoldStartTime = tick()
end
end
end)
UIS2.InputEnded:Connect(
function(oluzZHmXm0pzuM)
if oluzZHmXm0pzuM.UserInputType== Enum.UserInputType.MouseButton1then ESPState.spearIsHolding = false;
ESPState.spearHoldStartTime = nil
end
end)
MainState.olonnon()
end
CreateESPEntry("Spear_UpdateSnapLine", 0,
function(vvo_Wqm0mw)
local val36 = ESPState.SPEAR_SNAPLINEif not val36.enabledthen
if ESPState.SnapLineFramethen ESPState.SnapLineFrame.Visible = false
end
if ESPState.SnapLineDot then
ESPState.SnapLineDot.Visible = false
end
if ESPState.SnapLineTextLabelthen ESPState.SnapLineTextLabel.Visible = false
end
val36.locked = false;
val36.lockedTarget = nil;
val36.lockedPlayerName = ""
return
end
local char43 = Workspace.CurrentCameraif not char43 then
 if ESPState.SnapLineFramethen ESPState.SnapLineFrame.Visible = false
end
if ESPState.SnapLineDot then
ESPState.SnapLineDot.Visible = false
end
if ESPState.SnapLineTextLabel then
ESPState.SnapLineTextLabel.Visible = false
end
return
end
local gui89 = LocalPlayer.Characterlocal gui90 = gui89 and gui89:GetAttribute("spearmode")
if not gui90 then
 if ESPState.SnapLineFramethen ESPState.SnapLineFrame.Visible = false
end
if ESPState.SnapLineDotthen ESPState.SnapLineDot.Visible = false
end
if ESPState.SnapLineTextLabel then
ESPState.SnapLineTextLabel.Visible = false
end
return
end
local HvHvMlXv = char43.ViewportSizelocal val37 = Vector2.new(HvHvMlXv.X/ 2, HvHvMlXv.Y/ 2)
local val38 = gui89 and gui89:FindFirstChild("HumanoidRootPart")
local function func69()
local color19 = nil
local HIDN0 = math.hugelocal color20 = math.huge
for D_xMx, loxlI_o in ipairs(Players.GetPlayers(Players)) do
 if loxlI_o~= LocalPlayer and GetPlayerRole(loxlI_o)=="survivor" then
 local color21 = loxlI_o.Character
 if color21 then
 local color22 = color21:FindFirstChildOfClass("Humanoid")
 local color23 = MainState.ppmDZmUwpIop(color21)
 if color23 and color22 and color22.Health> 0 and color22.Health> 50 and not color21:GetAttribute("IsHooked") then
 local val39 = val38 and(color23- val38.Position).Magnitude or0
 if val39<= Settings.spearSnaplineMaxDistancethen
 local D0b1xbl, DxMZHvUNN = char43:WorldToViewportPoint(color23)
 if DxMZHvUNN then
 local v66 = (Vector2.new(D0b1xbl.X, D0b1xbl.Y)- val37).Magnitude
 if v66<= Settings.spearFovRadiusthen
 if v66< HIDN0 then
HIDN0 = v66;
color20 = val39;
color19 = loxlI_o
 end
end
 end
end
 end
end
end
end
return color19, HIDN0, color20
end
if ESPState.spearIsHoldingand not val36.lockedthen
local IWU1v1HbN1u1, NDuxlDnvw, QZqzuNnNI = func69()
if IWU1v1HbN1u1 then
val36.locked = true;
val36.lockedTarget = IWU1v1HbN1u1 val36.lockedPlayerName = IWU1v1HbN1u1.Name;
val36.currentNearestDist = QZqzuNnNI
end
end
if not ESPState.spearIsHolding then
val36.locked = false;
val36.lockedTarget = nil;
val36.lockedPlayerName = ""
end
local color24 = false
local color25 = nil
local color26 = 0
local color27 = nil
if val36.lockedand val36.lockedTarget then
 local color28 = val36.lockedTarget.Characterif color28 then
 local color29 = color28:FindFirstChildOfClass("Humanoid")
 local DxMnDox = MainState.ppmDZmUwpIop(color28)
 if DxMnDox and color29 and color29.Health> 50 and not color28:GetAttribute("IsHooked") then
 local Nq0xn, l0lOop1 = char43:WorldToViewportPoint(DxMnDox)
 if l0lOop1 then
 local color30 = (Vector2.new(Nq0xn.X, Nq0xn.Y)- val37).Magnitudeif color30<= Settings.spearFovRadius* 1.15 then
color25 = Vector2.new(Nq0xn.X, Nq0xn.Y)
color26 = val38 and(DxMnDox- val38.Position).Magnitudeor 0 color27 = DxMnDox;
color24 = true val36.currentNearestDist = color26
 end
end
 end
end
 if not color24 then
val36.locked = false;
val36.lockedTarget = nil;
val36.lockedPlayerName = ""
 end
end
local inst160 = nil
local gui91 = 0
local gui92 = nil
local gui93 = nil
if not val36.lockedthen
local DxlXb, IuMqN1DNOlp, p0mQINu = func69()
if DxlXb then
 local val40 = MainState.ppmDZmUwpIop(DxlXb.Character)
 local Hw0UQ, OuUuHnNN1o = char43:WorldToViewportPoint(val40)
inst160 = Vector2.new(Hw0UQ.X, Hw0UQ.Y)
gui91 = p0mQINu;
gui92 = val40 gui93 = DxlXb;
val36.currentNearestDist = p0mQINu
end
end
local val41 = false
if ESPState.spearIsHolding and ESPState.spearHoldStartTime and val38 then
 local val42 = color27 or(gui93 and MainState.ppmDZmUwpIop(gui93.Character))
 if val42 then
 local val43 = char43.CFrame.Position
 local v67 = val42- val43
 local v68 = Vector3.new(v67.X, 0, v67.Z)
 local v69 = v68.Magnitudelocal v70 = v67.Y
 local v71 = Workspace.Gravity*(ESPState.lastGravityMultor 1)
 local v72 = MainState.BQOObX(v69, v70, v71)
 if v72 then
 local HZI__U = tick()- ESPState.spearHoldStartTimeif HZI__U>= v72 then
val41 = true
 end
end
 end
end
local Qoxwm = nil
local v73 = ""
local v74 = 0
if val36.lockedand color24 then
Qoxwm = color25;
v73 = val36.lockedPlayerName v74 = color26
elseif inst160 then
Qoxwm = inst160;
v73 = gui93 and gui93.Nameor "" v74 = gui91
end
local v75 = pcall(
function()
if not ESPState.SnapLineFrame or not ESPState.SnapLineDotor not ESPState.SnapLineTextLabelor not char43 then
 if ESPState.SnapLineFramethen ESPState.SnapLineFrame.Visible = false
end
if ESPState.SnapLineDotthen ESPState.SnapLineDot.Visible = false
end
if ESPState.SnapLineTextLabelthen ESPState.SnapLineTextLabel.Visible = false
end
return
end
if not Qoxwm then
ESPState.SnapLineFrame.Visible = false;
ESPState.SnapLineDot.Visible = false ESPState.SnapLineTextLabel.Visible = false;
val36.currentNearestDist = math.hugereturn
end
local NWO1I = val37;
local v76 = Qoxwm
local v77 = v76- NWO1I;
local conn34 = v77.Magnitude
if conn34< 2 then
ESPState.SnapLineFrame.Visible = false;
ESPState.SnapLineDot.Visible = false ESPState.SnapLineTextLabel.Visible = false;
 return
end
local conn35 = val41
local conn36 = conn35 and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(255, 220, 0)
local char44 = conn35 and 0.08 or 0.35 ESPState.SnapLineFrame.BackgroundColor3 = conn36 ESPState.SnapLineFrame.BackgroundTransparency = char44 ESPState.SnapLineFrame.Size = UDim2.fromOffset(conn34, conn35 and2 or 1)
ESPState.SnapLineFrame.Position = UDim2.fromOffset((NWO1I.X+ v76.X)* 0.5,(NWO1I.Y+ v76.Y)* 0.5)
ESPState.SnapLineFrame.Rotation = math.deg(math.atan2(v77.Y, v77.X))
ESPState.SnapLineFrame.Visible = true ESPState.SnapLineDot.BackgroundColor3 = conn36 ESPState.SnapLineDot.Position = UDim2.fromOffset(v76.X, v76.Y)
ESPState.SnapLineDot.Visible = true
if Settings.spearSnaplineShowText and v73~="" then
ESPState.SnapLineTextLabel.Text = string.format("%s [%dm]", v73, math.floor(v74))
ESPState.SnapLineTextLabel.TextColor3 = conn36 ESPState.SnapLineTextLabel.Position = UDim2.fromOffset(v76.X, v76.Y- 14)
ESPState.SnapLineTextLabel.Visible = true
else ESPState.SnapLineTextLabel.Visible = false
end
end)
if not v75 then
 if ESPState.SnapLineFrame then
ESPState.SnapLineFrame.Visible = false
 end
if ESPState.SnapLineDot then
ESPState.SnapLineDot.Visible = false
 end
if ESPState.SnapLineTextLabelthen ESPState.SnapLineTextLabel.Visible = false
end
end
end) CreateESPEntry("Spear_UpdateSpearSystem", 0,
function()
if ESPState.SpearFOVCircle then
ESPState.SpearFOVCircle.Visible = ESPState.spearFovCircleEnabledlocal Tmp1 = Settings.spearFovRadius* 2
 if ESPState.SpearFOVCircle.Size.X.Offset~= Tmp1 then
ESPState.SpearFOVCircle.Size = UDim2.new(0, Tmp1, 0, Tmp1)
 end
end
if not ESPState.silentSpearEnabled then
ESPState.silentSpearTargetTorso = nil;
ESPState.silentSpearLookVector = nil
end
local flag33 = LocalPlayer.Character
local flag34 = flag33 and flag33:GetAttribute("spearmode")
if not ESPState.spearIndicatorEnabledor not flag34 then
 if ESPState.SpearIndicatorGui then
ESPState.SpearIndicatorGui.Enabled = false
 end
if not ESPState.silentSpearEnabled or not flag34 then
 return
 end
end
local DDW1X = flag33 and flag33:FindFirstChild("HumanoidRootPart")
if not DDW1X then
 return
end
local p1oov = workspace.CurrentCameraif not p1oov then
 return
end
if ESPState.spearIndicatorEnabledand flag34 and ESPState.SpearIndicatorGuithen ESPState.SpearIndicatorGui.Enabled = true
end
local upxqloop = nil
local v78 = math.huge
local v79 = math.hugelocal v80 = false
local v81 = Vector2.new(p1oov.ViewportSize.X/ 2, p1oov.ViewportSize.Y/ 2)
for lWIHb_1, H_HUX0oZmvoxI in ipairs(Players.GetPlayers(Players)) do
 if H_HUX0oZmvoxI~= LocalPlayer and GetPlayerRole(H_HUX0oZmvoxI)=="survivor" then
 local flag35 = H_HUX0oZmvoxI.Characterif flag35 then
 local flag36 = flag35:FindFirstChildOfClass("Humanoid")
 local flag37 = MainState.ppmDZmUwpIop(flag35)
 local flag38 = flag35:FindFirstChild("HumanoidRootPart")
 if flag36 and flag36.Health> 50 and typeof(flag37)=="Vector3" and flag38 and not flag35:GetAttribute("IsHooked") then
 local v82 = (flag37- DDW1X.Position).Magnitude
 local NuzNU, DxlO1 = p1oov:WorldToViewportPoint(flag37)
 if DxlO1 then
 local flag39 = (Vector2.new(NuzNU.X, NuzNU.Y)- v81).Magnitudeif flag39<= Settings.spearFovRadius then
 if flag39< v78 then
v78 = flag39;
v79 = v82 upxqloop = H_HUX0oZmvoxI;
v80 = true
 end
elseif not v80 and v82< v79 then
v79 = v82;
upxqloop = H_HUX0oZmvoxI
 end
elseif not v80 and v82< v79 then
v79 = v82;
upxqloop = H_HUX0oZmvoxI
 end
end
 end
end
end
if upxqloop and upxqloop.Character then
 local flag40 = MainState.ppmDZmUwpIop(upxqloop.Character)
 if flag40 then
v80 = MainState._vMo1mZ1l(p1oov, flag40, Settings.spearFovRadius)
 end
end
if ESPState.spearIndicatorEnabled and flag34 then
 if not upxqloop or not upxqloop.Characterthen ESPState.SpearStatusText.Text = "NO TARGET" ESPState.SpearStatusText.TextColor3 = Color3.fromRGB(200, 200, 200)
ESPState.SpearAccentBar.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
ESPState.SpearInfoText.Text = "Aim to Survivor";
 return
end
local gui94 = MainState.ppmDZmUwpIop(upxqloop.Character)
local gui95 = p1oov.CFrame.Position
local gui96 = gui94- gui95
local gui97 = Vector3.new(gui96.X, 0, gui96.Z)
local v83 = gui97.Magnitudelocal v84 = gui96.Ylocal cam18 = gui96.Magnitudelocal cam19 = Workspace.Gravity*(ESPState.lastGravityMultor 1)
local cam20 = MainState.BQOObX(v83, v84, cam19)
local cam21 = upxqloop.Name
local cam22 = string.format("%.0f", cam18)
if not cam20 then
ESPState.SpearStatusText.Text = "OUT OF RANGE" ESPState.SpearStatusText.TextColor3 = Color3.fromRGB(255, 80, 80)
ESPState.SpearAccentBar.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
ESPState.SpearInfoText.Text = string.format("%s | %s studs", cam21, cam22)
elseif not v80 then
ESPState.SpearStatusText.Text = "AIM AT TARGET" ESPState.SpearStatusText.TextColor3 = Color3.fromRGB(255, 150, 150)
ESPState.SpearAccentBar.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
 local lDvuvMnM, W0IlZNQMzHW_Iz = p1oov:WorldToViewportPoint(gui94)
 local cam23 = Vector2.new(p1oov.ViewportSize.X/ 2, p1oov.ViewportSize.Y/ 2)
 local flag41 = (Vector2.new(lDvuvMnM.X, lDvuvMnM.Y)- cam23).Magnitude
 local o100vmw = string.format("%.0f", flag41- Settings.spearFovRadius)
 if not W0IlZNQMzHW_Iz then
ESPState.SpearInfoText.Text = "Target di belakang kamera"
 else ESPState.SpearInfoText.Text = string.format("Masuk FOV: %s px lagi", o100vmw)
end
elseif not ESPState.spearIsHoldingthen ESPState.SpearStatusText.Text = "READY" ESPState.SpearStatusText.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPState.SpearAccentBar.BackgroundColor3 = Color3.fromRGB(150, 150, 200)
ESPState.SpearInfoText.Text = string.format("%s | %s studs | Hold: %ss", cam21, cam22, string.format("%.2f", cam20))
else
local v85 = tick()- ESPState.spearHoldStartTimelocal v86 = string.format("%.2f", v85)
local v87 = string.format("%.2f", cam20)
local v88 = MainState._vMo1mZ1l(p1oov, gui94, Settings.spearFovRadius)
if not v88 then
ESPState.SpearStatusText.Text = "AIM AT TARGET" ESPState.SpearStatusText.TextColor3 = Color3.fromRGB(255, 150, 150)
ESPState.SpearAccentBar.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
ESPState.SpearInfoText.Text = "Target keluar FOV!"
elseif v85>= cam20 then
ESPState.SpearStatusText.Text = "RELEASE!" ESPState.SpearStatusText.TextColor3 = Color3.fromRGB(80, 255, 120)
ESPState.SpearAccentBar.BackgroundColor3 = Color3.fromRGB(50, 255, 100)
ESPState.SpearInfoText.Text = string.format("Hold: %ss | Ideal: %ss", v86, v87)
else ESPState.SpearStatusText.Text = "HOLD..." ESPState.SpearStatusText.TextColor3 = Color3.fromRGB(255, 220, 100)
ESPState.SpearAccentBar.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
ESPState.SpearInfoText.Text = string.format("Hold: %ss | Ideal: %ss", v86, v87)
end
end
end
if ESPState.silentSpearEnabledand flag34 and upxqloop and upxqloop.Characterthen
local v89 = MainState.ppmDZmUwpIop(upxqloop.Character)
local v90 = upxqloop.Character:FindFirstChild("HumanoidRootPart")
if typeof(v89)=="Vector3" and v90 then
 local flag42 = MainState._vMo1mZ1l(p1oov, v89, Settings.spearFovRadius)
 if flag42 then
 local flag43 = p1oov.CFrame.Positionlocal flag44 = v89- flag43
 local flag45 = flag44.Magnitude
 if flag45> 0.1 then
 local v91 = 142.5
 if ESPState.spearIsHolding and ESPState.spearHoldStartTime then
 local flag46 = tick()- ESPState.spearHoldStartTime
 if flag46>= 2 then
v91 = 165
 elseif flag46>= 1 then
v91 = 142.5
 else v91 = math.max(23, flag46* 150)
 end
end
 local flag47 = Workspace.Gravity*(ESPState.lastGravityMultor 1)
 local flag48 = v90.AssemblyLinearVelocitylocal flag49 = Vector3.new(flag48.X, 0, flag48.Z)
 if flag49.Magnitude> 65 then
flag49 = flag49.Unit* 65
 end
ESPState.silentSpearTargetVel = flag49
 local MQlIpoO_oz0n, QnwzNlvHWXuwb0 = MainState.MqHuIln(flag43, v89, v91, flag47)
 if MQlIpoO_oz0n and QnwzNlvHWXuwb0 then
 local v92 = ESPState.silentSpearTargetVel* QnwzNlvHWXuwb0
 local v93 = v89+ v92
 local DHOQnwwuovnHxW, QOvzmllUM = MainState.MqHuIln(flag43, v93, v91, flag47)
 if DHOQnwwuovnHxW then
ESPState.silentSpearTargetTorso = v93;
ESPState.silentSpearLookVector = DHOQnwwuovnHxW
 else ESPState.silentSpearTargetTorso = nil;
ESPState.silentSpearLookVector = nil
 end
else ESPState.silentSpearTargetTorso = nil;
ESPState.silentSpearLookVector = nil
end
else ESPState.silentSpearTargetTorso = nil;
ESPState.silentSpearLookVector = nil
end
else ESPState.silentSpearTargetTorso = nil;
ESPState.silentSpearLookVector = nil
end
else ESPState.silentSpearTargetTorso = nil;
ESPState.silentSpearLookVector = nil
end
else ESPState.silentSpearTargetTorso = nil;
ESPState.silentSpearLookVector = nil
end
end)
end
do
 function MainState.bX_UINwW0NZ(HoHxxlzq, INxbwvxx_DNUw)
 if HoHxxlzq== LocalPlayer then
 return
 end
if not INxbwvxx_DNUw or not INxbwvxx_DNUw.Parentor HoHxxlzq.Character~= INxbwvxx_DNUw then
 return
 end
func5(HoHxxlzq, INxbwvxx_DNUw) Oqpmb(HoHxxlzq, INxbwvxx_DNUw)
 if Settings.hitboxEnabled then
task.wait(0.3)
 if HoHxxlzq.Character== INxbwvxx_DNUw and INxbwvxx_DNUw.Parent then
func32(HoHxxlzq, INxbwvxx_DNUw)
 end
end
 if Settings.hitboxEspEnabledthen func36(HoHxxlzq, INxbwvxx_DNUw)
end
if ESPState.autoParryEnabledor(AP_State and AP_State.Enabled) then
 if AP_HookKiller then
AP_HookKiller(HoHxxlzq, INxbwvxx_DNUw)
 end
end
end
function MainState.NuMzNx(HpwX0vQxDo1Wpo)
if HpwX0vQxDo1Wpo== LocalPlayer then
 return
end
IsPlayerAlive(HpwX0vQxDo1Wpo) func8(HpwX0vQxDo1Wpo) wxouub(HpwX0vQxDo1Wpo) HpwX0vQxDo1Wpo:GetPropertyChangedSignal("Team"):Connect(
function() IsPlayerAlive(HpwX0vQxDo1Wpo)
task.wait(0.2)
if ESPState.autoParryEnabled or(AP_State and AP_State.Enabled) then
 if AP_HookKiller then
AP_HookKiller(HpwX0vQxDo1Wpo)
 end
end
end)
if HpwX0vQxDo1Wpo.Characterthen task.spawn(
function()
MainState.bX_UINwW0NZ(HpwX0vQxDo1Wpo, HpwX0vQxDo1Wpo.Character)
end)
end
HpwX0vQxDo1Wpo.CharacterAdded:Connect(
function(MwZx_mq)
task.spawn(
function()
MainState.bX_UINwW0NZ(HpwX0vQxDo1Wpo, MwZx_mq)
end)
end)
end
function MainState.MnZvvMbQvnOzu(IuXvZp) func6(IuXvZp) func37(IuXvZp)
if IuXvZp.Character then
func33(IuXvZp, IuXvZp.Character)
end
end Players.PlayerAdded:Connect(MainState.NuMzNx)
Players.PlayerRemoving:Connect(MainState.MnZvvMbQvnOzu)
for w0zmvpUIn, MND0WOn in ipairs(Players.GetPlayers(Players)) do
 if MND0WOn~= LocalPlayer then
MainState.NuMzNx(MND0WOn)
 end
end
function MainState.pzZMm(ODOwMO)
ESPState.HoldLockActive = false;
ESPState.godLastHP = nil ESPState.CV_HoldingPC = false;
ESPState.CV_HoldingMobile = false ResetCameraVeil()
if ESPState.CV_Enabled then
task.defer(TempFlag)
end
task.spawn(func48, ODOwMO)
if ESPState.godEnabledthen task.wait(0.3);
func55();
func54()
end
if Settings.lockFovEnabledthen task.wait(0.1);
ESPState.originalFOV = nil;
MainState.BWQoHbUwlp0MZb(Settings.customFovValue)
end
if Settings.cameraZoomEnabledthen task.wait(0.1);
ESPState.originalMaxZoom = nil;
MainState.w_vnXUZ(Settings.cameraZoomValue)
end
end
if LocalPlayer.Character then
task.spawn(MainState.pzZMm, LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(
function(Nb_bQvlImbwUW)
task.spawn(MainState.pzZMm, Nb_bQvlImbwUW)
end)
RunService.Heartbeat:Connect(
function(QpQDqWu)
for IXmHQmXHHqno = 1,#ESPEntries do
 local v94 = ESPEntries[IXmHQmXHHqno] v94.timer = v94.timer+ QpQDqWu
 if v94.timer>= v94.intervalthen v94.timer = 0 v94.fn(QpQDqWu)
end
end
end)
MainState.p0WOU0IM = UILib:Window({ Title = "BOLONG-HUB", Image = "84034353458936", Footer = "Violence District", Author = "Discord.gg/pWpgqVGxNK", Color = NotifyColor, Version = 1, Search = true,})
MainState.WXDOInoUOHpw = MainState.p0WOU0IM.AddTab(MainState.p0WOU0IM,{ Name = "Exclusive", Icon = "sparkles"})
MainState.uXo1oQQNM = MainState.p0WOU0IM.AddTab(MainState.p0WOU0IM,{ Name = "Killer", Icon = "swords"})
MainState.DO_nopuz = MainState.p0WOU0IM.AddTab(MainState.p0WOU0IM,{ Name = "Survivor", Icon = "user"})
MainState._Q_UQwvznNuxzH = MainState.p0WOU0IM.AddTab(MainState.p0WOU0IM,{ Name = "Visual", Icon = "eye"})
MainState.p0N1pxWHmq = MainState.p0WOU0IM.AddTab(MainState.p0WOU0IM,{ Name = "Misc", Icon = "settings"})
MainState.ODQQmq = MainState.p0WOU0IM.AddTab(MainState.p0WOU0IM,{ Name = "Config", Icon = "save"}) do
MainState.Mqqznm = MainState.WXDOInoUOHpw.AddSection(MainState.WXDOInoUOHpw,"Auto Parry", nil)
MainState.Opoxb = MainState.Mqqznm.AddHStack(MainState.Mqqznm)
MainState.Opoxb:AddToggle({ Title = "Auto Parry", Default = false, Callback = function(OqoZW)
ESPState.autoParryEnabled = OqoZW
end,})
MainState.Opoxb:AddToggle({ Title = "Radius ESP", Default = false, Callback = function(BW1HZvUHupMn)
ESPState.autoParryRadiusEsp = BW1HZvUHupMn
if MainState.onDxz1o then
MainState.onDxz1o(BW1HZvUHupMn)
end
end,})
MainState.Mqqznm:AddSlider({ Title = "Parry Radius (Stud)", Min = 4, Max = 40, Default = 11, Increment = 1, Callback = function(_ZNz0W_1)
ESPState.autoParryRadius = _ZNz0W_1
end,})
MainState.BlDnnQHIqXvO = MainState.WXDOInoUOHpw.AddSection(MainState.WXDOInoUOHpw,"God Mode", nil)
MainState.BlDnnQHIqXvO:AddParagraph({ Title = "God Mode", Content = "Instant Heal + Anti Knock/Down.\nSangat Cocok Jika Digunakan Untuk Main Pistol-pistolan."})
MainState.BlDnnQHIqXvO:AddToggle({ Title = "Enable God Mode", Default = false, Callback = function(MoInqnm1_W)
if MoInqnm1_W then
func54()
else func55()
end
end,})
MainState.uWO1p1noQnlWm = MainState.WXDOInoUOHpw.AddSection(MainState.WXDOInoUOHpw,"Aim Lock (Legit)", nil)
MainState.uWO1p1noQnlWm:AddToggle({ Title = "Enable Aim Lock", Default = false, Callback = function(pwHM_pI_mU0)
Settings.cameralockEnabled = pwHM_pI_mU0
if pwHM_pI_mU0 then
MainState.vMvvZ()
else MainState.Hq1wbQvMzoz()
end
end,})
MainState.uWO1p1noQnlWm:AddDropdown({ Title = "Target Type", Options = {"Survivor","Killer"}, Default = "Survivor", Callback = function(uUxQl)
Settings.cameralockTargetType = uUxQl
end,})
MainState.uWO1p1noQnlWm:AddDropdown({ Title = "Aim Part", Options = {"Torso","Head"}, Default = "Torso", Callback = function(v0lz_olwppOvMO)
Settings.cameralockAimPart = v0lz_olwppOvMO
end,})
MainState.uWO1p1noQnlWm:AddDropdown({ Title = "Lock Mode", Content = "Recommended Use: Hold to Lock (PC: Right Click / Mobile: Slasher Attack Button)", Options = {"Always Lock","Hold to Lock"}, Default = "Always Lock", Callback = function(uunXv)
Settings.cameralockLockMode = uunXv
end,})
MainState.uWO1p1noQnlWm:AddSlider({ Title = "Max Distance", Content = "Maximum distance to lock target (studs)", Min = 20, Max = 700, Default = Settings.cameralockMaxDistance, Increment = 5, Callback = function(bMHXx_M0O_)
Settings.cameralockMaxDistance = bMHXx_M0O_
end,})
MainState.uWO1p1noQnlWm:AddSlider({ Title = "Camera Smoothness", Min = 0.01, Max = 1, Default = Settings.cameralockSmoothness, Increment = 0.01, Callback = function(BmuH1ZbqWb_vw)
Settings.cameralockSmoothness = BmuH1ZbqWb_vw
end,})
MainState.uvmnv = MainState.WXDOInoUOHpw.AddSection(MainState.WXDOInoUOHpw,"Camera Veil (Legit)", nil)
MainState.uvmnv:AddToggle({ Title = "Camera Veil", Default = false, Callback = function(omUvvM)
Settings.cameraVeilEnabled = omUvvM
local gen22 = pcall(
function()
if omUvvM then
GuiHolder()
else AntiAFKConn2()
end
end)
if not gen22 then
Settings.cameraVeilEnabled = false ShowNotify("Camera Veil","Gagal mengaktifkan Camera Veil", 2)
end
end,})
MainState.uvmnv:AddToggle({ Title = "SnapLine ESP", Default = false, Callback = function(OUXwqZ)
Settings.cameraVeilSnapLine = OUXwqZ
if not OUXwqZ then
 if ESPState.CV_SnapLine then
ESPState.CV_SnapLine.Visible = false
 end
if ESPState.CV_SnapDot then
ESPState.CV_SnapDot.Visible = false
 end
end
end,})
MainState.WoM_lmuoD_0o = MainState.WXDOInoUOHpw.AddSection(MainState.WXDOInoUOHpw,"Crosshair", nil)
MainState.WoM_lmuoD_0o:AddToggle({ Title = "Enable Crosshair", Default = false, Callback = function(wHpbvZXX)
MainState.Iw0_ov:SetEnabled(wHpbvZXX)
end,})
MainState.WoM_lmuoD_0o:AddDropdown({ Title = "Style / Model", Options = CROSSHAIR_STYLES, Default = "Dot", Callback = function(NDHwuN)
MainState.Iw0_ov:SetStyle(NDHwuN)
end,})
MainState.WoM_lmuoD_0o:AddSlider({ Title = "Size", Min = 1, Max = 100, Default = 20, Increment = 1, Callback = function(pz1moxHIvW)
MainState.Iw0_ov:SetSize(pz1moxHIvW)
end,})
MainState.WoM_lmuoD_0o:AddSlider({ Title = "Opacity", Min = 0, Max = 100, Default = 100, Increment = 1, Callback = function(QpW0MuX)
MainState.Iw0_ov:SetOpacity(QpW0MuX/ 100)
end,})
MainState.WoM_lmuoD_0o:AddInput({ Title = "Position X (px)", Default = "0", Placeholder = "Offset from center (positive = right)", Callback = function(lOMxw)
local char45 = tonumber(lOMxw)
if char45 then
MainState.Iw0_ov.SetOffsetX(MainState.Iw0_ov, math.clamp(char45,- 1000, 1000))
end
end,})
MainState.WoM_lmuoD_0o:AddInput({ Title = "Position Y (px)", Default = "0", Placeholder = "Offset from center (positive = down)", Callback = function(QDmx0zDW1)
local flag50 = tonumber(QDmx0zDW1)
if flag50 then
MainState.Iw0_ov.SetOffsetY(MainState.Iw0_ov, math.clamp(flag50,- 1000, 1000))
end
end,})
MainState.WoM_lmuoD_0o:AddColorPicker({ Title = "Crosshair Color", Default = Color3.fromRGB(255, 255, 255), Callback = function(WW0XZ)
MainState.Iw0_ov:SetColor(WW0XZ)
end,})
MainState.bI0nxwpvnN = MainState.WXDOInoUOHpw.AddSection(MainState.WXDOInoUOHpw,"Silent Spear (Veil)", nil)
MainState.bI0nxwpvnN:AddParagraph({ Title = "Aim Guide", Content = "[ID] Saat Indikator/Snapline berubah hijau atau menampilkan \"RELEASE\", itu adalah waktu paling akurat untuk melepaskan SPEAR (90% kena target jika target diam).\n\n[EN] When the Indicator/Snapline turns green or shows \"RELEASE\", it is the most accurate time to release the SPEAR (90% hit chance if the target is stationary)."})
MainState.bI0nxwpvnN:AddToggle({ Title = "Silent Spear", Default = false, Callback = function(WoDXOquvmOOw1)
ESPState.silentSpearEnabled = WoDXOquvmOOw1
end,})
MainState.OplOpzllnHuMnb = MainState.bI0nxwpvnN.AddHStack(MainState.bI0nxwpvnN)
MainState.oZwUx1zxp1v = MainState.bI0nxwpvnN.AddHStack(MainState.bI0nxwpvnN)
MainState.OplOpzllnHuMnb:AddToggle({ Title = "FOV Circle", Default = false, Callback = function(bqMu0bzmz0Qvop)
ESPState.spearFovCircleEnabled = bqMu0bzmz0Qvop
end,})
MainState.OplOpzllnHuMnb:AddToggle({ Title = "Aim Indicator", Default = false, Callback = function(QDDXHQQlX)
ESPState.spearIndicatorEnabled = QDDXHQQlX
end,})
MainState.oZwUx1zxp1v:AddToggle({ Title = "SnapLine", Default = false, Callback = function(Buxumn)
ESPState.SPEAR_SNAPLINE.enabled = Buxumn
end,})
MainState.oZwUx1zxp1v:AddToggle({ Title = "Show Name/Studs", Default = true, Callback = function(pXznlnqoZNW)
Settings.spearSnaplineShowText = pXznlnqoZNW
end,})
MainState.bI0nxwpvnN:AddSlider({ Title = "Spear FOV Radius", Min = 30, Max = 500, Default = 150, Step = 5, Callback = function(uXOuxINNU)
Settings.spearFovRadius = uXOuxINNU
end,})
MainState.OpxnOIHWnOImW = MainState.WXDOInoUOHpw.AddSection(MainState.WXDOInoUOHpw,"Silent Aim (Twist of Fate)", nil)
MainState.OpxnOIHWnOImW:AddToggle({ Title = "Silent Aim", Default = false, Callback = function(bwImUDQXoqz01w)
ESPState.silentAimEnabled = bwImUDQXoqz01w
end,})
MainState.unnpoH = MainState.OpxnOIHWnOImW.AddHStack(MainState.OpxnOIHWnOImW)
MainState.unnpoH:AddToggle({ Title = "FOV Circle", Default = false, Callback = function(lqmxbQ_mv)
ESPState.silentAimFovVisible = lqmxbQ_mv
end,})
MainState.unnpoH:AddToggle({ Title = "Laser ESP", Default = false, Callback = function(q1NnQUpX)
ESPState.laserEspEnabled = q1NnQUpX
end,})
MainState.OpxnOIHWnOImW:AddSlider({ Title = "Aim FOV Radius", Min = 30, Max = 500, Default = 150, Step = 5, Callback = function(_nIUNWm)
Settings.silentAimFovRadius = _nIUNWm
end,})
end
do
MainState.vx1OlOw = MainState.uXo1oQQNM.AddSection(MainState.uXo1oQQNM,"Hitbox Modifier", nil)
MainState.vx1OlOw:AddToggle({ Title = "Enable Hitbox Modifier", Default = false, Callback = function(Ozq0nXOI)
Settings.hitboxEnabled = Ozq0nXOI
 if Ozq0nXOI then
func34()
 else func35()
end
end,})
MainState.blXvQx = MainState.vx1OlOw.AddSlider(MainState.vx1OlOw,{ Title = "Survivor Hitbox Size (%)", Content = "Ukuran hitbox Survivor (100% = normal)", Min = 100, Max = 700, Default = 100, Increment = 5, Callback = function(OXZQzq1l_HxWQ)
Settings.survivorHitboxSize = OXZQzq1l_HxWQ
if Settings.hitboxEnabledthen func34()
end
end,})
MainState.BpZnQ1wbw1Nz = MainState.vx1OlOw.AddSlider(MainState.vx1OlOw,{ Title = "Killer Hitbox Size (%)", Content = "Ukuran hitbox Killer (100% = normal)", Min = 100, Max = 700, Default = 100, Increment = 5, Callback = function(WXZmZ_uIl)
Settings.killerHitboxSize = WXZmZ_uIl
if Settings.hitboxEnabled then
func34()
end
end,})
MainState._HxmI = MainState.vx1OlOw.AddHStack(MainState.vx1OlOw)
MainState._HxmI:AddButton({ Title = "Default", Callback = function()
MainState.blXvQx:Set(100);
MainState.BpZnQ1wbw1Nz.Set(MainState.BpZnQ1wbw1Nz, 100)
if Settings.hitboxEnabledthen func34()
end
ShowNotify("Hitbox Preset","Reset ke Default (100%)", 1.5)
end,})
MainState._HxmI:AddButton({ Title = "Big (200%)", Callback = function()
MainState.blXvQx:Set(200);
MainState.BpZnQ1wbw1Nz.Set(MainState.BpZnQ1wbw1Nz, 200)
if Settings.hitboxEnabled then
func34()
end
ShowNotify("Hitbox Preset","Big Hitbox aktif (200%)", 1.5)
end,})
MainState.vx1OlOw:AddToggle({ Title = "Enable Hitbox ESP", Default = false, Callback = function(_uuXp)
Settings.hitboxEspEnabled = _uuXp
if _uuXp then
func39()
else func40()
end
end,})
MainState.vx1OlOw:AddSlider({ Title = "Fill Transparency", Min = 0, Max = 100, Default = 50, Increment = 5, Callback = function(QNOon)
Settings.hitboxEspTransparency = QNOon/ 100
if not Settings.hitboxEspOutlineOnly then
func38()
end
end,})
MainState.MqpZOwDQ1nZ = MainState.vx1OlOw.AddHStack(MainState.vx1OlOw)
MainState.MqpZOwDQ1nZ:AddColorPicker({ Title = "Hitbox Survivor Color", Default = Settings.hitboxEspSurvivorColor, Callback = function(_IwDIQxXQ)
Settings.hitboxEspSurvivorColor = _IwDIQxXQ;
func38()
end,})
MainState.MqpZOwDQ1nZ:AddColorPicker({ Title = "HitBox Killer Color", Default = Settings.hitboxEspKillerColor, Callback = function(bIXDDvxZb1)
Settings.hitboxEspKillerColor = bIXDDvxZb1;
func38()
end,})
MainState.qIWWoZNx1v_b = MainState.uXo1oQQNM.AddSection(MainState.uXo1oQQNM,"Killer No Cooldown", nil)
MainState.qIWWoZNx1v_b:AddToggle({ Title = "Enable No Cooldown Bypass", Content = "Hidden, Abysswalker, Masked, More", Default = false, Callback = function(uXDomMOO_OOo)
AntiAFKActive = uXDomMOO_OOo
if uXDomMOO_OOo then
RemoveESPEntry()
else ClearAllESP()
end
end})
MainState.BN1nvpWmHb = MainState.qIWWoZNx1v_b.AddHStack(MainState.qIWWoZNx1v_b)
MainState.BN1nvpWmHb:AddButton({ Title = "Fire Corrupt (Abyss)", Callback = function() pcall(
function()
local gen23 = game:GetService("ReplicatedStorage").Remotes.Killers.Abysswalker.corruptlxunQ:FireServer()
end)
end})
MainState.BN1nvpWmHb:AddButton({ Title = "Fire Slash (Abyss)", Callback = function() pcall(
function()
local inst161 = game:GetService("ReplicatedStorage").Remotes.Attacks.BasicAttackBWmqXX:FireServer(true)
end)
end})
MainState._MxlZloZbMNlX = MainState.qIWWoZNx1v_b.AddHStack(MainState.qIWWoZNx1v_b)
MainState._MxlZloZbMNlX:AddButton({ Title = "Fire Leap (Hidden)", Callback = function() pcall(
function()
local gen24 = game:GetService("ReplicatedStorage").Remotes.Killers.Hidden.LeapN0pxXlzxOQ:FireServer(true)
end)
end})
MainState._MxlZloZbMNlX:AddButton({ Title = "Fire M2 (Hidden)", Callback = function() pcall(
function()
local gen25 = game:GetService("ReplicatedStorage").Remotes.Killers.Hidden.M2 gen25:FireServer({}, false)
end)
end})
MainState.OupN1u_wmZpzn = MainState.uXo1oQQNM.AddSection(MainState.uXo1oQQNM,"Masked Skill Spammer", nil)
MainState.Wqm1UMUv = "Cobra" MainState.OupN1u_wmZpzn.AddDropdown(MainState.OupN1u_wmZpzn,{ Title = "Select Mask Power", Options = {"Alex","Brandon","Cobra","Rabbit","Richter","Tony"}, Default = "Cobra", Callback = function(N_ZDWopxpxoUH)
MainState.Wqm1UMUv = N_ZDWopxpxoUH
end})
MainState.DnpuM = MainState.OupN1u_wmZpzn.AddHStack(MainState.OupN1u_wmZpzn)
MainState.DnpuM:AddButton({ Title = "Activate Power", Callback = function() pcall(
function()
local v95 = game:GetService("ReplicatedStorage").Remotes.Killers.Masked.ActivatepowerQpuXmbb0wH:FireServer(MainState.Wqm1UMUv)
end) ShowNotify("Masked","Power Activated: "..MainState.Wqm1UMUv, 1.5)
end})
MainState.DnpuM:AddButton({ Title = "Deactivate Power", Callback = function() pcall(
function()
local gen26 = game:GetService("ReplicatedStorage").Remotes.Killers.Masked.Deactivatepower gen26:FireServer()
end) ShowNotify("Masked","Power Deactivated", 1.5)
end})
MainState.HoZvH = MainState.uXo1oQQNM.AddSection(MainState.uXo1oQQNM,"Anti Blind", nil)
MainState.HoZvH:AddToggle({ Title = "Anti Flashlight Blind", Content = "Mencegah kamu terkena efek buta (Blinded) dari senter Survivor", Default = false, Callback = function(vZpupHuOXNMx)
Settings.antiBlindEnabled = vZpupHuOXNMx
end,})
MainState.oz_H1NbwmH_wM = MainState.uXo1oQQNM.AddSection(MainState.uXo1oQQNM,"Anti Looping", nil)
MainState.oz_H1NbwmH_wM:AddToggle({ Title = "Anti Loop Window", Content = "Membuat semua window di map tidak bisa digunakan untuk looping", Default = false, Callback = function(uQqmnvUqoID)
ESPState.antiLoopWindowEnabled = uQqmnvUqoID
if uQqmnvUqoID then
func28()
else func29()
end
end})
MainState.oz_H1NbwmH_wM:AddButton({ Title = "Auto Drop All Pallets", Callback = function() func30()
end})
end
do
MainState.w_IX1 = MainState.DO_nopuz.AddSection(MainState.DO_nopuz,"Auto Generator", nil)
MainState.w_IX1:AddToggle({ Title = "Auto Generator", Default = Settings.autoGenerator, Callback = function(OWllluOD)
Settings.autoGenerator = OWllluOD
end,})
MainState.w_IX1:AddDropdown({ Title = "Mode", Content = "Normal = safe zone | Perfect = zona Perfect | Instant = 😈 | Random = Succes/Neutral", Options = {"Instant","Perfect","Normal","Random"}, Default = Settings.autoGeneratorMode, Callback = function(v_Z_QZlWnxZmU)
Settings.autoGeneratorMode = v_Z_QZlWnxZmU
end,})
MainState.lzoOZm = MainState.DO_nopuz.AddSection(MainState.DO_nopuz,"Anti Fall Slow", nil)
MainState.lzoOZm:AddToggle({ Title = "Anti Fall Slow", Content = "Mencegah karakter melambat saat mendarat / jatuh dari ketinggian berapa pun", Default = false, Callback = function(Wxz1Zw1Mp)
ESPState.AntiFallSlow = Wxz1Zw1Mp
local v96 = LocalPlayer.Characterlocal wuvbv1 = v96 and v96:FindFirstChildOfClass("Humanoid")
if Wxz1Zw1Mp then
func44(wuvbv1)
else func45(wuvbv1)
end
end,})
MainState._pnvvou0uvl1Mz = MainState.DO_nopuz.AddSection(MainState.DO_nopuz,"Movement Modification", nil)
MainState._pnvvou0uvl1Mz:AddToggle({ Title = "No Slowdown", Default = false, Callback = function(qwwomlzo_zu)
ESPState.NoSlowdown = qwwomlzo_zu
local flag51 = LocalPlayer.Character
local flag52 = flag51 and flag51:FindFirstChildOfClass("Humanoid")
if qwwomlzo_zu then
func46(flag52)
else _StopNoSlowdown()
end
end,})
MainState._pnvvou0uvl1Mz:AddToggle({ Title = "Speed Boost", Default = false, Callback = function(HX1mDmbDQ)
ESPState.SpeedBoostInit = HX1mDmbDQ
if not HX1mDmbDQ then
 local flag53 = LocalPlayer.Characterlocal flag54 = flag53 and flag53:FindFirstChildOfClass("Humanoid")
 if flag54 then
func42(flag54, MagicConst)
 end
else
local flag55 = LocalPlayer.Characterlocal flag56 = flag55 and flag55:FindFirstChildOfClass("Humanoid")
if not ESPState.safeModeSpeedor(flag56 and flag56.Health> 50 and not(flag55:GetAttribute("IsHooked") or flag55:GetAttribute("IsCarried"))) then
func42(flag56, func41())
end
end
end,})
MainState._pnvvou0uvl1Mz:AddToggle({ Title = "Safe Mode (Speed)", Content = "Speed Boost & No Slowdown otomatis nonaktif saat Knockdown, Hook, dll.", Default = true, Callback = function(_1HHmI0ooN)
ESPState.safeModeSpeed = _1HHmI0ooN
end,})
MainState._pnvvou0uvl1Mz:AddSlider({ Title = "Boost Amount (%)", Min = 0, Max = 100, Default = 50, Callback = function(qpbQoMuNNlw1w)
ESPState.BoostPercent = qpbQoMuNNlw1w
end,})
MainState.DzNvHWmzIxDmmu = MainState.DO_nopuz.AddSection(MainState.DO_nopuz,"Auto Crouch (Abyss)", nil)
MainState.DzNvHWmzIxDmmu:AddToggle({ Title = "Auto Crouch", Default = false, Callback = function(_npU_pDIxzxuHU)
Settings.autoCrouchEnabled = _npU_pDIxzxuHU
if not _npU_pDIxzxuHU then
MainState.uuMqxOzluob(false)
end
end})
MainState.DzNvHWmzIxDmmu:AddSlider({ Title = "Crouch Radius (Stud)", Min = 4, Max = 40, Default = 18, Increment = 1, Callback = function(O0zwIbuImDZZu)
Settings.autoCrouchRadius = O0zwIbuImDZZu
end,})
MainState.vlIOU10MzvW = MainState.DO_nopuz.AddSection(MainState.DO_nopuz,"Auto Drop Nearby Pallet", nil)
MainState.vlIOU10MzvW:AddToggle({ Title = "Auto Drop Nearby Pallet", Default = false, Callback = function(BQWOMlDOM1Il)
ESPState.autoDropNearbyPallets = BQWOMlDOM1Il
if BQWOMlDOM1Il then
ESPState.palletPointsCache = nil
end
end})
MainState.Ox_OoNDZDOUplX = MainState.DO_nopuz.AddSection(MainState.DO_nopuz,"Moonwalk", nil)
MainState.Ox_OoNDZDOUplX:AddToggle({ Title = "Enable Moonwalk (Mobile GUI)", Default = false, Callback = function(WOlQub0IInIp0)
Settings.moonwalkEnabled = WOlQub0IInIp0
if WOlQub0IInIp0 then
func49()
 if ESPState.moonwalkGuithen ESPState.moonwalkGui.Enabled = true
end
else
if ESPState.moonwalkGuithen ESPState.moonwalkGui.Enabled = false
end
ESPState.moonwalkMobileDir = 0 HM1uHIZZl0.moonwalkPCForward = false ESPState.moonwalkPCBackward = false
end
end})
MainState.Ox_OoNDZDOUplX:AddKeybind({ Title = "PC Lock Forward Key", Default = Enum.KeyCode.Unknown, Callback = function()
if Settings.moonwalkEnabled then
ESPState.moonwalkPCForward = not ESPState.moonwalkPCForward
 if ESPState.moonwalkPCForwardthen ESPState.moonwalkPCBackward = false
end
end
end})
MainState.Ox_OoNDZDOUplX:AddKeybind({ Title = "PC Lock Backward Key", Default = Enum.KeyCode.Unknown, Callback = function()
if Settings.moonwalkEnabled then
ESPState.moonwalkPCBackward = not ESPState.moonwalkPCBackwardif ESPState.moonwalkPCBackward then
ESPState.moonwalkPCForward = false
 end
end
end})
MainState.WZpWIzxOMuD = MainState.DO_nopuz.AddSection(MainState.DO_nopuz,"Escape Gate", nil)
MainState.WZpWIzxOMuD:AddButton({ Title = "Auto Escape (Teleport)", Callback = function()
MainState._XDNw()
end})
MainState.WZpWIzxOMuD:AddToggle({ Title = "Ghost Gate (Legit Mode)", Default = false, Callback = function(ImZMoux)
ESPState.ghostGateEnabled = ImZMoux MainState.lHZlWupp()
end})
MainState.OmlqwO0Z = MainState.DO_nopuz.AddSection(MainState.DO_nopuz,"Lock FOV", nil)
MainState.OmlqwO0Z:AddToggle({ Title = "Lock FOV", Default = Settings.lockFovEnabled, Callback = function(pzQXnNU0_lH)
Settings.lockFovEnabled = pzQXnNU0_lH
if pzQXnNU0_lH then
MainState.BWQoHbUwlp0MZb(Settings.customFovValue)
else MainState.bxOlDXWlooNM()
end
end,})
MainState.OmlqwO0Z:AddSlider({ Title = "FOV Value", Min = 30, Max = 120, Default = Settings.customFovValue, Increment = 1, Callback = function(qHwMWp0vwvp)
Settings.customFovValue = qHwMWp0vwvp
if Settings.lockFovEnabledthen MainState.BWQoHbUwlp0MZb(qHwMWp0vwvp)
end
end,})
end
do
MainState.NvOXM = MainState._Q_UQwvznNuxzH.AddSection(MainState._Q_UQwvznNuxzH,"Killer ESP", nil)
MainState.pwQOzxOmU00Oq = MainState.NvOXM.AddHStack(MainState.NvOXM)
MainState.pwQOzxOmU00Oq:AddToggle({ Title = "Show Name", Default = Settings.killerShowName, Callback = function(vqubnXmvXI)
Settings.killerShowName = vqubnXmvXI;
func4()
end,})
MainState.pwQOzxOmU00Oq:AddToggle({ Title = "Show Outline", Default = Settings.killerShowOutline, Callback = function(HWXWbMQo)
Settings.killerShowOutline = HWXWbMQo;
func4()
end,})
MainState.NvOXM:AddColorPicker({ Title = "Killer Color", Default = Settings.killerColor, Callback = function(qWwbub_lpU1)
Settings.killerColor = qWwbub_lpU1;
func4()
end,})
MainState.vIZuUHO1 = MainState._Q_UQwvznNuxzH.AddSection(MainState._Q_UQwvznNuxzH,"Survivor ESP", nil)
MainState.loHWU = MainState.vIZuUHO1.AddHStack(MainState.vIZuUHO1)
MainState.loHWU:AddToggle({ Title = "Show Name", Default = Settings.survivorShowName, Callback = function(uz1wZNHpoQzZ1I)
Settings.survivorShowName = uz1wZNHpoQzZ1I;
func4()
end,})
MainState.loHWU:AddToggle({ Title = "Show Outline", Default = Settings.survivorShowOutline, Callback = function(vQqmuZHD)
Settings.survivorShowOutline = vQqmuZHD;
func4()
end,})
MainState.vIZuUHO1:AddColorPicker({ Title = "Survivor Color", Default = Settings.survivorColor, Callback = function(wzZmD0_uOvHUn)
Settings.survivorColor = wzZmD0_uOvHUn;
func4()
end,})
MainState.vlbbmUHO0DqzX = MainState._Q_UQwvznNuxzH.AddSection(MainState._Q_UQwvznNuxzH,"Show Item Survivor", nil)
MainState.vlbbmUHO0DqzX:AddToggle({ Title = "Show Equipped Item", Default = false, Callback = function(p1zvlbW)
Settings.espItemEnabled = p1zvlbW
end,})
MainState.MQOoHpooND = MainState._Q_UQwvznNuxzH.AddSection(MainState._Q_UQwvznNuxzH,"Outline Settings", nil)
MainState.MQOoHpooND:AddToggle({ Title = "Outline Only", Content = "Tampilkan outline saja tanpa fill (berlaku untuk Killer & Survivor)", Default = Settings.killerOutlineOnly, Callback = function(bXMOOon)
Settings.killerOutlineOnly = bXMOOon;
Settings.survivorOutlineOnly = bXMOOon func4()
end,})
MainState.qwXOxuX = MainState._Q_UQwvznNuxzH.AddSection(MainState._Q_UQwvznNuxzH,"Object ESP", nil)
MainState.bwZzbozHD = MainState.qwXOxuX.AddHStack(MainState.qwXOxuX)
MainState.bwZzbozHD:AddToggle({ Title = "ESP Generator", Default = Settings.espGeneratorEnabled, Callback = function(q1uDuD10X0HH_u)
Settings.espGeneratorEnabled = q1uDuD10X0HH_u;
func26()
end,})
MainState.bwZzbozHD:AddToggle({ Title = "Progress Gen", Default = Settings.espGeneratorProgressGen, Callback = function(BIWbZZNnpOwXWv)
Settings.espGeneratorProgressGen = BIWbZZNnpOwXWv
for _1WmxNbNzI0wz_, uIpD1QXm in ipairs(ESPState.cachedMapObjects.Generators) do
 if uIpD1QXm and uIpD1QXm.Parentthen uIpD1QXm:SetAttribute("__BolongGenLastPct__", nil)
 if not BIWbZZNnpOwXWv then
 local v97 = uIpD1QXm:FindFirstChild("__BolongGenProgress__")
 if v97 then
v97.Destroy(v97)
 end
end
end
end func26()
end,})
MainState.qwXOxuX:AddToggle({ Title = "Show Generator Info", Default = Settings.espGenShowPK, Content = "Player & Break", Callback = function(NMIv0lNxwIoq)
Settings.espGenShowPK = NMIv0lNxwIoq
for HvInNnz, ln0_pIZQu1W in ipairs(ESPState.cachedMapObjects.Generators) do
 if ln0_pIZQu1W and ln0_pIZQu1W.Parent then
ln0_pIZQu1W:SetAttribute("__BolongGenLastPct__", nil)
 end
end
end,})
MainState.MN0XuxIQDDnl = MainState.qwXOxuX.AddHStack(MainState.qwXOxuX)
MainState.MN0XuxIQDDnl:AddToggle({ Title = "ESP Window", Default = Settings.espWindowEnabled, Callback = function(IbnIbWnQw)
Settings.espWindowEnabled = IbnIbWnQw func26()
end,})
MainState.MN0XuxIQDDnl:AddToggle({ Title = "ESP Pallet", Default = Settings.espPalletEnabled, Callback = function(wMZx_0__MIuDZ)
Settings.espPalletEnabled = wMZx_0__MIuDZ;
func26()
end,})
MainState.wlWM_qQbD = MainState.qwXOxuX.AddHStack(MainState.qwXOxuX)
MainState.wlWM_qQbD:AddToggle({ Title = "ESP Hook", Default = Settings.espHookEnabled, Callback = function(NlNllmM0oWqp)
Settings.espHookEnabled = NlNllmM0oWqp;
func26()
end,})
MainState.wlWM_qQbD:AddToggle({ Title = "ESP Gate", Default = Settings.espGateEnabled, Callback = function(bOlI1m1Xm)
Settings.espGateEnabled = bOlI1m1Xm;
func26()
end,})
MainState.uMUI0QpIl = MainState.qwXOxuX.AddHStack(MainState.qwXOxuX)
MainState.uMUI0QpIl:AddColorPicker({ Title = "Generator Color", Default = Settings.espGeneratorColor, Callback = function(voH1Q1O1Zw)
Settings.espGeneratorColor = voH1Q1O1Zw
if Settings.espGeneratorEnabledthen
for HxbWnI11z, W0xbx in ipairs(ESPState.cachedMapObjects.Generators) do
 if W0xbx and W0xbx.Parent then
 local v98 = W0xbx:FindFirstChild("__BolongHL__")
 if v98 then
v98.FillColor = voH1Q1O1Zw;
v98.OutlineColor = voH1Q1O1Zw
 end
end
end
end
end,})
MainState.uMUI0QpIl:AddColorPicker({ Title = "Window Color", Default = Settings.espWindowColor, Callback = function(NoXbob)
Settings.espWindowColor = NoXbob
for HU0WzpN1Hbb_Z, wqvWQNlmlXp1z in pairs(ESPState.windowEspObjects) do
 if wqvWQNlmlXp1z and wqvWQNlmlXp1z.Parentthen pcall(
 function()
wqvWQNlmlXp1z.Color3 = NoXbob
end)
end
end
end,})
MainState.NMXN0uvm = MainState.qwXOxuX.AddHStack(MainState.qwXOxuX)
MainState.NMXN0uvm:AddColorPicker({ Title = "Pallet Color", Default = Settings.espPalletColor, Callback = function(Bn_00)
Settings.espPalletColor = Bn_00
for Ww1oxIwuOp, HDlwqHn in ipairs(ESPState.cachedMapObjects.Pallets) do
 if HDlwqHn then
 local v99 = HDlwqHn:FindFirstChild("__BolongHL__")
 if v99 then
v99.FillColor = Bn_00;
v99.OutlineColor = Bn_00
 end
end
end
end,})
MainState.NMXN0uvm:AddColorPicker({ Title = "Hook Color", Default = Settings.espHookColor, Callback = function(DQppNwUwoZonn)
Settings.espHookColor = DQppNwUwoZonn
for wNbz1IOzoNH, MNuMZD_UNozz in ipairs(ESPState.cachedMapObjects.Hooks) do
 if MNuMZD_UNozz and MNuMZD_UNozz.Parentthen
 local v100 = ESPState.cachedHookMeshParts[MNuMZD_UNozz]
 if v100 then
 for QzzqQOlvmoxbqX, qDbQWxMlN_ in ipairs(v100) do
 local v101 = qDbQWxMlN_:FindFirstChild("__BolongHL__")
 if v101 then
v101.FillColor = DQppNwUwoZonn;
v101.OutlineColor = DQppNwUwoZonn
 end
end
 end
end
end
end,})
MainState.bWnD000QvNl = MainState.qwXOxuX.AddHStack(MainState.qwXOxuX)
MainState.bWnD000QvNl:AddColorPicker({ Title = "Gate Color", Default = Settings.espGateColor, Callback = function(O1UN1lZX)
Settings.espGateColor = O1UN1lZX
for lZQzuMbno, oIWxwzwbOQ in ipairs(ESPState.cachedMapObjects.Gates) do
 if oIWxwzwbOQ and oIWxwzwbOQ.Parent then
 local v102 = oIWxwzwbOQ:FindFirstChild("__BolongHL__")
 if v102 then
v102.FillColor = O1UN1lZX;
v102.OutlineColor = O1UN1lZX
 end
end
end
end,})
MainState.bXI_Dz0vqn = MainState._Q_UQwvznNuxzH.AddSection(MainState._Q_UQwvznNuxzH,"Prediction Map&Killer", nil)
MainState.bXI_Dz0vqn:AddToggle({ Title = "Show Prediction Monitor", Default = false, Callback = function(vbomNWnIn)
if vbomNWnIn then
MainState.HuQnoUuWpwo()
else MainState.lboDUI()
end
end,})
MainState.vmo_0N = MainState._Q_UQwvznNuxzH.AddSection(MainState._Q_UQwvznNuxzH,"World Settings", nil)
MainState.vmo_0N:AddToggle({ Title = "Fullbright", Default = false, Callback = function(MINOIvOXwOlxwz)
ESPState.fullbrightEnabled = MINOIvOXwOlxwz
if MINOIvOXwOlxwz then
MainState.p_01zM1nQ()
else MainState.un10pxvlDoWQlp()
end
end,})
MainState.vmo_0N:AddToggle({ Title = "Remove Visual Effects", Content = "BoostFps", Default = false, Callback = function(_WvWZDm)
ESPState.removeVfxEnabled = _WvWZDm
if _WvWZDm then
MainState.NZ0MOpIIxM_0()
else MainState.WwMOwDZWQxwXD()
end
end,})
end
do
MainState.BHWwUOqxM = MainState.p0N1pxWHmq.AddSection(MainState.p0N1pxWHmq,"Anti AFK", nil)
MainState.BHWwUOqxM:AddToggle({ Title = "Enable Anti AFK", Default = false, Callback = function(vWz_pZnWxv) SetupAntiAFK(vWz_pZnWxv)
end,})
MainState.ol_p1qopNxquwo = MainState.p0N1pxWHmq.AddSection(MainState.p0N1pxWHmq,"Killer Warn", nil)
MainState.ol_p1qopNxquwo:AddToggle({ Title = "Enable Killer Warn", Content = "The ! sign above your head when the killer is around you", Default = Settings.warnEnabled, Callback = function(bplwwZI)
Settings.warnEnabled = bplwwZI
end,})
MainState.loXWx0_lU_0H = MainState.p0N1pxWHmq.AddSection(MainState.p0N1pxWHmq,"Performance Monitor", nil)
MainState.loXWx0_lU_0H:AddToggle({ Title = "Show Performance Window", Default = false, Callback = function(Q1XMnDoIOQunD)
if Q1XMnDoIOQunD then
MainState.lUwpXW()
else MainState.p_X0zlUul()
end
end,})
MainState._MvbqpNQIo_X1I = MainState.p0N1pxWHmq.AddSection(MainState.p0N1pxWHmq,"Camera Zoom", nil)
MainState._MvbqpNQIo_X1I:AddToggle({ Title = "Max Camera Zoom", Default = Settings.cameraZoomEnabled, Callback = function(HMW0U)
Settings.cameraZoomEnabled = HMW0U
if HMW0U then
MainState.w_vnXUZ(Settings.cameraZoomValue)
else MainState.Ww1z_Ob0vX()
end
end,})
MainState.u__Q_xlxpoxwxO = MainState.p0N1pxWHmq.AddSection(MainState.p0N1pxWHmq,"Force Cursor (PC Only)", nil)
MainState.IlQXmXmuW = MainState.u__Q_xlxpoxwxO.AddToggle(MainState.u__Q_xlxpoxwxO,{ Title = "Force Mouse Cursor", Content = "Forces the mouse cursor to always appear on the screen.", Default = false, Callback = function(OIuvD)
Settings.forceCursorEnabled = OIuvD
if OIuvD then
MainState.vvw0v_lDxx() ShowNotify("Force Cursor","Mouse cursor forced to appear!", 2)
else MainState.Bu0oXoOlbI()
end
end,})
MainState.u__Q_xlxpoxwxO:AddKeybind({ Title = "Toggle Keybind", Default = Enum.KeyCode.Y, Callback = function()
local v103 = not Settings.forceCursorEnabledMainState.IlQXmXmuW:Set(v103)
end}) do
 local v104 = bit32.band(23, 0)
 local v105 = bit32.bor(v104, 110)- 110
end
MainState.MnDwxvu = MainState.p0N1pxWHmq.AddSection(MainState.p0N1pxWHmq,"Protect Name", nil)
MainState.MnDwxvu:AddToggle({ Title = "Enable Protect Name", Default = false, Callback = function(BnlOmXmbozz)
if BnlOmXmbozz then
MainState.QwZpNwn()
else MainState.lOqqxMquzxn_()
end
end,})
MainState.OppMnHnZv = MainState.p0N1pxWHmq.AddSection(MainState.p0N1pxWHmq,"Skip Cutscene", nil)
MainState.NzXpUbznz = false MainState.bxUOQ = MainState.OppMnHnZv.AddToggle(MainState.OppMnHnZv,{ Title = "Skip End Screen", Default = false, Callback = function(Dm1IuI0oDn)
if MainState.NzXpUbznz then
 return
end
Settings.skipEndScreenEnabled = Dm1IuI0oDn
if Dm1IuI0oDn then
MainState.NzXpUbznz = true Settings.skipLoadEndScreenEnabled = false
 if MainState.pXHb0oo then
MainState.pXHb0oo.Set(MainState.pXHb0oo, false)
 end
MainState.NzXpUbznz = false MainState.Wb0x1XpWv()
MainState.oqWmXqpHU(false)
else MainState.Wb0x1XpWv()
end
end,})
MainState.pXHb0oo = MainState.OppMnHnZv.AddToggle(MainState.OppMnHnZv,{ Title = "Skip Loading & End Screen", Default = false, Callback = function(pmnozwuqZwwUQ)
if MainState.NzXpUbznz then
 return
end
Settings.skipLoadEndScreenEnabled = pmnozwuqZwwUQ
if pmnozwuqZwwUQ then
MainState.NzXpUbznz = true Settings.skipEndScreenEnabled = false
 if MainState.bxUOQ then
MainState.bxUOQ.Set(MainState.bxUOQ, false)
 end
MainState.NzXpUbznz = false MainState.Wb0x1XpWv()
MainState.oqWmXqpHU(true)
else MainState.Wb0x1XpWv()
end
end,})
MainState.NN_xb = MainState.p0N1pxWHmq.AddSection(MainState.p0N1pxWHmq,"Avatar Copy (Visual)", nil)
MainState.NN_xb:AddPresetManager({ Title = "Profile Avatar By Username / ID", Placeholder = "Jandel / 1234...", Default = "", Presets = { Boy1 = "kiicaine", Boy2 = "444jamesss", Boy3 = "KiLouo14", Girl1 = "9kinb", Girl2 = "winterilous", Girl3 = "ellea_893"}, Callback = function(uD_xIzH_)
currentAvatarInput = uD_xIzH_
end})
MainState.NN_xb:AddButton({ Title = "Copy Avatar", Callback = function()
if currentAvatarInput and currentAvatarInput~="" then
MainState.vzImqwp(currentAvatarInput)
else ShowNotify("BolongHub","Masukkan Username/ID terlebih dahulu!", 2)
end
end})
MainState.WHZomMMH = MainState.ODQQmq.AddSection(MainState.ODQQmq,"Configuration", true)
MainState.WHZomMMH:AddConfig()
end
print("BOLONGHUB LOADED!")
