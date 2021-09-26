//
//  ViewController.swift
//  swapi-ios
//
//  Created by Priscilla Ip on 2021-09-26.
//

import UIKit

class SWCharacterVC: UIViewController {

    private var swViewModel = SWViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupViews()
        self.loadSWCharacters()
    }

    private var tableView: UITableView = {
        return UITableView()
    }()

    fileprivate func setupViews() {
        self.navigationItem.title = "Star Wars Characters"

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
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "characterCell")
    }

    private func loadSWCharacters() {
        self.swViewModel.fetchCharacters(url: nil) { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}

// MARK: -

extension SWCharacterVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
        let character = self.swViewModel.cellForRowAt(indexPath: indexPath)

        var config = cell.defaultContentConfiguration()
        config.text = character.name
        cell.contentConfiguration = config

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.swViewModel.numberOfRowsInSection(section: section)
    }

    // MARK: - Delegate Methods

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = self.swViewModel.cellForRowAt(indexPath: indexPath)
        let swCharacterDetailVC = SWCharacterDetailVC(viewModel: self.swViewModel, character: character)
        navigationController?.pushViewController(swCharacterDetailVC, animated: true)
    }
}
