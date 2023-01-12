//
//  DetailsMainVC.swift
//  IGTracker
//
//  Created by Юлия Алдохина on 14/09/22.
//

import UIKit



class DetailsMainVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var searchView: UIView!
    
    var followers: [Followers] = []
    var filterFollowers: [Followers] = []
    var search = false
    
    var dateType: DetailDataType!
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        tableView.reloadData()
        hiddenSearchBar()
        searchBar.customize()
        showFetch()
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    
    private func hiddenSearchBar() {
        if dateType.url == "/not_following_back/" {
            searchBar.isHidden = false
            searchView.isHidden = false
        } else {
            searchBar.isHidden = true
            searchView.isHidden = true
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        }
    }
    
    
    
    
    // MARK: - Fetch URL
    private func showFetch() {
        fetch(with: dateType.url)
    }
    
    private func fetch(with urlCell: String) {
        DetailsAPI.shared.getFollowers(username: "", url: urlCell) { result in
            switch result {
            case .success(let followers):
                self.followers = followers
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
// MARK: - extension: UISearchBar

extension UISearchBar {
    func customize() {
        searchTextField.backgroundColor = UIColor(named: "subbackground")
        barTintColor = UIColor(named: "subbackground")
        tintColor = .white
        searchTextField.textColor = .white
        placeholder = "Search".localized()
    }
    
}

extension DetailsMainVC: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterData(letter: searchText)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
    
    private  func filterData(letter: String) -> [Followers]{
        filterFollowers = followers.filter({ user in
            user.userName.starts(with: letter) ||
            user.fullName.split(separator: " ").contains(where: {
                $0.starts(with: letter)
            })
        })
        search = true
        self.tableView.reloadData()
        
        return  filterFollowers
    }
    
}
// MARK: - extension: UITAbleViewDataSource
extension DetailsMainVC: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if search {
            return filterFollowers.count
        } else {
            return followers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath) as! DefaultCells
        if search {
            let follower = filterFollowers[indexPath.row]
            cell.nameLabel.text = follower.fullName
            cell.nikLabel.text = follower.userName
            
            if let url = follower.avatar {
                cell.avatarImage.loadImageWithUrl(URL(string: url)!)
            } else {
                cell.avatarImage.image = UIImage(named: "noAva")
            }
            return cell
        } else {
            
            let follower = followers[indexPath.row]
            
            // TODO: Получить от бека данные о том подписан я на него или нет,и если подписан то кнопку поменять на "отписаться"
            // TODO: Если не получится с бека это получить, то кнопку сделать просто open
            
            cell.nameLabel.text = follower.fullName
            cell.nikLabel.text = follower.userName
            if let url = follower.avatar {
                cell.avatarImage.loadImageWithUrl(URL(string: url)!)
            } else {
                cell.avatarImage.image = UIImage(named: "noAva")
            }
            return cell
            
        }
        
        
        //    @objc func followButtonClicked(sender: UIButton){
        //        //TODO: Здесь открыть deeplink
        //        tableView.reloadData()
        //    }
    }
}



// MARK: - extension: UITableViewDelegate
extension DetailsMainVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

