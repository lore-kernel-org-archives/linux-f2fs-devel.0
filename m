Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15BCCD343F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  7 May 2026 11:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=96YkU2+QLJ9bO5ATcs/YmDj6muqBOkYSEgLHVlFsd9Y=; b=Fhx59RWruTmTK5PRE55UPB23oX
	XlWWhY/1jlpl6HOvYiDWFJQNeblZXJ7a+DLD4tBuGzqQt5OHlz1jk5jE0/pOdTSAWl66tSz9ySfwf
	nbpMfWEztOn2ICeHVOyAZ7/mcosLeU2ZurFzlkG5cxvajeqsc80o41laz5BrKhLYh8ps=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wKx63-00016w-Ly;
	Thu, 07 May 2026 11:40:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1wKx5e-00013B-0T
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 May 2026 11:40:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ok4Q8RMiHzuAoNJXDdqoFNEaB2xKtj+D3fQgpJdyXGI=; b=HiZP4+0UcTKITOyt8yH9br7pJJ
 Lf5ATU4FDg4IQJM1gVKIwVqhF2S5/yMeaXJyr98k7U5YAm/5VyVcgCX0erlih3S64AbpZ+FGIP+Nt
 gl7V/1zVr0ESy6xcF6BGq2ROT/A5CMQP8XDMHcDWvbKpjIVkkPo6nvKzqwCEg6S51Ko0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ok4Q8RMiHzuAoNJXDdqoFNEaB2xKtj+D3fQgpJdyXGI=; b=E/JlZVhk5YGtjXLb49MSQTWtI/
 3WLqnPOqXk5vspEZ3uFxJ0C6ZIeqBuRj+trnfmB9nr/Ztxp1Q2hn5YslSDdKjneWmNCeOS08JexZI
 +HSnidtTHU69ugAmW0ZzOoHw1QfDqEDOfk43PG7Cqn+/AiCXHpbqUNsoxU2fn4B7wFZg=;
Received: from mail3-167.sinamail.sina.com.cn ([202.108.3.167])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wKx5a-0002oO-D4 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 May 2026 11:40:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1778154022; bh=ok4Q8RMiHzuAoNJXDdqoFNEaB2xKtj+D3fQgpJdyXGI=;
 h=From:Subject:Date:Message-ID;
 b=DndUka7GT1MYNvvBdtcpJeX+HFx+PrKYLbUoYpNC6OyfPGazq1A27rJcRbknPbX92
 xHczQbrx90+TUVplzzZ3UQaQXEERwuJtnWXyUFyrmxzAqfYiFnTSiQyV192OdXVW8P
 4CGlEVvS4kxRQSSHgFsRq93xwlhSve5ngPf91qOA=
X-SMAIL-HELO: xiaomi-ThinkCentre-M760t.mioffice.cn
Received: from unknown (HELO
 xiaomi-ThinkCentre-M760t.mioffice.cn)([114.247.175.249])
 by sina.com (10.54.253.33) with ESMTP
 id 69FC7A1800006ED5; Thu, 7 May 2026 19:40:13 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 9657366685182
X-SMAIL-UIID: 234BC65F864E497F8F95EB6BD94A842E-20260507-194013-1
From: Yongpeng Yang <monty_pavel@sina.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu,  7 May 2026 19:39:53 +0800
Message-ID: <20260507113952.1353530-2-monty_pavel@sina.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507113840.1353304-2-monty_pavel@sina.com>
References: <20260507113840.1353304-2-monty_pavel@sina.com>
MIME-Version: 1.0
X-Headers-End: 1wKx5a-0002oO-D4
Subject: [f2fs-dev] [RFC PATCH 4/4] f2fs: add sysfs interface for inline
 extent management
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

Add sysfs attributes to manage the inline extent feature at runtime:

- inline_extent_extension_list: read/write interface to manage file
  extension list that determines which files should use inline extent
  format. Writing an extension name adds it to the list; writing
  "!extension" removes it.

- inline_extent_enable: toggle to dynamically enable or disable the
  inline extent feature without remounting.

Also add inline extent code coverage statistics output under
/sys/kernel/debug/f2fs/ when CONFIG_F2FS_INLINE_EXTENT_DEBUG is
enabled, showing counters for various extent operations (merges,
splits, inserts, evictions, etc.).

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/f2fs/debug.c   |  4 ++++
 fs/f2fs/iextent.c | 39 ++++++++++++++++++++++++++++++++++++
 fs/f2fs/iextent.h |  3 +++
 fs/f2fs/sysfs.c   | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index af88db8fdb71..b77246b6dbfc 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -19,6 +19,7 @@
 #include "node.h"
 #include "segment.h"
 #include "gc.h"
+#include "iextent.h"
 
 static LIST_HEAD(f2fs_stat_list);
 static DEFINE_SPINLOCK(f2fs_stat_lock);
@@ -762,6 +763,9 @@ static int stat_show(struct seq_file *s, void *v)
 				si->ext_mem[EX_BLOCK_AGE] >> 10);
 		seq_printf(s, "  - paged : %llu KB\n",
 				si->page_mem >> 10);
+#ifdef CONFIG_F2FS_INLINE_EXTENT_DEBUG
+		f2fs_iext_show_stat(sbi, s);
+#endif
 	}
 	spin_unlock(&f2fs_stat_lock);
 	return 0;
diff --git a/fs/f2fs/iextent.c b/fs/f2fs/iextent.c
index e834c4f474a4..c2d539014493 100644
--- a/fs/f2fs/iextent.c
+++ b/fs/f2fs/iextent.c
@@ -785,3 +785,42 @@ int f2fs_iext_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
 	spin_unlock_irqrestore(&iext_info->iext_ext_lock, flag);
 	return ret;
 }
+
+#ifdef CONFIG_F2FS_INLINE_EXTENT_DEBUG
+void f2fs_iext_show_stat(struct f2fs_sb_info *sbi, struct seq_file *s)
+{
+	struct f2fs_iext_info *iext_info = sbi->iext_info;
+
+	seq_printf(s, "Inline extent code coverage statistics:\n"
+		"  - left_merge_count: %llu\n"
+		"  - right_merge_count: %llu\n"
+		"  - fast_right_merge_count: %llu\n"
+		"  - lr_merge_count: %llu\n"
+		"  - split_left_count: %llu\n"
+		"  - split_right_count: %llu\n"
+		"  - split_mid_count: %llu\n"
+		"  - insert_new_ext_count: %llu\n"
+		"  - overwrite_ext_count: %llu\n"
+		"  - add_ext_count: %llu\n"
+		"  - del_ext_count: %llu\n"
+		"  - evict_last_ext_cnt: %llu\n"
+		"  - truncate_last_ext_cnt: %llu\n"
+		"  - drop_insert_new_ext_cnt: %llu\n"
+		"  - trigger_ext_format_convert: %llu\n",
+		atomic64_read(&iext_info->left_merge_count),
+		atomic64_read(&iext_info->right_merge_count),
+		atomic64_read(&iext_info->fast_right_merge_count),
+		atomic64_read(&iext_info->lr_merge_count),
+		atomic64_read(&iext_info->split_left_count),
+		atomic64_read(&iext_info->split_right_count),
+		atomic64_read(&iext_info->split_mid_count),
+		atomic64_read(&iext_info->insert_new_ext_count),
+		atomic64_read(&iext_info->overwrite_ext_count),
+		atomic64_read(&iext_info->add_ext_count),
+		atomic64_read(&iext_info->del_ext_count),
+		atomic64_read(&iext_info->evict_last_ext_cnt),
+		atomic64_read(&iext_info->truncate_last_ext_cnt),
+		atomic64_read(&iext_info->drop_insert_new_ext_cnt),
+		atomic64_read(&iext_info->trigger_ext_format_convert));
+}
+#endif
diff --git a/fs/f2fs/iextent.h b/fs/f2fs/iextent.h
index 6d4c86e62f43..f83e786a10ac 100644
--- a/fs/f2fs/iextent.h
+++ b/fs/f2fs/iextent.h
@@ -164,4 +164,7 @@ int f2fs_iext_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
 					bool set);
 int f2fs_iext_info_init(struct f2fs_sb_info *sbi);
 void f2fs_iext_info_destroy(struct f2fs_sb_info *sbi);
+#ifdef CONFIG_F2FS_INLINE_EXTENT_DEBUG
+void f2fs_iext_show_stat(struct f2fs_sb_info *sbi, struct seq_file *s);
+#endif
 #endif
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 665687244c93..db228481e84d 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -18,6 +18,7 @@
 #include "segment.h"
 #include "gc.h"
 #include "iostat.h"
+#include "iextent.h"
 #include <trace/events/f2fs.h>
 
 static struct proc_dir_entry *f2fs_proc_root;
@@ -40,6 +41,9 @@ enum {
 	RESERVED_BLOCKS,	/* struct f2fs_sb_info */
 	CPRC_INFO,	/* struct ckpt_req_control */
 	ATGC_INFO,	/* struct atgc_management */
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+	INLINE_EXTENT,		/* struct f2fs_iext_info */
+#endif
 };
 
 static const char *gc_mode_names[MAX_GC_MODE] = {
@@ -98,6 +102,10 @@ static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
 		return (unsigned char *)&sbi->cprc_info;
 	else if (struct_type == ATGC_INFO)
 		return (unsigned char *)&sbi->am;
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+	else if (struct_type == INLINE_EXTENT)
+		return (unsigned char *)sbi->iext_info;
+#endif
 	return NULL;
 }
 
@@ -405,6 +413,22 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 		return len;
 	}
 
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+	if (!strcmp(a->attr.name, "inline_extent_extension_list")) {
+		struct f2fs_iext_info *iext_info = sbi->iext_info;
+		__u8 (*extlist)[F2FS_EXTENSION_LEN] = iext_info->extensions;
+		int len = 0, i;
+		unsigned long flag;
+
+		spin_lock_irqsave(&iext_info->iext_ext_lock, flag);
+		for (i = 0; i < iext_info->iext_ext_cnt; i++)
+			len += sysfs_emit_at(buf, len, "%s\n", extlist[i]);
+		spin_unlock_irqrestore(&iext_info->iext_ext_lock, flag);
+
+		return len;
+	}
+#endif
+
 	if (!strcmp(a->attr.name, "ckpt_thread_ioprio")) {
 		struct ckpt_req_control *cprc = &sbi->cprc_info;
 		int class = IOPRIO_PRIO_CLASS(cprc->ckpt_thread_ioprio);
@@ -535,6 +559,25 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return ret ? ret : count;
 	}
 
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+	if (!strcmp(a->attr.name, "inline_extent_extension_list")) {
+		const char *name = strim((char *)buf);
+		bool set = true;
+
+		if (*name == '!') {
+			name++;
+			set = false;
+		}
+
+		if (!strlen(name) || strlen(name) >= F2FS_EXTENSION_LEN)
+			return -EINVAL;
+
+		ret = f2fs_iext_update_extension_list(sbi, name, set);
+
+		return ret ? ret : count;
+	}
+#endif
+
 	if (!strcmp(a->attr.name, "ckpt_thread_ioprio")) {
 		const char *name = strim((char *)buf);
 		struct ckpt_req_control *cprc = &sbi->cprc_info;
@@ -1257,6 +1300,10 @@ NM_INFO_GENERAL_RW_ATTR(dirty_nats_ratio);
 
 /* F2FS_SBI ATTR */
 F2FS_RW_ATTR(F2FS_SBI, f2fs_super_block, extension_list, extension_list);
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+F2FS_RW_ATTR(INLINE_EXTENT, f2fs_iext_info, inline_extent_extension_list, extensions);
+F2FS_RW_ATTR(INLINE_EXTENT, f2fs_iext_info, inline_extent_enable, iext_enable);
+#endif
 F2FS_SBI_RW_ATTR(gc_idle, gc_mode);
 F2FS_SBI_RW_ATTR(gc_urgent, gc_mode);
 F2FS_SBI_RW_ATTR(cp_interval, interval_time[CP_TIME]);
@@ -1457,6 +1504,10 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(max_io_bytes),
 	ATTR_LIST(gc_pin_file_thresh),
 	ATTR_LIST(extension_list),
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+	ATTR_LIST(inline_extent_extension_list),
+	ATTR_LIST(inline_extent_enable),
+#endif
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	ATTR_LIST(inject_rate),
 	ATTR_LIST(inject_type),
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
