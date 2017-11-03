From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] fsck: check inline_dentry i_addr[0] same as
 inline_data
Date: Fri, 3 Nov 2017 14:29:39 +0800
Message-ID: <1509690579-16102-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <heyunlei@huawei.com>) id 1eAVg2-0001qU-KW
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Nov 2017 06:42:02 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1eAVg0-0003bZ-Ji
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Nov 2017 06:42:02 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Cc: heyunlei@huawei.com, morgan.wang@huawei.com

<4>[   30.222442s][pid:1,cpu4,init][<ffffff8008357ffc>] f2fs_evict_inode+0x850/0xa34
<4>[   30.222442s][pid:1,cpu4,init][<ffffff8008209ec4>] evict+0xa0/0x168
<4>[   30.222442s][pid:1,cpu4,init][<ffffff800820ad34>] iput+0x188/0x220
<4>[   30.222473s][pid:1,cpu4,init][<ffffff800836d050>] recover_orphan_inodes+0x2b4/0xa80
<4>[   30.222473s][pid:1,cpu4,init][<ffffff80083648b0>] f2fs_fill_super+0xcf4/0x16a0
<4>[   30.222473s][pid:1,cpu4,init][<ffffff80081f2478>] mount_bdev+0x198/0x1c8
<4>[   30.222473s][pid:1,cpu4,init][<ffffff80083608a8>] f2fs_mount+0x14/0x1c
<4>[   30.222503s][pid:1,cpu4,init][<ffffff80081f2f38>] mount_fs+0x3c/0x15c
<4>[   30.222503s][pid:1,cpu4,init][<ffffff800820e9f8>] vfs_kern_mount+0x7c/0x16c
<4>[   30.222503s][pid:1,cpu4,init][<ffffff8008212548>] do_mount+0x214/0xcf8
<4>[   30.222503s][pid:1,cpu4,init][<ffffff800821338c>] SyS_mount+0xa8/0x164
<4>[   30.222503s][pid:1,cpu4,init][<ffffff80080831b0>] el0_svc_naked+0x24/0x28

Mount failed with message as blow:
	recover_orphan_inode: orphan failed (ino=1265), run fsck to fix

One orphan directory with inline_dentry flag, but i_addr[0] is not zero.
By the way, sit bitmap of i_addr[0] is also invalidate.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fsck/fsck.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 56a47be..17cf6ff 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -601,6 +601,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 	u32 i_links = le32_to_cpu(node_blk->i.i_links);
 	u64 i_size = le64_to_cpu(node_blk->i.i_size);
 	u64 i_blocks = le64_to_cpu(node_blk->i.i_blocks);
+	int ofs = get_extra_isize(node_blk);
 	unsigned char en[F2FS_NAME_LEN + 1];
 	int namelen;
 	unsigned int idx = 0;
@@ -660,9 +661,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 			ftype == F2FS_FT_FIFO || ftype == F2FS_FT_SOCK)
 		goto check;
 
-	if((node_blk->i.i_inline & F2FS_INLINE_DATA)) {
-		int ofs = get_extra_isize(node_blk);
-
+	if ((node_blk->i.i_inline & F2FS_INLINE_DATA)) {
 		if (le32_to_cpu(node_blk->i.i_addr[ofs]) != 0) {
 			/* should fix this bug all the time */
 			FIX_MSG("inline_data has wrong 0'th block = %x",
@@ -685,8 +684,18 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 		DBG(3, "ino[0x%x] has inline data!\n", nid);
 		goto check;
 	}
-	if((node_blk->i.i_inline & F2FS_INLINE_DENTRY)) {
+
+	if ((node_blk->i.i_inline & F2FS_INLINE_DENTRY)) {
 		DBG(3, "ino[0x%x] has inline dentry!\n", nid);
+		if (le32_to_cpu(node_blk->i.i_addr[ofs]) != 0) {
+			/* should fix this bug all the time */
+			FIX_MSG("inline_dentry has wrong 0'th block = %x",
+					le32_to_cpu(node_blk->i.i_addr[ofs]));
+			node_blk->i.i_addr[ofs] = 0;
+			node_blk->i.i_blocks = cpu_to_le64(*blk_cnt);
+			need_fix = 1;
+		}
+
 		ret = fsck_chk_inline_dentries(sbi, node_blk, &child);
 		if (ret < 0) {
 			/* should fix this bug all the time */
@@ -715,7 +724,6 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 	/* check data blocks in inode */
 	for (idx = 0; idx < ADDRS_PER_INODE(&node_blk->i);
 						idx++, child.pgofs++) {
-		int ofs = get_extra_isize(node_blk);
 		block_t blkaddr = le32_to_cpu(node_blk->i.i_addr[ofs + idx]);
 
 		/* check extent info */
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
