From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 3/3] f2fs: add reclaiming control by sysfs
Date: Thu, 24 Oct 2013 16:57:42 +0900
Message-ID: <1382601462-7989-3-git-send-email-jaegeuk.kim@samsung.com>
References: <1382601462-7989-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VZFoL-0006Xe-LY
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Oct 2013 07:58:29 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VZFoJ-0006s9-NI for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Oct 2013 07:58:29 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MV500BS9Y3N2ZU0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Oct 2013 16:58:21 +0900 (KST)
In-reply-to: <1382601462-7989-1-git-send-email-jaegeuk.kim@samsung.com>
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

This patch adds a control method in sysfs to reclaim prefree segments.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 Documentation/filesystems/f2fs.txt |  6 +++++
 fs/f2fs/super.c                    | 50 +++++++++++++++++++++++++++-----------
 2 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 3cd27be..4c647c2 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -164,6 +164,12 @@ Files in /sys/fs/f2fs/<devname>
                               gc_idle = 1 will select the Cost Benefit approach
                               & setting gc_idle = 2 will select the greedy aproach.
 
+ reclaim_segments             This parameter controls the number of prefree
+                              segments to be reclaimed. If the number of prefree
+			      segments is larger than this number, f2fs tries to
+			      conduct checkpoint to reclaim the prefree segments
+			      to free segments. By default, 100 segments, 200MB.
+
 ================================================================================
 USAGE
 ================================================================================
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9a09459..e42351c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -69,24 +69,40 @@ static match_table_t f2fs_tokens = {
 };
 
 /* Sysfs support for f2fs */
+enum {
+	GC_THREAD,	/* struct f2fs_gc_thread */
+	SM_INFO,	/* struct f2fs_sm_info */
+};
+
 struct f2fs_attr {
 	struct attribute attr;
 	ssize_t (*show)(struct f2fs_attr *, struct f2fs_sb_info *, char *);
 	ssize_t (*store)(struct f2fs_attr *, struct f2fs_sb_info *,
 			 const char *, size_t);
+	int struct_type;
 	int offset;
 };
 
+static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
+{
+	if (struct_type == GC_THREAD)
+		return (unsigned char *)sbi->gc_thread;
+	else if (struct_type == SM_INFO)
+		return (unsigned char *)SM_I(sbi);
+	return NULL;
+}
+
 static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 			struct f2fs_sb_info *sbi, char *buf)
 {
-	struct f2fs_gc_kthread *gc_kth = sbi->gc_thread;
+	unsigned char *ptr = NULL;
 	unsigned int *ui;
 
-	if (!gc_kth)
+	ptr = __struct_ptr(sbi, a->struct_type);
+	if (!ptr)
 		return -EINVAL;
 
-	ui = (unsigned int *)(((char *)gc_kth) + a->offset);
+	ui = (unsigned int *)(ptr + a->offset);
 
 	return snprintf(buf, PAGE_SIZE, "%u\n", *ui);
 }
@@ -95,15 +111,16 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 			struct f2fs_sb_info *sbi,
 			const char *buf, size_t count)
 {
-	struct f2fs_gc_kthread *gc_kth = sbi->gc_thread;
+	unsigned char *ptr;
 	unsigned long t;
 	unsigned int *ui;
 	ssize_t ret;
 
-	if (!gc_kth)
+	ptr = __struct_ptr(sbi, a->struct_type);
+	if (!ptr)
 		return -EINVAL;
 
-	ui = (unsigned int *)(((char *)gc_kth) + a->offset);
+	ui = (unsigned int *)(ptr + a->offset);
 
 	ret = kstrtoul(skip_spaces(buf), 0, &t);
 	if (ret < 0)
@@ -139,21 +156,25 @@ static void f2fs_sb_release(struct kobject *kobj)
 	complete(&sbi->s_kobj_unregister);
 }
 
-#define F2FS_ATTR_OFFSET(_name, _mode, _show, _store, _elname) \
+#define F2FS_ATTR_OFFSET(_struct_type, _name, _mode, _show, _store, _offset) \
 static struct f2fs_attr f2fs_attr_##_name = {			\
 	.attr = {.name = __stringify(_name), .mode = _mode },	\
 	.show	= _show,					\
 	.store	= _store,					\
-	.offset = offsetof(struct f2fs_gc_kthread, _elname),	\
+	.struct_type = _struct_type,				\
+	.offset = _offset					\
 }
 
-#define F2FS_RW_ATTR(name, elname)	\
-	F2FS_ATTR_OFFSET(name, 0644, f2fs_sbi_show, f2fs_sbi_store, elname)
+#define F2FS_RW_ATTR(struct_type, struct_name, name, elname)	\
+	F2FS_ATTR_OFFSET(struct_type, name, 0644,		\
+		f2fs_sbi_show, f2fs_sbi_store,			\
+		offsetof(struct struct_name, elname))
 
-F2FS_RW_ATTR(gc_min_sleep_time, min_sleep_time);
-F2FS_RW_ATTR(gc_max_sleep_time, max_sleep_time);
-F2FS_RW_ATTR(gc_no_gc_sleep_time, no_gc_sleep_time);
-F2FS_RW_ATTR(gc_idle, gc_idle);
+F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_min_sleep_time, min_sleep_time);
+F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_max_sleep_time, max_sleep_time);
+F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_no_gc_sleep_time, no_gc_sleep_time);
+F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_idle, gc_idle);
+F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, reclaim_segments, rec_prefree_segments);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -161,6 +182,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_max_sleep_time),
 	ATTR_LIST(gc_no_gc_sleep_time),
 	ATTR_LIST(gc_idle),
+	ATTR_LIST(reclaim_segments),
 	NULL,
 };
 
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
