Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACF3CD4F3D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 22 May 2026 08:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hmKi/AaftZdFboiHjVsqwe9ww3VUC1U7RnLdAyoK+z0=; b=iJyvHdXUuispYlcFR3NarPEc4I
	n1px6Y7F6QVe8uMpXLazR567YWhBZOSOyKa0nWaw/D1Fe1wHPyQaV9DGhq5rfXBerK0x6QLZwdnIw
	dahlTBp+jPp9mOZej+CmMLNkyI2zRn6h7mEWEXWh6J1wckBWk0wbPb+wnd2rytSb1qh4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wQL8F-0002rv-Uq;
	Fri, 22 May 2026 08:21:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1wQL8D-0002qZ-Bx
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 May 2026 08:21:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M/KWFvfLBUuOEbqCTObm+8eedd4hBvnMS8TqsV3eqbI=; b=PIg84+zK3C/+qRWkrg3oMpFUi0
 +z9fZlDCF1WASXlkbJBoKzes/fXRlMCV4XG/6TuzGFWl3B92uDUk3mTLNdNKk0t8OR3a/SHwIZvEw
 YntoQPc21lf/sE4Fgwb9l3QInAM0pvCz7Dn3SXowBu4sklhXEH/3cabG1Wau25A/2Tt8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=M/KWFvfLBUuOEbqCTObm+8eedd4hBvnMS8TqsV3eqbI=; b=W
 tSHlaLNG/MlvTbh+nQT3TvtXKP3jpWCbA11P9sTrfIixkgOgteEXraxdzuNNB3HZTeftHqUA1kUte
 Yj5qjhkS8JHTcMS8RlIJPComt/IztNWdIIozxhesoc7PhTRlcUC7xGfAfmc3+qNaeJOc8tIC5egfS
 TxrsCiK7juC//imc=;
Received: from r3-17.sinamail.sina.com.cn ([202.108.3.17])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wQL88-0007Cv-V3 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 May 2026 08:21:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1779438077; bh=M/KWFvfLBUuOEbqCTObm+8eedd4hBvnMS8TqsV3eqbI=;
 h=From:Subject:Date:Message-ID;
 b=EZnX7zA4jJ/NJz7iowW2t0NjCTwZZNXxwHOj8vrka8MefowK+/jfV5PcPz/izInp1
 JioMB3iyLkwsaNQDwLZPqYJ1Mf2r/YreYx22mM73C92YJfYgREpBbAiWFKRNWSniUB
 Sgc6B1rVx1mmMDraVzvKKi/0kwU8VXfP8cXySjSU=
X-SMAIL-HELO: xiaomi-ThinkCentre-M760t.mioffice.cn
Received: from unknown (HELO
 xiaomi-ThinkCentre-M760t.mioffice.cn)([114.247.175.249])
 by sina.com (10.54.253.34) with ESMTP
 id 6A1011EA00007C80; Fri, 22 May 2026 16:21:03 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 1338956292241
X-SMAIL-UIID: 261BF1CF6B744342A9D495EDCEADF48A-20260522-162103-1
From: Yongpeng Yang <monty_pavel@sina.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 22 May 2026 16:20:10 +0800
Message-ID: <20260522082013.3716237-2-monty_pavel@sina.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wQL88-0007Cv-V3
Subject: [f2fs-dev] [PATCH 1/5] f2fs: fix extent merge failure when largest
 extent is not in rb-tree
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

The following scenario can cause fiemap to report incorrect extents:

$ mkfs.f2fs /dev/vdb -f
$ mount -o mode=lfs /dev/vdb /mnt/f2fs/
$ dd if=/dev/urandom of=data bs=4K count=874 conv=notrunc
$ f2fs_io fiemap 0 1000000 data 1
$ shrink all extent
$ dd if=/dev/urandom of=data bs=4K count=150 seek=874 conv=notrunc
$ f2fs_io fiemap 0 1000000 data 1
Fiemap: offset = 0 len = 1000000
        logical addr.    physical addr.   length           flags
0       0000000000000000 00000002868d4000 000000000036a000 00001000
1       000000000036a000 0000000286c3e000 0000000000096000 00001001

The root cause is that when the largest extent is not in the extent
tree, mergeable extents are not merged, causing f2fs_map_blocks to
misjudge and output an incorrect extent list.

Fix this by allowing the extent being inserted to merge with the largest
extent. When updating the extent tree range, if the new extent can be
front-merged or back-merged with the largest extent and the largest
extent is not in the rb-tree, merge them before the normal lookup.

Fixes: 429511cdf8b3 ("f2fs: add core functions for rb-tree extent cache")
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/f2fs/extent_cache.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 61f6b9714366..aa368a01b035 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -702,6 +702,27 @@ static void __update_extent_tree_range(struct inode *inode,
 		__drop_largest_extent(et, fofs, len);
 	}
 
+	if (et->largest.len != 0 &&
+			(__is_front_mergeable(tei, &et->largest, type) ||
+			 __is_back_mergeable(tei, &et->largest, type))) {
+		/* 0. try to merge with largest extent. */
+		en = __lookup_extent_node_ret(&et->root,
+				et->cached_en, et->largest.fofs,
+				&prev_en, &next_en,
+				&insert_p, &insert_parent,
+				&leftmost);
+		if (!en) {
+			if (__is_back_mergeable(tei, &et->largest, type)) {
+				tei->fofs = et->largest.fofs;
+				tei->blk = et->largest.blk;
+				fofs = tei->fofs;
+			}
+			tei->len += et->largest.len;
+			len = tei->len;
+			end = fofs + len;
+		}
+	}
+
 	/* 1. lookup first extent node in range [fofs, fofs + len - 1] */
 	en = __lookup_extent_node_ret(&et->root,
 					et->cached_en, fofs,
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
