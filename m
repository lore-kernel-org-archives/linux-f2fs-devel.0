From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 10/11] f2fs: fix leak of orphan inode objects
Date: Tue,  3 May 2016 11:21:47 -0700
Message-ID: <1462299708-67906-10-git-send-email-jaegeuk@kernel.org>
References: <1462299708-67906-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1axexa-0005zs-FS
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 May 2016 18:22:14 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1axexZ-0005Jk-MC
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 May 2016 18:22:14 +0000
In-Reply-To: <1462299708-67906-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

When unmounting filesystem, we should release all the ino entries.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 6 +++---
 fs/f2fs/f2fs.h       | 2 +-
 fs/f2fs/super.c      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 9169dab..6402e93 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -449,12 +449,12 @@ bool exist_written_data(struct f2fs_sb_info *sbi, nid_t ino, int mode)
 	return e ? true : false;
 }
 
-void release_ino_entry(struct f2fs_sb_info *sbi)
+void release_ino_entry(struct f2fs_sb_info *sbi, bool all)
 {
 	struct ino_entry *e, *tmp;
 	int i;
 
-	for (i = APPEND_INO; i <= UPDATE_INO; i++) {
+	for (i = all ? ORPHAN_INO: APPEND_INO; i <= UPDATE_INO; i++) {
 		struct inode_management *im = &sbi->im[i];
 
 		spin_lock(&im->ino_lock);
@@ -1090,7 +1090,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		invalidate_mapping_pages(META_MAPPING(sbi), discard_blk,
 								discard_blk);
 
-	release_ino_entry(sbi);
+	release_ino_entry(sbi, false);
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 659fdea..6e6fd0b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1910,7 +1910,7 @@ void ra_meta_pages_cond(struct f2fs_sb_info *, pgoff_t);
 long sync_meta_pages(struct f2fs_sb_info *, enum page_type, long);
 void add_ino_entry(struct f2fs_sb_info *, nid_t, int type);
 void remove_ino_entry(struct f2fs_sb_info *, nid_t, int type);
-void release_ino_entry(struct f2fs_sb_info *);
+void release_ino_entry(struct f2fs_sb_info *, bool);
 bool exist_written_data(struct f2fs_sb_info *, nid_t, int);
 int acquire_orphan_inode(struct f2fs_sb_info *);
 void release_orphan_inode(struct f2fs_sb_info *);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 55e8eb0..6b5f0af 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -596,7 +596,7 @@ static void f2fs_put_super(struct super_block *sb)
 	 * normally superblock is clean, so we need to release this.
 	 * In addition, EIO will skip do checkpoint, we need this as well.
 	 */
-	release_ino_entry(sbi);
+	release_ino_entry(sbi, true);
 	release_discard_addrs(sbi);
 
 	f2fs_leave_shrinker(sbi);
-- 
2.6.3


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
