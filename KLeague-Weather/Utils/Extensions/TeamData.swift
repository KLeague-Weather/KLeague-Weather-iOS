//
//  TeamData.swift
//  KLeague-Weather
//
//  Created by JunnKyuu on 7/24/25.
//

import Foundation

struct TeamData {
    static let allTeams: [Team] = [
        // K리그1 (12개팀)
        Team(id: 1, name: "울산현대", league: .kLeague1, logoURL: "ulsan_logo", stadiumName: "울산문수축구경기장", latitude: 35.53528362, longitude: 129.2595358),
        Team(id: 2, name: "전북현대", league: .kLeague1, logoURL: "jeonbuk_logo", stadiumName: "전주월드컵경기장", latitude: 35.86812937, longitude: 127.0644898),
        Team(id: 3, name: "FC서울", league: .kLeague1, logoURL: "fcseoul_logo", stadiumName: "서울월드컵경기장", latitude: 37.56825004, longitude: 126.8972437),
        Team(id: 4, name: "포항스틸러스", league: .kLeague1, logoURL: "pohang_logo", stadiumName: "포항스틸야드", latitude: 35.99772228, longitude: 129.3844152),
        Team(id: 5, name: "대전하나시티즌", league: .kLeague1, logoURL: "daejeon_logo", stadiumName: "대전월드컵경기장", latitude: 36.36517109, longitude: 127.3251387),
        Team(id: 6, name: "대구FC", league: .kLeague1, logoURL: "daegu_logo", stadiumName: "DGB대구은행파크", latitude: 35.88124947, longitude: 128.5882427),
        Team(id: 7, name: "안양FC", league: .kLeague1, logoURL: "anyang_logo", stadiumName: "안양종합운동장", latitude: 37.40532631, longitude: 126.9464811),
        Team(id: 8, name: "강원FC", league: .kLeague1, logoURL: "gangwon_logo", stadiumName: "춘천송암스포츠타운", latitude: 37.85480848, longitude: 127.6919356),
        Team(id: 9, name: "광주FC", league: .kLeague1, logoURL: "gwangju_logo", stadiumName: "광주축구전용구장", latitude: 35.13368229, longitude: 126.874895),
        Team(id: 10, name: "제주유나이티드", league: .kLeague1, logoURL: "jeju_logo", stadiumName: "제주월드컵경기장", latitude: 33.24615163, longitude: 126.5093811),
        Team(id: 11, name: "수원FC", league: .kLeague1, logoURL: "suwonfc_logo", stadiumName: "수원종합운동장", latitude: 37.29775504, longitude: 127.0113609),
        Team(id: 12, name: "김천상무", league: .kLeague1, logoURL: "gimcheon_logo", stadiumName: "김천종합운동장", latitude: 36.13967662, longitude: 128.0864244),

        // K리그2 (14개팀)
        Team(id: 13, name: "수원삼성블루윙즈", league: .kLeague2, logoURL: "suwonsamsung_logo", stadiumName: "수원월드컵경기장", latitude: 37.28649766, longitude: 127.0369207),
        Team(id: 14, name: "인천유나이티드", league: .kLeague2, logoURL: "incheon_logo", stadiumName: "인천축구전용구장", latitude: 37.46616287, longitude: 126.6430076),
        Team(id: 15, name: "부천FC1995", league: .kLeague2, logoURL: "bucheon_logo", stadiumName: "부천종합운동장", latitude: 37.50254894, longitude: 126.7990104),
        Team(id: 16, name: "경남FC", league: .kLeague2, logoURL: "gyeongnam_logo", stadiumName: "창원축구센터", latitude: 35.22337362, longitude: 128.7057039),
        Team(id: 17, name: "김포FC", league: .kLeague2, logoURL: "gimpo_logo", stadiumName: "김포종합운동장", latitude: 37.6408458, longitude: 126.6499675),
        Team(id: 18, name: "성남FC", league: .kLeague2, logoURL: "seongnam_logo", stadiumName: "탄천종합운동장", latitude: 37.41018493, longitude: 127.1213311),
        Team(id: 19, name: "서울이랜드FC", league: .kLeague2, logoURL: "seoul_eland_logo", stadiumName: "목동종합운동장", latitude: 37.53072914, longitude: 126.8820987),
        Team(id: 20, name: "안산그리너스", league: .kLeague2, logoURL: "ansan_logo", stadiumName: "안산와스타디움", latitude: 37.31934057, longitude: 126.8186445),
        Team(id: 21, name: "아산무궁화", league: .kLeague2, logoURL: "asan_logo", stadiumName: "이순신종합운동장", latitude: 36.76818685, longitude: 127.0216216),
        Team(id: 22, name: "천안시티FC", league: .kLeague2, logoURL: "cheonan_logo", stadiumName: "천안종합운동장", latitude: 36.81879375, longitude: 127.1150742),
        Team(id: 23, name: "부산아이파크", league: .kLeague2, logoURL: "busan_logo", stadiumName: "부산아시아드주경기장", latitude: 35.19008279, longitude: 129.0583325),
        Team(id: 24, name: "전남드래곤즈", league: .kLeague2, logoURL: "jeonnam_logo", stadiumName: "광양축구전용구장", latitude: 34.93311239, longitude: 127.7274829),
        Team(id: 25, name: "청주FC", league: .kLeague2, logoURL: "cheongju_logo", stadiumName: "청주종합운동장", latitude: 36.63782521, longitude: 127.472366),
        Team(id: 26, name: "화성FC", league: .kLeague2, logoURL: "hwaseong_logo", stadiumName: "화성종합운동장", latitude: 37.173611, longitude: 126.837222)
    ]
} 
