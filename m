From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [f2fs-dev] [PATCH 2/3] f2fs: add f2fs_readonly()
Date: Tue, 21 May 2013 12:56:32 +0900
Message-ID: <1369108593-880-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1369108593-880-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1UediV-0007bq-BW
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 21 May 2013 03:58:27 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UediU-0008JB-Ba for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 21 May 2013 03:58:27 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MN400294R151BI0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 21 May 2013 12:58:17 +0900 (KST)
In-reply-to: <1369108593-880-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Introduce a simple macro function for readability.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/f2fs.h  | 5 +++++
 fs/f2fs/file.c  | 2 +-
 fs/f2fs/super.c | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9182b27..6594ce1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -887,6 +887,11 @@ static inline int cond_clear_inode_flag(struct f2fs_inode_info *fi, int flag)
 	return 0;
 }
 
+static inline int f2fs_readonly(struct super_block *sb)
+{
+	return sb->s_flags & MS_RDONLY;
+}
+
 /*
  * file.c
  */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9937ba1..316bcfe 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -114,7 +114,7 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		.for_reclaim = 0,
 	};
 
-	if (inode->i_sb->s_flags & MS_RDONLY)
+	if (f2fs_readonly(inode->i_sb))
 		return 0;
 
 	trace_f2fs_sync_file_enter(inode);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8555f7d..3ac305d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -170,7 +170,7 @@ static int f2fs_freeze(struct super_block *sb)
 {
 	int err;
 
-	if (sb->s_flags & MS_RDONLY)
+	if (f2fs_readonly(sb))
 		return 0;
 
 	err = f2fs_sync_fs(sb, 1);
-- 
1.8.1.3.566.gaa39828


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
