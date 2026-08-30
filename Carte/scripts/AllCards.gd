class_name AllCards 
extends ItemList

var dico :Dictionary[int,Carte]

#region Helper method for loading Carte_X.gd
func is_Carte(d :Dictionary):
	return d["base"]=="Carte"

func add_to_dico(entrance : Dictionary , id : int)->void:
	var baseString=entrance["class"]
	var number : int =baseString.erase(0,baseString.length()-2).to_int()
	##la ligne du cauchmard elle 
	###1-crée l'instance du script
	###2-la met dans le dictionnaire
	###3-lui attribue le bon owner
	(dico.get_or_add(number,load(entrance["path"]).new()) as Carte).owner=id
#endregion

func _ready() -> void:
	##le get parent*2 ne marche que si la hiéarchie ne change pas c'est du hard code de bourrin
	var id : int= (get_parent().get_parent() as Player).player_Id
	for x in ProjectSettings.get_global_class_list().filter(is_Carte) :
		add_to_dico(x,id)
	##initialise tout les script enfant de Class correctement formaté
	####Pire crime de l'histoire de l'humanité,on raconte que son créateur construit une tour de sont hubris,la hauteur serait tell qu'elle perças le paradis


func GetCarteInstanceOnNumber(entrance :int)->Card :
	var test =  dico[entrance]
	return test
