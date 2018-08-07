//
//  SearchResultHeaderView.swift
//  iTunes Search
//
//  Created by Simon Elhoej Steinmejer on 07/08/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

protocol SearchResultHeaderViewDelegate: class
{
    func segmentedControlValueChanged(searchBar: UISearchBar)
}

class SearchResultHeaderView: UITableViewHeaderFooterView, UIPickerViewDelegate
{
    weak var delegate: SearchResultHeaderViewDelegate?
    
    let searchBar: UISearchBar =
    {
        let sb = UISearchBar()
        sb.placeholder = "Search iTunes"
            
        return sb
    }()
    
    let mediaTypeSegmentedControl: UISegmentedControl =
    {
        let sc = UISegmentedControl(items: ["Apps", "Music", "Movies"])
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(handleSegmentedValueChanged), for: .valueChanged)
        
        return sc
    }()
    
    let searchLimitLabel: UILabel =
    {
        let label = UILabel()
        label.text = "Search limit:"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.sizeToFit()
        
        return label
    }()
    
    let searchLimitPickerView: UIPickerView =
    {
        let pv = UIPickerView()
        
        return pv
    }()
    
    override init(reuseIdentifier: String?)
    {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    @objc private func handleSegmentedValueChanged()
    {
        delegate?.segmentedControlValueChanged(searchBar: self.searchBar)
    }
    
    private func setupUI()
    {
        addSubview(mediaTypeSegmentedControl)
        addSubview(searchBar)
        addSubview(searchLimitLabel)
        addSubview(searchLimitPickerView)

        mediaTypeSegmentedControl.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingRight: 8, paddingBottom: 0, width: 0, height: 26)
        
        searchBar.anchor(top: mediaTypeSegmentedControl.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 42)
        
        searchLimitLabel.anchor(top: searchBar.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        searchLimitPickerView.anchor(top: searchLimitLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 8, paddingRight: 8, paddingBottom: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}







