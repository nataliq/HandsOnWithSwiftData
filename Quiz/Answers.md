1. `True`
2. `False`, it needs to be added to a model context and saved
3. `False`
4. `All`
5. `False`, even thought the type is Array the order is not preserved
6. `True`
7. `False`, because @Model macro expands our models with some non-codable properties (see [this post for more info](https://www.donnywals.com/making-your-swiftdata-models-codable/)).
8. `False`, for example it can't execute [fetchCount(_:)](https://developer.apple.com/documentation/swiftdata/modelcontext/fetchcount(_:)).
9. Subjective but based on the runtime exceptions that one goes through when doing the tasks on top of the starter project in this repo, I'd say `False`.
10. `True`
11. `False`, from Apple's docs: "SwiftData has uses beyond persisting locally created content. For example, an app that fetches data from a remote web service might use SwiftData to implement a lightweight caching mechanism and provide limited offline functionality.". Using it for a CloudKit integration is another example.
