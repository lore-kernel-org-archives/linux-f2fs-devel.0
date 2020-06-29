Return-Path: <SRS0=zfsZ=AK=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D016C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:13:53 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 129AC23B23
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="lh1VTPS7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="cH6IECNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129AC23B23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jpsfY-0007wI-Mi; Mon, 29 Jun 2020 12:13:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jpsfW-0007wA-PQ
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jun 2020 12:13:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ibV2NGj6KGnFNT7MmIlk5jfeyCRmAv3Q/U3sj5b5uoA=; b=lh1VTPS7bmUEee2gdWa1Wka5sj
 Cvj0M9GOSZ4CTSzoKtIE5yt4IlZoNT25psEF1qprW5FoqnPvRCuXmNExqU5X/FiXvswD+qNvvC6uQ
 UJlvt09xjQeb+h/RbWxFCLWY38ZT35u73GTZMFBEVHWFnUKrvpAh3B41RXqMeDErjHzg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ibV2NGj6KGnFNT7MmIlk5jfeyCRmAv3Q/U3sj5b5uoA=; b=cH6IECNam9Q4g0HWUhypShvgbm
 3Jg77ADrKu6fK04icj3OQYYd9HstqhCdhGKP4OHHZfqq3YHVR7vm4r14CrtstSsqphY95srXi8Imc
 M3JTMfMGMFhBKKWpGAL0siQ5Bd6ommK4uG+Z+Mz481y/3uCmESD1MsaEjgRfGYz0mRsk=;
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jpsfV-0064Kf-8E
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jun 2020 12:13:50 +0000
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id EB34C1AEC8048B373B37;
 Mon, 29 Jun 2020 20:13:34 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Mon, 29 Jun 2020 20:13:28 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Mon, 29 Jun 2020 20:13:13 +0800
Message-ID: <20200629121313.68072-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629121313.68072-1-yuchao0@huawei.com>
References: <20200629121313.68072-1-yuchao0@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1jpsfV-0064Kf-8E
Subject: [f2fs-dev] [PATCH v2 3/3] f2fs: support to trace f2fs_fiemap()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

to show f2fs_fiemap()'s result as below:

f2fs_fiemap: dev = (251,0), ino = 7, lblock:0, pblock:1625292800, len:2097152, flags:0, ret:0

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- use show_dev_ino() to avoid compile warning.
 fs/f2fs/data.c              |  6 +++++-
 fs/f2fs/inline.c            |  2 ++
 include/trace/events/f2fs.h | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c07a50e4d967..995cf78b23c5 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1813,6 +1813,7 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 			flags |= FIEMAP_EXTENT_LAST;
 
 		err = fiemap_fill_next_extent(fieinfo, 0, phys, len, flags);
+		trace_f2fs_fiemap(inode, 0, phys, len, flags, err);
 		if (err || err == 1)
 			return err;
 	}
@@ -1836,8 +1837,10 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 		flags = FIEMAP_EXTENT_LAST;
 	}
 
-	if (phys)
+	if (phys) {
 		err = fiemap_fill_next_extent(fieinfo, 0, phys, len, flags);
+		trace_f2fs_fiemap(inode, 0, phys, len, flags, err);
+	}
 
 	return (err < 0 ? err : 0);
 }
@@ -1931,6 +1934,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 		ret = fiemap_fill_next_extent(fieinfo, logical,
 				phys, size, flags);
+		trace_f2fs_fiemap(inode, logical, phys, size, flags, ret);
 		if (ret)
 			goto out;
 		size = 0;
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index dbade310dc79..def4b8481883 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -12,6 +12,7 @@
 
 #include "f2fs.h"
 #include "node.h"
+#include <trace/events/f2fs.h>
 
 bool f2fs_may_inline_data(struct inode *inode)
 {
@@ -776,6 +777,7 @@ int f2fs_inline_data_fiemap(struct inode *inode,
 	byteaddr += (char *)inline_data_addr(inode, ipage) -
 					(char *)F2FS_INODE(ipage);
 	err = fiemap_fill_next_extent(fieinfo, start, byteaddr, ilen, flags);
+	trace_f2fs_fiemap(inode, start, byteaddr, ilen, flags, err);
 out:
 	f2fs_put_page(ipage, 1);
 	return err;
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 2e8713a52d76..8a1c1311acac 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1917,6 +1917,43 @@ TRACE_EVENT(f2fs_bmap,
 		(unsigned long long)__entry->pblock)
 );
 
+TRACE_EVENT(f2fs_fiemap,
+
+	TP_PROTO(struct inode *inode, sector_t lblock, sector_t pblock,
+		unsigned long long len, unsigned int flags, int ret),
+
+	TP_ARGS(inode, lblock, pblock, len, flags, ret),
+
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(ino_t, ino)
+		__field(sector_t, lblock)
+		__field(sector_t, pblock)
+		__field(unsigned long long, len)
+		__field(unsigned int, flags)
+		__field(int, ret)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= inode->i_sb->s_dev;
+		__entry->ino		= inode->i_ino;
+		__entry->lblock		= lblock;
+		__entry->pblock		= pblock;
+		__entry->len		= len;
+		__entry->flags		= flags;
+		__entry->ret		= ret;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %lu, lblock:%lld, pblock:%lld, "
+		"len:%llu, flags:%u, ret:%d",
+		show_dev_ino(__entry),
+		(unsigned long long)__entry->lblock,
+		(unsigned long long)__entry->pblock,
+		__entry->len,
+		__entry->flags,
+		__entry->ret)
+);
+
 #endif /* _TRACE_F2FS_H */
 
  /* This part must be outside protection */
-- 
2.26.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
