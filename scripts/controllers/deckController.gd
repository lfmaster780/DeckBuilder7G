extends Node
#GALAXIA DEPENDENTE
var galaxia : String
var deck := []
var nome : String
var total : int
var fortaleza : Fortaleza

func _ready():
	novo()
	
func novo():
	deck = []
	total = 0
	nome = ""
	galaxia = ""
	
func adicionar(card : Card, mode = 0):
	#mode diferente de 0 quer dizer que é um card novo
	if mode != 0:
		var novaCarta = Carta.new(card)
		deck.append(novaCarta)
		total += 1
		return 1
		
	for item in deck:
		if card.ID == item.ID:
			item.adicionar()
			total += 1
			return 0
			
func retirar(card : Card):
	var cont = 0
	
	for item in deck:
		if card.ID == item.ID:
			var ret = item.retirar()
			#Diminuindo o total de cartas do deck
			total -= 1
			if ret == 0:
				deck.remove(cont)
				return 0
			else:
				return 1
				
		cont += 1

func quantidade(card: Card):
	for carta in deck:
		if carta.card.ID == card.ID:
			return carta.quantidade
			
	return 0

func salvar(pathPersonalizado : String):
	
	var file_path := pathPersonalizado + self.nome + ".deck"
	var file = File.new()
	file.open(file_path, File.WRITE)
	
	file.store_var(galaxia)
	file.store_var(nome)
	file.store_32(total)
	file.store_32(deck.size())
	
	for cardDeck in deck:
		
		file.store_32(cardDeck.quantidade)
		#file.store_var(cardDeck.ID)
		var card = cardDeck.card
		# Salva as variáveis da classe Card
		file.store_var(card.ID)
		file.store_var(card.Nome)
		file.store_var(card.Tipo)
		file.store_var(card.Filiacao)
		file.store_var(card.CustoNivel)
		file.store_var(card.Efeitos)
		file.store_var(card.TipoEfeitos)
		file.store_var(card.CustoEnergia)
		file.store_var(card.Vida)
		file.store_var(card.Ataque)
		file.store_var(card.Escudo)
		file.store_var(card.ContraAtaque)
		file.store_var(card.Alcance)
		file.store_var(card.Intuicao)
		file.store_var(card.Agilidade)
		file.store_var(card.Multiataque)
		file.store_var(card.Oculto)
		file.store_var(card.AlvoPrimario)
		file.store_var(card.Voador)
		file.store_var(card.SuperVelocidade)
		file.store_var(card.Teletransporte)
		file.store_var(card.EspecialID)
		
	file.store_var(fortaleza.ID)
	file.close()
	AppController.update()

func carregar(path : String):
	self.novo()
	var file = File.new()
	if not file.file_exists(path):
		print_debug("Arquivo não existe")
	file.open(path, File.READ)
	
	self.galaxia = file.get_var()
	#self.deck = file.get_var()
	self.nome = file.get_var()
	self.total = file.get_32()
	var tamanho = file.get_32()
	
	var string = "Galaxia: %s Nome: %s Total: %d" % [galaxia,nome,total]
	for k in range(tamanho):
		var qtd = file.get_32()
		#var id = file.get_var()
		var card = Card.new()
		#CARREGA OS ATRIBUTOS DE CARD
		card = Card.new()
		card.ID = file.get_var()
		card.Nome = file.get_var()
		card.Tipo = file.get_var()
		card.Filiacao = file.get_var()
		card.CustoNivel = file.get_var()
		card.Efeitos = file.get_var()
		card.TipoEfeitos = file.get_var()
		card.CustoEnergia = file.get_var()
		card.Vida = file.get_var()
		card.Ataque = file.get_var()
		card.Escudo = file.get_var()
		card.ContraAtaque = file.get_var()
		card.Alcance = file.get_var()
		card.Intuicao = file.get_var()
		card.Agilidade = file.get_var()
		card.Multiataque = file.get_var()
		card.Oculto = file.get_var()
		card.AlvoPrimario = file.get_var()
		card.Voador = file.get_var()
		card.SuperVelocidade = file.get_var()
		card.Teletransporte = file.get_var()
		card.EspecialID = file.get_var()
		
		# Lê a textura do arquivo
		#var imagem = Image.new()
		#var buffer = file.get_buffer()
		#var textura = imagem.load_png_from_buffer(buffer)
		var img : Card
		if galaxia.to_lower() == "gaia":
			img = CardsController.buscarID(card.ID,CardsController.listaGaia)
		elif galaxia.to_lower() == "stroj":
			img = CardsController.buscarID(card.ID,CardsController.listaStroj)
		elif galaxia.to_lower() == "majik":
			img = CardsController.buscarID(card.ID,CardsController.listaMajik)
		elif galaxia.to_lower() == "adroit":
			img = CardsController.buscarID(card.ID,CardsController.listaAdroit)
		else:
			print_debug("Galaxia inexistente no momento")
		
		var textura = img.textura
		card.textura = textura
		
		var carta = Carta.new(card)
		carta.quantidade = qtd
		
		self.deck.append(carta)
	var idFortaleza = file.get_var()
	if idFortaleza != null:
		self.fortaleza = CardsController.buscarFortalezaID(idFortaleza)
	else:
		if galaxia.to_lower() == "gaia":
			self.fortaleza = CardsController.buscarFortalezaID("F2")
		elif galaxia.to_lower() == "stroj":
			self.fortaleza = CardsController.buscarFortalezaID("F1")
		elif galaxia.to_lower() == "majik":
			self.fortaleza = CardsController.buscarFortalezaID("")
		elif galaxia.to_lower() == "adroit":
			self.fortaleza = CardsController.buscarFortalezaID("")
	
	file.close()
		
