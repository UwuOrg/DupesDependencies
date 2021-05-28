--written by Darkdoom/Uwu, 5/28/2021
--0.1
--basic example of moving to a location and fighting mobs in a single zone
--load dupes assembly
luanet.load_assembly('DupesDEVNet5')
--import classes
MovementTask = luanet.import_type("DupesDEVNet5.Bots.Tasks.MovementTask")
CombatRoutine = luanet.import_type("DupesDEVNet5.CombatRoutines.CombatRoutine")
Vector3 = luanet.import_type("DupesDEVNet5.Vector3")

--vars
local _MobsToKill = {"Huge Hornet", "Tunnel Worm"}
local _DesiredZone = "South Gustaberg"
local _CampOne = Vector3(147.435, -219.870, 2.623)

local _HaveTarget = false
local _Navigating = false
local _MovementTask = nil
local _CombatRoutine = nil

--stateThread equivalent
local function TestNav()

    while(true)do
        --don't run if we're zoning
        if(not IsZoning)then

            local player = GetLocalPlayer()
            
            dbgprint(player.Name .. " " .. player.Pos.X .. " " .. player.Pos.Y .. " " .. player.Pos.Z)
            dbgprint("distance to wp " .. player.Pos:DistanceToPoint(_CampOne))
            --check distance to camp/home location
            if(player.Pos:DistanceToPoint(_CampOne) > 50)then
                --start moving to camp
                if(not _Navigating)then

                    _MovementTask = MovementTask(_CampOne)
                    _Navigating = true
                    dbgprint('created movement task')
                    if(_MovementTask and not _MovementTask.IsRunning)then
                        
                        _MovementTask:Run()
                        dbgprint('started movement task')
                    end

                end

            else
                --otherwise we're at camp, start looking for mobs
                if(_MovementTask and _MovementTask.AtGoal)then
                    _Navigating = false
                end

                --distance is currently hardcoded to 25
                --will be settable
                local entity = GetClosestEntity("Huge Hornet")

                dbgprint("looking for entity")

                if(entity and _HaveTarget == false and _Navigating == false)then
                    --we found a target, start a combatroutine
                    --combat routine's will automatically load predetermined logic for simple combat based on player's job
                    dbgprint("found entity " .. entity.Id)

                    _CombatRoutine = CombatRoutine(entity.Id)
                    _HaveTarget = true

                   dbgprint("spawned combat routine")

                    if(_CombatRoutine and not _CombatRoutine.BotRunning and not _Navigating)then

                        _CombatRoutine:Start()
                        dbgprint("started combat routine")

                    end

                end
                --task is complete, start checking for new targets or continue navigating
                if((_CombatRoutine and _CombatRoutine.TaskFinished) or _Navigating)then
                    _HaveTarget = false
                    dbgprint("target routine done or navigation superceded")
                end

            end

        end

    end

end

TestNav()