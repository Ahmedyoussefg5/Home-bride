//
//  CardPageVC.swift
//  Gawla
//
//  Created by Youssef on 11/11/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import UIKit

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardsBagTableCell", for: indexPath) as! ChatCell
//        cell.configCell(message: mess)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let lable = UILabel()
        lable.text = "Chat Room Is Closed".localize
        lable.font = .CairoSemiBold(of: 14)
        lable.textAlignment = .center
        return lable
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {

        if !mainView.chatTxt.isEnabled {
            return 100
        }
        if messages.count > 0 {
            return 0
        }
        return 0
    }
}
