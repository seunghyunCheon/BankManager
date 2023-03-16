//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by brody, christy, harry on 2023/03/07.
//

import Foundation

struct Bank {
    private var loanSection: BusinessSection
    private var depositSection: BusinessSection
    private let customerQueue: BankManagerQueue<Customer> = BankManagerQueue()
    private let dispatchGroup = DispatchGroup()
    
    init() {
        loanSection = BusinessSection(
            queueName: "대출창구",
            businessType: .loan,
            numberOfBankers: 1
        )
        depositSection = BusinessSection(
            queueName: "예금창구",
            businessType: .deposit,
            numberOfBankers: 2
        )
    }
    
    func setUpCustomerQueue(customers: [Customer]) {
        customers.forEach {
            customerQueue.enqueue($0)
        }
    }
    
    private mutating func work() {
        while !customerQueue.isEmpty {
            guard let currentCustomer = customerQueue.dequeue() else { return }
            
            switch currentCustomer.businessType {
            case .loan:
                loanSection.processJob(for: currentCustomer, group: dispatchGroup)
                loanSection.addJobCount()
            case .deposit:
                depositSection.processJob(for: currentCustomer, group: dispatchGroup)
                depositSection.addJobCount()
            }
        }
    }
    
    mutating func startBankService() {
        let startTime = CFAbsoluteTimeGetCurrent()
        loanSection.isWorking = true
        depositSection.isWorking = true
        work()
        
        let durationTime = CFAbsoluteTimeGetCurrent() - startTime
        let completedJobCount = loanSection.completedJobCount + depositSection.completedJobCount
        
        endBusiness(count: completedJobCount, time: durationTime)
    }
    
    private func endBusiness(count completedJobCount: Int, time durationTime: CFAbsoluteTime) {
        let formattedTime = String(format: "%.2f", durationTime)
//        print("업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(completedJobCount)명이며, 총 업무시간은 \(formattedTime)초입니다.\n")
    }
    
    func reset() {
        customerQueue.clear()
        loanSection.isWorking = false
        depositSection.isWorking = false
    }
}