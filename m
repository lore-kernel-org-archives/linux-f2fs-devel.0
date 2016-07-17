From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: support clone_file_range
Date: Sat, 16 Jul 2016 23:24:27 -0700
Message-ID: <20160717062427.56718-3-jaegeuk@kernel.org>
References: <20160717062427.56718-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bOfVG-0000Cf-Op
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 17 Jul 2016 06:24:38 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bOfVG-0003zn-43
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 17 Jul 2016 06:24:38 +0000
In-Reply-To: <20160717062427.56718-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch implements clone_file_range in f2fs.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c2b7e35..37480f3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2312,6 +2312,12 @@ ssize_t f2fs_copy_file_range(struct file *file_in, loff_t pos_in,
 	return ret;
 }
 
+int f2fs_clone_file_range(struct file *file_in, loff_t pos_in,
+		struct file *file_out, loff_t pos_out, u64 len)
+{
+	return f2fs_clone_files(file_in, pos_in, file_out, pos_out, len);
+}
+
 #ifdef CONFIG_COMPAT
 long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
@@ -2359,6 +2365,7 @@ const struct file_operations f2fs_file_operations = {
 	.compat_ioctl	= f2fs_compat_ioctl,
 #endif
 	.copy_file_range = f2fs_copy_file_range,
+	.clone_file_range = f2fs_clone_file_range,
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 };
-- 
2.8.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev
