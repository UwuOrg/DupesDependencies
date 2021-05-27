--written by Darkdoom/Uwu, 5/23/2021
--0.1
--load relevant assembly
luanet.load_assembly('DupesDEVNet5')
--import the class
EliteApiTextObject = luanet.import_type('DupesDEVNet5.EliteApiTextObject')

--settings prototype
local textObjectSettings = {
    ["Name"] = 'a name',
    ["InitialX"] = 100,
    ["InitialY"] = 100,
    ["TextColor"] = {
        ["Red"] = 25,
        ["Green"] = 48,
        ["Blue"] = 120,
        ["Alpha"] = 255,
    },
    ["BgColor"] = {
        ["Red"] = 255,
        ["Green"] = 255,
        ["Blue"] = 255,
        ["Alpha"] = 255,
    },
    ["InitialText"] = "some initial text",
    ["FontSize"] = 12,
    ["Font"] = "Arial",
}

--create a new text object
newObject = EliteApiTextObject(textObjectSettings["Name"], textObjectSettings["InitialX"], textObjectSettings["InitialY"], textObjectSettings["TextColor"]["Red"], textObjectSettings["TextColor"]["Green"],
 textObjectSettings["TextColor"]["Blue"], textObjectSettings["TextColor"]["Alpha"], textObjectSettings["BgColor"]["Red"], textObjectSettings["BgColor"]["Green"], textObjectSettings["BgColor"]["Blue"],
 textObjectSettings["BgColor"]["Alpha"], textObjectSettings["InitialText"], textObjectSettings["FontSize"], textObjectSettings["Font"])

--print to c# and lua consoles that we've created a text object
dbgprint('Text object created!')
