Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B7CC56208
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Aug 2026 13:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dzlrvXa4+nndma88X68bktsT0ueLmF9n/BNmJxmqJmY=; b=iTDF47Jn+RwejQ72eNRGSDuDIG
	dhpQPgXomfST8+wHMCcVCsh04IMhh+yWvRVNVReAPWy5HboEpV7zNFbHTsNzvxlcnqUEDqt3PNFby
	nBEamGFm8j9Q6nVUFuhNETfZV0+WFt071Kl1v0NqiXfz47BJUhX2Nfa9nSE1crm1Umg4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wry0t-0005zb-9j;
	Thu, 06 Aug 2026 13:19:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yangyongpeng.storage@gmail.com>) id 1wry0s-0005zV-2M
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 13:19:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yr00SajNgD0tVD7ggh5MO761A+INAMsJYuFBDbBey3c=; b=acFAMAIV6CEgoqNc+C6CjFkLLJ
 eRrRtAs0XTtck7eM1loqdxqXB2QpYgSSc3HJ0rpedrCqU7mbN5rQKPEjNoyb9XmEobTdbZrMro8rw
 PwrK4ojNq9CZkXMyzafCzMt31mduXBt0vP5cjYWKqwpf5tgCHA54k/dl4G4XHrp3lHN4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yr00SajNgD0tVD7ggh5MO761A+INAMsJYuFBDbBey3c=; b=BAdyInTrSbGtWgxGP8gHtXmQhT
 VzyyBZxp6xHQHQRrIWohmYLI5WW/5X6lwF97ZdgRZP/rRXcBaZwGn7eyyOiY99EvdFMEbOHUVs8w2
 GLrgO/y9l3pK/jbnvEjv0eZd7dyJiiQLKAjxlaJILRLP49cuWivRa+PaACPBvyIbI7fE=;
Received: from mail-pl1-f178.google.com ([209.85.214.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wry0r-0001lT-Fl for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 13:19:58 +0000
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2ce7d2adef4so32890155ad.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 06:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786022392; x=1786627192; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yr00SajNgD0tVD7ggh5MO761A+INAMsJYuFBDbBey3c=;
 b=H8TLwfQnbea67qP0AV+2/rrLzoK46mTRsQho8awPmdPdCXitmzt/6N2Bs8I0K4dUvU
 e7xiMMy02FurR2FGlBfbU/UjkuzU3iuS6LO86BffSpy+PPie42sAQW9aCQpmhSGU92pL
 EeaN1DIuqGUCqwtVbdgHQExnQIspQp9imyzJtiKxrkSIyxFwZszQeVrUWyKkLbvIVYLY
 xOA2MQSdIQ+DqrueJENoudvnxjShN12q8P9SE4LIVeaLbtl3xNyux4TFJ784xIclZKzN
 iIV5BiXidSqjrfY7+iuGTwQmxeRCO0YUrCWxtFryPOAaeeeE0Io7ln+AO130X8ioVz3P
 LOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786022392; x=1786627192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yr00SajNgD0tVD7ggh5MO761A+INAMsJYuFBDbBey3c=;
 b=Fc067M11/4wGYRLHqmnDSDOTG5/DxPkoqF4tmPvldJ+9Uf9vx7649w9VVB5SAQqmZC
 12MhCxQBJdjdIXl37Ci9C2/qq8yleT6jacSimrvw9vU6qitESXSWUClwTMGNZKgFY4jw
 epzcwmePY6ySd/bSaoQRXIRnM0NdDBuVDt2gbUrgZhBiY0605lKt0kgkajXIdB5GU9X+
 ppJdpWYJ/EICLQHQW1E7xp7TnY6jdyv+DN23Za8Z0LfH4CLbvgCjE0JbL0FvgswN42/p
 /Qv8oEgHmjc52Z0VZPXklfl92rKkR3qBnb3HZTTymO3wuzUi9Wmy6cWUsMdHyF1u1skl
 yJBA==
X-Gm-Message-State: AOJu0YxVscRsclWpvMuBVxi0adYiBAAw8GIwudm1PKLlaTe7GDmc68W6
 9G4aVi+XSL1l38ikW24Gi672mUpqEWC3GRJsHBrd0slYOHHmQjLUzuYJ
X-Gm-Gg: AR+sD13WReOAsEN/NV5NP4hoOq0DwswGIGai/3MfqeAfzkrHEiCQwF0cF7NvKPx59DW
 B83UFuWW4WWwWunQNY6QcCK0HcIga1pkTWJn/YkceS8AnLQUMriMMq2a/yCdST9Uzdj0/5843hA
 9+NrlkiwL+AhH4OAybBbDW6sCbPR69+4nwzdSX3Vza1d9M6crUPVmgOyc0MLVrYr40yGw/Gcc0d
 HG0j1MI73vj0LnghyF+2Nwwy5ohVsppFn8GwVRxTiymZg4T7RyyhrEJFWPCoxrTxFdnaFiuPd08
 d5m9RhJ+oi+sWgTCBCs56eb1zWKPcyjVIrFL+yyb/vvnBx8GCQXrNlzcN2oblDb1POkDoiREokn
 AkdHS3knpgbRb54yKaiRuzUtbUy5tnXsJC9dGUDJFDLubc8pNtjbOZ4b/SM10iIF+62xdp4KYJK
 yc7WcSyZZ5g7mpT9cAO4QZRZ3UwB+A7S9MHM/sKtjsJ5r+IU1DbS+xnIdG+lSTghuye7hr0FXn2
 r8+jzz66eBJkEa69PTTZEJzZX/3GTt8vvH/fibj7g0Cgd9qtZeUEYCyyg==
X-Received: by 2002:a17:903:22cb:b0:2ca:a03a:29b2 with SMTP id
 d9443c01a7336-2d0ca71140fmr154682905ad.8.1786022391528; 
 Thu, 06 Aug 2026 06:19:51 -0700 (PDT)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0a9ffb2f7sm31736355ad.29.2026.08.06.06.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 06:19:50 -0700 (PDT)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu,  6 Aug 2026 21:19:04 +0800
Message-ID: <20260806131906.2961409-6-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806131906.2961409-2-yangyongpeng.storage@gmail.com>
References: <20260806131906.2961409-2-yangyongpeng.storage@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1wry0r-0001lT-Fl
Subject: [f2fs-dev] [RFC PATCH v4 2/3] f2fs: add sysfs interface for inline
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

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
v4:
- Remove the inline-extent code-coverage statistics output.
---
 fs/f2fs/sysfs.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

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
