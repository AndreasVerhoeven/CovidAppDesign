//
//  StatusViewController.swift
//  CovidDesign
//
//  Created by Andreas Verhoeven on 01/06/2020.
//  Copyright © 2020 Andreas Verhoeven. All rights reserved.
//

import UIKit

class StatusViewController: UITableViewController {
	var headerView: StatusHeaderView!

	enum Section: Int, CaseIterable {
		case main
		case about
	}

	enum MainRow: Int, CaseIterable {
		case selfTest
		case requestTest
	}

	enum AboutRow: Int, CaseIterable {
		case howDoesItWork
		case settings
	}

	init() {
		super.init(style: .insetGrouped)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Private
	private func updateStatus(animated: Bool) {
		guard isViewLoaded == true else {return}
		headerView.statusTitleLabel.setText(NSLocalizedString("status_active_title", comment: ""), animated: animated)
		headerView.statusTextLabel.setText(NSLocalizedString("status_active_text", comment: ""), animated: animated)
		tableView.updateTableViewHeader(headerView, animated: animated)
	}

	// MARK: Notifications
	@objc private func invertColorsStatusDidChangeNotification(_ notification: Notification) {
		setNeedsStatusBarAppearanceUpdate()
	}

	//MARK: - UIViewController
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		tableView.reloadData()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.cellLayoutMarginsFollowReadableWidth = true
		tableView.backgroundColor = .systemBackground
		tableView.separatorColor = .systemBackground
		tableView.register(CustomTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "Header")
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

		headerView = StatusHeaderView()
		headerView.translatesAutoresizingMaskIntoConstraints = false
		updateStatus(animated: false)

		navigationItem.standardAppearance = UINavigationBarAppearance()
		navigationItem.compactAppearance = UINavigationBarAppearance()
		navigationItem.standardAppearance?.configureWithTransparentBackground()
		navigationItem.compactAppearance?.configureWithTransparentBackground()

		NotificationCenter.default.addObserver(self, selector: #selector(invertColorsStatusDidChangeNotification(_:)), name: UIAccessibility.invertColorsStatusDidChangeNotification, object: nil)
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		headerView.insetsToCompensateFor = tableView.safeAreaInsets
		headerView.offsetToCompensateFor = tableView.contentOffset
		tableView.updateTableViewHeader(headerView)
	}

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return (UIAccessibility.isInvertColorsEnabled == true ? .darkContent : .lightContent)
	}
}

class RoundRectImageView: UIImageView {
	override func layoutSubviews() {
		layer.cornerRadius = bounds.width * 0.5
	}
}

// MARK: - UITableViewDataSource
extension StatusViewController {
	override func numberOfSections(in tableView: UITableView) -> Int {
		return Section.allCases.count
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch Section(rawValue: section)! {
			case .main: return MainRow.allCases.count
			case .about: return AboutRow.allCases.count
		}
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel?.font = .customFont(.tableRow)
		cell.accessoryType = .disclosureIndicator
		cell.backgroundColor = .secondarySystemGroupedBackground

		switch self.traitCollection.userInterfaceStyle {
			case .unspecified, .light: cell.backgroundColor = .systemGroupedBackground
			case .dark: cell.backgroundColor = .secondarySystemGroupedBackground
			@unknown default: break
		}

		switch Section(rawValue: indexPath.section)! {
			case .main:
				switch MainRow(rawValue: indexPath.row)! {
					case .selfTest:
						cell.textLabel?.text = NSLocalizedString("status_menu_self_test", comment: "")
						cell.imageView?.image = UIImage.circle(with: "eyedropper.full", color: .iconPurple, size: 32)
					
					case .requestTest:
						cell.textLabel?.text = NSLocalizedString("status_menu_request_test", comment: "")
						cell.imageView?.image = UIImage.circle(with: "staroflife.fill", color: .iconPink, size: 32)
				}

			case .about:
				switch AboutRow(rawValue: indexPath.row)! {
					case .howDoesItWork:
						cell.textLabel?.text = NSLocalizedString("status_menu_how_does_it_work", comment: "")
						cell.imageView?.image = UIImage.circle(with: "doc.text.fill", color: .iconYellow, size: 32)

					case .settings:
						cell.textLabel?.text = NSLocalizedString("status_menu_settings", comment: "")
						cell.imageView?.image = UIImage.circle(with: "gear", color: .iconBlue, size: 32)
			}
		}

		return cell
	}

	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		switch Section(rawValue: section)! {
			case .main:
				return UIView()

			case .about:
				guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as? CustomTableViewHeader else {return nil}
				header.label.text = NSLocalizedString("status_menu_about_header", comment: "")
				return header

		}
	}
}

// MARK: - UITableViewDelegate
extension StatusViewController {
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	 	tableView.deselectRow(at: indexPath, animated: true)

		switch Section(rawValue: indexPath.section)! {
			case .main:
				switch MainRow(rawValue: indexPath.row)! {
					case .selfTest:
						let viewController = UIViewController()
						viewController.view.backgroundColor = .systemBackground
						viewController.title = "Self Test"
						present(UINavigationController(rootViewController: viewController), animated: true)
						break

					case .requestTest:
						let viewController = UIViewController()
						viewController.view.backgroundColor = .systemBackground
						viewController.title = "Request Test"
						present(UINavigationController(rootViewController: viewController), animated: true)
				}

			case .about:
				switch AboutRow(rawValue: indexPath.row)! {
					case .howDoesItWork:
						let viewController = UIViewController()
						viewController.view.backgroundColor = .systemBackground
						viewController.title = "How Does It Work"
						present(UINavigationController(rootViewController: viewController), animated: true)

					case .settings:
						let viewController = UIViewController()
						viewController.view.backgroundColor = .systemBackground
						viewController.title = "Settings"
						present(UINavigationController(rootViewController: viewController), animated: true)
			}
		}
	}

	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		switch Section(rawValue: section)! {
			case .main: return 0
			case .about: return UITableView.automaticDimension
		}
	}
}
