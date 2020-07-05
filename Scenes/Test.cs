using Godot;
using System;

public class Test : Node2D
{
	// Declare member variables here. Examples:
	// private int a = 2;
	// private string b = "text";

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(float delta)
	{
		if(Input.IsActionPressed("click")) {
			GD.Print("Mouse Motion at: ", GetViewport().GetMousePosition());

			PackedScene scene = ResourceLoader.Load("res://Block.tscn") as PackedScene;
			Node2D block = scene.Instance() as Node2D;
			AddChild(block);
			Node2D player = GetNode("/root/Test/Player2D") as Node2D;
			block.Position = player.GetViewport().GetMousePosition() - new Vector2(512, 300);
		}
	}
}
