//
//  GithubService.swift
//  GithubFollowers
//
//  Created by qwerty on 19.06.2024.
//


import Foundation
import Combine

class GitHubService: ObservableObject {
    @Published var followers: [GitHubUser] = []
    @Published var following: [GitHubUser] = []
    @Published var notFollowingBack: [GitHubUser] = []
    @Published var notFollowedBack: [GitHubUser] = []

    @Published var userId: Int? // Username'in id'si
    @Published var avatarUrl: String? // Username'in avatar URL'si

    private var cancellables = Set<AnyCancellable>()
    
    func fetchFollowers(for username: String) {
        guard let url = URL(string: "https://api.github.com/users/\(username)/followers") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [GitHubUser].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.followers = $0
                self?.calculateNotFollowingBack()
                self?.calculateNotFollowedBack()
            }
            .store(in: &cancellables)
    }
    
    func fetchFollowing(for username: String) {
        guard let url = URL(string: "https://api.github.com/users/\(username)/following") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [GitHubUser].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.following = $0
                self?.calculateNotFollowingBack()
                self?.calculateNotFollowedBack()
            }
            .store(in: &cancellables)
    }
    
    private func calculateNotFollowingBack() {
        notFollowingBack = followers.filter { follower in
            !following.contains { $0.id == follower.id }
        }
    }
    
    private func calculateNotFollowedBack() {
        notFollowedBack = following.filter { followee in
            !followers.contains { $0.id == followee.id }
        }
    }

    // Username'in id'si ve avatar_url'si için fetch işlemi
    func fetchUserIdAndAvatar(for username: String) {
        guard let url = URL(string: "https://api.github.com/users/\(username)") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: GitHubUser.self, decoder: JSONDecoder())
            .replaceError(with: GitHubUser(id: 0, login: "", avatar_url: nil)) // Varsayılan değer, hata durumunda
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                self?.userId = user.id
                self?.avatarUrl = user.avatar_url
            }
            .store(in: &cancellables)
    }
}
