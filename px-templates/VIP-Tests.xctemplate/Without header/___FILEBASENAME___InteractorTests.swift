import XCTest
@testable import ___PROJECTNAMEASIDENTIFIER___

final class ___FILEBASENAMEASIDENTIFIER___: XCTestCase {
    
    private let repositorySpyStub = ___VARIABLE_productName___RepositorySpyStub()
    private let presenterSpy = ___VARIABLE_productName___PresenterSpy()
    
    private lazy var sut = ___VARIABLE_productName___Interactor(
        presenter: presenterSpy,
        repository: repositorySpyStub)
    
    func testExample() {
        //Given
        
        //Then
        
        //When
    }
}
