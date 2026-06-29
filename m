Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4388C43327
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Qr39UvOzgicL6TEOW8cTnW8nXrNLzGZB78dG5+ptWYk=; b=kgq0EoLxPxNBqQ7LzlpYDSm+3F
	sKQAjM7KgRHjN+DdByjFqvOHW6/BawbJiRY4Z70+nnwPPlnE7ag5wsuoM4BHQh+IObDdEvjDxRpzZ
	1S1JZ5Sh5QCCQfzaBCf4InHGrM2w5CJd60ca8mDgIsnvTC3KNQgD2UH7dFHCC3Cd40MM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1weAH1-0001m2-HS;
	Mon, 29 Jun 2026 11:35:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1weAH0-0001lw-96
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 11:35:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dUfXUhJKFOXNw8CUsqhWMHTHM7liMd5Eu8ugQl8pICc=; b=QbQz82Cc/IeS5B8CfUUpLzzOzL
 2BzdHJFqjf7rXL3raBOCsl33DsBmsB62zyct6w8jS7RuXU9NgGCm6vkxeOWNbQ2rW+MiyGnyUShn8
 ox3rIjbyJvlNSDC7FVeiimStIlaAd73jM35w/pkCuGGlijh1S799txv7SdysXwZns9B8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dUfXUhJKFOXNw8CUsqhWMHTHM7liMd5Eu8ugQl8pICc=; b=T
 vP3UqDFSn7H7gaz/j20CVEvys41nIem7Sit9tTXaz+tV0ZRs5E9EetDOqzoCoXlNiBrla7AvQgy9o
 vaD1T/0OIhhMfKGKzPtodNtGL/Q8bzBLdKemhogR5jZXhBgBq3qP6wkzgQC3FNygMBfQrnqk+vOUb
 ThMzGeaoTKRhaBUw=;
Received: from mail-pl1-f171.google.com ([209.85.214.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weAGy-000831-SW for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 11:35:34 +0000
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2c7cfa17fedso26994265ad.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 04:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782732923; x=1783337723; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dUfXUhJKFOXNw8CUsqhWMHTHM7liMd5Eu8ugQl8pICc=;
 b=T4hvTTMGBuB+Kr37gtx3TOWvPTtmsTMUDGBXECy4HwPuaj3wZ4+oD6f3WEYozYepLR
 fcwNBsP8pZ9BAmvkNR6ZF00rrBleR3eOUx9C7FXYOyQuqRX83G/mt9ZgEglN9zSAfeHz
 Ks/y6KT86NOUFvEkgqMiehVVnCemDFrApBCiYArAT8tSWzuwJYfxMO1Q1YcImVkPe4uP
 S04wbAE3NFES2bRupmAzdnZwEdM74QIHyeavAcDmAADVJAlfW6gfmALHB1LhWg0kM7fU
 o87xDzGavuh4cydB3VVYj8DH7frnLBsWRKKgRhLl9qb1fb1JyRaP3GNcChhMuUdqYl8f
 FhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782732923; x=1783337723;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dUfXUhJKFOXNw8CUsqhWMHTHM7liMd5Eu8ugQl8pICc=;
 b=JXmskzQqHc/da/BWzCjLF5/ZsJQlaCA986UGzcCz7rcyRWEh/5GWkR1YUvf6XBISHr
 56ivRMJ2Z+Lb7tiW09+hU2nEKfceRNe7f5w+xwYGVuu3ohYhTJUybJ5+cHh6PERy9ANT
 etW3guZy1bW7eIpokMivYpE7eMpDjDC8RrRXSbE5VY1LMecyWHgqv666hWn5ppRZU/5p
 d50CIqjYvOXw1RUGnQWjm6rTSZJ02F877aJAhP9ORRDgZPwA6qhG/vftbYP+LYN47z2K
 H1nOA8qWdiK97SYKq36fcn+2QCSQ7VlyhNi/hoVkTL2I1pgI8AJJYYgcI5zYF/9AsVHF
 w6wA==
X-Gm-Message-State: AOJu0YwsguxvcNiG3K+qhBtDA3fJEOT8OI5Dq1tmtvog8RfxUm48RgsF
 KadIk8t2qNZibvxihlouERBvJVnzWnYsyoOv/yVhveSNYURbB2sG6Lyl
X-Gm-Gg: AfdE7cl4uRQ3qDhzU99fFNZvLbaTYUudKNAw9JIccZsK/zlSdkJYvEAJZ4AnfesqpBI
 r40QjeXaaqzoWi1IDEm8FWquz5+9FOVSlx1RD+1PD01FLTZssTqW57A0myKjStJ59EFVUdHNpYo
 CHahaTLOpUbmNYBIlOucewlE6BOqAYHyPYIqV3tHVrPAdNyXJcxWIPPTUGXrC0s0E+FzyKqs0+N
 2W+Mxnzh3pFzTgODoqGlhy4z06HJ9jN9E8CSHSo3KjyD563b6ivzrWg+bKGqWT+ccjAO8FNTrb1
 c8tYmKa+c4iWlvruVpstgFW6T/hsjlweoiJzFKORBFwbW/c2IJz7dfg4bER7FfLHChvVL7IHPbJ
 Xqw0SlOMMPZ77Cz/2MurXz488WwhWlIvUIQ+fQWqiG+t5AgnsikMYv+rKM1IPY6ggTGg15unIcZ
 CLos5DWCJK3eeecCVtiy4GyFh7Dr5/5AakyT0LnSwdMp6FVLFb
X-Received: by 2002:a17:903:2408:b0:2c9:c517:d069 with SMTP id
 d9443c01a7336-2c9c517d497mr57773875ad.17.1782732922523; 
 Mon, 29 Jun 2026 04:35:22 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9d4823066sm33937035ad.77.2026.06.29.04.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 04:35:22 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon, 29 Jun 2026 19:35:15 +0800
Message-ID: <20260629113516.2123545-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1weAGy-000831-SW
Subject: [f2fs-dev] [PATCH] f2fs: skip preallocation for mapped buffered
 overwrites
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
Cc: qwjhust@gmail.com, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

For a full-block buffered overwrite, PRE_AIO does not reserve a block if
the target range is already mapped.  It still walks the dnode path under
the node_change read lock.

Skip PRE_AIO when the write is within i_size and the read extent cache
covers the whole range with valid data blocks.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
QEMU test on a 1GiB F2FS scratch image:
- mapped 4K overwrite: PRE_AIO traces 20000 -> 0, about
  10.2 -> 2.0 us/write.
- sparse in-i_size hole write miss case: PRE_AIO traces stayed
  8192 -> 8192, median 7.71 -> 7.95 us/write.

 fs/f2fs/file.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4b52c56d71f0..cb03df086ff3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5007,6 +5007,32 @@ static ssize_t f2fs_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	return count;
 }
 
+static bool f2fs_prealloc_mapped_overwrite(struct inode *inode,
+					   loff_t pos, size_t count,
+					   const struct f2fs_map_blocks *map)
+{
+	struct extent_info ei = {};
+	loff_t size = i_size_read(inode);
+	pgoff_t start = map->m_lblk;
+	pgoff_t end = start + map->m_len;
+	pgoff_t ei_end;
+
+	if (pos >= size || count > size - pos)
+		return false;
+	if (f2fs_has_inline_data(inode) || f2fs_compressed_file(inode) ||
+	    f2fs_is_atomic_file(inode) || IS_DEVICE_ALIASING(inode))
+		return false;
+	if (end < start)
+		return false;
+	if (!f2fs_lookup_read_extent_cache(inode, start, &ei))
+		return false;
+	if (!__is_valid_data_blkaddr(ei.blk))
+		return false;
+
+	ei_end = (pgoff_t)ei.fofs + ei.len;
+	return start >= ei.fofs && end <= ei_end;
+}
+
 /*
  * Preallocate blocks for a write request, if it is possible and helpful to do
  * so.  Returns a positive number if blocks may have been preallocated, 0 if no
@@ -5061,6 +5087,9 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
 	else
 		return 0;
 
+	if (!dio && f2fs_prealloc_mapped_overwrite(inode, pos, count, &map))
+		return 0;
+
 	if (!IS_DEVICE_ALIASING(inode))
 		map.m_may_create = true;
 	if (dio) {


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
