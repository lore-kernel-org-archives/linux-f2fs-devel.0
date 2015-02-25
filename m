From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: [PATCH 1/2] f2fs: introduce macro __cp_payload
Date: Thu, 26 Feb 2015 07:57:20 +0800
Message-ID: <1424908641-76409-1-git-send-email-wanpeng.li@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wanpeng.li@linux.intel.com>) id 1YQlqA-0008RH-IQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 Feb 2015 23:58:06 +0000
Received: from mga02.intel.com ([134.134.136.20])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YQlq9-0005FS-P0 for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 Feb 2015 23:58:06 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Wanpeng Li <wanpeng.li@linux.intel.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch introduce macro __cp_payload.

Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
---
 fs/f2fs/checkpoint.c | 7 +++----
 fs/f2fs/f2fs.h       | 7 ++++++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 7f794b7..4dbcc81 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -471,8 +471,7 @@ void recover_orphan_inodes(struct f2fs_sb_info *sbi)
 
 	set_sbi_flag(sbi, SBI_POR_DOING);
 
-	start_blk = __start_cp_addr(sbi) + 1 +
-		le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_payload);
+	start_blk = __start_cp_addr(sbi) + 1 + __cp_payload(sbi);
 	orphan_blkaddr = __start_sum_addr(sbi) - 1;
 
 	ra_meta_pages(sbi, start_blk, orphan_blkaddr, META_CP);
@@ -615,7 +614,7 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 	unsigned long blk_size = sbi->blocksize;
 	unsigned long long cp1_version = 0, cp2_version = 0;
 	unsigned long long cp_start_blk_no;
-	unsigned int cp_blks = 1 + le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_payload);
+	unsigned int cp_blks = 1 + __cp_payload(sbi);
 	block_t cp_blk_no;
 	int i;
 
@@ -884,7 +883,7 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	__u32 crc32 = 0;
 	void *kaddr;
 	int i;
-	int cp_payload_blks = le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_payload);
+	int cp_payload_blks = __cp_payload(sbi);
 
 	/*
 	 * This avoids to conduct wrong roll-forward operations and uses
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7fa3313..f8bde23 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -920,12 +920,17 @@ static inline unsigned long __bitmap_size(struct f2fs_sb_info *sbi, int flag)
 	return 0;
 }
 
+static inline block_t __cp_payload(struct f2fs_sb_info *sbi)
+{
+	return le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_payload);
+}
+
 static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	int offset;
 
-	if (le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_payload) > 0) {
+	if (__cp_payload(sbi) > 0) {
 		if (flag == NAT_BITMAP)
 			return &ckpt->sit_nat_version_bitmap;
 		else
-- 
1.9.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
