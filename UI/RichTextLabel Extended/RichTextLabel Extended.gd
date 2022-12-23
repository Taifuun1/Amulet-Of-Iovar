extends RichTextLabel

var spellData = load("res://Objects/Spell/SpellData.gd").new()

var colors = {  }

func _ready():
	for _spellData in spellData.spellData:
		if !_spellData.match("spellDirections"):
			colors[_spellData] = spellData.spellData[_spellData].color
	colors.common = "#c1c1c1"
	colors.uncommon = "#1f7dc4"
	colors.rare = "#b8c41f"
	colors.legendary = "#e19f28"
#	colors.ring = "#1fc437"

func createRichTextLabel(_text, _color = null, _textAlignment = null):
	var _bbcode = str(_text)
	if _color != null:
		_bbcode = _bbcode.join(["[color=%s]" % colors[_color], "[/color]"])
	if _textAlignment != null:
		_bbcode = _bbcode.join(["[%s]" % _textAlignment, "[/%s]" % _textAlignment])
	append_bbcode(_bbcode)
