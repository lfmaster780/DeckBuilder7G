extends Node

var saves := []
const PATH = "user://Decks7G/"
var inicializacao = true

var diretorio := Directory.new()

func _ready():
	#if not diretorio.dir_exists(PATH):
		#print_debug("Não existe a pasta de decks")
		#diretorio.make_dir_recursive(PATH)
		
	#Definindo valor padrao do tamanho de tela seguindo a resolução do monitor
	var screen_size = OS.get_screen_size()
	OS.window_size = Vector2(screen_size.x*0.7,screen_size.y*0.7)
	#maximizando a tela
	OS.window_maximized = true

func carregarListaArquivos():
	var item_files := []
	var can_continue := diretorio.open(PATH) == OK
	if not can_continue:
		print_debug('Não foi possível abrir "%s"' % [PATH])
		saves = item_files
		return
	
	diretorio.list_dir_begin(true, true)
	var file_name := diretorio.get_next()
	while file_name != "":
		if file_name.get_extension() == "deck":
			item_files.append(file_name)
		file_name = diretorio.get_next()
		
	self.saves = item_files

func update():
	carregarListaArquivos()
