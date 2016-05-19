From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: flush pending bios right away when error
	occurs
Date: Thu, 19 May 2016 09:43:45 -0700
Message-ID: <1463676225-73614-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b3R3B-0003BF-E2
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 May 2016 16:43:53 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b3R39-0000bB-Hv
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 May 2016 16:43:53 +0000
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

Given errors, this patch flushes pending bios as soon as possible.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 7 +++++++
 fs/f2fs/f2fs.h       | 7 +------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index cf79598..ecf7153 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -26,6 +26,13 @@
 static struct kmem_cache *ino_entry_slab;
 struct kmem_cache *inode_entry_slab;
 
+void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi)
+{
+	set_ckpt_flags(sbi->ckpt, CP_ERROR_FLAG);
+	sbi->sb->s_flags |= MS_RDONLY;
+	f2fs_flush_merged_bios(sbi);
+}
+
 /*
  * We guarantee no failure on the returned page.
  */
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 02f0656..6550263 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1698,12 +1698,6 @@ static inline bool f2fs_cp_error(struct f2fs_sb_info *sbi)
 	return is_set_ckpt_flags(sbi->ckpt, CP_ERROR_FLAG);
 }
 
-static inline void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi)
-{
-	set_ckpt_flags(sbi->ckpt, CP_ERROR_FLAG);
-	sbi->sb->s_flags |= MS_RDONLY;
-}
-
 static inline bool is_dot_dotdot(const struct qstr *str)
 {
 	if (str->len == 1 && str->name[0] == '.')
@@ -1937,6 +1931,7 @@ void destroy_segment_manager_caches(void);
 /*
  * checkpoint.c
  */
+void f2fs_stop_checkpoint(struct f2fs_sb_info *);
 struct page *grab_meta_page(struct f2fs_sb_info *, pgoff_t);
 struct page *get_meta_page(struct f2fs_sb_info *, pgoff_t);
 struct page *get_tmp_page(struct f2fs_sb_info *, pgoff_t);
-- 
2.6.3


------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
