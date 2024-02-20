-- Variables --
local VESRION = 0.1
local PCID = os.getComputerID()
local recievePC

local stressOmeter = true--periperal.find("Stressometer")

local modem = periperal.find("modem")
local stressError = "Stress to High Clutch Engaged"

local foundPeriperal = false
local correctInput = false
local clutchOut = false

-- Checks that peripherals are installed correctly --
while(foundPeriperal == fasle) do
    if stressOmeter and modem then
        print("Periphals Found...")
        sleep(2.5)
        Clear()
    elseif stressOmeter == false and modem == true then
        print("StressOmeter Not Found...")
        sleep(2.5)
        Clear()
    elseif stressOmeter == true and modem == false then
        print("Modem Not Found...")
        sleep(2.5)
        Clear()
    elseif stressOmeter == false and modem == false then
        print("No Periperal's Found...")
        sleep(2.5)
        Clear()
    end
end

-- Disclaimer/Program Version
print("Create Power Management System | HUB V".. VERSION .." Create by V01D")
print("This program is the 'Heart' of the system and is designed to be hidden and")
print("used in tandem with the 'Create Power Management System | Display' program.")
print("This secondary program can be found here: ")
print("This message will disappear in 30 seconds")
sleep(30)
Clear()

-- Ask's user for redstone input --
print("What side is the redstone input on?")
print("Options: front, back, left, right, top, bottom")
redstoneSide = read();
while(correctInput == false) do
    if redstoneSide ~= "front" or redstoneSide ~= "back" or redstoneSide ~= "left" or redstoneSide ~= "right" or redstoneSide ~= "top" or redstoneSide ~= "bottom" then
        Clear()
        print("Incorrect Value Entered. Please Try Again.")
        print("What side is the redstone input on?")
        print("Options: front, back, left, right, top, bottom")
        redstoneSide = read()
    else
        correctInput = true
        Clear()
    end
end

-- use clutch to keep power going --

-- Sends system data over rednet--
print("Rednet ID: ".. PCID)
print("what is the 'Display' PC Rednet ID?")
recievePC = tonumber(read())
Clear()

rednet.open(modem)
while true do
    currentStreess = stressOmeter.getStress()
    maxStress = stressOmeter.getStressCapacity()
    print(currentStreess)
    print(maxStress)
    Clear()

    if (currentStreess > maxStress) then
        clutchOut = true
        redstone.setOutput(redstoneSide, true)
    else
        clutchOut = false
    end

    if (clutchOut == false) then
        rednet.send(recievePC, currentStreess)
        rednet.send(recievePC, maxStress)
    else
        rednet.send(recievePC, stressError)
    end
end
