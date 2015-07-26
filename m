From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: call set_page_dirty to attach i_wb for cgroup
Date: Sat, 25 Jul 2015 17:21:16 -0700
Message-ID: <1437870077-46892-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

The cgroup attaches inode->i_wb via mark_inode_dirty and when set_page_writeback
is called, __inc_wb_stat() updates i_wb's stat.

So, we need to explicitly call set_page_dirty->__mark_inode_dirty in prior to
any writebacking pages.

This patch should resolve the following kernel panic reported by Andreas Reis.

https://bugzilla.kernel.org/show_bug.cgi?id=101801

--- Comment #2 from Andreas Reis <andreas.reis@gmail.com> ---
BUG: unable to handle kernel NULL pointer dereference at 00000000000000a8
IP: [<ffffffff8149deea>] __percpu_counter_add+0x1a/0x90
PGD 2951ff067 PUD 2df43f067 PMD 0
Oops: 0000 [#1] PREEMPT SMP
Modules linked in:
CPU: 7 PID: 10356 Comm: gcc Tainted: G        W       4.2.0-1-cu #1
Hardware name: Gigabyte Technology Co., Ltd. G1.Sniper M5/G1.Sniper M5, BIOS
T01 02/03/2015
task: ffff880295044f80 ti: ffff880295140000 task.ti: ffff880295140000
RIP: 0010:[<ffffffff8149deea>]  [<ffffffff8149deea>]
__percpu_counter_add+0x1a/0x90
RSP: 0018:ffff880295143ac8  EFLAGS: 00010082
RAX: 0000000000000003 RBX: ffffea000a526d40 RCX: 0000000000000001
RDX: 0000000000000020 RSI: 0000000000000001 RDI: 0000000000000088
RBP: ffff880295143ae8 R08: 0000000000000000 R09: ffff88008f69bb30
R10: 00000000fffffffa R11: 0000000000000000 R12: 0000000000000088
R13: 0000000000000001 R14: ffff88041d099000 R15: ffff880084a205d0
FS:  00007f8549374700(0000) GS:ffff88042f3c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000000a8 CR3: 000000033e1d5000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Stack:
 0000000000000000 ffffea000a526d40 ffff880084a20738 ffff880084a20750
 ffff880295143b48 ffffffff811cc91e ffff880000000000 0000000000000296
 0000000000000000 ffff880417090198 0000000000000000 ffffea000a526d40
Call Trace:
 [<ffffffff811cc91e>] __test_set_page_writeback+0xde/0x1d0
 [<ffffffff813fee87>] do_write_data_page+0xe7/0x3a0
 [<ffffffff813faeea>] gc_data_segment+0x5aa/0x640
 [<ffffffff813fb0b8>] do_garbage_collect+0x138/0x150
 [<ffffffff813fb3fe>] f2fs_gc+0x1be/0x3e0
 [<ffffffff81405541>] f2fs_balance_fs+0x81/0x90
 [<ffffffff813ee357>] f2fs_unlink+0x47/0x1d0
 [<ffffffff81239329>] vfs_unlink+0x109/0x1b0
 [<ffffffff8123e3d7>] do_unlinkat+0x287/0x2c0
 [<ffffffff8123ebc6>] SyS_unlink+0x16/0x20
 [<ffffffff81942e2e>] entry_SYSCALL_64_fastpath+0x12/0x71
Code: 41 5e 5d c3 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 41 55 49
89 f5 41 54 49 89 fc 53 48 83 ec 08 65 ff 05 e6 d9 b6 7e <48> 8b 47 20 48 63 ca
65 8b 18 48 63 db 48 01 f3 48 39 cb 7d 0a
RIP  [<ffffffff8149deea>] __percpu_counter_add+0x1a/0x90
 RSP <ffff880295143ac8>
CR2: 00000000000000a8
---[ end trace 5132449a58ed93a3 ]---
note: gcc[10356] exited with preempt_count 2

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c    | 2 --
 fs/f2fs/file.c    | 7 ++++---
 fs/f2fs/gc.c      | 7 ++++++-
 fs/f2fs/inline.c  | 2 ++
 fs/f2fs/segment.c | 1 +
 5 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e5952d1..111f180 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1573,8 +1573,6 @@ static int f2fs_set_data_page_dirty(struct page *page)
 		return 1;
 	}
 
-	mark_inode_dirty(inode);
-
 	if (!PageDirty(page)) {
 		__set_page_dirty_nobuffers(page);
 		update_dirty_page(inode, page);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ee17472..25d1a2f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1356,12 +1356,13 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 	if (ret)
 		return ret;
 
-	if (f2fs_is_atomic_file(inode))
+	if (f2fs_is_atomic_file(inode)) {
+		clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
 		commit_inmem_pages(inode, false);
+	}
 
 	ret = f2fs_sync_file(filp, 0, LLONG_MAX, 0);
 	mnt_drop_write_file(filp);
-	clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
 	return ret;
 }
 
@@ -1416,8 +1417,8 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
 	f2fs_balance_fs(F2FS_I_SB(inode));
 
 	if (f2fs_is_atomic_file(inode)) {
-		commit_inmem_pages(inode, false);
 		clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
+		commit_inmem_pages(inode, false);
 	}
 
 	if (f2fs_is_volatile_file(inode))
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 22007ad..fcb263a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -571,6 +571,11 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
 	if (unlikely(fio.encrypted_page->mapping != META_MAPPING(fio.sbi)))
 		goto put_page_out;
 
+	set_page_dirty(fio.encrypted_page);
+	f2fs_wait_on_page_writeback(fio.encrypted_page, META);
+	if (clear_page_dirty_for_io(fio.encrypted_page))
+		dec_page_count(fio.sbi, F2FS_DIRTY_META);
+
 	set_page_writeback(fio.encrypted_page);
 
 	/* allocate block address */
@@ -615,8 +620,8 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type)
 			.page = page,
 			.encrypted_page = NULL,
 		};
+		set_page_dirty(page);
 		f2fs_wait_on_page_writeback(page, DATA);
-
 		if (clear_page_dirty_for_io(page))
 			inode_dec_dirty_pages(inode);
 		set_cold_data(page);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 74c301d..95c2e84 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -141,6 +141,8 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 	kunmap_atomic(dst_addr);
 	SetPageUptodate(page);
 no_update:
+	set_page_dirty(page);
+
 	/* clear dirty state */
 	dirty = clear_page_dirty_for_io(page);
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 08b2ebc..f7bfc3b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -257,6 +257,7 @@ void commit_inmem_pages(struct inode *inode, bool abort)
 		if (!abort) {
 			lock_page(cur->page);
 			if (cur->page->mapping == inode->i_mapping) {
+				set_page_dirty(cur->page);
 				f2fs_wait_on_page_writeback(cur->page, DATA);
 				if (clear_page_dirty_for_io(cur->page))
 					inode_dec_dirty_pages(inode);
-- 
2.1.1
