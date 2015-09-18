From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 3/3] f2fs: disallow switch extent_cache option
	dynamically
Date: Fri, 18 Sep 2015 16:55:26 +0800
Message-ID: <00cd01d0f1ef$db65bd20$92313760$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZcrSq-0002u0-MZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 18 Sep 2015 08:56:16 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZcrSo-0005d4-H7
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 18 Sep 2015 08:56:16 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NUV01L6K7HJKX30@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 18 Sep 2015 17:56:07 +0900 (KST)
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

Swith extent_cache option dynamically when remount may casue consistency
issue between extent cache and dnode page. Fix in this patch to avoid
that condition.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/super.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f794781..16442ec 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -742,6 +742,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	int err, active_logs;
 	bool need_restart_gc = false;
 	bool need_stop_gc = false;
+	bool no_extent_cache = !test_opt(sbi, EXTENT_CACHE);
 
 	sync_filesystem(sb);
 
@@ -767,6 +768,14 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	if (f2fs_readonly(sb) && (*flags & MS_RDONLY))
 		goto skip;
 
+	/* disallow enable/disable extent_cache dynamically */
+	if (no_extent_cache == !!test_opt(sbi, EXTENT_CACHE)) {
+		err = -EINVAL;
+		f2fs_msg(sbi->sb, KERN_WARNING,
+				"switch extent_cache option is not allowed");
+		goto restore_opts;
+	}
+
 	/*
 	 * We stop the GC thread if FS is mounted as RO
 	 * or if background_gc = off is passed in mount
-- 
2.5.2



------------------------------------------------------------------------------
