From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: avoid to access NULL pointer in
 issue_flush_thread
Date: Mon, 07 Jul 2014 09:39:32 +0800
Message-ID: <006001cf9984$6b07f490$4117ddb0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1X3xuy-0007tn-NL
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 07 Jul 2014 01:40:32 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1X3xuw-0007YA-Es
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 07 Jul 2014 01:40:32 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N8B0028PJBA3N00@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 07 Jul 2014 10:40:23 +0900 (KST)
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=75861

Denis 2014-05-10 11:28:59 UTC reported:
"F2FS-fs (mmcblk0p28): mounting..
 Unable to handle kernel NULL pointer dereference at virtual address 00000018
 ...
 [<c0a2f678>] (_raw_spin_lock+0x3c/0x70) from [<c03a0330>] (issue_flush_thread+0x50/0x17c)
 [<c03a0330>] (issue_flush_thread+0x50/0x17c) from [<c01b4064>] (kthread+0x98/0xa4)
 [<c01b4064>] (kthread+0x98/0xa4) from [<c0108060>] (kernel_thread_exit+0x0/0x8)"

This patch assign cmd_control_info in sm_info before issue_flush_thread is being
created, so this make sure that issue flush thread will have no chance to access
invalid info in fcc.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/segment.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index bb5980d..a4f8375 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -272,14 +272,15 @@ int create_flush_cmd_control(struct f2fs_sb_info *sbi)
 		return -ENOMEM;
 	spin_lock_init(&fcc->issue_lock);
 	init_waitqueue_head(&fcc->flush_wait_queue);
+	sbi->sm_info->cmd_control_info = fcc;
 	fcc->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
 				"f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev));
 	if (IS_ERR(fcc->f2fs_issue_flush)) {
 		err = PTR_ERR(fcc->f2fs_issue_flush);
 		kfree(fcc);
+		sbi->sm_info->cmd_control_info = NULL;
 		return err;
 	}
-	sbi->sm_info->cmd_control_info = fcc;
 
 	return err;
 }
-- 
2.0.0.257.g75cc6c6



------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
