Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A409FC71155
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Jun 2025 06:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FepJwxFTyEwypGZGUmy9CCXtpGyT25+9LUkyqKBeV7Y=; b=D7oWA2GJFg+OvS7eOpHaOlO+Gk
	VIFkhQQm+JF5lGvhbHfLXhdgAo46ur+77lRLqZkVJzgL+cnIKc9o6Oa8xDxCsChdSWKHwO1G9NGsF
	n2MWBNQttXEIEQgvzsQ+4WZNSAKigHHb8a4kduol4c3H9JR0mflaLaVse8QhJf/ecoYQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uRPYD-0006hb-5Y;
	Tue, 17 Jun 2025 06:12:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <huangjianan@xiaomi.com>) id 1uRPYA-0006hS-3v
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Jun 2025 06:12:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t31Otl3ie785jJ19i79mUlMQutNG+jPslfUz/3JPpB4=; b=d11Ijw9YAbSETK01oqp4Uz2fd/
 jpMttODpofofFGffg3GQoKXdtuSxHvzGVF5qZYixjJBLvPbWgD41S4HB/yL56mTUmo9/whMP1qj+k
 3RAe/pTEmJ9KSZQ4GZjN7284t3D1YJ8qIH3aw9rYZY4jTyCzMHhs/CnKM+yM51Tba1yI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=t31Otl3ie785jJ19i79mUlMQutNG+jPslfUz/3JPpB4=; b=g
 XgYYqES6sr/rk6rvF2Mwgp7FYtwJ2WPXJnPCDqDqjcloVNFn4S+c+kj9Nr/vFYl+OCUho0YbJy0mL
 OtaH7nYjm+wF73rsSklZY/frW4J3PN2SAOJ1Gvh5l4u+4Khs+19nEm0eSLSW4JtQUYcjTv3/h7h8z
 z8mVtcjDBJTJ8TG4=;
Received: from outboundhk.mxmail.xiaomi.com ([207.226.244.123])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtp (Exim 4.95)
 id 1uRPY9-0005wR-I6 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Jun 2025 06:12:02 +0000
X-CSE-ConnectionGUID: XDt/ZtQDS0WweoeaI/0mfQ==
X-CSE-MsgGUID: tju3whUUQ+KxvXAjjN8WOA==
X-IronPort-AV: E=Sophos;i="6.16,242,1744041600"; d="scan'208";a="143362134"
To: <linux-f2fs-devel@lists.sourceforge.net>, <chao@kernel.org>,
 <jaegeuk@kernel.org>
Date: Tue, 17 Jun 2025 13:55:42 +0800
Message-ID: <20250617055542.218681-1-huangjianan@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Originating-IP: [10.237.8.167]
X-ClientProxiedBy: BJ-MBX07.mioffice.cn (10.237.8.127) To YZ-MBX05.mioffice.cn
 (10.237.88.125)
X-Headers-End: 1uRPY9-0005wR-I6
Subject: [f2fs-dev] [PATCH] f2fs: avoid splitting bio when reading multiple
 pages
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
From: Jianan Huang via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jianan Huang <huangjianan@xiaomi.com>
Cc: Sheng Yong <shengyong1@xiaomi.com>, wanghui33@xiaomi.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

When fewer pages are read, nr_pages may be smaller than nr_cpages. Due
to the nr_vecs limit, the compressed pages will be split into multiple
bios and then merged at the block level. In this case, nr_cpages should
be used to pre-allocate bvecs.

Signed-off-by: Jianan Huang <huangjianan@xiaomi.com>
Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
---
 fs/f2fs/data.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 31e892842625..c7773b09d83f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2303,7 +2303,8 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 		}
 
 		if (!bio) {
-			bio = f2fs_grab_read_bio(inode, blkaddr, nr_pages,
+			bio = f2fs_grab_read_bio(inode, blkaddr,
+					max(nr_pages, cc->nr_cpages) - i,
 					f2fs_ra_op_flags(rac),
 					folio->index, for_write);
 			if (IS_ERR(bio)) {
@@ -2373,7 +2374,6 @@ static int f2fs_mpage_readpages(struct inode *inode,
 	pgoff_t index;
 #endif
 	unsigned nr_pages = rac ? readahead_count(rac) : 1;
-	unsigned max_nr_pages = nr_pages;
 	int ret = 0;
 
 	map.m_pblk = 0;
@@ -2400,7 +2400,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 		/* there are remained compressed pages, submit them */
 		if (!f2fs_cluster_can_merge_page(&cc, index)) {
 			ret = f2fs_read_multi_pages(&cc, &bio,
-						max_nr_pages,
+						nr_pages,
 						&last_block_in_bio,
 						rac, false);
 			f2fs_destroy_compress_ctx(&cc, false);
@@ -2432,7 +2432,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 read_single_page:
 #endif
 
-		ret = f2fs_read_single_page(inode, folio, max_nr_pages, &map,
+		ret = f2fs_read_single_page(inode, folio, nr_pages, &map,
 					&bio, &last_block_in_bio, rac);
 		if (ret) {
 #ifdef CONFIG_F2FS_FS_COMPRESSION
@@ -2450,7 +2450,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 			/* last page */
 			if (nr_pages == 1 && !f2fs_cluster_is_empty(&cc)) {
 				ret = f2fs_read_multi_pages(&cc, &bio,
-							max_nr_pages,
+							nr_pages,
 							&last_block_in_bio,
 							rac, false);
 				f2fs_destroy_compress_ctx(&cc, false);
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
