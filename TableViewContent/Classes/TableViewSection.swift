//
//  TableViewSection.swift
//  Pods-TableViewContent_Example
//
//  Created by Akira Matsuda on 2019/06/19.
//

import Foundation

open class TableViewSection: NSObject {
    internal var contents: [CellContent] = []
    open var headerTitle: String? = nil
    open var footerTitle: String? = nil
    open var selectedAction: ((UITableView, IndexPath, Any?) -> Void)? = nil
    
    public override init() {
        super.init()
    }
    
    public init(headerTitle: String) {
        self.headerTitle = headerTitle
    }
    
    public init(footerTitle: String) {
        self.footerTitle = footerTitle
    }
    
    public convenience init(headerTitle: String, footerTitle: String) {
        self.init(headerTitle: headerTitle)
        self.footerTitle = footerTitle
    }
    
    public convenience init(_ contents: [CellContent]) {
        self.init()
        self.contents = contents
    }
    
    public convenience init(headerTitle: String, contents: [CellContent]) {
        self.init(headerTitle: headerTitle)
        self.contents = contents
    }
    
    public convenience init(headerTitle: String, contents: [CellContent], footerTitle: String) {
        self.init(headerTitle: headerTitle, footerTitle: footerTitle)
        self.contents = contents
    }
    
    public convenience init(contents: [CellContent], footerTitle: String) {
        self.init(footerTitle: footerTitle)
        self.contents = contents
    }
    
    @discardableResult
    public func header(_ title: String) -> Self {
        headerTitle = title
        return self
    }
    
    @discardableResult
    public func footer(_ title: String) -> Self {
        footerTitle = title
        return self
    }
    
    @discardableResult
    public func contents(_ sectionContents: [CellContent]) -> Self {
        contents = sectionContents
        return self
    }
    
    @discardableResult
    public func contents(_ closure: (TableViewSection) -> Void) -> Self {
        closure(self)
        return self
    }
    
    @discardableResult
    public func append<Content: CellContent>(_ content: Content) -> Content {
        contents.append(content)
        return content
    }
    
    @discardableResult
    public func didSelected(_ action: @escaping (UITableView, IndexPath, Any?) -> Void) -> Self {
        selectedAction = action
        return self
    }
}
