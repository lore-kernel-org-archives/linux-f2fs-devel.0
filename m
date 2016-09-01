From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: set dentry bits on random location in memory
Date: Wed, 31 Aug 2016 18:08:23 -0700
Message-ID: <20160901010823.18300-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This fixes pointer panic when using inline_dentry, which was triggered when
backporting to 3.10.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c    | 2 +-
 fs/f2fs/inline.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 9316d8a..2fb20fc 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -510,7 +510,7 @@ void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *d,
 	de->ino = cpu_to_le32(ino);
 	set_de_type(de, mode);
 	for (i = 0; i < slots; i++) {
-		test_and_set_bit_le(bit_pos + i, (void *)d->bitmap);
+		__set_bit_le(bit_pos + i, (void *)d->bitmap);
 		/* avoid wrong garbage data for readdir */
 		if (i)
 			(de + i)->name_len = 0;
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 8a96107..4d526f3 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -566,7 +566,7 @@ void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	inline_dentry = inline_data_addr(page);
 	bit_pos = dentry - inline_dentry->dentry;
 	for (i = 0; i < slots; i++)
-		test_and_clear_bit_le(bit_pos + i,
+		__clear_bit_le(bit_pos + i,
 				&inline_dentry->dentry_bitmap);
 
 	set_page_dirty(page);
-- 
2.8.3
