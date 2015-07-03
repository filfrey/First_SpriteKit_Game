//
//  Character.swift
//  Not Like You
//
//  Created by Jeffrey Lin on 7/2/15.
//  Copyright (c) 2015 Jeffrey Lin. All rights reserved.
//

import Foundation

protocol SharedAssets {
    static func loadSharedAssets()
}

enum CharacterType {
    case Hero, LineEnemy, WavyEnemy, Coin
}

func inferCharacterType(fromType: Sprite.Type) -> CharacterType {
    switch fromType {
    case is Hero.Type:
        return CharacterType.Hero
    case is LineEnemy.Type:
        return CharacterType.LineEnemy
    case is WavyEnemy.Type:
        return CharacterType.WavyEnemy
    case is CoinSprite.Type:
        return CharacterType.Coin
    default:
        fatalError("Unknown type provided for \(__FUNCTION__).")
    }
}
