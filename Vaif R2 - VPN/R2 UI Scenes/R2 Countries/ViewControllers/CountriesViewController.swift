//
//  CountriesViewController.swift
//  VaifR2
//
//  Created by VAIF on 1/7/23.
//

import UIKit
//import Search
import FirebaseFirestore

protocol CountriesViewControllerDelegate {
    func listServerDidSelect(server: R1ServerModel)
}

final class CountriesViewController: UIViewController {
    

    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: CountriesViewModel!

    //var coordinator: SearchCoordinator?
    
    lazy var db = Firestore.firestore()
    var data: [R1ServerModel] = []
    var selectedIndex: Int = -1
    var delegate: CountriesViewControllerDelegate?
    var selectedServer: R1ServerModel?
    
    func setupData() {
        if let data = UserDefaults.standard.dictionary(forKey: "selectedServer")  {
            let server = R1ServerModel()
            server.initWith(data: data)
            self.selectedServer = server
        }
        
        if WitWork.shared.serversData.count > 0 {
            self.data = WitWork.shared.serversData
            tableView.reloadData()
        }else {
            print("/self.showHUD()")
            //self.showHUD()
        }
        
        db.collection("Servers").getDocuments() { [weak self](querySnapshot, err) in
            guard let wSelf = self else {return}
            //wSelf.hideHUD()
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                wSelf.data.removeAll()
                for document in querySnapshot!.documents {
                    let server = R1ServerModel()
                    server.initWith(data: document.data())
                    wSelf.data.append(server)
                    print("\(document.documentID))")
                }
                
                wSelf.data.sort { $0.premium == false && !$1.premium == false}
                
                var i: Int = 0
                wSelf.data.forEach { server in
                    if let selectedServer = wSelf.selectedServer {
                        if selectedServer.ipAddress == server.ipAddress {
                            wSelf.selectedIndex = i
                        }
                        i+=1
                    }
                }
                WitWork.shared.serversData = wSelf.data

                wSelf.tableView.reloadData()
            }
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        tabBarItem = UITabBarItem(title: LocalizedString.countries, image: IconProvider.earth, tag: 0)
        tabBarItem.accessibilityIdentifier = "Premium Servers"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.contentChanged = { [weak self] in
            self?.contentChanged()
            self?.reloadSearch()
        }
        setupData()
        setupView()
        //setupConnectionBar()
//        setupSecureCoreBar()
        setupTableView()
        setupNavigationBar()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(setupAnnouncements), name: AnnouncementStorageNotifications.contentChanged, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //setupAnnouncements()
    }
    
    private func setupView() {
        navigationItem.title = LocalizedString.countries
        view.layer.backgroundColor = ColorProvider.FloatyBackground.cgColor
    }
    


    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = ColorProvider.FloatyBackground
        tableView.register(CountryCell.nib, forCellReuseIdentifier: CountryCell.identifier)
        tableView.register(ServersHeaderView.nib, forHeaderFooterViewReuseIdentifier: ServersHeaderView.identifier)
    }
    
    private func setupNavigationBar() {
        let infoButton = UIBarButtonItem(image: IconProvider.infoCircle, style: .plain, target: self, action: #selector(displayServicesInfo))
        let searchButton = UIBarButtonItem(image: IconProvider.magnifier, style: .plain, target: self, action: #selector(showSearch))
        navigationItem.rightBarButtonItems = [searchButton, infoButton]
    }
    
    @objc private func displayServicesInfo() {
        let viewModel = ServersFeaturesInformationViewModelImplementation()
        let vc = ServersFeaturesInformationVC(viewModel)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
    }
    
    private func contentChanged() {
//        guard let viewModel = viewModel else { return }
//        secureCoreSwitch.setOn(viewModel.secureCoreOn, animated: true)
        tableView.reloadData()
    }

    func showCountry(cellModel: CountryItemViewModel) {
        if cellModel.isUsersTierTooLow {
            viewModel.presentAllCountriesUpsell()
            return
        }

//        guard let countryViewController = viewModel.countryViewController(viewModel: cellModel) else {
//            return
//        }
//
//        self.navigationController?.pushViewController(countryViewController, animated: true)
    }
}

extension CountriesViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        //return viewModel.numberOfSections()
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if viewModel.numberOfSections() < 2 {
            return nil
        }
        
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ServersHeaderView.identifier) as? ServersHeaderView {
            headerView.setName(name: viewModel.titleFor(section: section) ?? "")
            return headerView
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.headerHeight(for: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let server = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryCell
       
        cell.countryName.text = server.country + ", " + server.state.uppercased()
        cell.flagIcon.fileName = server.countryCode.lowercased()
        
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < data.count else {
            return
        }
        
        self.selectedIndex = indexPath.row
        self.tableView.reloadData()
        let server = self.data[indexPath.row]
        self.delegate?.listServerDidSelect(server: server)
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}

