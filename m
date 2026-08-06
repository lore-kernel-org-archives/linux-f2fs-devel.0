Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DD0C55ABF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Aug 2026 13:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3/K5kfuB6go5i8rCjsjkisdTkbWi0Lk6CHtO+qmVFQc=; b=ZfP6h+uxmlOUxfhisX7MCG/CbP
	l8LZnuTw0lyytCSX4E0TjrCokfYTCPqGMuaf55FdEBzk1raFxlcsl7GeZ17S30kP3HkYr0TyxsS2k
	uURbz7SZcfd7ZkiqEGnyTq2WDRiNcR/Cb6OfuSlt0WSmF7bn8rc+ZDRHA9mg30LYoTQQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wry0z-0001uW-P7;
	Thu, 06 Aug 2026 13:20:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yangyongpeng.storage@gmail.com>) id 1wry0x-0001uG-HL
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 13:20:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z0vPYhcSlITIE/Ifu73WNA2DEkU/JXW+i2Y4+W7/flE=; b=Pv2AgPNwc4xWr7Hk/THnaR8eZn
 snkowIjMqeUv1YtBIAcv3IajiY+HEHfOxBXDFtC7kw1eV3sl+IfnQmJWqrQ5kebnjSfxgS6L7OPzw
 7w7yuHVNxpfZ8QkjEaN6YoUyjwBWBUSZkmnOAgo3VAKVbTg7X92tv/nBzlpYdp1Afo+Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Z0vPYhcSlITIE/Ifu73WNA2DEkU/JXW+i2Y4+W7/flE=; b=cx3e9vTjuS6j8oRAMh4/9b7kZY
 UMqymrCcBayEogFO/0K3gB2Dk9WIPFiJ/0xORwH3qUv+MY52h9chHQ664UPMJqXAiAc/okn86UGiL
 qzBat9OtpzqRdKfOCoDHGLdxWlNks0bJlC9ueqq2QkBFSIq80biuaGXvjVBHdGza7mqI=;
Received: from mail-pl1-f170.google.com ([209.85.214.170])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wry0w-0001lc-28 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 13:20:03 +0000
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2cc97653887so25578535ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 06:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786022396; x=1786627196; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z0vPYhcSlITIE/Ifu73WNA2DEkU/JXW+i2Y4+W7/flE=;
 b=lUVUfjy5PPhs0TEfkqQqpd5deMIEODxyfx6lednw+rZCF7vQvQCZZb6r4yJYZC2o5J
 ngXLocWitqWPKdODOGNlBE/mi6W31H4UDX+Q54ZE+MqctViRWSZ/Xvas1LEAS9FFY4zr
 MlQEfP/zpb/j0WG+yBKCRNpJizfvPkPavcCRqnKtKQkWXHlO0o6S1JEKuM4ZseKjZS8s
 0OkOb6kqvTrVjIQ4Tlb65RIU/5ERyN3/zdssF9MMO/sDedOo8dKF1WaTees3dBjR4HZv
 wDu0JLWyzOtMMFfxsEwOMVdYgmTsUsSLP0if3e9rLyC7cZ9gReTa26q4SPRcOD0Yr9gA
 RagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786022396; x=1786627196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z0vPYhcSlITIE/Ifu73WNA2DEkU/JXW+i2Y4+W7/flE=;
 b=SexEpCounHEPWO7z7o2CpuB78g550osiZHHaVlWsiZOB6xvd1BVkmMaPxUGVBAD4HP
 671nAj8HuAv6L9Hn/LUUZavGsRFx1c1B/sfFXx0MUYiBN3qAAC2eNLKuVqNktdAJfajg
 osPZpM4j1rqR8UkRNjox6Id0I+w19hyXiGYn5xmjuiPx7j349IG60hFDahLWQ31siC+Y
 waLcl7NAT0Gs7MVnWJSEh6octnidCbtE3YILcyAXaV6zMCzR2FiHgDU/IT4SYjCKULs1
 nad6StJnh8gAWDKnGHaUaTwhdDt7ojM4I+vO0m125/+5ayQKrbv2ZD20ijHfSPXPv6sW
 z9sA==
X-Gm-Message-State: AOJu0YyryVQDFL7ikZkkC90egNDvw0IGAr9V2g3anQ0lDQGXvekzqNbL
 TrsSmnlHUq7aOJg4UnCcyUQAWOq2g+ewOqBieuzP09KV0heJHCQ1jqxH
X-Gm-Gg: AR+sD13IN043LLdi7PB5NzkwNoaWjQotJRnQxRoHogWyCsjD2Q1CvF092ICYfAoQy5l
 wC0GfyKQPd7SBtf0ln6f3AL57+A8mxBQLkMoAITpDl2j+0sJRfuVF0hFYgn7fgF7Kwi9xQNNKOK
 QwoiZTimsZUaV17iZ7asQfP4rtVuWHJwOjGEd6bpwz7XcoiCmRiQJzjnAytgr8LA85p4ScbON5W
 pDT2w51tGnqEvhY9C6AtXVipB59mEI3Klh+9TMSPlo3a/IXtIUCa1YGlqMUZu6/RwxAQG7jqIP+
 /cNO1ZIddiQpkB86tcu9UKGPyHhvaiLxbEiImfTujTRF/f2OEb3jrMGKdj/aLuTuJCu3B3QgkkD
 0cIMgSN6lX2FuMgGvJ1bcbZskwpJOZgv3YZ8Exk/GcMlETjOXcfJ/D0JKWhVooByMDKFxoQelbH
 zSEmN2h3y7X4eVMj2+BxoG6WILwwe7+0YLDuySSUQYS1tnzSGAuIRrFdbCUwGWJp0hTnfT8Tp4g
 BAr3YM9UszGXluhaKxeRxRYdLIn8JV7GUo=
X-Received: by 2002:a17:903:3248:b0:2ca:ecf6:910e with SMTP id
 d9443c01a7336-2d0ca14c351mr196306355ad.0.1786022396025; 
 Thu, 06 Aug 2026 06:19:56 -0700 (PDT)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0a9ffb2f7sm31736355ad.29.2026.08.06.06.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 06:19:54 -0700 (PDT)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu,  6 Aug 2026 21:19:05 +0800
Message-ID: <20260806131906.2961409-7-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806131906.2961409-2-yangyongpeng.storage@gmail.com>
References: <20260806131906.2961409-2-yangyongpeng.storage@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1wry0w-0001lc-28
Subject: [f2fs-dev] [RFC PATCH v4 3/3] f2fs: introduce tracepoints for
 inline extent lookup and update
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

Add tracepoints to aid performance analysis and debugging of the
inline extent mechanism:

- trace_f2fs_iext_lookup_blkaddr_start: fired at the beginning of an
  inline extent lookup, recording the inode and logical block offset.

- trace_f2fs_iext_lookup_blkaddr_end: fired on successful lookup,
  recording the inode, logical offset, resolved physical block address,
  and extent length.

- trace_f2fs_iext_update_data_blkaddr: fired when updating a block
  mapping in the inline extent area, recording the inode, logical
  offset, and new physical block address.

These tracepoints can be used with ftrace/perf to measure inline
extent cache hit rates and identify hot files benefiting from the
feature.

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/f2fs/iextent.c           |  7 ++++
 include/trace/events/f2fs.h | 79 +++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/fs/f2fs/iextent.c b/fs/f2fs/iextent.c
index e2eed9e79960..09e2994ab61f 100644
--- a/fs/f2fs/iextent.c
+++ b/fs/f2fs/iextent.c
@@ -9,6 +9,7 @@
 
 #include "f2fs.h"
 #include "iextent.h"
+#include <trace/events/f2fs.h>
 
 /*
  * ASSERT - debug assertion for inline extent code.
@@ -256,6 +257,7 @@ int f2fs_iext_update_data_blkaddr(struct inode *inode, struct folio *ifolio,
 	block_t start, end;
 	unsigned int len;
 
+	trace_f2fs_iext_update_data_blkaddr(inode, fofs, blkaddr);
 	/* NEW_ADDR blocks are never cached. Treat it as a delete. */
 	if (blkaddr == NEW_ADDR)
 		blkaddr = NULL_ADDR;
@@ -345,6 +347,8 @@ int f2fs_iext_lookup_blkaddr(struct inode *inode, struct folio *ifolio,
 	int index, hit;
 	block_t blk_start, fofs_start;
 
+	trace_f2fs_iext_lookup_blkaddr_start(inode, fofs);
+
 	if (EXT_ENTRY_COUNT(eh) == 0 || F2FS_EXT_LOGICAL_END(last_ext) < fofs)
 		return -ENOENT;
 
@@ -361,6 +365,9 @@ int f2fs_iext_lookup_blkaddr(struct inode *inode, struct folio *ifolio,
 	if (len)
 		*len = F2FS_EXT_LEN(ext) - (fofs - fofs_start);
 
+	trace_f2fs_iext_lookup_blkaddr_end(inode, fofs,
+			*blkaddr, len ? *len : 1);
+
 	return 0;
 }
 
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 270c1a2c24c4..dc468a0c2980 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -2623,6 +2623,85 @@ TRACE_EVENT(f2fs_fault_report,
 		__entry->data)
 );
 
+TRACE_EVENT(f2fs_iext_lookup_blkaddr_start,
+
+	TP_PROTO(struct inode *inode, unsigned int pgofs),
+
+	TP_ARGS(inode, pgofs),
+
+	TP_STRUCT__entry(
+		__field(u64,	ino)
+		__field(dev_t,	dev)
+		__field(unsigned int, pgofs)
+	),
+
+	TP_fast_assign(
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->ino = inode->i_ino;
+		__entry->pgofs = pgofs;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %llu, pgofs = %u",
+		show_dev_ino(__entry),
+		__entry->pgofs)
+);
+
+TRACE_EVENT(f2fs_iext_lookup_blkaddr_end,
+
+	TP_PROTO(struct inode *inode, unsigned int pgofs, block_t blkaddr,
+						unsigned int len),
+
+	TP_ARGS(inode, pgofs, blkaddr, len),
+
+	TP_STRUCT__entry(
+		__field(u64,	ino)
+		__field(dev_t,	dev)
+		__field(unsigned int, pgofs)
+		__field(u32, blk)
+		__field(unsigned int, len)
+	),
+
+	TP_fast_assign(
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->ino = inode->i_ino;
+		__entry->pgofs = pgofs;
+		__entry->blk = blkaddr;
+		__entry->len = len;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %llu, pgofs = %u, blkaddr = %u, len = %u",
+		show_dev_ino(__entry),
+		__entry->pgofs,
+		__entry->blk,
+		__entry->len)
+);
+
+TRACE_EVENT(f2fs_iext_update_data_blkaddr,
+
+	TP_PROTO(struct inode *inode, unsigned int pgofs, block_t blkaddr),
+
+	TP_ARGS(inode, pgofs, blkaddr),
+
+	TP_STRUCT__entry(
+		__field(u64,	ino)
+		__field(dev_t,	dev)
+		__field(unsigned int, pgofs)
+		__field(u32, blk)
+	),
+
+	TP_fast_assign(
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->ino = inode->i_ino;
+		__entry->pgofs = pgofs;
+		__entry->blk = blkaddr;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %llu, pgofs = %u, blkaddr = %u",
+		show_dev_ino(__entry),
+		__entry->pgofs,
+		__entry->blk)
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
