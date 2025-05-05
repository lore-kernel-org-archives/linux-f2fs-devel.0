Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772A3C3ABB6
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 May 2025 10:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rYFWP7wi3BxjPfaGT9m9zFmsp8c+jWmOBGBVzvfdtZw=; b=lwIoxK+ChTMtsPpCBONAcpcCZi
	5wmMbA9DkgNizngaezY4KWN7E2SYju/AULpZw4yZaxSw3y2Xb6ygvNEjS9PRcbis0TLGtrpb/Spns
	ATI+4XQRLogvUbPpYvIlpe3ezkT5Juhc9GbWjanj4maStej0Vv1GT4NobmU68Gwt4mvc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uBt5T-000221-5f;
	Mon, 05 May 2025 10:30:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+9b9d72b124a21f5aaaac+7925+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1uBt5S-00021n-30 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 May 2025 10:30:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sELj/MlDtAAj12/hR7awIfpwOruMjrHMsTWeklMcCBo=; b=aNbeqCgQtC4FpEqc5FFbxMIe1S
 8t6mC3h3MFctveyr8glfMBgVM8f5WWi/URskHC3pLvsIf7V1BA5CGkF8rIMpa8LMLk+v2BtnCIOxY
 LGjb9M8y241xe6Izxhk/W9bK5pXydpMX1tMncCiW0CE+XVPaFojIZSepZo/wmSnBnR18=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sELj/MlDtAAj12/hR7awIfpwOruMjrHMsTWeklMcCBo=; b=hyAlwWs5/CPNQVLl7kk8C3915S
 mFCY55P9/iXrCSOR8nh2AKmrUqyjXpGbUlqQ+mTBC2VeiVQjcLNARAFVGU+EfnMbK/2l9NdfG8sJh
 uU6MMhDaxaEPIveGC2PteBYq5gxlS98svIUdx9uJLAQBcLqrZwdOryWLrBN0j29az2j0=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uBt55-0002w9-Me for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 May 2025 10:30:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=sELj/MlDtAAj12/hR7awIfpwOruMjrHMsTWeklMcCBo=; b=hWMVJqmrABhxNjTTqPVqQzaT2Q
 6vMHdKc/nise00cHaSu44/FhLCMa/yt86MpB1tTBj8eU5nmvSQVYIYAtmwN2+O+/zioQ9vPyUPm9Q
 AkIhfP+q0QArgX4UP0xwSNZ73iFizNvjX/tP1ODkKIrD3I6SNtwEounEkrcfS+ZWcr40rhhndLmoD
 BDJoVDWOKgdpFMmFDET9JKuX4cJzBQmWLHA5/MMEliefErtE5OWcBuUoCgFyjfq5ixA/aAydsgGkw
 EViiXPrOhwK7cV6/mnLGu+nC8pY4cvQguEfrBz+1+cexad/QLKM9SPwoEZGq2Su5+tVkTcJLhf/iH
 pvWGf9JA==;
Received: from
 2a02-8389-2341-5b80-c9f7-77ec-522e-47ca.cable.dynamic.v6.surfer.at
 ([2a02:8389:2341:5b80:c9f7:77ec:522e:47ca] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1uBs5d-00000006uky-0wDw; Mon, 05 May 2025 09:26:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon,  5 May 2025 11:25:59 +0200
Message-ID: <20250505092613.3451524-3-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505092613.3451524-1-hch@lst.de>
References: <20250505092613.3451524-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1uBt55-0002w9-Me
Subject: [f2fs-dev] [PATCH 2/4] f2fs: don't return AOP_WRITEPAGE_ACTIVATE
 from f2fs_write_single_data_page
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

Instead unlock the pages locally where that would happen and thus
consolidate the code in the callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/f2fs/compress.c |  5 +----
 fs/f2fs/data.c     | 13 ++++---------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index e016b0f96313..ce63b3bfb28f 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1565,10 +1565,7 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 						NULL, NULL, wbc, io_type,
 						compr_blocks, false);
 		if (ret) {
-			if (ret == AOP_WRITEPAGE_ACTIVATE) {
-				folio_unlock(folio);
-				ret = 0;
-			} else if (ret == -EAGAIN) {
+			if (ret == -EAGAIN) {
 				ret = 0;
 				/*
 				 * for quota file, just redirty left pages to
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 08a8a107adcb..e32c9cf5b4f5 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2930,10 +2930,10 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 	 * file_write_and_wait_range() will see EIO error, which is critical
 	 * to return value of fsync() followed by atomic_write failure to user.
 	 */
-	if (!err || wbc->for_reclaim)
-		return AOP_WRITEPAGE_ACTIVATE;
 	folio_unlock(folio);
-	return err;
+	if (err && !wbc->for_reclaim)
+		return err;
+	return 0;
 }
 
 /*
@@ -3146,8 +3146,6 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 			ret = f2fs_write_single_data_page(folio,
 					&submitted, &bio, &last_block,
 					wbc, io_type, 0, true);
-			if (ret == AOP_WRITEPAGE_ACTIVATE)
-				folio_unlock(folio);
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 result:
 #endif
@@ -3159,10 +3157,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				 * keep nr_to_write, since vfs uses this to
 				 * get # of written pages.
 				 */
-				if (ret == AOP_WRITEPAGE_ACTIVATE) {
-					ret = 0;
-					goto next;
-				} else if (ret == -EAGAIN) {
+				if (ret == -EAGAIN) {
 					ret = 0;
 					if (wbc->sync_mode == WB_SYNC_ALL) {
 						f2fs_io_schedule_timeout(
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
