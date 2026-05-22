Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759DACD4F3D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 22 May 2026 08:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pcsnFYvBNC1zExBu7VyVbHKOBNHdZ87IzG2hUipe6dk=; b=TlFMaf3Oyd0OkaHLgFC/Ub9R76
	tl74dh85LSbVAPNNO3bJ2FvXGR/OSTRjntqGOgcxduyqnFxCNSF7Z7H8HPC7e9zm0CoD78QBQwFHE
	jbCreUhBAWJA4RUopaSK/Sp6Eabcy3ND6lvnYoqK+byceE4nglvyBru1QGA/Rv4acrTU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wQLAP-0002hK-CX;
	Fri, 22 May 2026 08:23:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1wQLAO-0002hC-54
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 May 2026 08:23:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CPylUVmUOjExbHDu2NGb4UkHnQalvJixWz5yHaXMfRE=; b=PJcO+5bZLThaUwxbdJp5t7vQDE
 jvpfYHyxvtCc0VNL2qgsl4/C8yCqupbcP26hLZ/zIS0C7U82zeQdaIXDtRQf1EV69HC/UiFWOL6er
 3LQEuDKgJ5NTmtl8psz9TXYwISa6FpsMmxHqp+/NQz+K/u+vnP8BJiXqIERSjuzQPw+8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CPylUVmUOjExbHDu2NGb4UkHnQalvJixWz5yHaXMfRE=; b=fIjtScJ0HLOJPZBf7Z4zTEcvGZ
 RiNqZcEw/N+awYzrL/Y2pxmgajsGPyMzLhHNYzdka5EppmnzkIxonhkexO/ER6qgMojMZlFlrf9SZ
 SNh9xekExdweB2CYcVfbxwJiPFT2pcucziv89q0GO2zTGJWW7SzSpL9PiUPK7BDMQx+E=;
Received: from mail3-164.sinamail.sina.com.cn ([202.108.3.164])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wQL9f-0007Og-II for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 May 2026 08:23:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1779438172; bh=CPylUVmUOjExbHDu2NGb4UkHnQalvJixWz5yHaXMfRE=;
 h=From:Subject:Date:Message-ID;
 b=TnfQnT4pZIhYO5QbHrgbUMLWu95SDrac+5ONSfzz5vhd/9bBVoZNH/1DhBqp0gwzt
 sI+4yk5kPMzFFfGr7eQWiydyBOo9TYh+eIu6dm/Xaxy7aQUMVxXbz8GedEBtGtllZD
 YxqgN4MZNcabqb8r9exC1eO9GZG1froehO4wHyyw=
X-SMAIL-HELO: xiaomi-ThinkCentre-M760t.mioffice.cn
Received: from unknown (HELO
 xiaomi-ThinkCentre-M760t.mioffice.cn)([114.247.175.249])
 by sina.com (10.54.253.32) with ESMTP
 id 6A101246000002AE; Fri, 22 May 2026 16:22:39 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 1018484456607
X-SMAIL-UIID: D19855CB5CD04E259AECB73CF73593CB-20260522-162239-1
From: Yongpeng Yang <monty_pavel@sina.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 22 May 2026 16:22:14 +0800
Message-ID: <20260522082213.3725976-3-monty_pavel@sina.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522082013.3716237-2-monty_pavel@sina.com>
References: <20260522082013.3716237-2-monty_pavel@sina.com>
MIME-Version: 1.0
X-Headers-End: 1wQL9f-0007Og-II
Subject: [f2fs-dev] [PATCH 3/5] f2fs: punch largest extent instead of
 dropping it entirely on overlap
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

Previously, when an extent being inserted overlaps with the largest
extent, the largest extent is dropped entirely. This was done to handle
the case where the largest extent is not in memory, avoiding
inconsistency between the largest extent and the extent tree.

This patch changes the semantics of __drop_largest_extent (renamed to
__punch_largest_extent): instead of discarding the entire largest
extent when any overlap is detected, keep the larger remaining portion
(left or right) after the punch. This preserves extent cache coverage
for truncate and overwrite operations that only partially overlap the
largest extent.

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/f2fs/extent_cache.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index f8d94db60dc6..82d84c4e98b2 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -397,14 +397,31 @@ static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
 	return count;
 }
 
-static void __drop_largest_extent(struct extent_tree *et,
+static void __punch_largest_extent(struct extent_tree *et,
 					pgoff_t fofs, unsigned int len)
 {
-	if (fofs < (pgoff_t)et->largest.fofs + et->largest.len &&
-			fofs + len > et->largest.fofs) {
-		et->largest.len = 0;
-		et->largest_updated = true;
+	unsigned int largest_end, punch_end;
+	unsigned int left_len, right_len;
+
+	if (fofs >= (pgoff_t)et->largest.fofs + et->largest.len ||
+			fofs + len <= et->largest.fofs)
+		return;
+
+	/* Punch [fofs, fofs + len) from largest extent. */
+	largest_end = et->largest.fofs + et->largest.len;
+	punch_end = fofs + len;
+
+	left_len = fofs > et->largest.fofs ? fofs - et->largest.fofs : 0;
+	right_len = largest_end > punch_end ? largest_end - punch_end : 0;
+
+	if (left_len >= right_len) {
+		et->largest.len = left_len;
+	} else {
+		et->largest.blk += punch_end - et->largest.fofs;
+		et->largest.fofs = punch_end;
+		et->largest.len = right_len;
 	}
+	et->largest_updated = true;
 }
 
 void f2fs_init_read_extent_tree(struct inode *inode, struct folio *ifolio)
@@ -680,10 +697,10 @@ static void __update_extent_tree_range(struct inode *inode,
 		dei.len = 0;
 
 		/*
-		 * drop largest extent before lookup, in case it's already
+		 * punch largest extent before lookup, in case it's already
 		 * been shrunk from extent tree
 		 */
-		__drop_largest_extent(et, fofs, len);
+		__punch_largest_extent(et, fofs, len);
 	}
 
 	if (et->largest.len != 0 &&
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
