From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: fix to handle io error in ->direct_IO
Date: Mon, 21 Sep 2015 20:17:52 +0800
Message-ID: <005f01d0f467$a71626c0$f5427440$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Here is a oops reported as following message when testing generic/019 of
xfstest:

 ------------[ cut here ]------------
 kernel BUG at /home/yuchao/git/f2fs-dev/segment.c:882!
 invalid opcode: 0000 [#1] SMP
 Modules linked in: zram lz4_compress lz4_decompress f2fs(O) ip6table_filter ip6_tables ebtable_nat ebtables nf_conntrack_ipv4
nf_def
 CPU: 2 PID: 25441 Comm: fio Tainted: G           O    4.3.0-rc1+ #6
 Hardware name: Hewlett-Packard HP Z220 CMT Workstation/1790, BIOS K51 v01.61 05/16/2013
 task: ffff8803f4e85580 ti: ffff8803fd61c000 task.ti: ffff8803fd61c000
 RIP: 0010:[<ffffffffa0784981>]  [<ffffffffa0784981>] new_curseg+0x321/0x330 [f2fs]
 RSP: 0018:ffff8803fd61f918  EFLAGS: 00010246
 RAX: 00000000000007ed RBX: 0000000000000224 RCX: 000000000000001f
 RDX: 0000000000000800 RSI: ffffffffffffffff RDI: ffff8803f56f4300
 RBP: ffff8803fd61f978 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000024 R11: ffff8800d23bbd78 R12: ffff8800d0ef0000
 R13: 0000000000000224 R14: 0000000000000000 R15: 0000000000000001
 FS:  00007f827ff85700(0000) GS:ffff88041ea80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: ffffffffff600000 CR3: 00000003fef17000 CR4: 00000000001406e0
 Stack:
  000007ea00000002 0000000100000001 ffff8803f6456248 000007ed0000002b
  0000000000000224 ffff880404d1aa20 ffff8803fd61f9c8 ffff8800d0ef0000
  ffff8803f6456248 0000000000000001 00000000ffffffff ffffffffa078f358
 Call Trace:
  [<ffffffffa0785b87>] allocate_segment_by_default+0x1a7/0x1f0 [f2fs]
  [<ffffffffa078322c>] allocate_data_block+0x17c/0x360 [f2fs]
  [<ffffffffa0779521>] __allocate_data_block+0x131/0x1d0 [f2fs]
  [<ffffffffa077a995>] f2fs_direct_IO+0x4b5/0x580 [f2fs]
  [<ffffffff811510ae>] generic_file_direct_write+0xae/0x160
  [<ffffffff811518f5>] __generic_file_write_iter+0xd5/0x1f0
  [<ffffffff81151e07>] generic_file_write_iter+0xf7/0x200
  [<ffffffff81319e38>] ? apparmor_file_permission+0x18/0x20
  [<ffffffffa0768480>] ? f2fs_fallocate+0x1190/0x1190 [f2fs]
  [<ffffffffa07684c6>] f2fs_file_write_iter+0x46/0x90 [f2fs]
  [<ffffffff8120b4fe>] aio_run_iocb+0x1ee/0x290
  [<ffffffff81700f7e>] ? mutex_lock+0x1e/0x50
  [<ffffffff8120a1d7>] ? aio_read_events+0x207/0x2b0
  [<ffffffff8120b913>] do_io_submit+0x373/0x630
  [<ffffffff8120a4f6>] ? SyS_io_getevents+0x56/0xb0
  [<ffffffff8120bbe0>] SyS_io_submit+0x10/0x20
  [<ffffffff81703857>] entry_SYSCALL_64_fastpath+0x12/0x6a
 Code: 45 c8 48 8b 78 10 e8 9f 23 bf e0 41 8b 8c 24 cc 03 00 00 89 c7 31 d2 89 c6 89 d8 29 df f7 f1 29 d1 39 cf 0f 83 be fd ff ff eb
 RIP  [<ffffffffa0784981>] new_curseg+0x321/0x330 [f2fs]
  RSP <ffff8803fd61f918>
 ---[ end trace 2e577d7f711ddb86 ]---

The reason is that: in the test of generic/019, we will trigger a manmade
IO error in block layer through debugfs, after that, prefree segment will
no longer be freed, because we always skip doing gc or checkpoint when
there occurs an IO error.

Meanwhile fio with aio engine generated a large number of direct IOs,
which continue allocating spaces in free segment until we run out of them,
eventually, results in panic in new_curseg as no more free segment was
found.

So, this patch changes to return EIO in direct_IO for this condition.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8b86d02..a0ea1f8 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -524,6 +524,9 @@ static void __allocate_data_blocks(struct inode *inode, loff_t offset,
 		while (dn.ofs_in_node < end_offset && len) {
 			block_t blkaddr;
 
+			if (unlikely(f2fs_cp_error(sbi)))
+				goto sync_out;
+
 			blkaddr = datablock_addr(dn.node_page, dn.ofs_in_node);
 			if (blkaddr == NULL_ADDR || blkaddr == NEW_ADDR) {
 				if (__allocate_data_block(&dn))
@@ -566,6 +569,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 {
 	unsigned int maxblocks = map->m_len;
 	struct dnode_of_data dn;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int mode = create ? ALLOC_NODE : LOOKUP_NODE_RA;
 	pgoff_t pgofs, end_offset;
 	int err = 0, ofs = 1;
@@ -599,6 +603,10 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 
 	if (dn.data_blkaddr == NEW_ADDR || dn.data_blkaddr == NULL_ADDR) {
 		if (create) {
+			if (unlikely(f2fs_cp_error(sbi))) {
+				err = -EIO;
+				goto put_out;
+			}
 			err = __allocate_data_block(&dn);
 			if (err)
 				goto put_out;
@@ -652,6 +660,10 @@ get_next:
 
 		if (blkaddr == NEW_ADDR || blkaddr == NULL_ADDR) {
 			if (create) {
+				if (unlikely(f2fs_cp_error(sbi))) {
+					err = -EIO;
+					goto sync_out;
+				}
 				err = __allocate_data_block(&dn);
 				if (err)
 					goto sync_out;
@@ -1569,10 +1581,16 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 
 	trace_f2fs_direct_IO_enter(inode, offset, count, iov_iter_rw(iter));
 
-	if (iov_iter_rw(iter) == WRITE)
+	if (iov_iter_rw(iter) == WRITE) {
 		__allocate_data_blocks(inode, offset, count);
+		if (unlikely(f2fs_cp_error(F2FS_I_SB(inode)))) {
+			err = -EIO;
+			goto out;
+		}
+	}
 
 	err = blockdev_direct_IO(iocb, inode, iter, offset, get_data_block_dio);
+out:
 	if (err < 0 && iov_iter_rw(iter) == WRITE)
 		f2fs_write_failed(mapping, offset + count);
 
-- 
2.5.2
