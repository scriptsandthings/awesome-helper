//
//  AddRepositoryVC.swift
//  AwesomeHelper
//
//  Created by Serhii Londar on 1/29/18.
//  Copyright © 2018 slon. All rights reserved.
//

import UIKit
import GithubAPI
import RealmSwift

class AddRepositoryVC: BaseVC {
    @IBOutlet weak var repositoryOwnerTextField: UITextField! = nil
    @IBOutlet weak var repositoryNameTextField: UITextField! = nil
    @IBOutlet weak var addRepositoryButton: UIButton! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addRepositoryButtonPressed(_ sender: AnyObject) {
        if let owner = repositoryOwnerTextField.text, let name = repositoryNameTextField.text {
            self.showHUD()
            RepositoriesAPI().get(owner: owner, repo: name, completion: { (response, error) in
                DispatchQueue.main.async {
                    self.hideHUD()
                    if let response = response {
                        self.addRepository(response)
                    } else {
                        print(error ?? "")
                    }
                }
            })
        } else {
            self.showErrorAlert("Please enter repository owner and name.")
        }
    }
    
    func addRepository(_ repo: RepositoryResponse) {
        do {
            let repository = Repository()
            repository.name = repositoryNameTextField.text!
            repository.owner = repositoryOwnerTextField.text!
            repository.url = repo.htmlUrl!
            try Realm.default.write {
                Realm.default.add(repository)
            }
            self.navigationController?.popViewController(animated: true)
        } catch {
            self.showErrorAlert(error.localizedDescription)
        }
    }
}
