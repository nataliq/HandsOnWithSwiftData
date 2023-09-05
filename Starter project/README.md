
# Starter project

It’s a simple app for self-reflection. The main focus is a field on the `Reflect` tab where the user can type a `Thought` quickly. If the `text` is not empty the user can tap `Save` which clears the screen to its original state.

Optionally the user can select one or multiple options from a list of tags they created and attach them to the thought. The user can search for existing or create new tags on the fly.

The app provides a secondary screen where the user can browse and edit thoughts they created during this session.

One key missing feature is that thoughts and tags are not persisted between sessions but only in-memory. 

## Task 1

Persist thoughts and tags between app launches with the use of SwiftData.

## Task 2

Add an “Undo” bar button on the Browse tab so that the user can revert a save or delete of a thought. 
The undo button should be disabled if there are no actions to revert.
Use the provided `UndoModelChangesButton` as a starting point.

## Task 3

Replace the in-memory filtering of thoughts and tags with filtering during fetching for optimal performance.

## Task 4

Add functionality to add 10 000 new thoughts to the database without blocking the UI.
Use the provided `ImportModelDataButton` as a starting point.

## Task 5 

Make sure the unit test compiles and examine the test result. Play around and see if you can improve the test.

## Bonus task ideas

- Fetch data from a UIKit view.
  - You can try the `ModelContext`'s [fetchCount(\_:)](https://developer.apple.com/documentation/swiftdata/modelcontext/fetchcount(_:)) API.
- Create a matching CoreData stack and implement a view that fetches data using it.
  - You can use the provided `PersistenceController` as a starting point.
  - You can try using [NSFetchedResultsController](https://developer.apple.com/documentation/coredata/nsfetchedresultscontroller) for fetching data created with `SwiftData`.
- Try using `@Attribute` and `@Relationship` with different properties to improve the model schema.

