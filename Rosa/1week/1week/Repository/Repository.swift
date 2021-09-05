//
//  Repository.swift
//  1week
//
//  Created by jsj on 2021/09/05.
//

/**
 - Repository: Entity 를 fetch 하는 역할
 - Entity : Server API 또는 DB 에서 fetch 한 데이터
 */

import Foundation

class Repository {
    /// json 을 가져와 Entity 로 디코딩하여 반환
    func fetch() -> [Entity] {
        let dbdata = DBData()
        return dbdata.datas
    }
}
