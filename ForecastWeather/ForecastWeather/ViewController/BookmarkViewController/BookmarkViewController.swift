//
//  BookmarkViewController.swift
//  ForecastWeather
//
//  Created by Chirag on 11/10/18.
//  Copyright © 2018 Chirag. All rights reserved.
//

import UIKit

class BookmarkViewController: UIViewController {
 
    //MARK:- Outlates
    @IBOutlet weak var tableBookmark: UITableView!
    
    //MARK:- Variables 
    var viewModel = BookmarkViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Helper Methods
    private func prepareView() {
        tableBookmark.register(UINib(nibName: XIBClassName.BookmarkCell, bundle: nil) , forCellReuseIdentifier: CellIdentifier.kBookmarkCellID)
        tableBookmark.rowHeight = UITableViewAutomaticDimension
        tableBookmark.estimatedRowHeight = 100
        viewModel.prepareCityList()
        viewModel.updateLiveValue { [weak self] in
            self?.reloadTable()
        }
    }
    //Reload tableview
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableBookmark.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.bookmarkListToCityPicker {
            let destination = segue.destination as! CityPickerViewController
            destination.delegate = self
        }
        if segue.identifier == Segues.bookmarkListToDetail {
            if let view = segue.destination as? CityWeatherViewController {
                view.city = sender as? City
            }
        }
    }
}

//MARK:- UITableView Delegate and Datasource
extension BookmarkViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.citys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bookmarkCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.kBookmarkCellID, for: indexPath) as! BookmarkCell
        bookmarkCell.city = viewModel.citys[indexPath.row]
        return bookmarkCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                performSegue(withIdentifier: Segues.bookmarkListToDetail, sender: viewModel.citys[indexPath.row])
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            viewModel.removeobject(index: indexPath.row, complition: { [weak self] in
                self?.reloadTable()
            })
        }
    }
}

extension BookmarkViewController: CityPickerDelegate {
    //update city from city picker
    func didSelectCity(selectedCity: City) {
        viewModel.bookMarkCity(city: selectedCity) {
            self.reloadTable()
        }
    }
}
