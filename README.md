Possible solutions:
1. Store all records in one file. On first line of file, have an index (json) that maps a hash of record ID to a line number. To see if a record with ID already exists, load hash and check for ID in it. To overwrite an existing record, seek to line number, then overwrite line with new line.

Rationale: Turns out this won't work because IOStreams in Ruby don't allow you to seek quickly to a given line (was hoping for complexity O(1)), nor do they allow you to overwrite a single line (you would have to overwrite the entire rest of the file).


2. Use regex to find preexisting records that should be replaced. Otherwise append to file.

Rationale: My gut tells me this is terrible. Might scale poorly with very large numbers of records, depending on how the regex engine is optimized. Search would be complexity O(n) or worse.


3. Save each record as a separate file. Have one file that is an index that maps a hash of record ID to a file name. This allows 'quick' access to a specific file (as quick as the OS can manage). Importantly, read speed should not be affected by the number of records that are already stored (complexity O(1)). However, writing many records and especially reads will be rather slow due to opening and closing tons of files in quick succession. This solution leans on the OS being quick at opening and closing files.

Rationale: I don't like the idea of having a file for each record, but it satisfies the constraints of the assignment. It also could likely be optimized in a few ways, if necessary, such as aggregating a certain number of records into one file/page, sort of a mix of option 1 and option 3.


Going with option 3.


Final word: Option 3 ended up working as expected, except it didn't end up needing an index to track filenames (that was an unnecessary holdover from Option 1). I chose this option because it seemed closer to how a real database probably works.
