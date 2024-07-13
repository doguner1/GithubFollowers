//
//  GithubService.swift
//  GithubFollowers
//
//  Created by qwerty on 19.06.2024.
//

import Foundation
import Combine

struct GitHubRepository: Decodable {
    let name: String
}

class GitHubService: ObservableObject {
    @Published var followers: [GitHubUser] = []
    @Published var userRepos: [GitHubUser] = []
    @Published var following: [GitHubUser] = []
    @Published var notFollowingBack: [GitHubUser] = []
    @Published var notFollowedBack: [GitHubUser] = []
    @Published var userId: Int?
    @Published var avatarUrl: String?
    @Published var repositoryNames: [String] = []

    private var cancellables = Set<AnyCancellable>()

    func fetchFollowers(for username: String) {
        fetchUsers(for: username, endpoint: "followers") { [weak self] users in
            self?.followers = users
            self?.calculateNotFollowingBack()
            self?.calculateNotFollowedBack()
        }
    }
    
    func fetchUserRepos(for username: String) {
        guard let url = URL(string: "https://api.github.com/users/\(username)/repos") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [GitHubRepository].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] repositories in
                self?.repositoryNames = repositories.map { $0.name }
            }
            .store(in: &cancellables)
    }

    func fetchFollowing(for username: String) {
        fetchUsers(for: username, endpoint: "following") { [weak self] users in
            self?.following = users
            self?.calculateNotFollowingBack()
            self?.calculateNotFollowedBack()
        }
    }

    private func fetchUsers(for username: String, endpoint: String, completion: @escaping ([GitHubUser]) -> Void) {
        var allUsers: [GitHubUser] = []
        var page = 1
        var shouldContinue = true

        func fetchUsersPage(page: Int) {
            guard let url = URL(string: "https://api.github.com/users/\(username)/\(endpoint)?page=\(page)&per_page=100") else {
                shouldContinue = false
                return
            }

            URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: [GitHubUser].self, decoder: JSONDecoder())
                .replaceError(with: [])
                .receive(on: DispatchQueue.main)
                .sink { users in
                    allUsers.append(contentsOf: users)

                    if users.count == 100 { // Assuming per_page is 100
                        fetchUsersPage(page: page + 1)
                    } else {
                        shouldContinue = false
                        completion(allUsers)
                    }
                }
                .store(in: &cancellables)
        }

        fetchUsersPage(page: page)
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

    func fetchUserIdAndAvatar(for username: String) {
        guard let url = URL(string: "https://api.github.com/users/\(username)") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: GitHubUser.self, decoder: JSONDecoder())
            .replaceError(with: GitHubUser(id: 0, login: "", avatar_url: nil))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                self?.userId = user.id
                self?.avatarUrl = user.avatar_url
            }
            .store(in: &cancellables)
    }
}


