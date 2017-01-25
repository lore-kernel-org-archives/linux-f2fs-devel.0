From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix null pointer dereference when issuing flush in ->fsync
Date: Wed, 25 Jan 2017 10:52:40 +0800
Message-ID: <20170125025240.13622-2-yuchao0@huawei.com>
References: <20170125025240.13622-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170125025240.13622-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

We only allocate flush merge control structure sbi::sm_info::fcc_info when
flush_merge option is on, but in f2fs_issue_flush we still try to access
member of the control structure without that option, it incurs panic as
show below, fix it.

Call Trace:
 __remove_ino_entry+0xa9/0xc0 [f2fs]
 f2fs_do_sync_file.isra.27+0x214/0x6d0 [f2fs]
 f2fs_sync_file+0x18/0x20 [f2fs]
 vfs_fsync_range+0x3d/0xb0
 __do_page_fault+0x261/0x4d0
 do_fsync+0x3d/0x70
 SyS_fsync+0x10/0x20
 do_syscall_64+0x6e/0x180
 entry_SYSCALL64_slow_path+0x25/0x25
RIP: 0033:0x7f18ce260de0
RSP: 002b:00007ffdd4589258 EFLAGS: 00000246 ORIG_RAX: 000000000000004a
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f18ce260de0
RDX: 0000000000000006 RSI: 00000000016c0360 RDI: 0000000000000003
RBP: 00000000016c0360 R08: 000000000000ffff R09: 000000000000001f
R10: 00007ffdd4589020 R11: 0000000000000246 R12: 00000000016c0100
R13: 0000000000000000 R14: 00000000016c1f00 R15: 00000000016c0100
Code: fb 81 e3 00 08 00 00 48 89 45 a0 0f 1f 44 00 00 31 c0 85 db 75 27 41 81 e7 00 04 00 00 74 0c 41 8b 45 20 85 c0 0f 85 81 00 00 00 <f0> 41 ff 45 20 4c 89 e7 e8 f8 e9 ff ff f0 41 ff 4d 20 48 83 c4
RIP: f2fs_issue_flush+0x5b/0x170 [f2fs] RSP: ffffc90003b5fd78
CR2: 0000000000000020
---[ end trace a09314c24f037648 ]---

Reported-by: Shuoran Liu <liushuoran@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6b3d847bcb96..1a7a9177a265 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -477,7 +477,10 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi)
 	if (test_opt(sbi, NOBARRIER))
 		return 0;
 
-	if (!test_opt(sbi, FLUSH_MERGE) || !atomic_read(&fcc->submit_flush)) {
+	if (!test_opt(sbi, FLUSH_MERGE))
+		return submit_flush_wait(sbi);
+
+	if (!atomic_read(&fcc->submit_flush)) {
 		int ret;
 
 		atomic_inc(&fcc->submit_flush);
-- 
2.8.2.295.g3f1c1d0
