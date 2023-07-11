class_name Fortaleza
extends Resource
#Classe que representa as cartas de fortaleza

export var ID : String
export var Nome : String
export var Galaxia : String
export(PoolStringArray) var Efeitos := []
export(PoolStringArray) var TipoEfeitos := []
export(PoolIntArray) var CustoEnergia := []
export var Vida : int
export var textura : Texture
