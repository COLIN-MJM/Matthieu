class_name AllCarte 
extends Node

static  var dico :Dictionary[int,Carte]

#region Helper method for loading Carte_X.gd
func is_Carte(d :Dictionary):
	return d["base"]=="Carte"

func add_to_dico(entrance : Dictionary)->void:
	var baseString=entrance["class"]
	var number : int =baseString.erase(0,baseString.length()-2).to_int()
	dico.get_or_add(number,load(entrance["path"]).new())
#endregion

func _init() -> void:
	for x in ProjectSettings.get_global_class_list().filter(is_Carte) :
		add_to_dico(x)
	##initialise tout les script enfant de Class correctement formaté
	####Pire crime de l'histoire de l'humanité,on raconte que son créateur construit une tour de sont hubris,la hauteur tell qu'elle perças le paradis


func GetCarteInstanceOnNumber(entrance :int)->Carte :
	var test = dico[entrance].duplicate()
	return test
