From: Sahitya Tummala <stummala@codeaurora.org>
Subject: deadlock during writeback when using f2fs filesystem
Date: Fri, 1 Jun 2018 15:02:35 +0530
Message-ID: <20180601093235.GA12489@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <stummala@codeaurora.org>) id 1fOgQa-0008WL-0W
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Jun 2018 09:32:56 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fOgQX-004rMU-6f
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Jun 2018 09:32:55 +0000
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: vinmenon@codeaurora.org

Hi,

We are observing a deadlock scenario during FS writeback under low-memory
condition with F2FS filesystem.

Here is the callstack of this scenario -

shrink_inactive_list()
shrink_node_memcg.isra.74()
shrink_node()
shrink_zones(inline)
do_try_to_free_pages(inline)
try_to_free_pages()
__perform_reclaim(inline)
__alloc_pages_direct_reclaim(inline)
__alloc_pages_slowpath(inline)
no_zone()
__alloc_pages(inline)
__alloc_pages_node(inline)
alloc_pages_node(inline)
__page_cache_alloc(inline)
pagecache_get_page()
find_or_create_page(inline)
grab_cache_page(inline)
f2fs_grab_cache_page(inline)
__get_node_page.part.32()
__get_node_page(inline)
get_node_page()
update_inode_page()
f2fs_write_inode()
write_inode(inline)
__writeback_single_inode()
writeback_sb_inodes()
__writeback_inodes_wb()
wb_writeback()
wb_do_writeback(inline)
wb_workfn()

The writeback thread is entering into the direct reclaim path due to low-memory and is
getting stuck in shrink_inactive_list(), as shrink_inactive_list() is inturn waiting for
writeback to happen for the dirty pages present in the inactive list.

Do you think we can use GFP_NOWAIT for node mapping gfp_mask so that we can avoid direct
reclaim path in the writeback context? As we may now see allocation failures with this flag,
do you see any risk or issue in using it w.r.t F2FS FS and writeback?
Appreciate your suggestions on this.

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 89c838b..d3daf3b 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -316,7 +316,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 make_now:
        if (ino == F2FS_NODE_INO(sbi)) {
                inode->i_mapping->a_ops = &f2fs_node_aops;
-               mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_ZERO);
+               mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_NODE_MAPPING);
        } else if (ino == F2FS_META_INO(sbi)) {
                inode->i_mapping->a_ops = &f2fs_meta_aops;
                mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_ZERO);
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 58aecb6..bb985cd 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -47,6 +47,7 @@
 /* This flag is used by node and meta inodes, and by recovery */
 #define GFP_F2FS_ZERO          (GFP_NOFS | __GFP_ZERO)
 #define GFP_F2FS_HIGH_ZERO     (GFP_NOFS | __GFP_ZERO | __GFP_HIGHMEM)
+#define GFP_F2FS_NODE_MAPPING  (GFP_NOWAIT | __GFP_IO | __GFP_ZERO)

Thanks,
Sahitya.
-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
