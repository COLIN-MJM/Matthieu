@abstract
class_name PlayerState
extends Node

@export var player : NewPlayer
@export var linkedButtons : Control
@export var indicativeText : RichTextLabel

@abstract func OnEnter() -> void
@abstract func OnUpdate() -> void
@abstract func OnExit() -> void
