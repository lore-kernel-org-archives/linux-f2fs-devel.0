From: Sahitya Tummala <stummala@codeaurora.org>
Subject: Re: [PATCH 1/2] f2fs: fix sbi->extent_list corruption
 issue
Date: Fri, 23 Nov 2018 09:12:18 +0530
Message-ID: <20181123034218.GA9838@codeaurora.org>
References: <1542884360-19470-1-git-send-email-stummala@codeaurora.org>
 <a1e799ad-a559-12cc-9f2d-a6f037640a35@huawei.com>
 <20181122121107.GB52295@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <stummala@codeaurora.org>) id 1gQ2MU-0000R2-PX
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 23 Nov 2018 03:42:34 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gQ2MT-000MmC-1c
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 23 Nov 2018 03:42:34 +0000
Content-Disposition: inline
In-Reply-To: <20181122121107.GB52295@jaegeuk-macbookpro.roam.corp.google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Thu, Nov 22, 2018 at 04:11:07AM -0800, Jaegeuk Kim wrote:
> On 11/22, Chao Yu wrote:
> > On 2018/11/22 18:59, Sahitya Tummala wrote:
> > > When there is a failure in f2fs_fill_super() after/during
> > > the recovery of fsync'd nodes, it frees the current sbi and
> > > retries again. This time the mount is successful, but the files
> > > that got recovered before retry, still holds the extent tree,
> > > whose extent nodes list is corrupted since sbi and sbi->extent_list
> > > is freed up. The list_del corruption issue is observed when the
> > > file system is getting unmounted and when those recoverd files extent
> > > node is being freed up in the below context.
> > > 
> > > list_del corruption. prev->next should be fffffff1e1ef5480, but was (null)
> > > <...>
> > > kernel BUG at kernel/msm-4.14/lib/list_debug.c:53!
> > > task: fffffff1f46f2280 task.stack: ffffff8008068000
> > > lr : __list_del_entry_valid+0x94/0xb4
> > > pc : __list_del_entry_valid+0x94/0xb4
> > > <...>
> > > Call trace:
> > > __list_del_entry_valid+0x94/0xb4
> > > __release_extent_node+0xb0/0x114
> > > __free_extent_tree+0x58/0x7c
> > > f2fs_shrink_extent_tree+0xdc/0x3b0
> > > f2fs_leave_shrinker+0x28/0x7c
> > > f2fs_put_super+0xfc/0x1e0
> > > generic_shutdown_super+0x70/0xf4
> > > kill_block_super+0x2c/0x5c
> > > kill_f2fs_super+0x44/0x50
> > > deactivate_locked_super+0x60/0x8c
> > > deactivate_super+0x68/0x74
> > > cleanup_mnt+0x40/0x78
> > > __cleanup_mnt+0x1c/0x28
> > > task_work_run+0x48/0xd0
> > > do_notify_resume+0x678/0xe98
> > > work_pending+0x8/0x14
> > > 
> > > Fix this by cleaning up the extent tree of those recovered files
> > > before freeing up sbi and before next retry.
> > 
> > Would it be more clear to call shrink_dcache_sb earlier to invalid all
> > inodes and call f2fs_shrink_extent_tree release cached entries and trees in
> > error path?
> 
> Agreed.
> 
I have tried doing shrink_dcache_sb() earlier but that doesn't call
f2fs_shrink_extent_tree(). So I have moved f2fs_join_shrinker() earlier and 
tried calling f2fs_leave_shrinker() in the error path. That helps to clean up
the cached extent nodes. However, I see that extent tree is left intact for
those recovered files, which should not be a problem as it gets freed as part
of next umount/rm. Only one small problem I see with this is - during rm/umount when
those previoulsy recovered files are being evicted, extent tree memory gets
free'd but the counter sbi->total_ext_tree gets invalid as these recovered
files are not present as part of current sbi->extent_tree_root. So i have come
up with this patch below to fix this. Let me know if this looks good?

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 1cb0fcc..3e4801e 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -654,9 +654,9 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 		}
 		f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
 		list_del_init(&et->list);
-		radix_tree_delete(&sbi->extent_tree_root, et->ino);
+		if (radix_tree_delete(&sbi->extent_tree_root, et->ino))
+			atomic_dec(&sbi->total_ext_tree);
 		kmem_cache_free(extent_tree_slab, et);
-		atomic_dec(&sbi->total_ext_tree);
 		atomic_dec(&sbi->total_zombie_tree);
 		tree_cnt++;
 
@@ -767,7 +767,8 @@ void f2fs_destroy_extent_tree(struct inode *inode)
 	/* delete extent tree entry in radix tree */
 	mutex_lock(&sbi->extent_tree_lock);
 	f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
-	radix_tree_delete(&sbi->extent_tree_root, inode->i_ino);
+	if (radix_tree_delete(&sbi->extent_tree_root, inode->i_ino))
+		atomic_dec(&sbi->total_ext_tree);
 	kmem_cache_free(extent_tree_slab, et);
 	atomic_dec(&sbi->total_ext_tree);
 	mutex_unlock(&sbi->extent_tree_lock);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index af58b2c..3e5588f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3295,6 +3295,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	if (err)
 		goto free_root_inode;
 
+	f2fs_join_shrinker(sbi);
 #ifdef CONFIG_QUOTA
 	/* Enable quota usage during mount */
 	if (f2fs_sb_has_quota_ino(sb) && !f2fs_readonly(sb)) {
@@ -3379,8 +3380,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 			sbi->valid_super_block ? 1 : 2, err);
 	}
 
-	f2fs_join_shrinker(sbi);
-
 	f2fs_tuning_parameters(sbi);
 
 	f2fs_msg(sbi->sb, KERN_NOTICE, "Mounted with checkpoint version = %llx",
@@ -3402,6 +3401,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	 * falls into an infinite loop in f2fs_sync_meta_pages().
 	 */
 	truncate_inode_pages_final(META_MAPPING(sbi));
+	shrink_dcache_sb(sb);
+	f2fs_leave_shrinker(sbi);
 	f2fs_unregister_sysfs(sbi);
 free_root_inode:
 	dput(sb->s_root);
@@ -3445,7 +3446,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	/* give only one another chance */
 	if (retry) {
 		retry = false;
-		shrink_dcache_sb(sb);
 		goto try_onemore;
 	}
 	return err;

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
