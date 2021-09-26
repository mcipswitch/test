//
//  SWViewModel.swift
//  swapi-ios
//
//  Created by Priscilla Ip on 2021-09-26.
//

import Foundation

class SWViewModel {

    var apiClient = APIClient()

    private var characters = [SWCharacter]()
    private var films = [SWCharacter: [SWFilm]]()

    func fetchCharacters(url: URL?, completion: @escaping () -> Void) {
        self.apiClient.fetch(url: url, dataType: SWRootResponse.self) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                if let nextPageURL = response.next {
                    self.fetchCharacters(url: nextPageURL) {
                        completion()
                    }
                }

                self.characters.append(contentsOf: response.results)

                completion()

            case .failure(let error):
                print("Error processing json data: \(error.localizedDescription)")
            }
        }
    }

    func fetchFilms(for character: SWCharacter, completion: @escaping () -> Void) {
        self.films[character] = []

        character.films.forEach {
            self.apiClient.fetch(url: $0, dataType: SWFilm.self) { result in
                switch result {
                case .success(let response):
                    self.films[character]?.append(response)
                    completion()

                case .failure(let error):
                    print("Error processing json data: \(error.localizedDescription)")
                }
            }
        }
    }

    // MARK: - TableView

    func numberOfRowsInSection(section: Int) -> Int {
        if self.characters.count != 0 {
            return self.characters.count
        } else {
            return 0
        }
    }

    func cellForRowAt(indexPath: IndexPath) -> SWCharacter {
        self.characters[indexPath.row]
    }

    func findFilms(for character: SWCharacter) -> [SWFilm] {
        self.films[character] ?? []
    }
}
