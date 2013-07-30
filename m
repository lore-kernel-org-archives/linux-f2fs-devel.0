From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH] f2fs: add a wait step when submit bio with {READ,WRITE}_SYNC
Date: Tue, 30 Jul 2013 18:06:22 +0800
Message-ID: <51F7901E.3010204@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Kim <jaegeuk.kim@samsung.com>
Cc: f2fs <linux-f2fs-devel@lists.sourceforge.net>, fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

When we submit bio with READ_SYNC or WRITE_SYNC, we need to wait a
moment for the io completion, current codes only find_data_page() follows the
rule, other places missing this step, so add it.

Further more, moving the PageUptodate check into f2fs_readpage() to clean up
the codes.

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/checkpoint.c |    1 -
 fs/f2fs/data.c       |   39 +++++++++++++++++----------------------
 fs/f2fs/node.c       |    1 -
 fs/f2fs/recovery.c   |    2 --
 fs/f2fs/segment.c    |    2 +-
 5 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index fe91773..e376a42 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -64,7 +64,6 @@ repeat:
 	if (f2fs_readpage(sbi, page, index, READ_SYNC))
 		goto repeat;
 
-	lock_page(page);
 	if (page->mapping != mapping) {
 		f2fs_put_page(page, 1);
 		goto repeat;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 19cd7c6..b048936 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -216,13 +216,11 @@ struct page *find_data_page(struct inode *inode, pgoff_t index, bool sync)
 
 	err = f2fs_readpage(sbi, page, dn.data_blkaddr,
 					sync ? READ_SYNC : READA);
-	if (sync) {
-		wait_on_page_locked(page);
-		if (!PageUptodate(page)) {
-			f2fs_put_page(page, 0);
-			return ERR_PTR(-EIO);
-		}
-	}
+	if (err)
+		return ERR_PTR(err);
+
+	if (sync)
+		unlock_page(page);
 	return page;
 }
 
@@ -267,11 +265,6 @@ repeat:
 	if (err)
 		return ERR_PTR(err);
 
-	lock_page(page);
-	if (!PageUptodate(page)) {
-		f2fs_put_page(page, 1);
-		return ERR_PTR(-EIO);
-	}
 	if (page->mapping != mapping) {
 		f2fs_put_page(page, 1);
 		goto repeat;
@@ -325,11 +318,7 @@ repeat:
 		err = f2fs_readpage(sbi, page, dn.data_blkaddr, READ_SYNC);
 		if (err)
 			return ERR_PTR(err);
-		lock_page(page);
-		if (!PageUptodate(page)) {
-			f2fs_put_page(page, 1);
-			return ERR_PTR(-EIO);
-		}
+
 		if (page->mapping != mapping) {
 			f2fs_put_page(page, 1);
 			goto repeat;
@@ -399,6 +388,16 @@ int f2fs_readpage(struct f2fs_sb_info *sbi, struct page *page,
 
 	submit_bio(type, bio);
 	up_read(&sbi->bio_sem);
+
+	if (type == READ_SYNC) {
+		wait_on_page_locked(page);
+		lock_page(page);
+		if (!PageUptodate(page)) {
+			f2fs_put_page(page, 1);
+			return -EIO;
+		}
+	}
+
 	return 0;
 }
 
@@ -679,11 +678,7 @@ repeat:
 		err = f2fs_readpage(sbi, page, dn.data_blkaddr, READ_SYNC);
 		if (err)
 			return err;
-		lock_page(page);
-		if (!PageUptodate(page)) {
-			f2fs_put_page(page, 1);
-			return -EIO;
-		}
+
 		if (page->mapping != mapping) {
 			f2fs_put_page(page, 1);
 			goto repeat;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f5172e2..f061554 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1534,7 +1534,6 @@ int restore_node_summary(struct f2fs_sb_info *sbi,
 		if (f2fs_readpage(sbi, page, addr, READ_SYNC))
 			goto out;
 
-		lock_page(page);
 		rn = F2FS_NODE(page);
 		sum_entry->nid = rn->footer.nid;
 		sum_entry->version = 0;
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 639eb34..ec68183 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -140,8 +140,6 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
 		if (err)
 			goto out;
 
-		lock_page(page);
-
 		if (cp_ver != cpver_of_node(page))
 			break;
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9b74ae2..bcd19db 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -639,7 +639,7 @@ static void do_submit_bio(struct f2fs_sb_info *sbi,
 
 		trace_f2fs_do_submit_bio(sbi->sb, btype, sync, sbi->bio[btype]);
 
-		if (type == META_FLUSH) {
+		if ((type == META_FLUSH) || (rw & WRITE_SYNC)) {
 			DECLARE_COMPLETION_ONSTACK(wait);
 			p->is_sync = true;
 			p->wait = &wait;
-- 
1.7.7

