From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: recover invalid/reserved block address for
	fsynced file
Date: Wed, 05 Aug 2015 17:23:54 +0800
Message-ID: <009e01d0cf60$8b66bb00$a2343100$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZMuwG-0004YA-N3
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Aug 2015 09:24:44 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZMuwE-0005Sl-Mx
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Aug 2015 09:24:44 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NSL0129JRGPM240@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Aug 2015 18:24:35 +0900 (KST)
Content-language: zh-cn
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

When testing with generic/101 in xfstests, error message outputed as below:

    --- tests/generic/101.out
    +++ results//generic/101.out.bad
    @@ -10,10 +10,14 @@
     File foo content after log replay:
     0000000 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
     *
    -0200000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    +0200000 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
     *
     0372000
    ...
    (Run 'diff -u tests/generic/101.out results/generic/101.out.bad'  to see the entire diff)

The test flow is like below:
1. pwrite foo -S 0xaa 0 64K
2. pwrite foo -S 0xbb 64K 61K
3. sync
4. truncate foo 64K
5. truncate foo 125K
6. fsync foo
7. flakey drop writes
8. umount

After this test, we expect the data of recovered file will have the first
64k of data filling with value 0xaa and the next 61k of data filling with
value 0x00 because we have fsynced it before dropping writes in dm.

In f2fs, during recovering, we will only recover the valid block address
in direct node page if it is marked as a fsynced dnode, but block address
which means invalid/reserved (with value NULL_ADDR/NEW_ADDR) will not be
recovered. So, the file recovered shows its incorrect data 0xbb in range of
[61k, 125k].

In this patch, we fix to recover invalid/reserved block during recover flow.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/recovery.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 07a36e4..d2ef0c9 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -399,14 +399,35 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	f2fs_bug_on(sbi, ni.ino != ino_of_node(page));
 	f2fs_bug_on(sbi, ofs_of_node(dn.node_page) != ofs_of_node(page));
 
-	for (; start < end; start++) {
+	for (; start < end; start++, dn.ofs_in_node++) {
 		block_t src, dest;
 
 		src = datablock_addr(dn.node_page, dn.ofs_in_node);
 		dest = datablock_addr(page, dn.ofs_in_node);
 
-		if (src != dest && dest != NEW_ADDR && dest != NULL_ADDR &&
-			is_valid_blkaddr(sbi, dest, META_POR)) {
+		/* skip recovering if dest is the same as src */
+		if (src == dest)
+			continue;
+
+		/* dest is invalid, just invalidate src block */
+		if (dest == NULL_ADDR) {
+			truncate_data_blocks_range(&dn, 1);
+			continue;
+		}
+
+		/*
+		 * dest is reserved block, invalidate src block
+		 * and then reserve one new block in dnode page.
+		 */
+		if (dest == NEW_ADDR) {
+			truncate_data_blocks_range(&dn, 1);
+			err = reserve_new_block(&dn);
+			f2fs_bug_on(sbi, err);
+			continue;
+		}
+
+		/* dest is valid block, try to recover from src to dest */
+		if (is_valid_blkaddr(sbi, dest, META_POR)) {
 
 			if (src == NULL_ADDR) {
 				err = reserve_new_block(&dn);
@@ -424,7 +445,6 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 							ni.version, false);
 			recovered++;
 		}
-		dn.ofs_in_node++;
 	}
 
 	if (IS_INODE(dn.node_page))
-- 
2.4.2



------------------------------------------------------------------------------
