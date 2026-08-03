class_name AllCarte 
extends Node

static  var dico :Dictionary[int,Carte]
static  var CarteName : String ="Carte"
func is_Carte(d :Dictionary):
	return d["base"]=="Carte"

func add_to_dico(entrance : Dictionary)->void:
	var baseString=entrance["class"]
	var number : int =baseString.erase(0,baseString.length()-2).to_int()
	dico[number]=load(entrance["path"]).new()

func _init() -> void:
	ProjectSettings.get_global_class_list().filter(is_Carte).all(add_to_dico)
	print(dico[3].ActivationType)


func GetCarteInstanceOnNumber(entrance :int)->Carte :
	var test = dico[entrance].new()
	return test
