//
//  SWCharacterDetailVC.swift
//  swapi-ios
//
//  Created by Priscilla Ip on 2021-09-26.
//

import UIKit

class SWCharacterDetailVC: UIViewController {

    private var viewModel: SWViewModel

    private let character: SWCharacter

    init(viewModel: SWViewModel, character: SWCharacter) {
        self.viewModel = viewModel
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupViews()
        self.loadSWFilms()
    }

    private var tableView: UITableView = {
        return UITableView()
    }()

    fileprivate func setupViews() {
        self.navigationItem.title = self.character.name

        [tableView].forEach { self.view.addSubview($0) }
        self.setupLayouts()
        self.setupTableView()
    }

    fileprivate func setupLayouts() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        ])
    }

    fileprivate func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "characterDetailCell")
    }

    private func loadSWFilms() {
        self.viewModel.fetchFilms(for: self.character) {
            self.tableView.reloadData()
        }
    }
}

// MARK: -

extension SWCharacterDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterDetailCell", for: indexPath)

        var config = cell.defaultContentConfiguration()

        switch indexPath.row {

        case 0:
            config.text = "Date of Birth: \(self.character.birthYear)"

        case 1:
            config.text = "Gender: \(self.character.gender)"

        case 2:
            config.text = "Height: \(self.character.height)"

        case 3:
            config.text = "Mass: \(self.character.mass)"

        case 4:
            config.text = "Hair Color: \(self.character.hairColor)"

        case 5:
            config.text = "Skin Color: \(self.character.skinColor)"

        case 6:
            config.text = "Eye Color: \(self.character.eyeColor)"

        case 7:

            let films = self.viewModel.findFilms(for: self.character)

            let filmString = films.map {
                $0.title
            }.joined(separator: ", ")

            config.text = "Films: \(filmString)"

        default:
            config.text = ""
        }

        cell.contentConfiguration = config

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
}
