# jam-bunny

The Godot 4 scene I start every game jam from. A bunny that hops, some carrots
that appear, a number that goes up. That is the whole game. It exists because I
kept re-typing the same `CharacterBody2D` movement code at the start of every
48-hour jam and losing the first hour to it.

## What is in here

- `project.godot` — 320x180 viewport, `viewport` stretch so pixels stay square
  at any size. Uses the built-in `ui_*` actions, so there is no input map to
  merge into your own project.
- `main.tscn` — the whole game: player, floor, carrot container, score label.
  Opens with zero missing-resource errors.
- `player.gd` — hop movement with variable jump height and float-on-hold hang
  time. Emits `hopped`.
- `carrot_spawner.gd` — spawns a carrot every 1.4s, handles pickup by distance,
  drives the squash-and-stretch on the player sprite.

## Install

Requires Godot 4.2 or newer. No addons, no dependencies.

```
git clone https://github.com/poormikey80-create/jam-bunny.git
```

Open Godot, click Import, point it at `project.godot`, press F5 to run.

## Usage

Left and Right arrows move. Space hops. Hold Space at the top of a hop to hang
in the air a little longer. Walk into a carrot to collect it.

To turn this into your game: delete `carrot_spawner.gd`, keep `player.gd`, tune
the four constants at the top of it. That is the intended workflow.

## About the art

There is no art. The scene uses `PlaceholderTexture2D` at 16x16 so it runs on a
clean clone with no binary files in the repo.

The bunny I draw over it sits in the top ten rows of a 16x16 grid, where `.` is
transparent, `#` is outline, `o` is body and `*` is the eye:

```
. . . # # . . . . . . # # . . .
. . # o o # . . . . # o o # . .
. . # o o # . . . . # o o # . .
. . . # o o # # # o o # . . . .
. . . # o o o o o o o # . . . .
. . # o * o o o o * o o # . . .
. . # o o o o o o o o o # . . .
. . # o o o # # # o o o # . . .
. . . # o o o o o o o # . . . .
. . . . # # o o o # # . . . . .
```

Drop a real `bunny.png` next to the scene, swap the `texture` on the
`Sprite2D`, and delete this section.

## Licence

MIT. Use it, sell what you make with it, no credit needed.
