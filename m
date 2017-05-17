From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: fix a bug caused by NULL extent tree
Date: Wed, 17 May 2017 14:45:36 +0800
Message-ID: <1495003536-12807-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1dAstM-0003M0-Uk
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 17 May 2017 06:57:04 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dAstK-0004xa-VC
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 17 May 2017 06:57:04 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Thread A:					Thread B:

-f2fs_remount
    -sbi->mount_opt.opt = 0;
						<--- -f2fs_iget
						         -do_read_inode
							     -f2fs_init_extent_tree
							         -F2FS_I(inode)->extent_tree is NULL
        -default_options && parse_options
	    -remount return
						<---  -f2fs_map_blocks
						          -f2fs_lookup_extent_tree
                                                              -f2fs_bug_on(sbi, !et);

The same problem with f2fs_new_inode.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/extent_cache.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 2f98d70..5c9ba22 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -327,6 +327,9 @@ bool f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext)
 	struct extent_node *en;
 	struct extent_info ei;
 
+	if (!test_opt(F2FS_I_SB(inode), EXTENT_CACHE))
+		set_inode_flag(inode, FI_NO_EXTENT);
+
 	if (!f2fs_may_extent_tree(inode)) {
 		/* drop largest extent */
 		if (i_ext && i_ext->len) {
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
