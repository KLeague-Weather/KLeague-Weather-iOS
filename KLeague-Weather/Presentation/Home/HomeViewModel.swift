//
//  HomeViewModel.swift
//  KLeague-Weather
//
//  Created by JunnKyuu on 7/24/25.
//

import Foundation

class HomeViewModel {
    // MARK: - properties
    private var teams: [Team] = TeamData.allTeams
    private var _filteredTeams: [Team] = []
    private var _selectedLeague: League = .kLeague1
    
    // MARK: - computed properties
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
    
    // MARK: - public method
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
    
    // MARK: - private method
    private func filterTeams(by league: League) {
        filteredTeams = teams.filter { $0.league == league }
    }
}
