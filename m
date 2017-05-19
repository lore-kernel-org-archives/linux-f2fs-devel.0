From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH v2] f2fs: fix a bug caused by NULL extent tree
Date: Fri, 19 May 2017 15:06:12 +0800
Message-ID: <1495177572-28886-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1dBcAP-0008Nh-8c
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 May 2017 07:17:41 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dBcAN-0003xu-Jx
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 May 2017 07:17:41 +0000
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
 fs/f2fs/extent_cache.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 2f98d70..ff2352a 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -320,7 +320,7 @@ static void __drop_largest_extent(struct inode *inode,
 }
 
 /* return true, if inode page is changed */
-bool f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext)
+static bool __f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct extent_tree *et;
@@ -358,6 +358,16 @@ bool f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext)
 	return false;
 }
 
+bool f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext)
+{
+	bool ret =  __f2fs_init_extent_tree(inode, i_ext);
+
+	if (!F2FS_I(inode)->extent_tree)
+		set_inode_flag(inode, FI_NO_EXTENT);
+
+	return ret;
+}
+
 static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 							struct extent_info *ei)
 {
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
