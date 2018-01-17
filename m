From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH v2] f2fs: avoid hungtask when GC encrypted block
 if io_bits is set
Date: Wed, 17 Jan 2018 12:11:31 +0800
Message-ID: <20180117041131.242712-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <shengyong1@huawei.com>) id 1ebf4v-0006RS-IL
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Jan 2018 04:11:57 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ebf4t-00080H-QL
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Jan 2018 04:11:57 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: shengyong1@huawei.com, linux-f2fs-devel@lists.sourceforge.net

When io_bits is set, GCing encrypted block may hit the following hungtask.
Since io_bits requires aligned block address, f2fs_submit_page_write may
return -EAGAIN if new_blkaddr does not satisify io_bits alignment. As a
result, the encrypted page will never be writtenback.

This patch makes move_data_block aware the EAGAIN error and cancel the
writeback.

[  246.751371] INFO: task kworker/u4:4:797 blocked for more than 90 seconds.
[  246.752423]       Not tainted 4.15.0-rc4+ #11
[  246.754176] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  246.755336] kworker/u4:4    D25448   797      2 0x80000000
[  246.755597] Workqueue: writeback wb_workfn (flush-7:0)
[  246.755616] Call Trace:
[  246.755695]  ? __schedule+0x322/0xa90
[  246.755761]  ? blk_init_request_from_bio+0x120/0x120
[  246.755773]  ? pci_mmcfg_check_reserved+0xb0/0xb0
[  246.755801]  ? __radix_tree_create+0x19e/0x200
[  246.755813]  ? delete_node+0x136/0x370
[  246.755838]  schedule+0x43/0xc0
[  246.755904]  io_schedule+0x17/0x40
[  246.755939]  wait_on_page_bit_common+0x17b/0x240
[  246.755950]  ? wake_page_function+0xa0/0xa0
[  246.755961]  ? add_to_page_cache_lru+0x160/0x160
[  246.755972]  ? page_cache_tree_insert+0x170/0x170
[  246.755983]  ? __lru_cache_add+0x96/0xb0
[  246.756086]  __filemap_fdatawait_range+0x14f/0x1c0
[  246.756097]  ? wait_on_page_bit_common+0x240/0x240
[  246.756120]  ? __wake_up_locked_key_bookmark+0x20/0x20
[  246.756167]  ? wait_on_all_pages_writeback+0xc9/0x100
[  246.756179]  ? __remove_ino_entry+0x120/0x120
[  246.756192]  ? wait_woken+0x100/0x100
[  246.756204]  filemap_fdatawait_range+0x9/0x20
[  246.756216]  write_checkpoint+0x18a1/0x1f00
[  246.756254]  ? blk_get_request+0x10/0x10
[  246.756265]  ? cpumask_next_and+0x43/0x60
[  246.756279]  ? f2fs_sync_inode_meta+0x160/0x160
[  246.756289]  ? remove_element.isra.4+0xa0/0xa0
[  246.756300]  ? __put_compound_page+0x40/0x40
[  246.756310]  ? f2fs_sync_fs+0xec/0x1c0
[  246.756320]  ? f2fs_sync_fs+0x120/0x1c0
[  246.756329]  f2fs_sync_fs+0x120/0x1c0
[  246.756357]  ? trace_event_raw_event_f2fs__page+0x260/0x260
[  246.756393]  ? ata_build_rw_tf+0x173/0x410
[  246.756397]  f2fs_balance_fs_bg+0x198/0x390
[  246.756405]  ? drop_inmem_page+0x230/0x230
[  246.756415]  ? ahci_qc_prep+0x1bb/0x2e0
[  246.756418]  ? ahci_qc_issue+0x1df/0x290
[  246.756422]  ? __accumulate_pelt_segments+0x42/0xd0
[  246.756426]  ? f2fs_write_node_pages+0xd1/0x380
[  246.756429]  f2fs_write_node_pages+0xd1/0x380
[  246.756437]  ? sync_node_pages+0x8f0/0x8f0
[  246.756440]  ? update_curr+0x53/0x220
[  246.756444]  ? __accumulate_pelt_segments+0xa2/0xd0
[  246.756448]  ? __update_load_avg_se.isra.39+0x349/0x360
[  246.756452]  ? do_writepages+0x2a/0xa0
[  246.756456]  do_writepages+0x2a/0xa0
[  246.756460]  __writeback_single_inode+0x70/0x490
[  246.756463]  ? check_preempt_wakeup+0x199/0x310
[  246.756467]  writeback_sb_inodes+0x2a2/0x660
[  246.756471]  ? is_empty_dir_inode+0x40/0x40
[  246.756474]  ? __writeback_single_inode+0x490/0x490
[  246.756477]  ? string+0xbf/0xf0
[  246.756480]  ? down_read_trylock+0x35/0x60
[  246.756484]  __writeback_inodes_wb+0x9f/0xf0
[  246.756488]  wb_writeback+0x41d/0x4b0
[  246.756492]  ? writeback_inodes_wb.constprop.55+0x150/0x150
[  246.756498]  ? set_worker_desc+0xf7/0x130
[  246.756502]  ? current_is_workqueue_rescuer+0x60/0x60
[  246.756511]  ? _find_next_bit+0x2c/0xa0
[  246.756514]  ? wb_workfn+0x400/0x5d0
[  246.756518]  wb_workfn+0x400/0x5d0
[  246.756521]  ? finish_task_switch+0xdf/0x2a0
[  246.756525]  ? inode_wait_for_writeback+0x30/0x30
[  246.756529]  process_one_work+0x3a7/0x6f0
[  246.756533]  worker_thread+0x82/0x750
[  246.756537]  kthread+0x16f/0x1c0
[  246.756541]  ? trace_event_raw_event_workqueue_work+0x110/0x110
[  246.756544]  ? kthread_create_worker_on_cpu+0xb0/0xb0
[  246.756548]  ret_from_fork+0x1f/0x30

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
v2->v1: do not change the index in meta inode
        make move_data_block aware EAGAIN error
---
 fs/f2fs/gc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 33e79697e41c..aa720cc44509 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -691,7 +691,12 @@ static void move_data_block(struct inode *inode, block_t bidx,
 	fio.op = REQ_OP_WRITE;
 	fio.op_flags = REQ_SYNC;
 	fio.new_blkaddr = newaddr;
-	f2fs_submit_page_write(&fio);
+	err = f2fs_submit_page_write(&fio);
+	if (err) {
+		if (PageWriteback(fio.encrypted_page))
+			end_page_writeback(fio.encrypted_page);
+		goto put_page_out;
+	}
 
 	f2fs_update_iostat(fio.sbi, FS_GC_DATA_IO, F2FS_BLKSIZE);
 
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
