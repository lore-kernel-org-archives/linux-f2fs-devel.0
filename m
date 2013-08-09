From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 3/3] f2fs: introduce cur_cp_versioin function to
 reduce code size
Date: Fri, 09 Aug 2013 15:20:30 +0900
Message-ID: <1376029230-303-3-git-send-email-jaegeuk.kim@samsung.com>
References: <1376029230-303-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1V7g4X-0000dQ-Ew
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 09 Aug 2013 06:21:13 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V7g4W-0001yF-DT for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 09 Aug 2013 06:21:13 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MR900KYX2Z1YL60@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 09 Aug 2013 15:21:01 +0900 (KST)
In-reply-to: <1376029230-303-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch introduces a new inline function, cur_cp_version, to reduce redundant
codes.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/checkpoint.c | 6 +++---
 fs/f2fs/f2fs.h       | 7 ++++++-
 fs/f2fs/file.c       | 3 +--
 fs/f2fs/recovery.c   | 4 ++--
 fs/f2fs/xattr.c      | 2 +-
 5 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index c5a5c39..bb31220 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -379,7 +379,7 @@ static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
 	if (!f2fs_crc_valid(crc, cp_block, crc_offset))
 		goto invalid_cp1;
 
-	pre_version = le64_to_cpu(cp_block->checkpoint_ver);
+	pre_version = cur_cp_version(cp_block);
 
 	/* Read the 2nd cp block in this CP pack */
 	cp_addr += le32_to_cpu(cp_block->cp_pack_total_block_count) - 1;
@@ -394,7 +394,7 @@ static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
 	if (!f2fs_crc_valid(crc, cp_block, crc_offset))
 		goto invalid_cp2;
 
-	cur_version = le64_to_cpu(cp_block->checkpoint_ver);
+	cur_version = cur_cp_version(cp_block);
 
 	if (cur_version == pre_version) {
 		*version = cur_version;
@@ -799,7 +799,7 @@ void write_checkpoint(struct f2fs_sb_info *sbi, bool is_umount)
 	 * Increase the version number so that
 	 * SIT entries and seg summaries are written at correct place
 	 */
-	ckpt_ver = le64_to_cpu(ckpt->checkpoint_ver);
+	ckpt_ver = cur_cp_version(ckpt);
 	ckpt->checkpoint_ver = cpu_to_le64(++ckpt_ver);
 
 	/* write cached NAT/SIT entries to NAT/SIT area */
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c1c9670..5348b63 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -503,6 +503,11 @@ static inline void F2FS_RESET_SB_DIRT(struct f2fs_sb_info *sbi)
 	sbi->s_dirty = 0;
 }
 
+static inline unsigned long long cur_cp_version(struct f2fs_checkpoint *cp)
+{
+	return le64_to_cpu(cp->checkpoint_ver);
+}
+
 static inline bool is_set_ckpt_flags(struct f2fs_checkpoint *cp, unsigned int f)
 {
 	unsigned int ckpt_flags = le32_to_cpu(cp->ckpt_flags);
@@ -691,7 +696,7 @@ static inline block_t __start_cp_addr(struct f2fs_sb_info *sbi)
 {
 	block_t start_addr;
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
-	unsigned long long ckpt_version = le64_to_cpu(ckpt->checkpoint_ver);
+	unsigned long long ckpt_version = cur_cp_version(ckpt);
 
 	start_addr = le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_blkaddr);
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 49a414d..dface4f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -161,8 +161,7 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		need_cp = true;
 	else if (!is_checkpointed_node(sbi, F2FS_I(inode)->i_pino))
 		need_cp = true;
-	else if (F2FS_I(inode)->xattr_ver ==
-			le64_to_cpu(F2FS_CKPT(sbi)->checkpoint_ver))
+	else if (F2FS_I(inode)->xattr_ver == cur_cp_version(F2FS_CKPT(sbi)))
 		need_cp = true;
 
 	if (need_cp) {
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 639eb34..c6908b5 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -117,7 +117,7 @@ static int recover_inode(struct inode *inode, struct page *node_page)
 
 static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
 {
-	unsigned long long cp_ver = le64_to_cpu(sbi->ckpt->checkpoint_ver);
+	unsigned long long cp_ver = cur_cp_version(F2FS_CKPT(sbi));
 	struct curseg_info *curseg;
 	struct page *page;
 	block_t blkaddr;
@@ -355,7 +355,7 @@ err:
 static int recover_data(struct f2fs_sb_info *sbi,
 				struct list_head *head, int type)
 {
-	unsigned long long cp_ver = le64_to_cpu(sbi->ckpt->checkpoint_ver);
+	unsigned long long cp_ver = cur_cp_version(F2FS_CKPT(sbi));
 	struct curseg_info *curseg;
 	struct page *page;
 	int err = 0;
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 0f6d2a1..fb16f71 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -488,7 +488,7 @@ int f2fs_setxattr(struct inode *inode, int name_index, const char *name,
 	}
 
 	/* store checkpoint version for conducting checkpoint during fsync */
-	fi->xattr_ver = le64_to_cpu(F2FS_CKPT(sbi)->checkpoint_ver);
+	fi->xattr_ver = cur_cp_version(F2FS_CKPT(sbi));
 
 	if (ipage)
 		update_inode(inode, ipage);
-- 
1.8.3.1.437.g0dbd812


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
