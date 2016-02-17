From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/2] f2fs: fix to delete old dirent in converted
 inline directory in ->rename
Date: Wed, 17 Feb 2016 16:47:05 +0800
Message-ID: <017001d1695f$dedf97e0$9c9ec7a0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aVxm5-0008En-RF
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 17 Feb 2016 08:47:53 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aVxm4-00019d-Dt
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 17 Feb 2016 08:47:53 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O2O01QJ5OFEBOB0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 17 Feb 2016 17:47:43 +0900 (KST)
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

When doing test with fstests/generic/068 in inline_dentry enabled f2fs,
following oops dmesg will be reported:

 ------------[ cut here ]------------
 WARNING: CPU: 5 PID: 11841 at fs/inode.c:273 drop_nlink+0x49/0x50()
 Modules linked in: f2fs(O) ip6table_filter ip6_tables ebtable_nat ebtables nf_conntrack_ipv4 nf_defrag_ipv4 xt_state
 CPU: 5 PID: 11841 Comm: fsstress Tainted: G           O    4.5.0-rc1 #45
 Hardware name: Hewlett-Packard HP Z220 CMT Workstation/1790, BIOS K51 v01.61 05/16/2013
  0000000000000111 ffff88009cdf7ae8 ffffffff813e5944 0000000000002e41
  0000000000000000 0000000000000111 0000000000000000 ffff88009cdf7b28
  ffffffff8106a587 ffff88009cdf7b58 ffff8804078fe180 ffff880374a64e00
 Call Trace:
  [<ffffffff813e5944>] dump_stack+0x48/0x64
  [<ffffffff8106a587>] warn_slowpath_common+0x97/0xe0
  [<ffffffff8106a5ea>] warn_slowpath_null+0x1a/0x20
  [<ffffffff81231039>] drop_nlink+0x49/0x50
  [<ffffffffa07b95b4>] f2fs_rename2+0xe04/0x10c0 [f2fs]
  [<ffffffff81231ff1>] ? lock_two_nondirectories+0x81/0x90
  [<ffffffff813f454d>] ? lockref_get+0x1d/0x30
  [<ffffffff81220f70>] vfs_rename+0x2e0/0x640
  [<ffffffff8121f9db>] ? lookup_dcache+0x3b/0xd0
  [<ffffffff810b8e41>] ? update_fast_ctr+0x21/0x40
  [<ffffffff8134ff12>] ? security_path_rename+0xa2/0xd0
  [<ffffffff81224af6>] SYSC_renameat2+0x4b6/0x540
  [<ffffffff810ba8ed>] ? trace_hardirqs_off+0xd/0x10
  [<ffffffff810022ba>] ? exit_to_usermode_loop+0x7a/0xd0
  [<ffffffff817e0ade>] ? int_ret_from_sys_call+0x52/0x9f
  [<ffffffff810bdc90>] ? trace_hardirqs_on_caller+0x100/0x1c0
  [<ffffffff81224b8e>] SyS_renameat2+0xe/0x10
  [<ffffffff8121f08e>] SyS_rename+0x1e/0x20
  [<ffffffff817e0957>] entry_SYSCALL_64_fastpath+0x12/0x6f
 ---[ end trace 2b31e17995404e42 ]---

This is because: in the same inline directory, when we renaming one file
from source name to target name which is not existed, once space of inline
dentry is not enough, inline conversion will be triggered, after that all
data in inline dentry will be moved to normal dentry page.

After attaching the new entry in coverted dentry page, still we try to
remove old entry in original inline dentry, since old entry has been
moved, so it obviously doesn't make any effect, result in remaining old
entry in converted dentry page.

Now, we have two valid dentries pointed to the same inode which has nlink
value of 1, deleting them both, above warning appears.

This issue can be reproduced easily as below steps:
1. mount f2fs with inline_dentry option
2. mkdir dir
3. touch 180 files named [001-180] in dir
4. rename dir/180 dir/181
5. rm dir/180 dir/181

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/namei.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 99ed009..8566907 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -608,6 +608,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct f2fs_dir_entry *old_dir_entry = NULL;
 	struct f2fs_dir_entry *old_entry;
 	struct f2fs_dir_entry *new_entry;
+	bool is_old_inline = f2fs_has_inline_dentry(old_dir);
 	int err = -ENOENT;
 
 	if ((old_dir != new_dir) && f2fs_encrypted_inode(new_dir) &&
@@ -694,6 +695,26 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			inc_nlink(new_dir);
 			update_inode_page(new_dir);
 		}
+
+		/*
+		 * old entry and new entry can locate in the same inline
+		 * dentry in inode, when attaching new entry in inline dentry,
+		 * it could force inline dentry conversion, after that,
+		 * old_entry and old_page will point to wrong address, in
+		 * order to avoid this, let's do the check and update here.
+		 */
+		if (is_old_inline && !f2fs_has_inline_dentry(old_dir)) {
+			f2fs_put_page(old_page, 0);
+			old_page = NULL;
+
+			old_entry = f2fs_find_entry(old_dir,
+						&old_dentry->d_name, &old_page);
+			if (!old_entry) {
+				err = -EIO;
+				f2fs_unlock_op(sbi);
+				goto out_whiteout;
+			}
+		}
 	}
 
 	down_write(&F2FS_I(old_inode)->i_sem);
-- 
2.7.0



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
