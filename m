From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] f2fs: new helper cur_cp_crc() getting crc in
	f2fs_checkpoint
Date: Sat, 25 Feb 2017 19:53:39 +0800
Message-ID: <d042bff5-e707-d4e6-1bbf-429762d0a55a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1chavO-0005V4-Dk
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 11:54:06 +0000
Received: from mail-io0-f196.google.com ([209.85.223.196])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1chavN-0006f8-IO
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 11:54:06 +0000
Received: by mail-io0-f196.google.com with SMTP id w10so1324298iod.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 25 Feb 2017 03:54:05 -0800 (PST)
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
Cc: linux-f2fs-devel@lists.sourceforge.net

There are four places that getting the crc value in f2fs_checkpoint,
just add a new helper cur_cp_crc for them.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/f2fs/checkpoint.c |  3 +--
 fs/f2fs/f2fs.h       |  6 ++++++
 fs/f2fs/node.c       |  5 +----
 fs/f2fs/node.h       | 20 +++++++-------------
 4 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index cd71321..37a216b 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -682,8 +682,7 @@ static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
 		return -EINVAL;
 	}
 
-	crc = le32_to_cpu(*((__le32 *)((unsigned char *)*cp_block
-							+ crc_offset)));
+	crc = cur_cp_crc(*cp_block);
 	if (!f2fs_crc_valid(sbi, crc, *cp_block, crc_offset)) {
 		f2fs_msg(sbi->sb, KERN_WARNING, "invalid crc value");
 		return -EINVAL;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8b6d496..79da17e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1135,6 +1135,12 @@ static inline unsigned long long cur_cp_version(struct f2fs_checkpoint *cp)
 	return le64_to_cpu(cp->checkpoint_ver);
 }
 
+static inline __u64 cur_cp_crc(struct f2fs_checkpoint *cp)
+{
+	size_t crc_offset = le32_to_cpu(cp->checksum_offset);
+	return le32_to_cpu(*((__le32 *)((unsigned char *)cp + crc_offset)));
+}
+
 static inline bool __is_set_ckpt_flags(struct f2fs_checkpoint *cp, unsigned int f)
 {
 	unsigned int ckpt_flags = le32_to_cpu(cp->ckpt_flags);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 8190329..1876288 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2540,9 +2540,6 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
 	unsigned int nat_bits_bytes = nm_i->nat_blocks / BITS_PER_BYTE;
 	unsigned int i;
 	__u64 cp_ver = cur_cp_version(ckpt);
-	size_t crc_offset = le32_to_cpu(ckpt->checksum_offset);
-	__u64 crc = le32_to_cpu(*((__le32 *)
-				((unsigned char *)ckpt + crc_offset)));
 	block_t nat_bits_addr;
 
 	if (!enabled_nat_bits(sbi, NULL))
@@ -2565,7 +2562,7 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
 		f2fs_put_page(page, 1);
 	}
 
-	cp_ver |= (crc << 32);
+	cp_ver |= (cur_cp_crc(ckpt) << 32);
 	if (cpu_to_le64(cp_ver) != *(__le64 *)nm_i->nat_bits) {
 		disable_nat_bits(sbi, true);
 		return 0;
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 3fc9c4b..2f9603f 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -300,14 +300,11 @@ static inline void fill_node_footer_blkaddr(struct page *page, block_t blkaddr)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(F2FS_P_SB(page));
 	struct f2fs_node *rn = F2FS_NODE(page);
-	size_t crc_offset = le32_to_cpu(ckpt->checksum_offset);
-	__u64 cp_ver = le64_to_cpu(ckpt->checkpoint_ver);
+	__u64 cp_ver = cur_cp_version(ckpt);
+
+	if (__is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG))
+		cp_ver |= (cur_cp_crc(ckpt) << 32);
 
-	if (__is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG)) {
-		__u64 crc = le32_to_cpu(*((__le32 *)
-				((unsigned char *)ckpt + crc_offset)));
-		cp_ver |= (crc << 32);
-	}
 	rn->footer.cp_ver = cpu_to_le64(cp_ver);
 	rn->footer.next_blkaddr = cpu_to_le32(blkaddr);
 }
@@ -315,14 +312,11 @@ static inline void fill_node_footer_blkaddr(struct page *page, block_t blkaddr)
 static inline bool is_recoverable_dnode(struct page *page)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(F2FS_P_SB(page));
-	size_t crc_offset = le32_to_cpu(ckpt->checksum_offset);
 	__u64 cp_ver = cur_cp_version(ckpt);
 
-	if (__is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG)) {
-		__u64 crc = le32_to_cpu(*((__le32 *)
-				((unsigned char *)ckpt + crc_offset)));
-		cp_ver |= (crc << 32);
-	}
+	if (__is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG))
+		cp_ver |= (cur_cp_crc(ckpt) << 32);
+
 	return cp_ver == cpver_of_node(page);
 }
 
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
