extends Node
#GALAXIA DEPENDENTE
#Variaveis da Galaxia de Gaia
var listaGaia := [] 
var listaGaiaEspecial := []
#Variaveis da Galaxia de Stroj
var listaStroj := [] 
var listaStrojEspecial := []
#Variaveis da Galaxia de Majik
var listaMajik := []
var listaMajikEspecial := []
#Variaveis da Galaxia de Adroit
var listaAdroit := []
var listaAdroitEspecial := []
#Lista de Fortalezas
var fortalezas

# Called when the node enters the scene tree for the first time.
func _ready():
	#Fazendo a leitura das cartas a partir dos Resources de cada uma delas
	#GAIA (apenas amazonas)
	listaGaia = loadItems("res://resources/gaia/amazonas/normal/")
	listaGaiaEspecial = loadItems("res://resources/gaia/amazonas/especial/")
	#STROJ (apenas goldrons)
	listaStroj = loadItems("res://resources/stroj/goldrons/normal/")
	listaStrojEspecial = loadItems("res://resources/stroj/goldrons/especial/")
	#MAJIK (apenas planeta zonnjik)
	listaMajik = loadItems("res://resources/majik/zonnjik/normal")
	listaMajikEspecial = loadItems("res://resources/majik/zonnjik/especial/")
	#ADROIT
	listaAdroit = loadItems("res://resources/adroit/zymetrix/normal/")
	listaAdroitEspecial = loadItems("res://resources/adroit/zymetrix/especial/")
	#FORTALEZAS
	fortalezas = loadItems("res://resources/fortalezas/")

static func loadItems(folderPath : String) -> Array:
	var item_files := []
	var items_folder := folderPath
	
	#criando instancia do diretorio a ser lido
	var directory := Directory.new()
	var can_continue := directory.open(items_folder) == OK
	if not can_continue:
		print_debug('Não foi possível abrir "%s"' % [items_folder])
		return item_files

	directory.list_dir_begin(true, true)
	#Estrutura para adicionar os resources (.tres) que representam as cartas em uma lista
	var file_name := directory.get_next()
	while file_name != "":
		if file_name.get_extension() == "tres":
			item_files.append(items_folder.plus_file(file_name))
		file_name = directory.get_next()
	
	#Carregar os itens da lista (eles viram elementos da classe Card automaticamente)
	var item_resources := []
	for path in item_files:
		item_resources.append(load(path))

	return item_resources
	
func buscarID(id:int,lista) -> Card:
	for elemento in lista:
		if elemento.ID == id:
			return elemento
	
	return null
	
func buscarFortalezaID(id : String):
	for fortal in fortalezas:
		if fortal.ID == id:
			return fortal
	
	return null

func buscarFortalezas(galaxia : String):
	var lista = []
	
	for fortal in fortalezas:
		if fortal.Galaxia.to_lower() == galaxia.to_lower():
			lista.append(fortal)
	
	return lista
