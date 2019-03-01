From: Wang Shilong <wangshilong1991@gmail.com>
Subject: [PATCH 5/8] fs: add project support to statx
Date: Fri,  1 Mar 2019 23:05:38 +0900
Message-ID: <1551449141-7884-6-git-send-email-wshilong1991@gmail.com>
References: <1551449141-7884-1-git-send-email-wshilong1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wangshilong1991@gmail.com>) id 1gzinj-0002MA-D5
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Mar 2019 14:06:11 +0000
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1gzinh-00Gmmr-MH
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Mar 2019 14:06:11 +0000
Received: by mail-pg1-f194.google.com with SMTP id y4so11475764pgc.12
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 01 Mar 2019 06:06:09 -0800 (PST)
In-Reply-To: <1551449141-7884-1-git-send-email-wshilong1991@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: adilger@dilger.ca, lixi@ddn.com, Wang Shilong <wshilong@ddn.com>

From: Wang Shilong <wshilong@ddn.com>

From: Wang Shilong <wshilong@ddn.com>

Extend statx to support project ID and inherit attribute.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 fs/stat.c                       | 1 +
 include/linux/stat.h            | 2 ++
 include/uapi/linux/stat.h       | 8 ++++++--
 tools/include/uapi/linux/stat.h | 8 ++++++--
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index adbfcd86c81b..82d855c4647c 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -551,6 +551,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_rdev_minor = MINOR(stat->rdev);
 	tmp.stx_dev_major = MAJOR(stat->dev);
 	tmp.stx_dev_minor = MINOR(stat->dev);
+	tmp.stx_projid = (u32)from_kprojid(&init_user_ns, stat->projid);
 
 	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 765573dc17d6..72c9d2ab5343 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/time.h>
 #include <linux/uidgid.h>
+#include <linux/projid.h>
 
 #define KSTAT_QUERY_FLAGS (AT_STATX_SYNC_TYPE)
 
@@ -40,6 +41,7 @@ struct kstat {
 	dev_t		rdev;
 	kuid_t		uid;
 	kgid_t		gid;
+	kprojid_t	projid;
 	loff_t		size;
 	struct timespec64 atime;
 	struct timespec64 mtime;
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 7b35e98d3c58..56d35a2cbd0c 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -123,7 +123,9 @@ struct statx {
 	__u32	stx_dev_major;	/* ID of device containing file [uncond] */
 	__u32	stx_dev_minor;
 	/* 0x90 */
-	__u64	__spare2[14];	/* Spare space for future expansion */
+	__u32	stx_projid;	/* Project ID of file */
+	__u32	__spare1[1];
+	__u64	__spare2[13];	/* Spare space for future expansion */
 	/* 0x100 */
 };
 
@@ -148,7 +150,8 @@ struct statx {
 #define STATX_BLOCKS		0x00000400U	/* Want/got stx_blocks */
 #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
-#define STATX_ALL		0x00000fffU	/* All currently supported flags */
+#define STATX_PROJID		0x00001000U	/* Want/Got stx_projid */
+#define STATX_ALL		0x00001fffU	/* All currently supported flags */
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
 /*
@@ -170,5 +173,6 @@ struct statx {
 
 #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
 
+#define STATX_ATTR_PROJINHERIT		0x00002000 /* [I] File project inherit is set */
 
 #endif /* _UAPI_LINUX_STAT_H */
diff --git a/tools/include/uapi/linux/stat.h b/tools/include/uapi/linux/stat.h
index 7b35e98d3c58..21b542b3b061 100644
--- a/tools/include/uapi/linux/stat.h
+++ b/tools/include/uapi/linux/stat.h
@@ -123,7 +123,9 @@ struct statx {
 	__u32	stx_dev_major;	/* ID of device containing file [uncond] */
 	__u32	stx_dev_minor;
 	/* 0x90 */
-	__u64	__spare2[14];	/* Spare space for future expansion */
+	__u32   stx_projid;     /* Project ID of file */
+	__u32   __spare1[1];
+	__u64   __spare2[13];   /* Spare space for future expansion */
 	/* 0x100 */
 };
 
@@ -148,7 +150,8 @@ struct statx {
 #define STATX_BLOCKS		0x00000400U	/* Want/got stx_blocks */
 #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
-#define STATX_ALL		0x00000fffU	/* All currently supported flags */
+#define STATX_PROJID		0x00001000U	/* Want/Got stx_projid */
+#define STATX_ALL		0x00001fffU	/* All currently supported flags */
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
 /*
@@ -170,5 +173,6 @@ struct statx {
 
 #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
 
+#define STATX_ATTR_PROJINHERIT		0x00002000 /* [I] File project inherit is set */
 
 #endif /* _UAPI_LINUX_STAT_H */
-- 
2.19.1
