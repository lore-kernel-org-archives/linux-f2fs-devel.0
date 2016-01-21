From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [oops, 4.4-rc8] warn + oops during generic/204
Date: Thu, 21 Jan 2016 19:46:10 +0800
Message-ID: <008501d15441$68c7d870$3a578950$@samsung.com>
References: <20160120213102.GF20456@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aMDhd-0002Tm-C4
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 21 Jan 2016 11:47:01 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aMDha-00027C-Eb
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 21 Jan 2016 11:47:01 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O1A01ZP5WQ2SE80@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 21 Jan 2016 20:46:50 +0900 (KST)
In-reply-to: <20160120213102.GF20456@dastard>
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
To: 'Dave Chinner' <david@fromorbit.com>, linux-f2fs-devel@lists.sourceforge.net

Hi Dave,

> -----Original Message-----
> From: Dave Chinner [mailto:david@fromorbit.com]
> Sent: Thursday, January 21, 2016 5:31 AM
> To: linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [oops, 4.4-rc8] warn + oops during generic/204
> 
> Hi f2fs folks,
> 
> I just ran xfstests on f2fs using defaults and a pair of 4GB ram
> disks for the test and scratch devices, and it hard locked the
> machine with this failure in generic/204:

Thanks for your report! :)

Hi all,

We didn't handle well with the case of inline data storm which floods
full disk. Actually the reason is: if we have 10M free space, and user
fillings the disk with ~10M inline data, then in memory there are ~10M
dirty inline datas and ~10M dirty inodes, once inodes were writebacked
before inline datas, all free space will be occupied, then we have to
write these dirty inline datas to ovp area which doesn't have enough
space there normally.

IMO, one solution could be: when writebacking node pages, we could
verify the number of dirty inline data pages, if there are too many of
them (which may potentially cause running out of free space), merging
data of inline pages into inode pages with enough number.

Or better ideas? :)

---
 fs/f2fs/checkpoint.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h       |  6 +++++-
 fs/f2fs/inline.c     |  3 +++
 fs/f2fs/segment.c    |  3 +++
 fs/f2fs/segment.h    |  9 +++++++++
 5 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index c75b148..b95deb1 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -844,6 +844,55 @@ retry:
 	goto retry;
 }
 
+int sync_inline_inode_page(struct f2fs_sb_info *sbi)
+{
+	struct list_head *head;
+	struct inode *inode;
+	struct f2fs_inode_info *fi;
+
+retry:
+	if (!get_pages(sbi, F2FS_DIRTY_INLINE))
+		return 0;
+
+	if (!has_inline_data_exceeded(sbi))
+		return 0;
+
+	if (unlikely(f2fs_cp_error(sbi)))
+		return -EIO;
+
+	spin_lock(&sbi->inode_lock[FILE_INODE]);
+	head = &sbi->inode_list[FILE_INODE];
+	if (list_empty(head)) {
+		spin_unlock(&sbi->inode_lock[FILE_INODE]);
+		return 0;
+	}
+
+	fi = list_entry(head->next, struct f2fs_inode_info, dirty_list);
+	inode = igrab(&fi->vfs_inode);
+	spin_unlock(&sbi->inode_lock[FILE_INODE]);
+
+	if (inode) {
+		if (f2fs_has_inline_data(inode))
+			filemap_fdatawrite(inode->i_mapping);
+
+		spin_lock(&sbi->inode_lock[FILE_INODE]);
+		if (is_inode_flag_set(fi, FI_DIRTY_FILE))
+			list_move_tail(&fi->dirty_list,
+					&sbi->inode_list[FILE_INODE]);
+		spin_unlock(&sbi->inode_lock[FILE_INODE]);
+
+		iput(inode);
+	} else {
+		/*
+		 * We should submit bio, since it exists several
+		 * wribacking dentry pages in the freeing inode.
+		 */
+		f2fs_submit_merged_bio(sbi, DATA, WRITE);
+		cond_resched();
+	}
+	goto retry;
+}
+
 /*
  * Freeze all the FS-operations for checkpoint.
  */
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 456e478..dc7f679 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -654,6 +654,7 @@ enum count_type {
 	F2FS_WRITEBACK,
 	F2FS_DIRTY_DENTS,
 	F2FS_DIRTY_DATA,
+	F2FS_DIRTY_INLINE,
 	F2FS_DIRTY_NODES,
 	F2FS_DIRTY_META,
 	F2FS_INMEM_PAGES,
@@ -1103,12 +1104,14 @@ static inline void inc_page_count(struct f2fs_sb_info *sbi, int count_type)
 	atomic_inc(&sbi->nr_pages[count_type]);
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
 }
-
+static inline int f2fs_has_inline_data(struct inode *inode);
 static inline void inode_inc_dirty_pages(struct inode *inode)
 {
 	atomic_inc(&F2FS_I(inode)->dirty_pages);
 	inc_page_count(F2FS_I_SB(inode), S_ISDIR(inode->i_mode) ?
 				F2FS_DIRTY_DENTS : F2FS_DIRTY_DATA);
+	if (f2fs_has_inline_data(inode))
+		inc_page_count(F2FS_I_SB(inode), F2FS_DIRTY_INLINE);
 }
 
 static inline void dec_page_count(struct f2fs_sb_info *sbi, int count_type)
@@ -1875,6 +1878,7 @@ void update_dirty_page(struct inode *, struct page *);
 void add_dirty_dir_inode(struct inode *);
 void remove_dirty_inode(struct inode *);
 int sync_dirty_inodes(struct f2fs_sb_info *, enum inode_type);
+int sync_inline_inode_page(struct f2fs_sb_info *);
 int write_checkpoint(struct f2fs_sb_info *, struct cp_control *);
 void init_ino_entry_info(struct f2fs_sb_info *);
 int __init create_checkpoint_caches(void);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index c3f0b7d..2b3068b 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -162,6 +162,7 @@ no_update:
 clear_out:
 	stat_dec_inline_inode(dn->inode);
 	f2fs_clear_inline_inode(dn->inode);
+	dec_page_count(F2FS_I_SB(dn->inode), F2FS_DIRTY_INLINE);
 	sync_inode_page(dn);
 	f2fs_put_dnode(dn);
 	return 0;
@@ -232,6 +233,8 @@ int f2fs_write_inline_data(struct inode *inode, struct page *page)
 	set_inode_flag(F2FS_I(inode), FI_APPEND_WRITE);
 	set_inode_flag(F2FS_I(inode), FI_DATA_EXIST);
 
+	dec_page_count(F2FS_I_SB(inode), F2FS_DIRTY_INLINE);
+
 	sync_inode_page(&dn);
 	f2fs_put_dnode(&dn);
 	return 0;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 070988b..9dbd748 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -290,6 +290,9 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 	if (!available_free_memory(sbi, FREE_NIDS))
 		try_to_free_nids(sbi, NAT_ENTRY_PER_BLOCK * FREE_NID_PAGES);
 
+	/* sync dirty pages of inline inode to inode page */
+	sync_inline_inode_page(sbi);
+
 	/* checkpoint is the only way to shrink partial cached entries */
 	if (!available_free_memory(sbi, NAT_ENTRIES) ||
 			!available_free_memory(sbi, INO_ENTRIES) ||
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index ee44d34..e0d984dd 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -482,6 +482,15 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi, int freed)
 						reserved_sections(sbi));
 }
 
+static inline bool has_inline_data_exceeded(struct f2fs_sb_info *sbi)
+{
+	int node_secs = get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
+	int dent_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DENTS);
+	int inline_secs = get_blocktype_secs(sbi, F2FS_DIRTY_INLINE);
+
+	return free_sections(sbi) <= (node_secs + 2 * dent_secs + inline_secs);
+}
+
 static inline bool excess_prefree_segs(struct f2fs_sb_info *sbi)
 {
 	return prefree_segments(sbi) > SM_I(sbi)->rec_prefree_segments;
-- 
2.7.0.2.g1b0b6dd

Thanks,

> 
> [  125.141471] run fstests generic/204 at 2016-01-21 08:24:22
> [  127.582183] ------------[ cut here ]------------
> [  127.583225] WARNING: CPU: 10 PID: 1224 at fs/f2fs/segment.c:916 new_curseg+0x296/0x380()
> [  127.584904] Modules linked in:
> [  127.585558] CPU: 10 PID: 1224 Comm: kworker/u32:3 Not tainted 4.4.0-rc8-dgc+ #631
> [  127.587057] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Debian-1.8.2-1
> 04/01/2014
> [  127.589329] Workqueue: writeback wb_workfn (flush-1:1)
> [  127.590966]  ffffffff82251760 ffff88042a163888 ffffffff817a25b9 0000000000000000
> [  127.593762]  ffff88042a1638c0 ffffffff810aa006 0000000000000002 0000000000000001
> [  127.596839]  ffff8804260e1800 000000000000002d ffff880429e4a800 ffff88042a1638d0
> [  127.599825] Call Trace:
> [  127.600832]  [<ffffffff817a25b9>] dump_stack+0x4b/0x72
> [  127.602821]  [<ffffffff810aa006>] warn_slowpath_common+0x86/0xc0
> [  127.605184]  [<ffffffff810aa0fa>] warn_slowpath_null+0x1a/0x20
> [  127.607337]  [<ffffffff816ee4b6>] new_curseg+0x296/0x380
> [  127.608980]  [<ffffffff816ee91d>] allocate_segment_by_default+0x1dd/0x1e0
> [  127.611439]  [<ffffffff816eec6d>] allocate_data_block+0x15d/0x2e0
> [  127.613590]  [<ffffffff816eefad>] do_write_page+0x1bd/0x280
> [  127.615503]  [<ffffffff816ef0f3>] write_node_page+0x23/0x30
> [  127.617443]  [<ffffffff816e7ce5>] f2fs_write_node_page+0x125/0x240
> [  127.619483]  [<ffffffff816e9b31>] sync_node_pages+0x401/0x600
> [  127.621388]  [<ffffffff816e9e38>] f2fs_write_node_pages+0x108/0x130
> [  127.623451]  [<ffffffff811941c1>] do_writepages+0x21/0x30
> [  127.625205]  [<ffffffff811feb25>] __writeback_single_inode+0x45/0x330
> [  127.627304]  [<ffffffff811ff2bb>] writeback_sb_inodes+0x25b/0x4d0
> [  127.629214]  [<ffffffff811ff788>] wb_writeback+0xf8/0x2d0
> [  127.630862]  [<ffffffff8120251e>] wb_workfn+0xfe/0x3b0
> [  127.632464]  [<ffffffff81dcba7e>] ? _raw_spin_unlock_irq+0xe/0x30
> [  127.634289]  [<ffffffff810cedfb>] ? finish_task_switch+0x8b/0x220
> [  127.636069]  [<ffffffff810c17ce>] process_one_work+0x14e/0x410
> [  127.637877]  [<ffffffff810c1dde>] worker_thread+0x4e/0x460
> [  127.639569]  [<ffffffff810c1d90>] ? rescuer_thread+0x300/0x300
> [  127.641284]  [<ffffffff810c1d90>] ? rescuer_thread+0x300/0x300
> [  127.642925]  [<ffffffff810c7176>] kthread+0xe6/0x100
> [  127.644325]  [<ffffffff810c7090>] ? kthread_create_on_node+0x190/0x190
> [  127.646032]  [<ffffffff81dcc30f>] ret_from_fork+0x3f/0x70
> [  127.647504]  [<ffffffff810c7090>] ? kthread_create_on_node+0x190/0x190
> [  127.649285] ---[ end trace 2107b831b703fa3a ]---
> [  127.650532] ------------[ cut here ]------------
> [  127.651780] WARNING: CPU: 10 PID: 1224 at fs/f2fs/segment.c:955 new_curseg+0x358/0x380()
> [  127.653918] Modules linked in:
> [  127.654752] CPU: 10 PID: 1224 Comm: kworker/u32:3 Tainted: G        W       4.4.0-rc8-dgc+
> #631
> [  127.657046] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Debian-1.8.2-1
> 04/01/2014
> [  127.659372] Workqueue: writeback wb_workfn (flush-1:1)
> [  127.660791]  ffffffff82251760 ffff88042a163888 ffffffff817a25b9 0000000000000000
> [  127.662825]  ffff88042a1638c0 ffffffff810aa006 000000000000002d 0000000000000001
> [  127.664791]  ffff8804260e1800 ffff880429e4a800 ffff8804260e1800 ffff88042a1638d0
> [  127.666679] Call Trace:
> [  127.667287]  [<ffffffff817a25b9>] dump_stack+0x4b/0x72
> [  127.668562]  [<ffffffff810aa006>] warn_slowpath_common+0x86/0xc0
> [  127.670025]  [<ffffffff810aa0fa>] warn_slowpath_null+0x1a/0x20
> [  127.671455]  [<ffffffff816ee578>] new_curseg+0x358/0x380
> [  127.672761]  [<ffffffff816ee91d>] allocate_segment_by_default+0x1dd/0x1e0
> [  127.674397]  [<ffffffff816eec6d>] allocate_data_block+0x15d/0x2e0
> [  127.675918]  [<ffffffff816eefad>] do_write_page+0x1bd/0x280
> [  127.677254]  [<ffffffff816ef0f3>] write_node_page+0x23/0x30
> [  127.678510]  [<ffffffff816e7ce5>] f2fs_write_node_page+0x125/0x240
> [  127.679930]  [<ffffffff816e9b31>] sync_node_pages+0x401/0x600
> [  127.681264]  [<ffffffff816e9e38>] f2fs_write_node_pages+0x108/0x130
> [  127.682729]  [<ffffffff811941c1>] do_writepages+0x21/0x30
> [  127.684009]  [<ffffffff811feb25>] __writeback_single_inode+0x45/0x330
> [  127.685532]  [<ffffffff811ff2bb>] writeback_sb_inodes+0x25b/0x4d0
> [  127.686913]  [<ffffffff811ff788>] wb_writeback+0xf8/0x2d0
> [  127.688223]  [<ffffffff8120251e>] wb_workfn+0xfe/0x3b0
> [  127.689370]  [<ffffffff81dcba7e>] ? _raw_spin_unlock_irq+0xe/0x30
> [  127.690696]  [<ffffffff810cedfb>] ? finish_task_switch+0x8b/0x220
> [  127.692054]  [<ffffffff810c17ce>] process_one_work+0x14e/0x410
> [  127.693361]  [<ffffffff810c1dde>] worker_thread+0x4e/0x460
> [  127.694569]  [<ffffffff810c1d90>] ? rescuer_thread+0x300/0x300
> [  127.695905]  [<ffffffff810c1d90>] ? rescuer_thread+0x300/0x300
> [  127.697110]  [<ffffffff810c7176>] kthread+0xe6/0x100
> [  127.698083]  [<ffffffff810c7090>] ? kthread_create_on_node+0x190/0x190
> [  127.699388]  [<ffffffff81dcc30f>] ret_from_fork+0x3f/0x70
> [  127.700484]  [<ffffffff810c7090>] ? kthread_create_on_node+0x190/0x190
> [  127.701743] ---[ end trace 2107b831b703fa3b ]---
> [  127.702644] BUG: unable to handle kernel NULL pointer dereference at           (null)
> [  127.704234] IP: [<ffffffff816ec3d8>] update_sit_entry+0xe8/0x270
> [  127.705434] PGD 0
> [  127.705859] Oops: 0000 [#1] PREEMPT SMP
> [  127.706687] Modules linked in:
> [  127.707323] CPU: 10 PID: 1224 Comm: kworker/u32:3 Tainted: G        W       4.4.0-rc8-dgc+
> #631
> [  127.709037] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Debian-1.8.2-1
> 04/01/2014
> [  127.710743] Workqueue: writeback wb_workfn (flush-1:1)
> [  127.711798] task: ffff88042a144580 ti: ffff88042a160000 task.ti: ffff88042a160000
> [  127.713260] RIP: 0010:[<ffffffff816ec3d8>]  [<ffffffff816ec3d8>]
> update_sit_entry+0xe8/0x270
> [  127.714921] RSP: 0018:ffff88042a163908  EFLAGS: 00010202
> [  127.715952] RAX: 0000000000000000 RBX: ffff8804260e1800 RCX: 0000000000000007
> [  127.717389] RDX: ffff8800ba868540 RSI: 0000000000000000 RDI: 0000000000000001
> [  127.718768] RBP: ffff88042a163948 R08: ffff88042a163a19 R09: ffff880429e4a800
> [  127.720157] R10: 0000000000000000 R11: ffff8800ba8680c0 R12: ffff8800bb1849d8
> [  127.721530] R13: 0000000000000080 R14: 0000000000000001 R15: 000000000000002d
> [  127.722902] FS:  0000000000000000(0000) GS:ffff88043fd40000(0000) knlGS:0000000000000000
> [  127.724469] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [  127.725579] CR2: 0000000000000000 CR3: 0000000002371000 CR4: 00000000000006e0
> [  127.726961] Stack:
> [  127.727376]  0000002dbb00f980 ffff8800ba868540 0000000000000000 ffff8804260e1800
> [  127.728892]  0000000000006a00 0000000000003e40 ffff8800bb00f980 0000000000000004
> [  127.730411]  ffff88042a163970 ffffffff816edd94 0000000000000180 ffff8804260e1800
> [  127.731918] Call Trace:
> [  127.732403]  [<ffffffff816edd94>] refresh_sit_entry+0x24/0xc0
> [  127.733539]  [<ffffffff816eec7e>] allocate_data_block+0x16e/0x2e0
> [  127.734724]  [<ffffffff816eefad>] do_write_page+0x1bd/0x280
> [  127.735810]  [<ffffffff816ef0f3>] write_node_page+0x23/0x30
> [  127.736898]  [<ffffffff816e7ce5>] f2fs_write_node_page+0x125/0x240
> [  127.738103]  [<ffffffff816e9b31>] sync_node_pages+0x401/0x600
> [  127.739241]  [<ffffffff816e9e38>] f2fs_write_node_pages+0x108/0x130
> [  127.740462]  [<ffffffff811941c1>] do_writepages+0x21/0x30
> [  127.741520]  [<ffffffff811feb25>] __writeback_single_inode+0x45/0x330
> [  127.742787]  [<ffffffff811ff2bb>] writeback_sb_inodes+0x25b/0x4d0
> [  127.743977]  [<ffffffff811ff788>] wb_writeback+0xf8/0x2d0
> [  127.745063]  [<ffffffff8120251e>] wb_workfn+0xfe/0x3b0
> [  127.746070]  [<ffffffff81dcba7e>] ? _raw_spin_unlock_irq+0xe/0x30
> [  127.747245]  [<ffffffff810cedfb>] ? finish_task_switch+0x8b/0x220
> [  127.748469]  [<ffffffff810c17ce>] process_one_work+0x14e/0x410
> [  127.749472]  [<ffffffff810c1dde>] worker_thread+0x4e/0x460
> [  127.750419]  [<ffffffff810c1d90>] ? rescuer_thread+0x300/0x300
> [  127.751429]  [<ffffffff810c1d90>] ? rescuer_thread+0x300/0x300
> [  127.752464]  [<ffffffff810c7176>] kthread+0xe6/0x100
> [  127.753324]  [<ffffffff810c7090>] ? kthread_create_on_node+0x190/0x190
> [  127.754449]  [<ffffffff81dcc30f>] ret_from_fork+0x3f/0x70
> [  127.755384]  [<ffffffff810c7090>] ? kthread_create_on_node+0x190/0x190
> [  127.756513] Code: 44 24 30 48 8b 53 38 48 8b 12 48 89 82 a8 00 00 00 44 89 e8 41 bd 01 00
> 00 00 c1 e8 03 41 d3 e5 48 89 c6 49 03 74 24 08 45 85 f6 <0f> be 16 0f 8e
> [  127.760859] RIP  [<ffffffff816ec3d8>] update_sit_entry+0xe8/0x270
> [  127.761929]  RSP <ffff88042a163908>
> [  127.762537] CR2: 0000000000000000
> [  127.763118] ---[ end trace 2107b831b703fa3c ]---
> 
> It's completely repeatable.
> 
> Cheers,
> 
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
> 
> ------------------------------------------------------------------------------
> Site24x7 APM Insight: Get Deep Visibility into Application Performance
> APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
> Monitor end-to-end web transactions and take corrective actions now
> Troubleshoot faster and improve end-user experience. Signup Now!
> http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
