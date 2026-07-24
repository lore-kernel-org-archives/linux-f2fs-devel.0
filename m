Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF725C531FA
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wiYpgBZ4h8i3x7xCE67H/MQgEsGE9YyOHp5yIQq1lfM=; b=ArEW0bpRDDeA+SJYjJGqrU0wYO
	wPmvNTZn77XFKPOJFSOOEEmHQHmQrzE2+zv1xy4ZDPUZu8MK9dWiNscqbBtHrWZTJVgsK622mbzi5
	kqwucZ8zuAAdllIX+ZpkOB6/FGff1MKpxdV4KzNuMZhmitDcIHOy2xUYLGb5kJnk7ZnY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnIDM-0002qA-3M;
	Fri, 24 Jul 2026 15:53:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yangyongpeng.storage@gmail.com>) id 1wnIDK-0002pw-Ex
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:53:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bHxWTi1PCyRivamLzUJut7BIkQYtbAzA3LcjPz6TE5s=; b=VCBz5oJYgeBpAMxTBaRhl6JAgc
 bj3Ph2/XmVZIXDj88QrPJ1mRTNgwNLjpS+ck6CR7L8fGkuMu2FwkoqlryC8i1ZDXwxAztuw7Q8ubd
 eSgsZ4qdhb5o42p3GF3AXW8jX2kVNX5UwEL0gGhfTWgNmZfiVdpRvPapwH/FDAKFYiFQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bHxWTi1PCyRivamLzUJut7BIkQYtbAzA3LcjPz6TE5s=; b=Tz2wQUUNKTSUM4Pk2STZH8ccT+
 vKjxKOYxGwDW0yiokPRytZ5ANebU57JO2Kyu3rH7B13DO6bWAix62Q+QYB8xSr66hHOrYXeZ+X8ep
 MXSew0mL0ak99rQrB8KP9LpZe34EC75ONpcT280SjzARQ3mk+SRqxk5n8VX+w9JLClWY=;
Received: from mail-oi1-f180.google.com ([209.85.167.180])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnIDN-0005GM-Tz for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:53:31 +0000
Received: by mail-oi1-f180.google.com with SMTP id
 5614622812f47-48a0ca07c38so287489b6e.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 08:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784908404; x=1785513204; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bHxWTi1PCyRivamLzUJut7BIkQYtbAzA3LcjPz6TE5s=;
 b=Dyl66woK4sDoSB6Crg9wmYYYiap96TcviXOukroMv0dLi0C5cfzHzFqZJZ08bD/huV
 8EoFFpgRkCqldSd9FLevu5kqSn6oRnG4qqLmyh5RnUzLXiwaYv+mcMSsa2ZLs+D45tYO
 O8/zBOGoYQBrNDENvKfvGdP/UyJWVtkNebPCGVPAz4+1JhTcnvUDRKsBIFH2AdqYK5k9
 eB1p6kIz3qdHQbv9G9oUMNwO23AiB85/3af9Yy12/1jYkei7UJEaLqH8/oTEqUYtJEJo
 x8f6mNwl/zQonzxQYbdVw56wMVIBFpD332w40zgIoyTF19cvchihnUz59wWDkcaIwTOl
 /6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784908404; x=1785513204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bHxWTi1PCyRivamLzUJut7BIkQYtbAzA3LcjPz6TE5s=;
 b=VzgJ7KL+/A2/s8lQHz4ziYcqbGsopq1QBaCH50ZdEKca/Kme4JL3meE2lc00VzjBuP
 mUZCTmx8/MyK91QH7ID24+adEL2RzAg555xnhafJkVDNoDfiIB9msTROIkBnXVH+MDqS
 zj1gsZljQ/nKoO7FbpVnhp/9/PSkSl+90GclNYPE+kCNk6bCx0p0kcv5TjrdHQcHjTUm
 adSKQZ0wjZ+NqHtBhovOL4kZDI6H/Yx4fAGqDR5nr+ZlNNYxx5TYAgXalio4ITyFxKxM
 lQqWtverP5grc64+/E8I/Zp4aLKjxXfHQ+01iKLtVF40NpDPMDLVzkbDKRga2BrCEOQ7
 eiJA==
X-Gm-Message-State: AOJu0YxCKymR5I7WOnCy6EnAOnl8HT/8uT/ehXgiIXdUnekykS1rFX2h
 4q5VadDvBqYYE7vx8JwQyD4o5xC4ro/x/Pquz9XS1EzuZhbMHAirSjdsipwh/Q==
X-Gm-Gg: AR+sD12cYTBZb5T/5vaKwkpIB/vEqjHf2+pJKN0tf901o3IgLgMGoo+pnDllnm5jzav
 ttfAnVBvA8dScntkZ8exFfIyE8P9qFvS/StjqfgJyR8RutKAfYJojscofu4fk3QJC47Dwgn27hH
 84RtZwziKthEAfM356pDCckeh8tNkOVWr3+OrMsyUCQBrJEMFwEJencwg7I52BfDse4eAyJsWQA
 WJAUONjNhiJwRyLe++343KzdG+QwdesUfGnfH6lleaPY609Zi0Zn1koI6M15U2g+KAfdU+V01Gs
 ffJPDQIW9axXogwf/C5TZctjz/S10WgZFWVhI8LI+EmeFBihkYsqj6ps+J1ZZ3dXQkaArqvyWQ5
 lVs2r+L1EQyYfGOU0wukbmdZEjrLKZxhnJAxLkZHiSNMeoinShE3UwGnR6BI/ZJx2cRRkiIX8vO
 gtYfglEQeMcsbU7C6tECSGIBwWqzm/xXQBSMnV4EfSBGftZxW5tKXgKKfN7zk=
X-Received: by 2002:a05:6870:e391:b0:456:b721:f16b with SMTP id
 586e51a60fabf-457a10b4390mr4437765fac.33.1784897959364; 
 Fri, 24 Jul 2026 05:59:19 -0700 (PDT)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45767486cf6sm7359957fac.15.2026.07.24.05.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 05:59:19 -0700 (PDT)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 24 Jul 2026 20:58:22 +0800
Message-ID: <20260724125847.3928772-5-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724125847.3928772-2-yangyongpeng.storage@gmail.com>
References: <20260724125847.3928772-2-yangyongpeng.storage@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1wnIDN-0005GM-Tz
Subject: [f2fs-dev] [RFC PATCH v3 2/3] f2fs: add sysfs interface for inline
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

Add sysfs interfaces for runtime management of the inline extent
feature:

- inline_extent_extension_list: read/write the file extension list
  that triggers inline extent allocation. Format for writing:
    "ext" or "ext:capacity" to add (with optional per-extension
    capacity), "!ext" to remove.
  Reading shows all extensions with their capacity settings.

- inline_extent_enable: toggle inline extent allocation on/off at
  runtime (0 or 1).

- Export inline extent debug statistics (code coverage counters for
  merge, split, insert, evict operations) via
  /sys/kernel/debug/f2fs/status when CONFIG_F2FS_INLINE_EXTENT_DEBUG is
  enabled.

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
v3:
- Config per-inode capacity via sysfs.
---
 fs/f2fs/debug.c   |  4 +++
 fs/f2fs/iextent.c | 38 ++++++++++++++++++++
 fs/f2fs/iextent.h |  3 ++
 fs/f2fs/sysfs.c   | 91 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 136 insertions(+)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index ff379aff4472..c441ef3fdcbc 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -19,6 +19,7 @@
 #include "node.h"
 #include "segment.h"
 #include "gc.h"
+#include "iextent.h"
 
 static LIST_HEAD(f2fs_stat_list);
 static DEFINE_SPINLOCK(f2fs_stat_lock);
@@ -758,6 +759,9 @@ static int stat_show(struct seq_file *s, void *v)
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
index 533aaa4089bd..dd1d1782598f 100644
--- a/fs/f2fs/iextent.c
+++ b/fs/f2fs/iextent.c
@@ -6,6 +6,7 @@
  *             http://www.mi.com/
  */
 #include <linux/f2fs_fs.h>
+#include <linux/seq_file.h>
 
 #include "f2fs.h"
 #include "iextent.h"
@@ -710,3 +711,40 @@ int f2fs_iext_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
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
+		"  - drop_insert_new_ext_cnt: %llu\n",
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
+		atomic64_read(&iext_info->drop_insert_new_ext_cnt));
+}
+#endif
\ No newline at end of file
diff --git a/fs/f2fs/iextent.h b/fs/f2fs/iextent.h
index 722c84ce1800..66782296bbd5 100644
--- a/fs/f2fs/iextent.h
+++ b/fs/f2fs/iextent.h
@@ -160,4 +160,7 @@ int f2fs_iext_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
 					bool set, unsigned int capacity);
 int f2fs_iext_info_init(struct f2fs_sb_info *sbi);
 void f2fs_iext_info_destroy(struct f2fs_sb_info *sbi);
+#ifdef CONFIG_F2FS_INLINE_EXTENT_DEBUG
+void f2fs_iext_show_stat(struct f2fs_sb_info *sbi, struct seq_file *s);
+#endif
 #endif
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index be92c05a5420..53d83f66f074 100644
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
 
@@ -405,6 +413,30 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
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
+		for (i = 0; i < iext_info->iext_ext_cnt; i++) {
+			unsigned int cap = iext_info->ext_capacity[i];
+
+			if (cap)
+				len += sysfs_emit_at(buf, len, "%s:%u\n",
+							extlist[i], cap);
+			else
+				len += sysfs_emit_at(buf, len, "%s\n",
+							extlist[i]);
+		}
+		spin_unlock_irqrestore(&iext_info->iext_ext_lock, flag);
+
+		return len;
+	}
+#endif
+
 	if (!strcmp(a->attr.name, "ckpt_thread_ioprio")) {
 		struct ckpt_req_control *cprc = &sbi->cprc_info;
 		int class = IOPRIO_PRIO_CLASS(cprc->ckpt_thread_ioprio);
@@ -535,6 +567,48 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return ret ? ret : count;
 	}
 
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+	if (!strcmp(a->attr.name, "inline_extent_extension_list")) {
+		const char *name = strim((char *)buf);
+		bool set = true;
+		unsigned int capacity = 0;
+		char ext_name[F2FS_EXTENSION_LEN];
+		const char *sep;
+
+		if (*name == '!') {
+			name++;
+			set = false;
+		}
+
+		if (!strlen(name) || strlen(name) >= F2FS_EXTENSION_LEN)
+			return -EINVAL;
+
+		/* Parse optional capacity: "ext:capacity" format. */
+		sep = strchr(name, ':');
+		if (sep) {
+			int name_len = sep - name;
+
+			if (name_len <= 0 || name_len >= F2FS_EXTENSION_LEN)
+				return -EINVAL;
+			memcpy(ext_name, name, name_len);
+			ext_name[name_len] = '\0';
+			if (set) {
+				ret = kstrtouint(sep + 1, 10, &capacity);
+				if (ret)
+					return ret;
+				if (!capacity)
+					return -EINVAL;
+			}
+			name = ext_name;
+		}
+
+		ret = f2fs_iext_update_extension_list(sbi, name, set,
+							capacity);
+
+		return ret ? ret : count;
+	}
+#endif
+
 	if (!strcmp(a->attr.name, "ckpt_thread_ioprio")) {
 		const char *name = strim((char *)buf);
 		struct ckpt_req_control *cprc = &sbi->cprc_info;
@@ -604,6 +678,14 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+	if (!strcmp(a->attr.name, "inline_extent_enable")) {
+		if (t > 1)
+			return -EINVAL;
+		f2fs_iext_set_enable(sbi, !!t);
+		return count;
+	}
+#endif
 	if (!strcmp(a->attr.name, "discard_io_aware_gran")) {
 		if (t > MAX_PLIST_NUM)
 			return -EINVAL;
@@ -1257,6 +1339,11 @@ NM_INFO_GENERAL_RW_ATTR(dirty_nats_ratio);
 
 /* F2FS_SBI ATTR */
 F2FS_RW_ATTR(F2FS_SBI, f2fs_super_block, extension_list, extension_list);
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+F2FS_RW_ATTR(INLINE_EXTENT, f2fs_iext_info, inline_extent_extension_list,
+			extensions);
+F2FS_RW_ATTR(INLINE_EXTENT, f2fs_iext_info, inline_extent_enable, iext_enable);
+#endif
 F2FS_SBI_RW_ATTR(gc_idle, gc_mode);
 F2FS_SBI_RW_ATTR(gc_urgent, gc_mode);
 F2FS_SBI_RW_ATTR(cp_interval, interval_time[CP_TIME]);
@@ -1457,6 +1544,10 @@ static struct attribute *f2fs_attrs[] = {
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
