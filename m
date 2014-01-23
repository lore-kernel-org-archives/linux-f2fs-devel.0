From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH 1/2 v2] f2fs: call mark_inode_dirty to flush
	dirty pages
Date: Thu, 23 Jan 2014 09:18:17 +0900
Message-ID: <1390436297.25542.4.camel@kjgkr>
References: <1390298075-21458-1-git-send-email-jaegeuk.kim@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1W681M-0003Rd-60
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Jan 2014 00:19:48 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1W681K-0003nt-DW
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Jan 2014 00:19:48 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MZT008KAVKR56B0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Jan 2014 09:19:39 +0900 (KST)
In-reply-to: <1390298075-21458-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Chang log from v1:
 o check and add mark_inode_dirty across the whole paths

>From a18ff063406dd6aec41fda598eabe2691007a30d Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Date: Tue, 21 Jan 2014 13:32:12 +0900
Subject: [PATCH 1/2] f2fs: call mark_inode_dirty to flush dirty pages

If a dentry page is updated, we should call mark_inode_dirty to add the
inode
into the dirty list, so that its dentry pages are flushed to the disk.
Otherwise, the inode can be evicted without flush.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/data.c  | 4 +++-
 fs/f2fs/dir.c   | 6 ++----
 fs/f2fs/namei.c | 3 +++
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f5fac16..0ae5587 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -249,6 +249,7 @@ int reserve_new_block(struct dnode_of_data *dn)
 
 	__set_data_blkaddr(dn, NEW_ADDR);
 	dn->data_blkaddr = NEW_ADDR;
+	mark_inode_dirty(dn->inode);
 	sync_inode_page(dn);
 	return 0;
 }
@@ -564,7 +565,6 @@ repeat:
 		i_size_write(inode, ((index + 1) << PAGE_CACHE_SHIFT));
 		/* Only the directory inode sets new_i_size */
 		set_inode_flag(F2FS_I(inode), FI_UPDATE_DIR);
-		mark_inode_dirty_sync(inode);
 	}
 	return page;
 
@@ -1060,6 +1060,8 @@ static int f2fs_set_data_page_dirty(struct page
*page)
 	trace_f2fs_set_page_dirty(page, DATA);
 
 	SetPageUptodate(page);
+	mark_inode_dirty(inode);
+
 	if (!PageDirty(page)) {
 		__set_page_dirty_nobuffers(page);
 		set_dirty_dir_page(inode, page);
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index cd055b6..b2b77cc 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -388,6 +388,8 @@ static void update_parent_metadata(struct inode
*dir, struct inode *inode,
 		clear_inode_flag(F2FS_I(inode), FI_NEW_INODE);
 	}
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
+	mark_inode_dirty(dir);
+
 	if (F2FS_I(dir)->i_current_depth != current_depth) {
 		F2FS_I(dir)->i_current_depth = current_depth;
 		set_inode_flag(F2FS_I(dir), FI_UPDATE_DIR);
@@ -395,8 +397,6 @@ static void update_parent_metadata(struct inode
*dir, struct inode *inode,
 
 	if (is_inode_flag_set(F2FS_I(dir), FI_UPDATE_DIR))
 		update_inode_page(dir);
-	else
-		mark_inode_dirty(dir);
 
 	if (is_inode_flag_set(F2FS_I(inode), FI_INC_LINK))
 		clear_inode_flag(F2FS_I(inode), FI_INC_LINK);
@@ -553,8 +553,6 @@ void f2fs_delete_entry(struct f2fs_dir_entry
*dentry, struct page *page,
 	if (inode && S_ISDIR(inode->i_mode)) {
 		drop_nlink(dir);
 		update_inode_page(dir);
-	} else {
-		mark_inode_dirty(dir);
 	}
 
 	if (inode) {
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index a68838d..3d32f29 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -430,6 +430,7 @@ static int f2fs_rename(struct inode *old_dir, struct
dentry *old_dentry,
 		if (old_dir_entry)
 			drop_nlink(new_inode);
 		drop_nlink(new_inode);
+		mark_inode_dirty(new_inode);
 
 		if (!new_inode->i_nlink)
 			add_orphan_inode(sbi, new_inode->i_ino);
@@ -459,11 +460,13 @@ static int f2fs_rename(struct inode *old_dir,
struct dentry *old_dentry,
 			f2fs_set_link(old_inode, old_dir_entry,
 						old_dir_page, new_dir);
 			F2FS_I(old_inode)->i_pino = new_dir->i_ino;
+			update_inode_page(old_inode);
 		} else {
 			kunmap(old_dir_page);
 			f2fs_put_page(old_dir_page, 0);
 		}
 		drop_nlink(old_dir);
+		mark_inode_dirty(old_dir);
 		update_inode_page(old_dir);
 	}
 
-- 
1.8.4.474.g128a96c



-- 
Jaegeuk Kim
Samsung


------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
