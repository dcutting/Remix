//  Copyright © 2017 cutting.io. All rights reserved.

import Utility
import Entity
import Services

class GroupSelectionInteractor {

    enum SelectionType {
        case leafGroup
        case parentGroup
    }

    private let groupService: GroupService

    init(groupService: GroupService) {
        self.groupService = groupService
    }

    func findSelectionType(for groupID: GroupID, completion: @escaping (AsyncResult<SelectionType>) -> Void) {
        groupService.fetchGroup(for: groupID) { result in
            switch result {
            case let .success(group):
                let type = self.findSelectionType(for: group)
                completion(.success(type))
            case .error:
                completion(.error)
            }
        }
    }

    private func findSelectionType(for group: Group) -> SelectionType {
        return group.children.isEmpty ? .leafGroup : .parentGroup
    }

    func fetchGroups(parentGroupID: GroupID?, completion: @escaping (AsyncResult<[Group]>) -> Void) {
        groupService.fetchGroups() { result in
            switch result {
            case let .success(groups):
                let filteredGroups = self.filter(groups: groups, withParentGroupID: parentGroupID)
                completion(.success(filteredGroups))
            case .error:
                completion(.error)
            }
        }
    }

    private func filter(groups: [Group], withParentGroupID parentGroupID: GroupID?) -> [Group] {
        return groups.filter { group in
            group.parent == parentGroupID
        }
    }
}
