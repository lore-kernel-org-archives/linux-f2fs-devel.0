From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: keep PagePrivate during releasepage
Date: Mon,  2 Feb 2015 14:51:18 -0800
Message-ID: <1422917479-36393-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If PagePrivate is removed by releasepage, f2fs loses counting dirty pages.

e.g., try_to_release_page will not release page when the page is dirty,
but our releasepage removes PagePrivate.

    [<ffffffff81188d75>] try_to_release_page+0x35/0x50
    [<ffffffff811996f9>] invalidate_inode_pages2_range+0x2f9/0x3b0
    [<ffffffffa02a7f54>] ? truncate_blocks+0x384/0x4d0 [f2fs]
    [<ffffffffa02b7583>] ? f2fs_direct_IO+0x283/0x290 [f2fs]
    [<ffffffffa02b7fb0>] ? get_data_block_fiemap+0x20/0x20 [f2fs]
    [<ffffffff8118aa53>] generic_file_direct_write+0x163/0x170
    [<ffffffff8118ad06>] __generic_file_write_iter+0x2a6/0x350
    [<ffffffff8118adef>] generic_file_write_iter+0x3f/0xb0
    [<ffffffff81203081>] new_sync_write+0x81/0xb0
    [<ffffffff81203837>] vfs_write+0xb7/0x1f0
    [<ffffffff81204459>] SyS_write+0x49/0xb0
    [<ffffffff817c286d>] system_call_fastpath+0x16/0x1b

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 4 ++++
 fs/f2fs/data.c       | 4 ++++
 fs/f2fs/node.c       | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index f7cdcad..470fa58 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -321,6 +321,10 @@ static void f2fs_invalidate_meta_page(struct page *page, unsigned int offset,
 
 static int f2fs_release_meta_page(struct page *page, gfp_t wait)
 {
+	/* If this is dirty page, keep PagePrivate */
+	if (PageDirty(page))
+		return 0;
+
 	ClearPagePrivate(page);
 	return 1;
 }
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6d9e6e4..27dc3fd 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1130,6 +1130,10 @@ static void f2fs_invalidate_data_page(struct page *page, unsigned int offset,
 
 static int f2fs_release_data_page(struct page *page, gfp_t wait)
 {
+	/* If this is dirty page, keep PagePrivate */
+	if (PageDirty(page))
+		return 0;
+
 	ClearPagePrivate(page);
 	return 1;
 }
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 05e6faa..9feda38 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1381,6 +1381,10 @@ static void f2fs_invalidate_node_page(struct page *page, unsigned int offset,
 
 static int f2fs_release_node_page(struct page *page, gfp_t wait)
 {
+	/* If this is dirty page, keep PagePrivate */
+	if (PageDirty(page))
+		return 0;
+
 	ClearPagePrivate(page);
 	return 1;
 }
-- 
2.1.1
