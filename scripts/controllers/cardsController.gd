extends Node

#Variaveis da Galaxia de Gaia
var listaGaia := [] 
var listaGaiaEspecial := []

#Variaveis da Galaxia de Stroj
var listaStroj := [] 
var listaStrojEspecial := []

# Called when the node enters the scene tree for the first time.
func _ready():
	#Fazendo a leitura das cartas a partir dos Resources de cada uma delas
	listaGaia = loadItems("res://resources/gaia/amazonas/normal/")
	listaGaiaEspecial = loadItems("res://resources/gaia/amazonas/especial/")
	listaStroj = loadItems("res://resources/stroj/goldrons/normal/")
	listaStrojEspecial = loadItems("res://resources/stroj/goldrons/especial/")
	print(listaGaiaEspecial.size())
	print(buscarID(39,listaGaiaEspecial).ID)
	
static func loadItems(folderPath : String) -> Array:
	var item_files := []
	var items_folder := folderPath#"res://resources/gaia/amazonas/"

	var directory := Directory.new()
	var can_continue := directory.open(items_folder) == OK
	if not can_continue:
		print_debug('Could not open directory "%s"' % [items_folder])
		return item_files

	directory.list_dir_begin(true, true)
	var file_name := directory.get_next()
	while file_name != "":
		if file_name.get_extension() == "tres":
			item_files.append(items_folder.plus_file(file_name))
		file_name = directory.get_next()

	var item_resources := []
	for path in item_files:
		item_resources.append(load(path))

	return item_resources
	
func buscarID(id:int,lista) -> Card:
	for elemento in lista:
		if elemento.ID == id:
			return elemento
	
	return null
