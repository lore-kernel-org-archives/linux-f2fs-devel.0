From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH 3/4] f2fs: add sysfs interfaces for fault
	injection
Date: Wed, 11 May 2016 17:08:16 +0800
Message-ID: <1462957697-6900-3-git-send-email-shengyong1@huawei.com>
References: <1462957697-6900-1-git-send-email-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1b0QAt-0001OH-Jx
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 11 May 2016 09:11:23 +0000
Received: from [119.145.14.65] (helo=szxga02-in.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1b0QAs-0007NH-4z
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 11 May 2016 09:11:23 +0000
In-Reply-To: <1462957697-6900-1-git-send-email-shengyong1@huawei.com>
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

This patch adds a new entry called fault_injection in /sys/fs/f2fs, and
all injection attributes are placed in this entry.  During initializing
f2fs module, these inject attributes are created.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fs/f2fs/super.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 069dc44..a9066e4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -52,6 +52,12 @@ char *fault_name[FAULT_MAX] = {
 	[FAULT_BLOCK]		= "no more block",
 	[FAULT_DIR_DEPTH]	= "too big dir depth",
 };
+
+static int f2fs_build_fault_attr(void)
+{
+	memset(&f2fs_fault, 0, sizeof(struct f2fs_fault_info));
+	return 0;
+}
 #endif
 
 /* f2fs-wide shrinker description */
@@ -119,6 +125,10 @@ enum {
 	SM_INFO,	/* struct f2fs_sm_info */
 	NM_INFO,	/* struct f2fs_nm_info */
 	F2FS_SBI,	/* struct f2fs_sb_info */
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	FAULT_INFO_RATE,
+	FAULT_INFO,
+#endif
 };
 
 struct f2fs_attr {
@@ -140,6 +150,10 @@ static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
 		return (unsigned char *)NM_I(sbi);
 	else if (struct_type == F2FS_SBI)
 		return (unsigned char *)sbi;
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	else if (struct_type == FAULT_INFO_RATE || struct_type == FAULT_INFO)
+		return (unsigned char *)&f2fs_fault;
+#endif
 	return NULL;
 }
 
@@ -189,6 +203,10 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 	ret = kstrtoul(skip_spaces(buf), 0, &t);
 	if (ret < 0)
 		return ret;
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	if (a->struct_type == FAULT_INFO && t > 1)
+		return -EINVAL;
+#endif
 	*ui = t;
 	return count;
 }
@@ -254,6 +272,15 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_victim_search, max_victim_search);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, cp_interval, interval_time[CP_TIME]);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, idle_interval, interval_time[REQ_TIME]);
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+F2FS_RW_ATTR(FAULT_INFO_RATE, f2fs_fault_info, inject_rate, inject_rate);
+F2FS_RW_ATTR(FAULT_INFO, f2fs_fault_info, inject_kmalloc, inject_kmalloc);
+F2FS_RW_ATTR(FAULT_INFO, f2fs_fault_info, inject_page_alloc, inject_page_alloc);
+F2FS_RW_ATTR(FAULT_INFO, f2fs_fault_info, inject_nid_alloc, inject_nid_alloc);
+F2FS_RW_ATTR(FAULT_INFO, f2fs_fault_info, inject_orphan, inject_orphan);
+F2FS_RW_ATTR(FAULT_INFO, f2fs_fault_info, inject_block, inject_block);
+F2FS_RW_ATTR(FAULT_INFO, f2fs_fault_info, inject_dir_depth, inject_dir_depth);
+#endif
 F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
@@ -290,6 +317,27 @@ static struct kobj_type f2fs_ktype = {
 	.release	= f2fs_sb_release,
 };
 
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+/* sysfs for f2fs fault injection */
+static struct kobject f2fs_fault_inject;
+
+static struct attribute *f2fs_fault_attrs[] = {
+	ATTR_LIST(inject_rate),
+	ATTR_LIST(inject_kmalloc),
+	ATTR_LIST(inject_page_alloc),
+	ATTR_LIST(inject_nid_alloc),
+	ATTR_LIST(inject_orphan),
+	ATTR_LIST(inject_block),
+	ATTR_LIST(inject_dir_depth),
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
@@ -1798,6 +1846,16 @@ static int __init init_f2fs_fs(void)
 		err = -ENOMEM;
 		goto free_extent_cache;
 	}
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	f2fs_fault_inject.kset = f2fs_kset;
+	f2fs_build_fault_attr();
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
@@ -1816,6 +1874,10 @@ free_filesystem:
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
@@ -1842,6 +1904,9 @@ static void __exit exit_f2fs_fs(void)
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
