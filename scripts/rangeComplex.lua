-- Spawn MTRange Trucks
Spawn_MTTruck_1 = SPAWN
	:New( "MTTruck-1" )
	:InitLimit( 4, 0 )
  	:SpawnScheduled( 5, .5 )
Spawn_Group_1 = Spawn_MTTruck_1:Spawn()

Spawn_MTTruck_2 = SPAWN
	:New("MTTruck-2")
	:InitLimit(4,0)
	:SpawnScheduled(5,.5)
Spawn_Group_2 = Spawn_MTTruck_2:Spawn()

-- Spawn Reaper Range Targets
ReaperZoneTable = {ZONE:New("ReaperZone1"),ZONE:New("ReaperZone2"),ZONE:New("ReaperZone3"),ZONE:New("ReaperZone4"),ZONE:New("ReaperZone5"),ZONE:New("ReaperZone6")}
ReaperTemplates = {"ReaperTarget1","ReaperTarget2", "ReaperTarget3"}

Spawn_ReaperTarget1 = SPAWN:New("ReaperTarget1")
	:InitLimit(10,0)
	:InitRandomizeZones(ReaperZoneTable)
	:InitRandomizeTemplate(ReaperTemplates)
	:InitHiddenOnMap()

	:SpawnScheduled(5,.5)

Spawn_ReaperTarget2 = SPAWN:New("ReaperTarget2")
	:InitLimit(10,0)
	:InitRandomizeZones(ReaperZoneTable)
	:InitRandomizeTemplate(ReaperTemplates)
	:InitHiddenOnMap()

	:SpawnScheduled(5,.5)

Spawn_Reaper_1 = SPAWN:New("Reaper-1")
	:InitLimit(1,0)
	:SpawnScheduled(5,.5)
Spawn_Reaper_2 = SPAWN:New("Reaper-2")
	:InitLimit(1,0)
	:SpawnScheduled(5,.5)

 -- Spawn SEAD Range Targets
 SEADTemplates = {"SEAD SA8","SEAD SA15"}
 SEADZones = {ZONE:New("SEAD Zone-1"),ZONE:New("SEAD Zone-2"),ZONE:New("SEAD Zone-3")}

 SpawnSEADTarget1 = SPAWN:New("SEAD Target-1")
 	:InitLimit(1,0)
 	:InitRandomizeTemplate(SEADTemplates)
 	:InitRandomizeZones(SEADZones)
 	:InitHiddenOnMap()
 	:SpawnScheduled(600,.4)
 SpawnSEADTarget2 = SPAWN:New("SEAD Target-2")
 	:InitLimit(1,0)
 	:InitRandomizeTemplate(SEADTemplates)
 	:InitRandomizeZones(SEADZones)
 	:InitHiddenOnMap()
 	:SpawnScheduled(600,.4)
 SpawnSEADTarget3 = SPAWN:New("SEAD Target-3")
 	:InitLimit(1,0)
 	:InitRandomizeTemplate(SEADTemplates)
 	:InitRandomizeZones(SEADZones)
 	:InitHiddenOnMap()
 	:SpawnScheduled(600,.4)
 SpawnSEADTarget4 = SPAWN:New("SEAD SA10")
    :InitLimit(8,0)
 	:InitHiddenOnMap()
	:SpawnScheduled(600,.4)

 -- Setup SEAD Range
 SEADRange = SEAD:New({"SEAD Target-1","SEAD Target-2","SEAD Target-3","SEAD SA10"})



 -- F10 Spawn BFM Targets
 BFMSpawnZone = {ZONE:New("BFMSpawnZone")}
 function BFMSpawn(unit)
 	SpawnBFMGroup = SPAWN:New(unit)
 		:InitLimit(1,1)
 		:InitRandomizeZones(BFMSpawnZone)
 		:SpawnScheduled(10,.5)
 end

 MenuLevel1 = MENU_MISSION:New("BFM Menu") -- Top level menu
 MenuLevel2_1 = MENU_MISSION:New("MiG", MenuLevel1)
 MenuLevel2_2 = MENU_MISSION:New("Sukhoi", MenuLevel1)
 MenuLevel2_3 = MENU_MISSION:New("Other", MenuLevel1)

 MenuLevel3_1 = MENU_MISSION_COMMAND:New("MiG-19 Farmer", MenuLevel2_1, BFMSpawn, "BFMFarmer")
 MenuLevel3_2 = MENU_MISSION_COMMAND:New("MiG-21 Fishbed", MenuLevel2_1, BFMSpawn, "BFMFishbed")
 MenuLevel3_3 = MENU_MISSION_COMMAND:New("MiG-23 Flogger", MenuLevel2_1, BFMSpawn, "BFMFlogger")
 MenuLevel3_4 = MENU_MISSION_COMMAND:New("MiG-25 Foxbat", MenuLevel2_1, BFMSpawn, "BFMFoxbat")
 MenuLevel3_5 = MENU_MISSION_COMMAND:New("MiG-29 Fulcrum", MenuLevel2_1, BFMSpawn, "BFMFulcrum")
 MenuLevel3_6 = MENU_MISSION_COMMAND:New("MiG-31 Foxhound", MenuLevel2_1, BFMSpawn, "BFMFoxhound")

 MenuLevel4_1 = MENU_MISSION_COMMAND:New("Su-27 Flanker", MenuLevel2_2, BFMSpawn, "BFMFlanker")
 MenuLevel4_2 = MENU_MISSION_COMMAND:New("Su-30 Flanker-C", MenuLevel2_2, BFMSpawn, "BFMFlanker-C")
 MenuLevel4_3 = MENU_MISSION_COMMAND:New("Su-33 Flanker-D", MenuLevel2_2, BFMSpawn, "BFMFlanker-D")

 MenuLevel5_1 = MENU_MISSION_COMMAND:New("F-14 Tomcat", MenuLevel2_3, BFMSpawn, "BFMTomcat")
 MenuLevel5_2 = MENU_MISSION_COMMAND:New("F-15 Eagle", MenuLevel2_3, BFMSpawn, "BFMEagle")
 MenuLevel5_3 = MENU_MISSION_COMMAND:New("F-16 Fighting Falcon", MenuLevel2_3, BFMSpawn, "BFMViper")
 MenuLevel5_4 = MENU_MISSION_COMMAND:New("F-4 Phantom II", MenuLevel2_3, BFMSpawn, "BFMPhantom")
 MenuLevel5_5 = MENU_MISSION_COMMAND:New("MiG-28", MenuLevel2_3, BFMSpawn, "BFMTiger")
 MenuLevel5_6 = MENU_MISSION_COMMAND:New("F/A-18 Hornet", MenuLevel2_3, BFMSpawn, "BFMHornet")
 MenuLevel5_7 = MENU_MISSION_COMMAND:New("BAE Systems Hawk", MenuLevel2_3, BFMSpawn, "BFMHawk")

 -- Setup the bombing / strafing range

 -- Strafe pits. Each pit can consist of multiple targets. Here we have two pits and each of the pits has two targets.
 -- These are names of the corresponding units defined in the ME.
 local strafepit={"Strafe Pit Left", "Strafe Pit Right"}


 -- Table of bombing target names. Again these are the names of the corresponding units as defined in the ME.
 local bombtargets={"Bomb Target Circle Left", "Bomb Target Circle Right", "BTTruck1", "BTTruck2", "BTTank1", "BTTank2", "BTStruc1", "BTBunker1", "BTBunker2", "BTBunker3", "BTSil1", "BTSil2", "BTSil3"}

 -- Create a range object.
 BTRange=RANGE:New("Bombing & Strafing Range")

 -- Distance between strafe target and foul line. You have to specify the names of the unit or static objects.
 -- Note that this could also be done manually by simply measuring the distance between the target and the foul line in the ME.
 BTRange:GetFoullineDistance("Strafe Pit Left", "Foul Line")

 -- Add strafe pits. Each pit (left and right) consists of two targets. Where "nil" is used as input, the default value is used.
 BTRange:AddStrafePit(strafepit, 3000, 400, nil, true, 20, fouldist)

 -- Add bombing targets. A good hit is if the bomb falls less then 50 m from the target.
 BTRange:AddBombingTargets(bombtargets, 30)

 -- Fine Tuning
 BTRange:TrackRocketsOFF()
 BTRange:SetInstructorRadio(305)
 BTRange:SetRangeControl(305)
 BTRange:SetAutosaveOn()

 -- Start range.
 BTRange:Start()


  -- Events handler for startup message
 Births = EVENTHANDLER:New()
 Births:HandleEvent(EVENTS.Birth)

 function Births:OnEventBirth(EventData)
 	if EventData.IniPlayerName==nil then
 		return false
 	end
 	local group = EventData.IniGroup -- Get group
 	local message = MESSAGE:New("Welcome to the range complex.  We currently have two ranges, accessible from the F10 menu.  The static range has two bombing targets, as well as a pair of strafe pits.  The moving target range has a convoy of trucks, and a convoy of DSHKs.  Both ranges are scored, and you will receive feedback over the radio if you tune to the frequency listed.  Your bombing scores will be added to the server scoreboard.  If you have any problems or questions, ping Dora, on Discord.", 30)
	USERSOUND:New("rangewelcome.wav"):ToGroup(group)
	message:ToGroup(group)
end





 -- Set up Farmer CAP for A2A Range
 -- Set up EWR and Dispatcher

 local DetectionSetGroup = SET_GROUP:New()
 DetectionSetGroup:FilterPrefixes("REWR")
 DetectionSetGroup:FilterStart()

 local A2ADetection = DETECTION_AREAS:New(DetectionSetGroup, 15000)

 RedAirDispatcher = AI_A2A_DISPATCHER:New(A2ADetection)

 A2ABorderZone = ZONE_POLYGON:New("A2ABorder",GROUP:FindByName("A2ABorder"))
 RedAirDispatcher:SetBorderZone( A2ABorderZone )

 -- Dispatcher defaults
 RedAirDispatcher:SetDefaultTakeoffInAir()
 RedAirDispatcher:SetDefaultLandingNearAirbase()
 RedAirDispatcher:SetDefaultGrouping(2)
 RedAirDispatcher:SetDefaultOverhead(1)
 RedAirDispatcher:SetEngageRadius() --default 100000

 -- Dispatcher tactical display
 RedAirDispatcher:SetTacticalDisplay(false)

 -- Define Sqns
 RedAirDispatcher:SetSquadron("A2A Flogger-1","Mineralnye Vody","A2A Flogger-1")
 RedAirDispatcher:SetSquadron("A2A Flogger-2","Mozdok","A2A Flogger-2")
 RedAirDispatcher:SetSquadron("A2A Fulcrum-1","Mozdok","A2A Fulcrum-1")
 RedAirDispatcher:SetSquadron("A2A Flogger-3","Beslan","A2A Flogger-3")
 RedAirDispatcher:SetSquadron("A2A Flanker-1","Beslan","A2A Flanker-1")
 -- Setup GCI
 RedAirDispatcher:SetSquadronGci("A2A Flogger-2",750,1400)
 RedAirDispatcher:SetSquadronGci("A2A Flogger-3",750,1400)
 RedAirDispatcher:SetSquadronGci("A2A Fulcrum-1",750,1400)
 RedAirDispatcher:SetSquadronGci("A2A Flanker-1",750,1400)

 -- Setup CAP
 RedAirDispatcher:SetSquadronCap("A2A Flogger-1",ZONE:New("A2ACAPZone-1"),3000,6000,600,800,1000,1300)
 RedAirDispatcher:SetSquadronCapInterval("A2A Flogger-1",1,30,60)

 -- Start Dispatcher
 RedAirDispatcher:Start()





 -- Designation of targets


	RecceSetGroup = SET_GROUP:New():FilterPrefixes( "Reaper" ):FilterStart()

	HQ = GROUP:FindByName( "HQ" )

	CC = COMMANDCENTER:New( HQ, "HQ" )

	-- Let the RecceSetGroup vehicles in the collection detect targets and group them in AREAS of 1000 meters.
	RecceDetection = DETECTION_UNITS:New( RecceSetGroup )

	-- Create a 
	AttackSet = SET_GROUP:New():FilterCoalitions("blue"):FilterStart()

	-- Setup Designation for the AttackSet.
	RecceDesignation = DESIGNATE:New( CC, RecceDetection, AttackSet )

	-- Generate the random laser codes.
	RecceDesignation:GenerateLaserCodes()

	-- The su-25T uses a specific laser code to guide its laser guides rockets.
	-- The code is 1113. A special menu option will be added that allows to lase with 1113.
	RecceDesignation:AddMenuLaserCode( 1113, "Lase for SU-25T (%d)" )

	-- The A-10A etc use a specific laser code to guide its laser guides rockets.
	-- The code is 1680. A special menu option will be added that allows to lase with 1680.
	RecceDesignation:AddMenuLaserCode( 1680, "Lase for A-10A (%d)" )

-- The X

Spawn_XTanks = SPAWN
	:New( "XTank1" )
	:InitLimit( 8, 0 )
	:InitRandomizePosition(300)
	:SpawnScheduled(1,0)
Spawn_XTanks:HandleEvent( EVENTS.Dead )
function Spawn_XTanks:OnEventDead( EventData )
  Spawn_XTanks:Destroy()
end


Bunker1 = STATIC:FindByName( "XBunker1-1", true )
Bunker1:HandleEvent( EVENTS.Dead )
function Bunker1:OnEventDead( EventData )
  Bunker1:ReSpawn()
end

Bunker2 = STATIC:FindByName( "XBunker2-1", true )
Bunker2:HandleEvent( EVENTS.Dead )
function Bunker2:OnEventDead( EventData )
  Bunker2:ReSpawn()
end

Bks = STATIC:FindByName( "XBks", true )
Bks:HandleEvent( EVENTS.Dead )
function Bks:OnEventDead( EventData )
  Bks:ReSpawn()
end

Heli = STATIC:FindByName( "XHeli-1", true )
Heli:HandleEvent( EVENTS.Dead )
function Heli:OnEventDead( EventData )
  Heli:Destroy()
  Heli:ReSpawn()
end

