/**
 Entity <----> Model 변환하기 위한 인터페이스
 */

protocol MappingInterface {
    associatedtype EntityType: Codable
    
    // EntityModel -> Model
    init(entityType: EntityType)
    
    // Model -> Entity Model
//    func mappingEntityType() -> EntityType
}
