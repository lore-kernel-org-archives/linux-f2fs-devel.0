Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE82D47CD0
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 Jan 2026 10:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:References:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=TwKuXfWkQVefVEc78pHBuOxgcwaY4nzIcBevtlvmRas=; b=J/lGt4k/hDmzcOqwVQ/1NMmORZ
	sZqN/oeOQ7QWP+OBOggq6QxCrQFmonXGUH8ld59TqNNp22cHCC+QN8iZu3EaVKUCFxFc6j5WVPUyu
	a8CLkMOAEFq9LQeTq2D084AaHA0usd1nMEcPE3Tqc2jCZzu7uiLU8UYpdcmw0sILuNOo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vghIf-000786-Lr;
	Fri, 16 Jan 2026 10:43:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <youngjin.gil@samsung.com>) id 1vghId-00077x-8X
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Jan 2026 10:43:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H5AI9BVpXvlAG2uSM9VJSAe53L3/3Kh2i8Vgsuw9k8U=; b=EWTQQRwXnEiLYcn81fRaSc+/hN
 v4AJ+ZDt5Agezp9NP8R0pqDPpgKHX0M2g6NVgcYJ9X20Q57asPNKpdy6T/YFzNiPOBX0JXrCoX3wA
 BlbV5kFSKuF+jtCVcmIJBdIxiq+GJvxv2B8zN2FCguv4c/1Ej9ItnO/JrRvhgD9maJnY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID
 :Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=H5AI9BVpXvlAG2uSM9VJSAe53L3/3Kh2i8Vgsuw9k8U=; b=C
 wZzBMf0yeiG7D3JKNTpsZg6RV9WpWugGdXocCackhROMLe3gurtSzCx0wTgCETFh6AXBHs8S23hxN
 L4NxA+T65rBU0sJ/JxrK97bWldzuN+cUP3GlHg2kSngfjTurrydMKF4+15xh2pMaR5ToY25y142OC
 95vGy6TIsXi+K83A=;
Received: from mailout3.samsung.com ([203.254.224.33])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vghIc-0007DQ-5F for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Jan 2026 10:43:27 +0000
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20260116102348epoutp03ef4853fe54bdd066a5c40a4e9a9011fd~LLxELPsNA0378403784epoutp039
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 16 Jan 2026 10:23:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20260116102348epoutp03ef4853fe54bdd066a5c40a4e9a9011fd~LLxELPsNA0378403784epoutp039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1768559028;
 bh=H5AI9BVpXvlAG2uSM9VJSAe53L3/3Kh2i8Vgsuw9k8U=;
 h=From:To:Cc:Subject:Date:References:From;
 b=cJNDmr/AHt0KRGlnEck2Q1QAe0+ZO6kqyPlbAwIYI0pmZR1IHdgmxklhoStrxW9ad
 wh5SDIcjHk6p/eUYM/Lc7Pa4f2s/jC0q/77cApAhY6oDlbGXcb0AX9tK5K2oZxNRVa
 H8N0uVVIpa2I5oT80Tcz4Si8hwPDbkSEEvjGKIPg=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPS id
 20260116102348epcas1p170a2d1d5c064b47fd760de44737d47cb~LLxDsZ0Gv0199901999epcas1p1T;
 Fri, 16 Jan 2026 10:23:48 +0000 (GMT)
Received: from epcas1p3.samsung.com (unknown [182.195.38.191]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4dswtX1LT6z3hhT3; Fri, 16 Jan
 2026 10:23:48 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20260116102347epcas1p46ed8360e1a69831f382dcf9d9ee486b0~LLxC8pSFq2177121771epcas1p4w;
 Fri, 16 Jan 2026 10:23:47 +0000 (GMT)
Received: from mypc.. (unknown [10.253.98.103]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20260116102347epsmtip1144a3c2be566684f0d9c302cee848560~LLxC5sPxq0242902429epsmtip1v;
 Fri, 16 Jan 2026 10:23:47 +0000 (GMT)
From: Yeongjin Gil <youngjin.gil@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, jyh429@gmail.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Date: Fri, 16 Jan 2026 19:23:46 +0900
Message-ID: <20260116102346.992546-1-youngjin.gil@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CMS-MailID: 20260116102347epcas1p46ed8360e1a69831f382dcf9d9ee486b0
X-Msg-Generator: CA
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260116102347epcas1p46ed8360e1a69831f382dcf9d9ee486b0
References: <CGME20260116102347epcas1p46ed8360e1a69831f382dcf9d9ee486b0@epcas1p4.samsung.com>
X-Headers-End: 1vghIc-0007DQ-5F
Subject: [f2fs-dev] [PATCH RESEND] f2fs: optimize f2fs_overwrite_io() for
 f2fs_iomap_begin
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
Cc: Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

When overwriting already allocated blocks, f2fs_iomap_begin() calls
f2fs_overwrite_io() to check block mappings. However,
f2fs_overwrite_io() iterates through all mapped blocks in the range,
which can be inefficient for fragmented files with large I/O requests.

This patch optimizes f2fs_overwrite_io() by adding a 'check_first'
parameter and introducing __f2fs_overwrite_io() helper. When called from
f2fs_iomap_begin(), we only check the first mapping to determine if the
range is already allocated, which is sufficient for setting
map.m_may_create.

This optimization significantly reduces the number of f2fs_map_blocks()
calls in f2fs_overwrite_io() when called from f2fs_iomap_begin(),
especially for fragmented files with large I/O requests.

Fixes: 351bc761338d ("f2fs: optimize f2fs DIO overwrites")
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Sunmin Jeong <s_min.jeong@samsung.com>
Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>
---
 fs/f2fs/data.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2e133a723b99..bfbd717e628a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1851,7 +1851,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 	return err;
 }
 
-bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len)
+static bool __f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len,
+				bool check_first)
 {
 	struct f2fs_map_blocks map;
 	block_t last_lblk;
@@ -1877,6 +1878,11 @@ bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len)
 	return true;
 }
 
+bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len)
+{
+	return __f2fs_overwrite_io(inode, pos, len, false);
+}
+
 static int f2fs_xattr_fiemap(struct inode *inode,
 				struct fiemap_extent_info *fieinfo)
 {
@@ -4443,7 +4449,7 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	 * f2fs_map_lock and f2fs_balance_fs are not necessary.
 	 */
 	if ((flags & IOMAP_WRITE) &&
-		!f2fs_overwrite_io(inode, offset, length))
+		!__f2fs_overwrite_io(inode, offset, length, true))
 		map.m_may_create = true;
 
 	err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_DIO);
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
