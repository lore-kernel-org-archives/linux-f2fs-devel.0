From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH v3 2/2] f2fs: add fault injection to sysfs
Date: Mon, 16 May 2016 12:38:50 +0800
Message-ID: <1463373530-6173-2-git-send-email-shengyong1@huawei.com>
References: <1463373530-6173-1-git-send-email-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1b2ALn-0000ne-Rw
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 16 May 2016 04:41:51 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1b2ALi-0006pe-6j
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 16 May 2016 04:41:51 +0000
In-Reply-To: <1463373530-6173-1-git-send-email-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

This patch introduces a new struct f2fs_fault_info and a global f2fs_fault
to save fault injection status. Fault injection entries are created in
/sys/fs/f2fs/fault_injection/ during initializing f2fs module.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
v3:
 * Integrate all fault types into inject_type entry
 * Reset fault attr value when remounting the partition
 * Fix some coding style issues
---
 fs/f2fs/f2fs.h  | 31 ++++++++++++++++++++-----
 fs/f2fs/super.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 91 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ec978b44..1351178 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -48,15 +48,36 @@ enum {
 	FAULT_MAX,
 };
 
-extern u32 f2fs_fault_rate;
-extern atomic_t f2fs_ops;
+struct f2fs_fault_info {
+	atomic_t inject_ops;
+	unsigned int inject_rate;
+	unsigned int inject_type;
+};
+
+extern struct f2fs_fault_info f2fs_fault;
 extern char *fault_name[FAULT_MAX];
+#define IS_FAULT_SET(type) (f2fs_fault.inject_type & (1 << (type)))
 
 static inline bool time_to_inject(int type)
 {
-	atomic_inc(&f2fs_ops);
-	if (f2fs_fault_rate && (atomic_read(&f2fs_ops) >= f2fs_fault_rate)) {
-		atomic_set(&f2fs_ops, 0);
+	if (!f2fs_fault.inject_rate)
+		return false;
+	if (type == FAULT_KMALLOC && !IS_FAULT_SET(type))
+		return false;
+	else if (type == FAULT_PAGE_ALLOC && !IS_FAULT_SET(type))
+		return false;
+	else if (type == FAULT_ALLOC_NID && !IS_FAULT_SET(type))
+		return false;
+	else if (type == FAULT_ORPHAN && !IS_FAULT_SET(type))
+		return false;
+	else if (type == FAULT_BLOCK && !IS_FAULT_SET(type))
+		return false;
+	else if (type == FAULT_DIR_DEPTH && !IS_FAULT_SET(type))
+		return false;
+
+	atomic_inc(&f2fs_fault.inject_ops);
+	if (atomic_read(&f2fs_fault.inject_ops) >= f2fs_fault.inject_rate) {
+		atomic_set(&f2fs_fault.inject_ops, 0);
 		printk("%sF2FS-fs : inject %s in %pF\n",
 				KERN_INFO,
 				fault_name[type],
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0e54e84..9df6d72 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -40,8 +40,7 @@ static struct kmem_cache *f2fs_inode_cachep;
 static struct kset *f2fs_kset;
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-u32 f2fs_fault_rate = 0;
-atomic_t f2fs_ops;
+struct f2fs_fault_info f2fs_fault;
 
 char *fault_name[FAULT_MAX] = {
 	[FAULT_KMALLOC]		= "kmalloc",
@@ -51,6 +50,17 @@ char *fault_name[FAULT_MAX] = {
 	[FAULT_BLOCK]		= "no more block",
 	[FAULT_DIR_DEPTH]	= "too big dir depth",
 };
+
+static void f2fs_build_fault_attr(unsigned int rate)
+{
+	if (rate) {
+		atomic_set(&f2fs_fault.inject_ops, 0);
+		f2fs_fault.inject_rate = rate;
+		f2fs_fault.inject_type = (1 << FAULT_MAX) - 1;
+	} else {
+		memset(&f2fs_fault, 0, sizeof(struct f2fs_fault_info));
+	}
+}
 #endif
 
 /* f2fs-wide shrinker description */
@@ -118,6 +128,10 @@ enum {
 	SM_INFO,	/* struct f2fs_sm_info */
 	NM_INFO,	/* struct f2fs_nm_info */
 	F2FS_SBI,	/* struct f2fs_sb_info */
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	FAULT_INFO_RATE,	/* struct f2fs_fault_info */
+	FAULT_INFO_TYPE,	/* struct f2fs_fault_info */
+#endif
 };
 
 struct f2fs_attr {
@@ -139,6 +153,11 @@ static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
 		return (unsigned char *)NM_I(sbi);
 	else if (struct_type == F2FS_SBI)
 		return (unsigned char *)sbi;
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	else if (struct_type == FAULT_INFO_RATE ||
+					struct_type == FAULT_INFO_TYPE)
+		return (unsigned char *)&f2fs_fault;
+#endif
 	return NULL;
 }
 
@@ -188,6 +207,10 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 	ret = kstrtoul(skip_spaces(buf), 0, &t);
 	if (ret < 0)
 		return ret;
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	if (a->struct_type == FAULT_INFO_TYPE && t >= (1 << FAULT_MAX))
+		return -EINVAL;
+#endif
 	*ui = t;
 	return count;
 }
@@ -253,6 +276,10 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_victim_search, max_victim_search);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, cp_interval, interval_time[CP_TIME]);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, idle_interval, interval_time[REQ_TIME]);
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+F2FS_RW_ATTR(FAULT_INFO_RATE, f2fs_fault_info, inject_rate, inject_rate);
+F2FS_RW_ATTR(FAULT_INFO_TYPE, f2fs_fault_info, inject_type, inject_type);
+#endif
 F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
@@ -289,6 +316,22 @@ static struct kobj_type f2fs_ktype = {
 	.release	= f2fs_sb_release,
 };
 
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+/* sysfs for f2fs fault injection */
+static struct kobject f2fs_fault_inject;
+
+static struct attribute *f2fs_fault_attrs[] = {
+	ATTR_LIST(inject_rate),
+	ATTR_LIST(inject_type),
+	NULL
+};
+
+static struct kobj_type f2fs_fault_ktype = {
+	.default_attrs	= f2fs_fault_attrs,
+	.sysfs_ops	= &f2fs_attr_ops,
+};
+#endif
+
 void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...)
 {
 	struct va_format vaf;
@@ -317,8 +360,9 @@ static int parse_options(struct super_block *sb, char *options)
 	int arg = 0;
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-	f2fs_fault_rate = 0;
+	f2fs_build_fault_attr(0);
 #endif
+
 	if (!options)
 		return 0;
 
@@ -456,8 +500,7 @@ static int parse_options(struct super_block *sb, char *options)
 			if (args->from && match_int(args, &arg))
 				return -EINVAL;
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-			f2fs_fault_rate = arg;
-			atomic_set(&f2fs_ops, 0);
+			f2fs_build_fault_attr(arg);
 #else
 			f2fs_msg(sb, KERN_INFO,
 				"FAULT_INJECTION was not selected");
@@ -1797,6 +1840,16 @@ static int __init init_f2fs_fs(void)
 		err = -ENOMEM;
 		goto free_extent_cache;
 	}
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	f2fs_fault_inject.kset = f2fs_kset;
+	f2fs_build_fault_attr(0);
+	err = kobject_init_and_add(&f2fs_fault_inject, &f2fs_fault_ktype,
+				NULL, "fault_injection");
+	if (err) {
+		f2fs_fault_inject.kset = NULL;
+		goto free_kset;
+	}
+#endif
 	err = register_shrinker(&f2fs_shrinker_info);
 	if (err)
 		goto free_kset;
@@ -1815,6 +1868,10 @@ free_filesystem:
 free_shrinker:
 	unregister_shrinker(&f2fs_shrinker_info);
 free_kset:
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	if (f2fs_fault_inject.kset)
+		kobject_put(&f2fs_fault_inject);
+#endif
 	kset_unregister(f2fs_kset);
 free_extent_cache:
 	destroy_extent_cache();
@@ -1841,6 +1898,9 @@ static void __exit exit_f2fs_fs(void)
 	destroy_segment_manager_caches();
 	destroy_node_manager_caches();
 	destroy_inodecache();
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	kobject_put(&f2fs_fault_inject);
+#endif
 	kset_unregister(f2fs_kset);
 	f2fs_destroy_trace_ios();
 }
-- 
2.7.1


------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
