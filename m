From: hujianyang <hujianyang@huawei.com>
Subject: [PATCH] f2fs: add compat_ioctl to f2fs_dir_operations
Date: Tue, 12 May 2015 16:05:57 +0800
Message-ID: <5551B465.8000804@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hujianyang@huawei.com>) id 1Ys5DB-0001AP-76
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 May 2015 08:06:45 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ys5D7-0007cp-AJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 May 2015 08:06:45 +0000
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
Cc: namjae.jeon@samsung.com, linux-f2fs-devel@lists.sourceforge.net

commit e9750824114ff939d9da299e73651add6aa65456

f2fs: add compat_ioctl to provide backward compatability

introduce compat_ioctl to regular files, but doesn't add this
functionality to f2fs_dir_operations.

While running a 32-bit busybox, I met an error like this:
(A is a directory)

# busybox chattr +i A
chattr: reading flags on A: Inappropriate ioctl for device

This patch copies compat_ioctl from f2fs_file_operations and
fix this problem.

Signed-off-by: hujianyang <hujianyang@huawei.com>
---
 fs/f2fs/dir.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 12f6869..3e92376 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -879,4 +879,7 @@ const struct file_operations f2fs_dir_operations = {
 	.iterate	= f2fs_readdir,
 	.fsync		= f2fs_sync_file,
 	.unlocked_ioctl	= f2fs_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl   = f2fs_compat_ioctl,
+#endif
 };
-- 
1.6.0.2



------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
