//
//  GithubUser.swift
//  GithubFollowers
//
//  Created by qwerty on 19.06.2024.
//


struct GitHubUser: Codable, Identifiable {
    let id: Int
    let login: String
    let avatar_url: String?
}
