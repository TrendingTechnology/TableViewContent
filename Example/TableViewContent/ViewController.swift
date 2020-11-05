//
//  ViewController.swift
//  TableViewContent
//
//  Created by Akira Matsuda on 10/08/2018.
//  Copyright (c) 2018 Akira Matsuda. All rights reserved.
//

import UIKit
import TableViewContent

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var delegate: ContentDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Example"

        // Do any additional setup after loading the view, typically from a nib.
        title = "Example"
        let dataSource = ContentDataSource {
            Section {
                DefaultTableViewCell(title: "title")
                DefaultTableViewCell(title: "title", style: .subtitle)
                    .detailText("subtitle")
                DefaultTableViewCell(title: "title", style: .value1)
                    .detailText("value1")
                DefaultTableViewCell(title: "title", style: .value2)
                    .accessoryType(.disclosureIndicator)
                    .detailText("value2")
                    .didSelect { (_, _, _) in
                        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
                        self.navigationController?.pushViewController(viewController, animated: true)
                }
            }
            Section {
                SwitchCell(title: "Switch")
                SwitchCell(title: "Switch2", isOn: true)
                    .toggled { isOn in
                        print("\(isOn)")
                    }.didSelect { _, _, isOn in
                        print("\(String(describing: isOn))")
                    }
            }
            Section {
                CustomCell {
                    print("button pressed")
                }
            }
            Section()
                .header(.title("header"))
                .contents { section in
                    for i in 0...5 {
                        section.append(DefaultTableViewCell(title: "\(i)"))
                    }
                }
                .footer(.title("footer"))
            Section()
                .header(.nib("custom header", UINib(nibName: "CustomHeaderView", bundle: nil)))
                .contents { section in
                    for i in 0...5 {
                        section.append(DefaultTableViewCell(title: "\(i)"))
                    }
                }
                .footer(.nib("custom footer", UINib(nibName: "CustomHeaderView", bundle: nil)))
        }
        delegate = ContentDelegate(dataSource: dataSource)
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
}
