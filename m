Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B23ED39410
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  2 Apr 2026 11:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5x03NpWIx+o76bqkWLgNP4WxJHENL4hCuGQZB/whoqc=; b=QNtCBLRuJrS4/r05QQBB2JhY6c
	0O+1+50G2EX0DVQ0d/YCyWcKAbtArLMIoU7mw4TkJr11SdGUZHozVZw4ORhSXe1AE5I81BNyfvVos
	M2Uhvu5j4FSfKzuPnefoH4eo3RhnvS8lg8XnvMk5oaY4rm6Kg7N5J5Tf0YmzStHJ+9Dw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w8GVI-0006kt-5S;
	Thu, 02 Apr 2026 11:46:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jinbaoliu365@gmail.com>) id 1w8GVE-0006kg-2L
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Apr 2026 11:46:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wjFBmwZDTxIwgUGBCtjToCqhoQI9lvOaOQe5frF7phw=; b=D9MvRWhpxtKbJphncbh/TAXdFh
 105QMihuxyBkPTIeWYStrZvCCpZv+CZCW+tOKdq8kUeGCQSEicGrMeZh/GmsvAz+i0zFcS6h5yYlh
 9rws7ScBCcK8KDqyasxYdlBiU0AE1hYpQsrF20BSaslz9ZmjMN75XrOBMhb+dBQey6qs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wjFBmwZDTxIwgUGBCtjToCqhoQI9lvOaOQe5frF7phw=; b=G
 sljHp3+GwW+HQUDJ71iXBJ68cpQ2T+1nkrS9wOiF4p37OlfB7qiYWbcg9+Yj3U/+zTlMheJgGiXXV
 1q1Uc8YVUdJbNql7nq7LdVcysmZ4Wee/ma7JtBEVBGv5jBYxzm3Hz6XnQe5sFlFJaiTGPKFPkTynN
 AJSTWWHQYouRgkzM=;
Received: from mail-pj1-f50.google.com ([209.85.216.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1w8GVD-00042a-Jb for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Apr 2026 11:46:24 +0000
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-35d971fb6f1so653343a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 02 Apr 2026 04:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775130373; x=1775735173; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wjFBmwZDTxIwgUGBCtjToCqhoQI9lvOaOQe5frF7phw=;
 b=RCedhI0b64EX6ia+0L18asU7qb74QtStsyg2RMvvZ95v5FPRLtAAeHFPV28MfMCILi
 wma1DGL9qxJPU7iAqHDAwD2+VZfT0LgJiA6r2lrhqxAMD4lpeuWRY29mwBj+dOVGH+S4
 O1CH1W59cFSqxPAHZumLxRcfdPWfNPgE26bDe0BdfcdKvUnkgHbqNE52UQb4HxNAsc2b
 WicqRdTo0L+X1TfrLZ1ovxEN/eQB1O1cDzbBNPZMh03ZScOOl+bWK81rCbz7bpoGzVdq
 WmwWSp+8MtSN+DjufR/Q0+EiQ1Wgc2KBnmNS6odR1o+OfUmS17Jyb9lmj9/eu70QsOds
 8zDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775130373; x=1775735173;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wjFBmwZDTxIwgUGBCtjToCqhoQI9lvOaOQe5frF7phw=;
 b=N/Abptx08tUCnsoqdBYoqbjjmAoyDqaaWB6+CA+F/J3va7pbcAkAkb85A5ycE1dGYu
 w7uxlvxwymzGUc36fGr3YxV6EEfecM8lJweuJEzqlnr1KMoacAbrAJJBm2SqzlgJQMf2
 e1zS5fkph3dyS1Oird8awSmMrN3AfPwGYOUH5rIiCMSlHM+JSAUMsvKSpWNus0NHLsef
 eJtD8OxZSkhYZ7mCwrcc8cHx5Mxem/H5b1Z7ne07UgBC1jotMqPEm8Lxq0nKVcFaoV/Z
 X5LpBC5BQksCKnaA0xR/S9Ov30WjSGf2hwkFuFPDxB+AKh4gVzETMoX4m37BMt+YuhSz
 ITtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9V/UlpfPr9LgmVXbPghi2D/VRr0cpxkbLzO2vGyBTszmB/LTr5U2GsN3x5dLI0pjxjMTRGUSI9Aag0PqCH1ip@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwW+398c7L0ziovgNA+kGIEgYKa1MRW9bGxIhHDGpYN/rHezvkJ
 Th4Bh/l+ONJzGts9iozIgFLlSvxnY5lFUMqXlTSUP6y8k2WUgVe55Fxr
X-Gm-Gg: AeBDietDDZD9Gvv4OssmIJQlrUrecLZzoO8dkIZuu4/X/kDgqbdwD2UpJvhGu1BMtzo
 /MCJotOCVQcJO8t2AFZO+20ra92IFiND02YcPqU+uE0sSHsgeT36jYMvOe4V8dQu8fv5BWntTY6
 9Hq3El7Ra+SKghGz+tAyAglSpc7rdr5wX7C7Y/vit4eB8lANO5tu0MHHFNe8RtgAzg+aSKJBGT+
 usbtt79JFdngDrd2VNaknZYP0mGxdUGapiSi4rD62tyV46wlHHXb5LJUVxRseLGVlEJXXZ7uS57
 c7FcrirMmoRvLu0/Woux6AQgzHO/UznHx6K8kv1uQKSbXhMorKi1vFqEqhHKQq8qJbv0cNHRaHv
 ZOqDlA92ahvpXbon74fozzwvlzdwa4mfQhvm8HCwaePLN303pFa94jD8FbEy+/f5ByqpkLEaQjJ
 Zb8SQJ2BiPOgnlE2b8tIW9gitSTbe8og==
X-Received: by 2002:a17:90b:28ce:b0:35b:e551:e776 with SMTP id
 98e67ed59e1d1-35dc70192b6mr7112247a91.27.1775130372825; 
 Thu, 02 Apr 2026 04:46:12 -0700 (PDT)
Received: from mi.mioffice.cn ([2408:8607:1b00:8:60c5:6316:6dba:4c40])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe9709b8sm7334452a91.16.2026.04.02.04.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 04:46:12 -0700 (PDT)
From: liujinbao1 <jinbaoliu365@gmail.com>
To: jaegeuk@kernel.org
Date: Thu,  2 Apr 2026 19:45:58 +0800
Message-ID: <20260402114559.2030042-1-jinbaoliu365@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1w8GVD-00042a-Jb
Subject: [f2fs-dev] [PATCH] f2fs: Add trace_f2fs_fault_report
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
Cc: jinbaoliu365@gmail.com, liujinbao1 <liujinbao1@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: liujinbao1 <liujinbao1@xiaomi.com>

Add trace_f2fs_fault_report to trigger reporting upon f2fs_bug_on,
need_fsck, stop_checkpoint, and handle_eio. Since f2fs_bug_on and
need_fsck can be triggered in hundreds of scenarios, define set_sbi_flag
as a macro to help capture the effective fault function and line number.

Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
---
 fs/f2fs/checkpoint.c        | 10 ++++++++++
 fs/f2fs/f2fs.h              | 20 +++++++++++++++++++-
 include/trace/events/f2fs.h | 22 ++++++++++++++++++++++
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 6dd39b7de11a..698540c0f619 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -24,6 +24,8 @@
 #include "iostat.h"
 #include <trace/events/f2fs.h>
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(f2fs_fault_report);
+
 static inline void get_lock_elapsed_time(struct f2fs_time_stat *ts)
 {
 	ts->total_time = ktime_get();
@@ -232,9 +234,17 @@ static inline void f2fs_unlock_all(struct f2fs_sb_info *sbi)
 static struct kmem_cache *ino_entry_slab;
 struct kmem_cache *f2fs_inode_entry_slab;
 
+void f2fs_fault_report(unsigned int err_code, const char *func, unsigned int data)
+{
+	trace_f2fs_fault_report(err_code, func, data);
+}
+
 void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io,
 						unsigned char reason)
 {
+	if (reason != STOP_CP_REASON_SHUTDOWN)
+		f2fs_fault_report(REPORT_FAULT_STOP_CP, __func__, reason);
+
 	f2fs_build_fault_attr(sbi, 0, 0, FAULT_ALL);
 	if (!end_io)
 		f2fs_flush_merged_writes(sbi);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bb34e864d0ef..ac2fa4b6bd37 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -97,6 +97,15 @@ extern const char *f2fs_fault_name[FAULT_MAX];
 #define DEFAULT_FAILURE_RETRY_COUNT		1
 #endif
 
+enum {
+	REPORT_FAULT_NEED_FSCK,
+	REPORT_FAULT_PAGE_EIO,
+	REPORT_FAULT_STOP_CP,
+	REPORT_FAULT_MAX,
+};
+
+void f2fs_fault_report(unsigned int err_code, const char *func, unsigned int data);
+
 /*
  * For mount options
  */
@@ -2275,11 +2284,18 @@ static inline bool is_sbi_flag_set(struct f2fs_sb_info *sbi, unsigned int type)
 	return test_bit(type, &sbi->s_flag);
 }
 
-static inline void set_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
+static inline void __set_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
 {
 	set_bit(type, &sbi->s_flag);
 }
 
+#define set_sbi_flag(sbi, type)				\
+do {							\
+	__set_sbi_flag(sbi, type);			\
+	if ((type) == SBI_NEED_FSCK)			\
+		f2fs_fault_report(REPORT_FAULT_NEED_FSCK, __func__, __LINE__);	\
+} while (0)
+
 static inline void clear_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
 {
 	clear_bit(type, &sbi->s_flag);
@@ -5064,6 +5080,8 @@ static inline void f2fs_handle_page_eio(struct f2fs_sb_info *sbi,
 	if (unlikely(f2fs_cp_error(sbi)))
 		return;
 
+	f2fs_fault_report(REPORT_FAULT_PAGE_EIO, __func__, type);
+
 	if (ofs == sbi->page_eio_ofs[type]) {
 		if (sbi->page_eio_cnt[type]++ == MAX_RETRY_PAGE_EIO)
 			set_ckpt_flags(sbi, CP_ERROR_FLAG);
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 9364e6775562..039c695c45a8 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -2582,6 +2582,28 @@ DEFINE_EVENT(f2fs_priority_update, f2fs_priority_restore,
 	TP_ARGS(sbi, lock_name, is_write, p, orig_prio, new_prio)
 );
 
+TRACE_EVENT(f2fs_fault_report,
+
+	TP_PROTO(unsigned int err_code, const char *func, unsigned int data),
+
+	TP_ARGS(err_code, func, data),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, err_code)
+		__string(func, func)
+		__field(unsigned int, data)
+	),
+
+	TP_fast_assign(
+		__entry->err_code = err_code;
+		__assign_str(func, func);
+		__entry->data = data;
+	),
+
+	TP_printk("err_code=%u func=%s data=%u",
+		__entry->err_code, __get_str(func), __entry->data)
+);
+
 #endif /* _TRACE_F2FS_H */
 
  /* This part must be outside protection */
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
