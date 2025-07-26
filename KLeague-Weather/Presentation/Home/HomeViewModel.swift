//
//  HomeViewModel.swift
//  KLeague-Weather
//
//  Created by JunnKyuu on 7/24/25.
//

import Foundation

class HomeViewModel {
    // MARK: - 프로퍼티
    private var teams: [Team] = TeamData.allTeams
    private var _filteredTeams: [Team] = []
    private var _selectedLeague: League = .kLeague1
    
    // MARK: - 계산 프로퍼티
    var filteredTeams: [Team] {
        get { _filteredTeams }
        set { _filteredTeams = newValue }
    }
    
    var selectedLeague: League {
        get { _selectedLeague }
        set { _selectedLeague = newValue }
    }
    
    // MARK: - 초기화
    init() {
        filterTeams(by: selectedLeague)
    }
    
    // MARK: - 공개 메서드
    func selectLeague(_ league: League) {
        selectedLeague = league
        filterTeams(by: league)
    }
    
    func getTeam(at index: Int) -> Team? {
        guard index >= 0 && index < filteredTeams.count else { return nil }
        return filteredTeams[index]
    }
    
    func getFilteredTeamsCount() -> Int {
        return filteredTeams.count
    }
    
    // MARK: - 비공개 메서드
    private func filterTeams(by league: League) {
        filteredTeams = teams.filter { $0.league == league }
    }
}
