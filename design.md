# Oxygen for a Dying World

## AI-Native User Interface Prototype

### Godot 4 Game Design Prompt

## Project Goal

Build a prototype in **Godot 4** that explores an AI-native user interface for games.

The objective is **not** to build a complete survival game. The objective is to prove that a traditional game interface can be replaced with a command-driven interface that understands player intent.

This prototype should prioritize clean architecture, modular systems, and future AI integration.

---

# Core Philosophy

Traditional games require players to learn menu structures.

Example:

Pause Menu
→ Inventory
→ Crafting
→ Social
→ Friends
→ Invite Friend

This project reverses that philosophy.

The player should never need to know where something is located.

Instead, they simply communicate what they want.

Examples:

> invite Kaylee

> show oxygen

> craft medkit

> equip rifle

> lower music

> where am I?

The interface should determine the player's intent and perform the requested action.

The user interface should feel closer to ChatGPT, Spotlight Search, Raycast, or a command palette than a traditional pause menu.

---

# Design Goals

* Minimize traditional menus.
* Replace menu navigation with intent-based interaction.
* Keep immersion high.
* Reduce cognitive load.
* Make every system accessible through natural language.
* Build a foundation for future AI companions.

---

# Platform

Engine:
Godot 4.x

Language:
GDScript

Architecture:
Component-based and modular.

---

# Initial MVP

The prototype should contain a minimal playable environment.

Required systems:

* Player movement
* Camera
* Pause/Command Menu
* Intent Parser
* Command Dispatcher
* Mock game systems

The world itself can be extremely simple.

The focus is the interface.

---

# Command Console

Pressing Tab (or Start on controller) opens a command prompt.

Example

> _

The player types commands.

Commands should execute immediately after pressing Enter.

---

# Example Commands

help

inventory

oxygen

status

where am I

craft medkit

equip pistol

invite Kaylee

settings

quit

---

# Command Pipeline

The architecture should be separated into layers.

Player Input

↓

Command Parser

↓

Intent Resolver

↓

Command Dispatcher

↓

Game System

Each layer should have a single responsibility.

No gameplay system should parse player text directly.

---

# Intent System

Initially, use keyword matching.

Example

"oxygen"

"o2"

"air"

"breathing"

"suit oxygen"

↓

ShowOxygenStatus()

Later this system can be replaced with an LLM without changing the gameplay systems.

Design this layer so it can easily swap implementations.

---

# Mock Systems

Create placeholder systems for:

Inventory

Suit Status

Crafting

Friends

Objectives

Settings

These do not need full functionality.

Simple mock data is acceptable.

Example:

Inventory

* Medkit x2
* Water x5
* Iron x12

---

# Response Style

Responses should appear like a terminal.

Example

> oxygen

Suit Status

Oxygen........84%

Estimated Time Remaining

31 minutes

Pressure Stable

---

# Future AI Compatibility

Design the architecture assuming an LLM will eventually replace the keyword parser.

Future examples:

"I keep running out of oxygen."

↓

AI understands:

Show Oxygen

Open Crafting

Recommend Oxygen Filter

Pin Required Resources

The gameplay systems should not need modification when this occurs.

---

# Long-Term Vision

Eventually every interaction in the game should be possible through intent.

Examples:

Navigation

Inventory

Crafting

Objectives

Friends

Settings

Equipment

Dialogue

Trading

Vehicles

Research

Quest Tracking

Map

Accessibility

HUD customization

Everything should be accessible through one unified interface.

---

# Non-Goals

Do not focus on graphics.

Do not optimize prematurely.

Do not build large gameplay systems.

Do not implement networking.

Do not implement online friends.

The prototype exists to validate the interface architecture.

---

# Code Quality

Use descriptive class names.

Separate systems into individual scripts.

Document major systems.

Avoid hard-coded dependencies.

Favor composition over inheritance.

Design for future expansion.

---

# Success Criteria

The prototype is successful if a player can interact with multiple gameplay systems using only the command console, without navigating traditional nested menus.

The architecture should make replacing the keyword parser with an AI model straightforward, allowing the interface to evolve into a fully conversational game companion.
