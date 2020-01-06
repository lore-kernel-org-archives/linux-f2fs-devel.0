Return-Path: <SRS0=h4up=23=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15C3C32771
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  6 Jan 2020 08:02:24 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F37B21734
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  6 Jan 2020 08:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="b9mr9Y8r";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="PtlJI3Op"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F37B21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ioNLE-00044C-70; Mon, 06 Jan 2020 08:02:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1ioNLB-00043R-On
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 06 Jan 2020 08:02:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q6KAFFeLAVwA5q3JuvwrGXxzHrh/utyWNPt/UXSiJAI=; b=b9mr9Y8rs+b7U9su+iXzymWM+9
 VxbogfM18Ap2bRsYY2spdBQQ8UrDsTNbGZGTkDW+6gG68Q+epbc37/FQ1CwDbB+LTnvHgci++V1k2
 kYOsJHGxeH1UevFFjS6y40zwqEpRkBQP9DwP5qq7Oo3lbUNeN0gNf7lumdz1aUvEF9Ps=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=q6KAFFeLAVwA5q3JuvwrGXxzHrh/utyWNPt/UXSiJAI=; b=PtlJI3OpdYjiktC8GywyH7wwHs
 zzeutaGraDWP0CJjx8UVDb1N9uJNCfED4w8l8eheTIunCLhc7MaVfBDRqRW1bsyViDBGSSwj6iR4Z
 Euf/n5NcY6QHzSuqlTV+sRbT/8LV1K5GIkiv6khECWRp0HM9qoJbkTeiWMA2iW900wcY=;
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1ioNKu-00AvrY-Nb
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 06 Jan 2020 08:02:20 +0000
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id EA950C201F57EAF36E37;
 Mon,  6 Jan 2020 16:01:55 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Mon, 6 Jan 2020 16:01:48 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Mon, 6 Jan 2020 16:01:43 +0800
Message-ID: <20200106080144.52363-3-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20200106080144.52363-1-yuchao0@huawei.com>
References: <20200106080144.52363-1-yuchao0@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1ioNKu-00AvrY-Nb
Subject: [f2fs-dev] [PATCH 3/4] f2fs: compress: fix error path in
 prepare_compress_overwrite()
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

- fix to release cluster pages in retry flow
- fix to call f2fs_put_dnode() & __do_map_lock() in error path

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index fc4510729654..3390351d2e39 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -626,20 +626,26 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 	}
 
 	for (i = 0; i < cc->cluster_size; i++) {
+		f2fs_bug_on(sbi, cc->rpages[i]);
+
 		page = find_lock_page(mapping, start_idx + i);
 		f2fs_bug_on(sbi, !page);
 
 		f2fs_wait_on_page_writeback(page, DATA, true, true);
 
-		cc->rpages[i] = page;
+		f2fs_compress_ctx_add_page(cc, page);
 		f2fs_put_page(page, 0);
 
 		if (!PageUptodate(page)) {
-			for (idx = 0; idx < cc->cluster_size; idx++) {
-				f2fs_put_page(cc->rpages[idx],
-						(idx <= i) ? 1 : 0);
+			for (idx = 0; idx <= i; idx++) {
+				unlock_page(cc->rpages[idx]);
 				cc->rpages[idx] = NULL;
 			}
+			for (idx = 0; idx < cc->cluster_size; idx++) {
+				page = find_lock_page(mapping, start_idx + idx);
+				f2fs_put_page(page, 1);
+				f2fs_put_page(page, 0);
+			}
 			kvfree(cc->rpages);
 			cc->nr_rpages = 0;
 			goto retry;
@@ -654,16 +660,20 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 		for (i = cc->cluster_size - 1; i > 0; i--) {
 			ret = f2fs_get_block(&dn, start_idx + i);
 			if (ret) {
-				/* TODO: release preallocate blocks */
 				i = cc->cluster_size;
-				goto unlock_pages;
+				break;
 			}
 
 			if (dn.data_blkaddr != NEW_ADDR)
 				break;
 		}
 
+		f2fs_put_dnode(&dn);
+
 		__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
+
+		if (ret)
+			goto unlock_pages;
 	}
 
 	*fsdata = cc->rpages;
-- 
2.18.0.rc1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
