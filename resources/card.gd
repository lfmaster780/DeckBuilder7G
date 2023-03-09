class_name Card
extends Resource


export var ID : int
export var Nome : String
export var Tipo : String
export(PoolStringArray) var Filiacao := []
export var CustoNivel : int
export(PoolStringArray) var Efeitos := []
export(PoolStringArray) var TipoEfeitos := []
export(PoolIntArray) var CustoEnergia := []
export var Vida : int
export var Ataque : int
export var Escudo : int
export var ContraAtaque : int
export var Alcance := 1
export var Intuicao : bool
export var Agilidade := -1
#1 para inimigo a esquerda, 2 para direita, 3 para esquerda atrás, 5 direita atrás,4 para atrás
export var Multiataque := -1 #-1 se nao tiver
export var Oculto : bool
export var AlvoPrimario : bool
export var Voador : bool
export var SuperVelocidade : bool
export var Teletransporte : bool
export var EspecialID : int
export var textura : Texture
