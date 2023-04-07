--[[
	Translator API
	Created by Matthew (sloss2003) (Updated slightly by nickales1757)
--]]

local languages = game.HttpService:JSONDecode(game.HttpService:GetAsync("https://pkgstore.datahub.io/core/language-codes:language-codes-full_json/data/language-codes-full_json.json"))

translator = {}
function translator.getLanguageAbreviation(name) -- Goes through the languages local and finds the Alpha2 abbreviation
	
	print("Attempting Language")
	
	name = string.lower(name)

	for i,v in pairs (languages) do

		print(v)

		if string.lower(v["English"]) == name or string.lower(string.split(v["English"]," ")[1]) == name..";" or v["alpha2"] == name then
			return(v["alpha2"])
		end
	end
end

function translator.getLanguageName(Alpha2) -- Uses the Alpha 2 abreviation to find the English name of it
	for i,v in pairs (languages) do
		if v["alpha2"] == Alpha2 then
			return(v["English"])		
		end	
	end	
end

function translator.translate(targetlanguage,Query) -- Fires the Translator, TargetLanguage being the Alpha 2, Query being the filtered message
	
	local Language = targetlanguage
	
	local http = game.HttpService:JSONDecode(game.HttpService:GetAsync("https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl="..Language.."&dt=t&q="..Query))
	return(http[1][1][1]) -- Returns the request, hopefully returning a result
end

return translator

