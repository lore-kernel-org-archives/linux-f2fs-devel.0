From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH] f2fs: set ->owner for debugfs status file's
	file_operations
Date: Sun, 20 Nov 2016 19:57:23 +0100
Message-ID: <20161120185723.16778-1-nicstange@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <nicstange@gmail.com>) id 1c8XJC-000368-3u
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 20 Nov 2016 18:57:46 +0000
Received: from mail-wj0-f194.google.com ([209.85.210.194])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1c8XJB-0000JG-70
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 20 Nov 2016 18:57:46 +0000
Received: by mail-wj0-f194.google.com with SMTP id kp2so2375315wjc.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sun, 20 Nov 2016 10:57:45 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: Martin Brandenburg <martin@omnibond.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Nicolai Stange <nicstange@gmail.com>, Mike Marshall <hubcap@omnibond.com>

The struct file_operations instance serving the f2fs/status debugfs file
lacks an initialization of its ->owner.

This means that although that file might have been opened, the f2fs module
can still get removed. Any further operation on that opened file, releasing
included,  will cause accesses to unmapped memory.

Indeed, Mike Marshall reported the following:

  BUG: unable to handle kernel paging request at ffffffffa0307430
  IP: [<ffffffff8132a224>] full_proxy_release+0x24/0x90
  <...>
  Call Trace:
   [] __fput+0xdf/0x1d0
   [] ____fput+0xe/0x10
   [] task_work_run+0x8e/0xc0
   [] do_exit+0x2ae/0xae0
   [] ? __audit_syscall_entry+0xae/0x100
   [] ? syscall_trace_enter+0x1ca/0x310
   [] do_group_exit+0x44/0xc0
   [] SyS_exit_group+0x14/0x20
   [] do_syscall_64+0x61/0x150
   [] entry_SYSCALL64_slow_path+0x25/0x25
  <...>
  ---[ end trace f22ae883fa3ea6b8 ]---
  Fixing recursive fault but reboot is needed!

Fix this by initializing the f2fs/status file_operations' ->owner with
THIS_MODULE.

This will allow debugfs to grab a reference to the f2fs module upon any
open on that file, thus preventing it from getting removed.

Fixes: 902829aa0b72 ("f2fs: move proc files to debugfs")
Reported-by: Mike Marshall <hubcap@omnibond.com>
Reported-by: Martin Brandenburg <martin@omnibond.com>
Cc: stable@vger.kernel.org
Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
Applicable to next-20161117. Compile-only tested.

 fs/f2fs/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 2fdf233..678733c 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -376,6 +376,7 @@ static int stat_open(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations stat_fops = {
+	.owner = THIS_MODULE,
 	.open = stat_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-- 
2.10.2


------------------------------------------------------------------------------
