Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EB7F41992
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/RaeOvtzrdFocBc2ylEpklxxfo/JPc5zS7TBSHp+R14=; b=NpbKEGQaBmTvE83zZm1REzOBF2
	z/poDiiNinSNp6a/Aw708pKIUw/JXxKnwhG27a2KaebF7r4NdGt4McRiKviQIYK5gN284ylwsVyWL
	7xpKfFms0GZkOLuvghC4RfbEZ1fPc95MhV3wdwFaQvvheDfHDSPp7CqMinBOgnQfs9E0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wCyfy-0001cP-20;
	Wed, 15 Apr 2026 11:44:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jinbaoliu365@gmail.com>) id 1wCyfw-0001cF-JX
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Apr 2026 11:44:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=APUCoi4C5MHBKOyC6USPCPJ/xNAE7WqBHL066e0uZso=; b=c3zafrnSx7lX4kpwKd+VkXH5gy
 UTNITMt1F01BWesuiy+kK7nlldeS0hNPacRtz5/KAzFf/AZhwn8Qf/6fd/UlqgayMVL5PUbEqBDnR
 cKgTlfdcCtxTbKs+ZXykHF7SobivnGJdfKdnY7IO0Z2WnOoqhfFwXeETUuNhc4jXCK8I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=APUCoi4C5MHBKOyC6USPCPJ/xNAE7WqBHL066e0uZso=; b=e
 1ekGda9VL3GIkAS9fItyokqbj5FIlvAWneSwHLpUadBwIoQMk4Xj7NX43ha7KrQWi8J4s75evSX4N
 Aqi4zl502OLoTcuzBazfq0lSLTBkripQo99hpp63xoZsbK6EbaX5cDwJ3zCzJlKNm9H/xeDBuPX5l
 gZmaGk5hXBp8wc2Y=;
Received: from mail-pj1-f49.google.com ([209.85.216.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wCyfw-0008Jq-4H for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Apr 2026 11:44:56 +0000
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-35fb7c1a455so1348294a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 15 Apr 2026 04:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776253485; x=1776858285; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=APUCoi4C5MHBKOyC6USPCPJ/xNAE7WqBHL066e0uZso=;
 b=tFpSCNf93+9JySywc7EA5RbJ6YpzYs4oOAKau6QYm+2W022zfqU0drOqsxVjcEZDbT
 3ZDFMQnHxQ8YlDDs2fuwlM7j6lStr9+vTOeVxzKfn8uXxYdH2JzShEAlZxE50wtu2Bs/
 UtlkAJjMZd7H+OH4Opxk39Y+GQsclLhqfR4khkqQzAa6sz8SMkKySVT0Xy8dkSKJbfQc
 W73vZKRTcqsLc5Q12Vrw/upk0dWcdsoOcx4pin0N2Fy4Q+/uf90n+JvSHo42HOiUe7ZA
 KpR45jKdiGy/Icx+LRAy1PHtaWkKJ2C7tBLg8Vr3orUDN3DUikFlYCIF5DDb50NAWbi2
 5TxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776253485; x=1776858285;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=APUCoi4C5MHBKOyC6USPCPJ/xNAE7WqBHL066e0uZso=;
 b=dwlqGY61DLFh2jB9RF/CVIktvmasxBgcecuKRN37dM9YZ31AbN7gKj+5BhufROulz/
 TmNduxeJLi+DxMj47KGJHIcTeMrfuFa49uiFXSUKTUX8dBucxjuEscRNZQ1llgKPWmC0
 Ec+J6kW9sAY1Kzkf2uAQ+xfmmwM5FmTr5tWFqoZtAP86pF7KTQSIFXIpPjWUE0kF5FoK
 Sekq0PnVtWW6JwWjHEdcLC/bZ7qcOf1aivHefZ5oxrM1vKdYgJ+vFQ34VccDAgI0OcS4
 U3P0VAKA06TpcXVpr+S6qabbBwI6APEvIa3T/hirYRkgAyTov5cXVnKS/UvfvZLV/DMN
 6kuQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+PH4lb102t5lvpS9HE8hWrypwbyuTPoPneIyKcAXOH7OGb28D3C8hPrCXzMpiIhLxZDHn7kIzky8taZ53t98dp@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzqZcp4iyapukwpngOEAXu5ePZHcdZAQ5mHZ/wJu6BRYBod3461
 qf5dvKdZd2W/wmv5jIKf1oEezE/2CLLmL0GlyceXl+yfKlM86X+Z/AJk
X-Gm-Gg: AeBDietiy6n42DTCEBLh1XfaXWSAdFKAcVQ0jD9kkOpP1ZbT9tnYA5AbQUnfVna85uS
 K8/UhRbVMcWwGhemYywEjL1rfNd2ub5r4W7BwusCScA3LONspqp0eMgkJS5USVKgoyy7BTX0XdY
 bE6G8CXHo10YmXNhrAxHA/KeJP1TAFBvfbLv8+vUww/qDKhk34FzCnV6ywObwsP1ads8s46b3fy
 sqoRlCVR6iyVyVB3esC3yvAc2Gbrg/ACm3AhCCmHNBsRrnSUMvjNRZlzLWtiCDS6FksXlLVIh8g
 8bZ4BEixiJVEfjGXTZIgdPRsfMya9tzGN4PCJb5blepYix2nD1hvYwzL9mWPDC59fWYRplC/LSW
 X39rG8jdO8lAxy2GkgWFMsF7UP5iuF0l9jqC+nhFSnsibNl/9wLW9UQfE8FRo5im0/gtoVlQNtS
 tCyBpbXBFgflaQUpUAA5tVfY/tmxO7hV9DvYkjf1pX1Q==
X-Received: by 2002:a17:90a:d407:b0:35e:594a:5b75 with SMTP id
 98e67ed59e1d1-35e594a62e8mr12978191a91.25.1776253485349; 
 Wed, 15 Apr 2026 04:44:45 -0700 (PDT)
Received: from mi.mioffice.cn ([43.224.245.178])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35fd1fe9fcesm2148463a91.2.2026.04.15.04.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 04:44:44 -0700 (PDT)
From: liujinbao1 <jinbaoliu365@gmail.com>
To: jaegeuk@kernel.org
Date: Wed, 15 Apr 2026 19:42:37 +0800
Message-ID: <20260415114237.3089952-1-jinbaoliu365@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wCyfw-0008Jq-4H
Subject: [f2fs-dev] [PATCH] [PATCH v2] f2fs: Add trace_f2fs_fault_report
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
Cc: jinbaoliu365@gmail.com, shengyong1 <shengyong1@xiaomi.com>,
 liujinbao1 <liujinbao1@xiaomi.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: liujinbao1 <liujinbao1@xiaomi.com>

Add trace_f2fs_fault_report to trigger reporting upon f2fs_bug_on,
need_fsck, stop_checkpoint, and handle_eio. Since f2fs_bug_on and
need_fsck can be triggered in hundreds of scenarios, define set_sbi_flag
as a macro to help capture the effective fault function and line number.

Signed-off-by: shengyong1 <shengyong1@xiaomi.com>
Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
---
 fs/f2fs/f2fs.h              | 18 +++++++++++++++++-
 fs/f2fs/super.c             |  9 +++++++++
 include/trace/events/f2fs.h | 28 ++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 56c4af4b1737..2249a68d6bf5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -97,6 +97,15 @@ extern const char *f2fs_fault_name[FAULT_MAX];
 #define DEFAULT_FAILURE_RETRY_COUNT		1
 #endif
 
+enum {
+	REPORT_FAULT_NEED_FSCK,
+	REPORT_FAULT_STOP_CP,
+	REPORT_FAULT_MAX,
+};
+
+void f2fs_fault_report(struct super_block *sb, unsigned int err_code,
+			const char *func, unsigned int data);
+
 /*
  * For mount options
  */
@@ -2278,11 +2287,18 @@ static inline bool is_sbi_flag_set(struct f2fs_sb_info *sbi, unsigned int type)
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
+		f2fs_fault_report(sbi->sb, REPORT_FAULT_NEED_FSCK, __func__, __LINE__);	\
+} while (0)
+
 static inline void clear_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
 {
 	clear_bit(type, &sbi->s_flag);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ccf806b676f5..b431842751d6 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4724,9 +4724,18 @@ static void f2fs_handle_critical_error(struct f2fs_sb_info *sbi,
 	 */
 }
 
+void f2fs_fault_report(struct super_block *sb, unsigned int err_code,
+			const char *func, unsigned int data)
+{
+	trace_f2fs_fault_report(sb, err_code, func, data);
+}
+
 void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io,
 						unsigned char reason)
 {
+	if (reason != STOP_CP_REASON_SHUTDOWN)
+		f2fs_fault_report(sbi->sb, REPORT_FAULT_STOP_CP, __func__, reason);
+
 	f2fs_build_fault_attr(sbi, 0, 0, FAULT_ALL);
 	if (!end_io)
 		f2fs_flush_merged_writes(sbi);
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 9364e6775562..b97bc3bf499a 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -2582,6 +2582,34 @@ DEFINE_EVENT(f2fs_priority_update, f2fs_priority_restore,
 	TP_ARGS(sbi, lock_name, is_write, p, orig_prio, new_prio)
 );
 
+TRACE_EVENT(f2fs_fault_report,
+
+	TP_PROTO(struct super_block *sb, unsigned int err_code,
+		const char *func, unsigned int data),
+
+	TP_ARGS(sb, err_code, func, data),
+
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned int, err_code)
+		__string(func, func)
+		__field(unsigned int, data)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= sb->s_dev;
+		__entry->err_code	= err_code;
+		__assign_str(func, func);
+		__entry->data		= data;
+	),
+
+	TP_printk("dev = (%d,%d), err_code = %u, func = %s, data = %u",
+		show_dev(__entry->dev),
+		__entry->err_code,
+		__get_str(func),
+		__entry->data)
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
