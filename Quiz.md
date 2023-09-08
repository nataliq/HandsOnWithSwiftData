The questions used in the workshop quiz:

1. @Model can NOT be attached to structs. -> `True`
2. After attaching @Model to a class all of its new instances will get saved on disk. -> `False`, it needs to be added to a model context and saved
3. @Model can be attached to subclasses. -> `False`
4. Which relationships are not supported by SwiftData? 1-to-1, 1-to-many, many-to-many or all? -> `All`
5. To-many relationships are ordered collections. -> `False`, even thought the type is Array the order is not preserved
6. All SwiftData models are also automatically Observable. -> `True`
7. All SwiftData models are also automatically Codable. -> `False`, because @Model macro expands our models with some non-codable properties (see [this post for more info](https://www.donnywals.com/making-your-swiftdata-models-codable/)).
8. @Query can execute all types of SwiftData fetches. -> `False`, for example it can't execute [fetchCount(_:)](https://developer.apple.com/documentation/swiftdata/modelcontext/fetchcount(_:)).
9. The compiler makes it very hard to make mistakes in SwiftData code. -> Subjective but based on the runtime exceptions that one goes through when doing the tasks on top of the starter project in this repo, I'd say `False`.
10. SwiftData uses the CoreData stack behind the scenes. -> `True`
11. It only makes sense to use SwiftData if we want to persist content locally. -> `False`, from Apple's docs: "SwiftData has uses beyond persisting locally created content. For example, an app that fetches data from a remote web service might use SwiftData to implement a lightweight caching mechanism and provide limited offline functionality.". Using it for a CloudKit integration is another example.
