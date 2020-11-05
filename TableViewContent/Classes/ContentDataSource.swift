//
//  ContentDataSource.swift
//  Pods-TableViewContent_Example
//
//  Created by Akira Matsuda on 2019/06/19.
//

import UIKit

@_functionBuilder
public struct TableViewSectionBuilder {
    public static func buildBlock(_ items: TableViewSection...) -> [TableViewSection] {
        return items
    }
}

open class ContentDataSource: NSObject, UITableViewDataSource {
    internal var sections: [TableViewSection] = []
    open var registeredReuseIdentifiers = [] as [String]
    
    public init(_ sections: [TableViewSection]) {
        self.sections = sections
    }
    
    public init(@TableViewSectionBuilder _ sections: () -> [TableViewSection]) {
        self.sections = sections()
    }
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let s = sections[section]
        return s.contents.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        let row = section.contents[indexPath.row]
        
        switch row.source {
        case let .nib(nib):
            if !registeredReuseIdentifiers.contains(row.reuseIdentifier) {
                registeredReuseIdentifiers.append(row.reuseIdentifier)
                tableView.register(nib, forCellReuseIdentifier: row.reuseIdentifier)
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier, for: indexPath)
            row._configure(cell, indexPath)
            return cell
            
        case let .class(cellClass):
            if !registeredReuseIdentifiers.contains(row.reuseIdentifier) {
                registeredReuseIdentifiers.append(row.reuseIdentifier)
                tableView.register(cellClass, forCellReuseIdentifier: row.reuseIdentifier)
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier, for: indexPath)
            row._configure(cell, indexPath)
            return cell
            
        case let .style(cellStyle):
            if let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier) {
                row._configure(cell, indexPath)
                return cell
            }
            else {
                let cell = UITableViewCell(style: cellStyle, reuseIdentifier: row.reuseIdentifier)
                row._configure(cell, indexPath)
                return cell
            }
        }
    }
    
    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let s = sections[section]
        switch s.headerView?.sectionType {
        case let .title(text):
            return text
        default:
            return nil
        }
    }
    
    open func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let s = sections[section]
        switch s.footerView?.sectionType {
        case let .title(text):
            return text
        default:
            return nil
        }
    }
}
