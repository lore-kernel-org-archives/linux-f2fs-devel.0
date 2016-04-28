From: Chao Yu <chao@kernel.org>
Subject: [PATCH 4/4] f2fs: fix inode cache leak
Date: Thu, 28 Apr 2016 23:17:19 +0800
Message-ID: <5722297F.9020807@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1avnhG-0008HA-3Y
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Apr 2016 15:17:42 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1avnhA-00012K-8D
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Apr 2016 15:17:42 +0000
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

From: Chao Yu <yuchao0@huawei.com>

When testing f2fs with inline_dentry option, generic/342 reports:
VFS: Busy inodes after unmount of dm-0. Self-destruct in 5 seconds.  Have a nice
day...

After rmmod f2fs module, kenrel shows following dmesg:
 =============================================================================
 BUG f2fs_inode_cache (Tainted: G           O   ): Objects remaining in
f2fs_inode_cache on __kmem_cache_shutdown()
 -----------------------------------------------------------------------------

 Disabling lock debugging due to kernel taint
 INFO: Slab 0xf51ca0e0 objects=22 used=1 fp=0xd1e6fc60 flags=0x40004080
 CPU: 3 PID: 7455 Comm: rmmod Tainted: G    B      O    4.6.0-rc4+ #16
 Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
  00000086 00000086 d062fe18 c13a83a0 f51ca0e0 d062fe38 d062fea4 c11c7276
  c1981040 f51ca0e0 00000016 00000001 d1e6fc60 40004080 656a624f 20737463
  616d6572 6e696e69 6e692067 66326620 6e695f73 5f65646f 68636163 6e6f2065
 Call Trace:
  [<c13a83a0>] dump_stack+0x5f/0x8f
  [<c11c7276>] slab_err+0x76/0x80
  [<c11cbfc0>] ? __kmem_cache_shutdown+0x100/0x2f0
  [<c11cbfc0>] ? __kmem_cache_shutdown+0x100/0x2f0
  [<c11cbfe5>] __kmem_cache_shutdown+0x125/0x2f0
  [<c1198a38>] kmem_cache_destroy+0x158/0x1f0
  [<c176b43d>] ? mutex_unlock+0xd/0x10
  [<f8f15aa3>] exit_f2fs_fs+0x4b/0x5a8 [f2fs]
  [<c10f596c>] SyS_delete_module+0x16c/0x1d0
  [<c1001b10>] ? do_fast_syscall_32+0x30/0x1c0
  [<c13c59bf>] ? __this_cpu_preempt_check+0xf/0x20
  [<c10afa7d>] ? trace_hardirqs_on_caller+0xdd/0x210
  [<c10ad50b>] ? trace_hardirqs_off+0xb/0x10
  [<c1001b81>] do_fast_syscall_32+0xa1/0x1c0
  [<c176d888>] sysenter_past_esp+0x45/0x74
 INFO: Object 0xd1e6d9e0 @offset=6624
 kmem_cache_destroy f2fs_inode_cache: Slab cache still has objects
 CPU: 3 PID: 7455 Comm: rmmod Tainted: G    B      O    4.6.0-rc4+ #16
 Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
  00000286 00000286 d062fef4 c13a83a0 f174b000 d062ff14 d062ff28 c1198ac7
  c197fe18 f3c5b980 d062ff20 000d04f2 d062ff0c d062ff0c d062ff14 d062ff14
  f8f20dc0 fffffff5 d062e000 d062ff30 f8f15aa3 d062ff7c c10f596c 73663266
 Call Trace:
  [<c13a83a0>] dump_stack+0x5f/0x8f
  [<c1198ac7>] kmem_cache_destroy+0x1e7/0x1f0
  [<f8f15aa3>] exit_f2fs_fs+0x4b/0x5a8 [f2fs]
  [<c10f596c>] SyS_delete_module+0x16c/0x1d0
  [<c1001b10>] ? do_fast_syscall_32+0x30/0x1c0
  [<c13c59bf>] ? __this_cpu_preempt_check+0xf/0x20
  [<c10afa7d>] ? trace_hardirqs_on_caller+0xdd/0x210
  [<c10ad50b>] ? trace_hardirqs_off+0xb/0x10
  [<c1001b81>] do_fast_syscall_32+0xa1/0x1c0
  [<c176d888>] sysenter_past_esp+0x45/0x74

The reason is: in recovery flow, we use delayed iput mechanism for directory
which has recovered dentry block. It means the reference of inode will be
held until last dirty dentry page being writebacked.

But when we mount f2fs with inline_dentry option, during recovery, dirent
may only be recovered into dir inode page rather than dentry page, so there
are no chance for us to release inode reference in ->writepage when
writebacking last dentry page.

This patch fixes this issue by obsoleting old mechanism, and call iput
explicitly pairing iget instead.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 16 ----------------
 fs/f2fs/f2fs.h       |  2 --
 fs/f2fs/recovery.c   | 15 +++------------
 3 files changed, 3 insertions(+), 30 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index bf040b5..dc7bc72 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -786,19 +786,9 @@ void update_dirty_page(struct inode *inode, struct page *page)
 	f2fs_trace_pid(page);
 }

-void add_dirty_dir_inode(struct inode *inode)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-
-	spin_lock(&sbi->inode_lock[DIR_INODE]);
-	__add_dirty_inode(inode, DIR_INODE);
-	spin_unlock(&sbi->inode_lock[DIR_INODE]);
-}
-
 void remove_dirty_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct f2fs_inode_info *fi = F2FS_I(inode);
 	enum inode_type type = S_ISDIR(inode->i_mode) ? DIR_INODE : FILE_INODE;

 	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode) &&
@@ -808,12 +798,6 @@ void remove_dirty_inode(struct inode *inode)
 	spin_lock(&sbi->inode_lock[type]);
 	__remove_dirty_inode(inode, type);
 	spin_unlock(&sbi->inode_lock[type]);
-
-	/* Only from the recovery routine */
-	if (is_inode_flag_set(fi, FI_DELAY_IPUT)) {
-		clear_inode_flag(fi, FI_DELAY_IPUT);
-		iput(inode);
-	}
 }

 int sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0786a45..a87625f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1455,7 +1455,6 @@ enum {
 	FI_NO_ALLOC,		/* should not allocate any blocks */
 	FI_FREE_NID,		/* free allocated nide */
 	FI_UPDATE_DIR,		/* should update inode block for consistency */
-	FI_DELAY_IPUT,		/* used for the recovery */
 	FI_NO_EXTENT,		/* not to use the extent cache */
 	FI_INLINE_XATTR,	/* used for inline xattr */
 	FI_INLINE_DATA,		/* used for inline data*/
@@ -1886,7 +1885,6 @@ void remove_orphan_inode(struct f2fs_sb_info *, nid_t);
 int recover_orphan_inodes(struct f2fs_sb_info *);
 int get_valid_checkpoint(struct f2fs_sb_info *);
 void update_dirty_page(struct inode *, struct page *);
-void add_dirty_dir_inode(struct inode *);
 void remove_dirty_inode(struct inode *);
 int sync_dirty_inodes(struct f2fs_sb_info *, enum inode_type);
 int write_checkpoint(struct f2fs_sb_info *, struct cp_control *);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 481f94e..395c212 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -116,7 +116,7 @@ static int recover_dentry(struct inode *inode, struct page
*ipage)
 	if (unlikely(name.len > F2FS_NAME_LEN)) {
 		WARN_ON(1);
 		err = -ENAMETOOLONG;
-		goto out_err;
+		goto out_iput;
 	}
 retry:
 	de = f2fs_find_entry(dir, &name, &page);
@@ -142,22 +142,13 @@ retry:
 		goto retry;
 	}
 	err = __f2fs_add_link(dir, &name, inode, inode->i_ino, inode->i_mode);
-	if (err)
-		goto out_err;
-
-	if (is_inode_flag_set(F2FS_I(dir), FI_DELAY_IPUT)) {
-		iput(dir);
-	} else {
-		add_dirty_dir_inode(dir);
-		set_inode_flag(F2FS_I(dir), FI_DELAY_IPUT);
-	}

-	goto out;
+	goto out_iput;

 out_unmap_put:
 	f2fs_dentry_kunmap(dir, page);
 	f2fs_put_page(page, 0);
-out_err:
+out_iput:
 	iput(dir);
 out:
 	f2fs_msg(inode->i_sb, KERN_NOTICE,
-- 
2.7.2


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
