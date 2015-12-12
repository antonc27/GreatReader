//
//  FolderDocumentListViewModel.m
//  GreatReader
//
//  Created by MIYAMOTO Shohei on 5/23/14.
//  Copyright (c) 2014 MIYAMOTO Shohei. All rights reserved.
//

#import "FolderDocumentListViewModel.h"

#import "Folder.h"
#import "RootFolder.h"
#import "PDFDocument.h"
#import "PDFDocumentStore.h"
#import "PDFRecentDocumentList.h"

@interface FolderDocumentListViewModel ()
@property (nonatomic, strong, readwrite) Folder *folder;
@end

@implementation FolderDocumentListViewModel

- (instancetype)initWithFolder:(Folder *)folder
{
    self = [super init];
    if (self) {
        _folder = folder;
    }
    return self;
}

- (NSString *)title
{
    if ([self.folder isKindOfClass:[RootFolder class]]) {
        return LocalizedString(@"home.all-documents");
    } else {
        return self.folder.name;
    }
}

- (NSUInteger)count
{
    return self.folder.files.count;
}

- (PDFDocument *)documentAtIndex:(NSUInteger)index
{
    return self.folder.files[index];
}

- (void)reload
{
    [self.folder load];
}

- (void)deleteDocuments:(NSArray *)documents
{
    [self.folder.store deleteDocuments:documents];
}

- (Folder *)createFolderInCurrentFolderWithName:(NSString *)folderName error:(NSError **)error
{
    return [self.folder createSubFolderWithName:folderName error:error];
}

- (BOOL)moveDocuments:(NSArray *)documents toFolder:(Folder *)folder error:(NSError **)error
{
    return [self.folder.store moveDocuments:documents toFolder:folder error:error];
}

@end
