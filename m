From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 06/11] f2fs: inject kmalloc failure
Date: Tue,  3 May 2016 11:21:43 -0700
Message-ID: <1462299708-67906-6-git-send-email-jaegeuk@kernel.org>
References: <1462299708-67906-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1axexT-0008UG-AA
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 May 2016 18:22:07 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1axexS-0007Ew-Ht
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 May 2016 18:22:07 +0000
In-Reply-To: <1462299708-67906-1-git-send-email-jaegeuk@kernel.org>
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

This patch injects kmalloc failure given a fault injection rate.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h  | 29 +++++++++++++++++++++++++++++
 fs/f2fs/super.c |  6 ++++++
 2 files changed, 35 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0684d3e..60098df 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -37,6 +37,31 @@
 	} while (0)
 #endif
 
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+enum {
+	FAULT_KMALLOC,
+	FAULT_MAX,
+};
+
+extern u32 f2fs_fault_rate;
+extern atomic_t f2fs_ops;
+extern char *fault_name[FAULT_MAX];
+
+static inline bool time_to_inject(int type)
+{
+	atomic_inc(&f2fs_ops);
+	if (f2fs_fault_rate && (atomic_read(&f2fs_ops) >= f2fs_fault_rate)) {
+		atomic_set(&f2fs_ops, 0);
+		printk("%sF2FS-fs : inject %s in %pF\n",
+				KERN_INFO,
+				fault_name[type],
+				__builtin_return_address(0));
+		return true;
+	}
+	return false;
+}
+#endif
+
 /*
  * For mount options
  */
@@ -1646,6 +1671,10 @@ static inline bool f2fs_may_extent_tree(struct inode *inode)
 
 static inline void *f2fs_kmalloc(size_t size, gfp_t flags)
 {
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	if (time_to_inject(FAULT_KMALLOC))
+		return NULL;
+#endif
 	return kmalloc(size, flags);
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b27febd..76f4d2c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -41,6 +41,11 @@ static struct kset *f2fs_kset;
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 u32 f2fs_fault_rate = 0;
+atomic_t f2fs_ops;
+
+char *fault_name[FAULT_MAX] = {
+	[FAULT_KMALLOC]		= "kmalloc",
+};
 #endif
 
 /* f2fs-wide shrinker description */
@@ -444,6 +449,7 @@ static int parse_options(struct super_block *sb, char *options)
 				return -EINVAL;
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 			f2fs_fault_rate = arg;
+			atomic_set(&f2fs_ops, 0);
 #else
 			f2fs_msg(sb, KERN_INFO,
 				"FAULT_INJECTION was not selected");
-- 
2.6.3


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
