//
//  Team.swift
//  KLeague-Weather
//
//  Created by JunnKyuu on 7/24/25.
//

import Foundation

struct Team {
    let id: Int
    let name: String
    let league: League
    let logoURL: String
    let stadiumName: String
    let teamColor: String
    let nx: String
    let ny: String
}

enum League: String, CaseIterable {
    case kLeague1 = "K리그1"
    case kLeague2 = "K리그2"
}

struct TeamData {
    static let allTeams: [Team] = [
        // K리그1 (12개팀)
        Team(id: 1, name: "울산현대", league: .kLeague1, logoURL: "ulsan_logo", stadiumName: "울산문수축구경기장", teamColor: "ulsan_color", nx: "102", ny: "84"),
        Team(id: 2, name: "전북현대", league: .kLeague1, logoURL: "jeonbuk_logo", stadiumName: "전주월드컵경기장", teamColor: "jeonbuk_color", nx: "63", ny: "100"),
        Team(id: 3, name: "FC서울", league: .kLeague1, logoURL: "fcseoul_logo", stadiumName: "서울월드컵경기장", teamColor: "fcseoul_color", nx: "59", ny: "127"),
        Team(id: 4, name: "포항스틸러스", league: .kLeague1, logoURL: "pohang_logo", stadiumName: "포항스틸야드", teamColor: "pohang_color", nx: "102", ny: "95"),
        Team(id: 5, name: "대전하나시티즌", league: .kLeague1, logoURL: "daejeon_logo", stadiumName: "대전월드컵경기장", teamColor: "daejeon_color", nx: "68", ny: "100"),
        Team(id: 6, name: "대구FC", league: .kLeague1, logoURL: "daegu_logo", stadiumName: "DGB대구은행파크", teamColor: "daegu_color", nx: "89", ny: "91"),
        Team(id: 7, name: "안양FC", league: .kLeague1, logoURL: "anyang_logo", stadiumName: "안양종합운동장", teamColor: "anyang_color", nx: "60", ny: "122"),
        Team(id: 8, name: "강원FC", league: .kLeague1, logoURL: "gangwon_logo", stadiumName: "춘천송암스포츠타운", teamColor: "gangwon_color", nx: "75", ny: "130"),
        Team(id: 9, name: "광주FC", league: .kLeague1, logoURL: "gwangju_logo", stadiumName: "광주축구전용구장", teamColor: "gwangju_color", nx: "58", ny: "78"),
        Team(id: 10, name: "제주유나이티드", league: .kLeague1, logoURL: "jeju_logo", stadiumName: "제주월드컵경기장", teamColor: "jeju_color", nx: "52", ny: "33"),
        Team(id: 11, name: "수원FC", league: .kLeague1, logoURL: "suwonfc_logo", stadiumName: "수원종합운동장", teamColor: "suwonfc_color", nx: "61", ny: "121"),
        Team(id: 12, name: "김천상무", league: .kLeague1, logoURL: "gimcheon_logo", stadiumName: "김천종합운동장", teamColor: "gimcheon_color", nx: "76", ny: "106"),

        // K리그2 (14개팀)
        Team(id: 13, name: "수원삼성블루윙즈", league: .kLeague2, logoURL: "suwonsamsung_logo", stadiumName: "수원월드컵경기장", teamColor: "suwonsamsung_color", nx: "62", ny: "121"),
        Team(id: 14, name: "인천유나이티드", league: .kLeague2, logoURL: "incheon_logo", stadiumName: "인천축구전용구장", teamColor: "incheon_color", nx: "54", ny: "125"),
        Team(id: 15, name: "부천FC1995", league: .kLeague2, logoURL: "bucheon_logo", stadiumName: "부천종합운동장", teamColor: "bucheon_color", nx: "57", ny: "127"),
        Team(id: 16, name: "경남FC", league: .kLeague2, logoURL: "gyeongnam_logo", stadiumName: "창원축구센터", teamColor: "gyeongnam_color", nx: "90", ny: "77"),
        Team(id: 17, name: "김포FC", league: .kLeague2, logoURL: "gimpo_logo", stadiumName: "김포종합운동장", teamColor: "gimpo_color", nx: "62", ny: "130"),
        Team(id: 18, name: "성남FC", league: .kLeague2, logoURL: "seongnam_logo", stadiumName: "탄천종합운동장", teamColor: "seongnam_color", nx: "63", ny: "123"),
        Team(id: 19, name: "서울이랜드FC", league: .kLeague2, logoURL: "seoul_eland_logo", stadiumName: "목동종합운동장", teamColor: "seoul_eland_color", nx: "58", ny: "126"),
        Team(id: 20, name: "안산그리너스", league: .kLeague2, logoURL: "ansan_logo", stadiumName: "안산와스타디움", teamColor: "ansan_color", nx: "57", ny: "122"),
        Team(id: 21, name: "아산무궁화", league: .kLeague2, logoURL: "asan_logo", stadiumName: "이순신종합운동장", teamColor: "asan_color", nx: "60", ny: "109"),
        Team(id: 22, name: "천안시티FC", league: .kLeague2, logoURL: "cheonan_logo", stadiumName: "천안종합운동장", teamColor: "cheonan_color", nx: "64", ny: "110"),
        Team(id: 23, name: "부산아이파크", league: .kLeague2, logoURL: "busan_logo", stadiumName: "부산아시아드주경기장", teamColor: "busan_color", nx: "98", ny: "76"),
        Team(id: 24, name: "전남드래곤즈", league: .kLeague2, logoURL: "jeonnam_logo", stadiumName: "광양축구전용구장", teamColor: "jeonnam_color", nx: "70", ny: "70"),
        Team(id: 25, name: "청주FC", league: .kLeague2, logoURL: "cheongju_logo", stadiumName: "청주종합운동장", teamColor: "cheongju_color", nx: "71", ny: "103"),
        Team(id: 26, name: "화성FC", league: .kLeague2, logoURL: "hwaseong_logo", stadiumName: "화성종합운동장", teamColor: "hwaseong_color", nx: "57", ny: "117")
    ]
}
