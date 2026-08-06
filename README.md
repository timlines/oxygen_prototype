# Oxygen for a Dying World — AI-Native UI Prototype

A Godot 4 prototype of an intent-driven command console that replaces
traditional nested pause menus. Press **Tab** in-game to open the console,
type what you want (`craft medkit`, `invite Kaylee`, `where am i`), press
Enter.

## Running it

1. Open the project folder in Godot 4.3+ (`project.godot`).
2. Press F5 (or click Run). `scenes/Main.tscn` is the main scene.
3. Move with WASD/arrows. Press **Tab** to open the console, **Esc** or
   **Tab** again to close it.

## Try these commands

```
help
inventory
oxygen
status
where am i
objectives
friends
craft medkit
equip pistol
invite Kaylee
lower music
settings
quit
```

## Architecture

The pipeline described in the design doc, implemented as five layers with
one job each:

```
Player Input (CommandConsole.gd)
      │  raw text
      ▼
Command Parser (core/CommandParser.gd)
      │  normalized text
      ▼
Intent Resolver (autoload/IntentResolverService.gd)
      │  → strategy: core/intent_resolution/KeywordIntentResolver.gd
      │  Intent { action, args, confidence, raw_text }
      ▼
Command Dispatcher (autoload/CommandDispatcher.gd)
      │  routes action -> exactly one system call
      ▼
Game Systems (systems/*.gd, via autoload/GameSystems.gd)
      InventorySystem · SuitStatusSystem · CraftingSystem
      FriendsSystem · ObjectivesSystem · SettingsSystem
```

**Why it's split this way:** no layer knows about the layer two steps away.
`CommandConsole` never touches a game system directly; `CraftingSystem`
never sees raw player text. The only class that changes when you plug in
an LLM is `IntentResolverService.resolver` — everything else is untouched,
because every resolver (keyword-based today, LLM-based later) only has to
produce an `Intent` object.

### Swapping in an LLM later

1. Write a new class extending `IntentResolverBase` (see
   `core/intent_resolution/KeywordIntentResolver.gd` for the shape) that
   calls out to a model and returns an `Intent`.
2. In `autoload/IntentResolverService.gd`, change the default `resolver`
   (or call `set_resolver()` at runtime).
3. Nothing in `CommandConsole`, `CommandDispatcher`, or any file under
   `systems/` needs to change.

### Adding a new command

1. Add a keyword mapping in `KeywordIntentResolver.gd` (or a case in an
   LLM prompt, later).
2. Add a `match` case in `CommandDispatcher._route()`.
3. Add or extend a system under `systems/` if it needs new state/logic.

## What's mocked

Every gameplay system holds placeholder in-memory data (see each file
under `systems/`) rather than real save data or networking, per the
project's non-goals. `FriendsSystem.invite()` just moves a name to a
pending list — there's no real multiplayer.

## Project layout

```
project.godot
icon.svg
scenes/
  Main.tscn              Player + camera + command console UI
scripts/
  Player.gd               Minimal WASD movement
  CommandConsole.gd        UI: open/close console, echo input, show output
core/
  Intent.gd                 Data contract between resolver and dispatcher
  CommandParser.gd           Text normalization only
  intent_resolution/
    IntentResolverBase.gd     Strategy interface
    KeywordIntentResolver.gd  MVP implementation (swap target for an LLM)
autoload/
  IntentResolverService.gd   Owns the active resolver strategy
  CommandDispatcher.gd       Routes Intent -> system call
  GameSystems.gd             Registry/factory for the systems below
systems/
  InventorySystem.gd, SuitStatusSystem.gd, CraftingSystem.gd,
  FriendsSystem.gd, ObjectivesSystem.gd, SettingsSystem.gd
```
