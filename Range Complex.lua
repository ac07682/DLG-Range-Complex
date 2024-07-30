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
 SpawnSEADTarget = SPAWN:New("SEAD SA13-1")
 	:InitLimit(1,0)
 	--:InitHiddenOnMap()
 	:SpawnScheduled(120,.5)
  SpawnSEADTarget = SPAWN:New("SEAD SA13-2")
 	:InitLimit(1,0)
 	--:InitHiddenOnMap()
 	:SpawnScheduled(120,.5)
  SpawnSEADTarget = SPAWN:New("SEAD SA10")
 	:InitLimit(1,0)
 	--:InitHiddenOnMap()
 	:SpawnScheduled(120,.5)

 -- Setup SEAD Range
 SEADRange = SEAD:New({"SEAD SA13-1","SEAD SA13-2","SEAD SA10"})




 -- Setup the bombing / strafing range

 -- Strafe pits. Each pit can consist of multiple targets. Here we have two pits and each of the pits has two targets.
 -- These are names of the corresponding units defined in the ME.
 local strafepit={"Strafe Pit Left", "Strafe Pit Right"}


 -- Table of bombing target names. Again these are the names of the corresponding units as defined in the ME.
 local bombtargets={"Bomb Target Circle Left", "Bomb Target Circle Right"}

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



  -- Setup the Moving Target range

 -- Table of bombing target names. Again these are the names of the corresponding units as defined in the ME.
 local movingtargets={"MTTruck-1-1","MTTruck-1-2","MTTruck-1-3","MTTruck-1-4","MTTruck-2-1","MTTruck-2-2","MTTruck-2-3","MTTruck-2-4"}

 -- Create a range object.
 MTRange=RANGE:New("Moving Target Range")

 -- Add bombing targets. A good hit is if the bomb falls less then 50 m from the target.
 MTRange:AddBombingTargets(movingtargets, 30)

 -- Fine Tuning
 MTRange:TrackRocketsOFF()
 MTRange:SetInstructorRadio(300)
 MTRange:SetRangeControl(300)
 MTRange:SetAutosaveOn()
 MTRange:SetRangeZone("MTRange Zone")

 -- Start range.
 MTRange:Start()





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

