//
//  DataService.swift
//  Inspiration App
//
//  Created by Nikita Koniukh on 10/05/2020.
//  Copyright © 2020 Nikita Koniukh. All rights reserved.
//

import Foundation

struct DataService {
    static let instance = DataService()

    private let motivations = [
        Motivation(description: "Мечтай, о чем хочешь; иди  куда хочешь идти; будь с тем, с кем ты хочешь быть, потому что у тебя только одна жизнь и только один шанс…", motivationDate: "1", id: 1),
        Motivation(description: "Засыпай с мечтой - просыпайся с целью ", motivationDate: "2", id: 2),
        Motivation(description: "Научись никому, ничего не рассказывать. У вас тогда все будет хорошо.", motivationDate: "3", id: 3),
        Motivation(description: "Не сдавайся, ты не видишь всей картины, которую тебе рисует Бог.", motivationDate: "4", id: 4),
        Motivation(description: "Тому, кто умеет ждать всегда достаётся самое лучшее.", motivationDate: "5", id: 5),
        Motivation(description: "Главное - верить в себя. Мнение окружающих меняется ежедневно.", motivationDate: "6", id: 6),
        Motivation(description: "Научись никогда ни от кого ничего не ждать .", motivationDate: "7", id: 7),
        Motivation(description: "Только действия человека говорят о его личности и его отношения к вам. Не верьте словам. Наблюдайте и вы увидите истину.", motivationDate: "8", id: 8),
        Motivation(description: "Не бывает ленивых победителей .", motivationDate: "9", id: 9),
        Motivation(description: "Следуй за своим сердцем, но не забудь взять свой ум. ", motivationDate: "10", id: 10),
        Motivation(description: "Каждый новый день - еще один шанс изменить свою жизнь.", motivationDate: "11", id: 11),
        Motivation(description: "Трудности - это не наказание за прошлое, а испытания ради будущего. ", motivationDate: "12", id: 12),
        Motivation(description: "Измени образ мышления и изменишь свою жизнь.", motivationDate: "13", id: 13),
        Motivation(description: "Делай добро и добро к тебе вернется .", motivationDate: "14", id: 14),
        Motivation(description: "Все правильные мысли приходят только после того, как эмоции заканчиваются.", motivationDate: "15", id: 15),
        Motivation(description: "Я все равно ни о чем не жалею - хотя бы потому, что это бессмысленно. \nЭльчин Сафарли ", motivationDate: "16", id: 16),
        Motivation(description: "Настоящая сила рождается в голове. Она заставляет идти, даже когда тело хочет упасть. ", motivationDate: "17", id: 17),
        Motivation(description: "Я думал, друзей теряют в ссорах, а они просто растворяются в делах, деньгах и времени. \nБернард Шоу", motivationDate: "18", id: 18),
        Motivation(description: "Не ищите лучше, а ищите свое, ведь лучшее не всегда станет вашим, за то свое - всегда лучше. ", motivationDate: "19", id: 19),
        Motivation(description: "Путь наверх тяжел, за то вид хороший.", motivationDate: "20", id: 20)


    ]

    func getMotivations() -> [Motivation]{
        return motivations
    }
}
