Return-Path: <SRS0=h4up=23=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB723C33C9A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  6 Jan 2020 08:02:08 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD04D21734
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  6 Jan 2020 08:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="O1Yd8hSz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="d+e+tpIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD04D21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ioNKx-0004Hu-Lw; Mon, 06 Jan 2020 08:02:07 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1ioNKv-0004Hl-96
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 06 Jan 2020 08:02:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZbvnHTdwDOK6akBKgU+lhA9WinAqvdxPVWGgPwBnftg=; b=O1Yd8hSz1QHUBna+Dgn8fA++6i
 TREPLMxIsjW9KiUQMaaP+VEQuhjeqKM7rIO+GK6MOXQ734YRsS+eGaTIn5u0Qwt8Jm506oguBq3Xr
 mkSVZzxrEDj7rHoKo7oBWsYzxEm2RhZphEHMtPCbMc0XlJMcCKHFye1N7fDwa5alewo8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZbvnHTdwDOK6akBKgU+lhA9WinAqvdxPVWGgPwBnftg=; b=d+e+tpIsENyW+qNKUqCTUY1cRZ
 5n/V8gt5p9pfP9wE3NZpZqot2onZfj5YgJ2k9zgSfcoTfD+JnkvQ6wsko2OUosmhDQHWb6flWwp2j
 cWih5ApP+IVFuvIv/pDgh7ok+V0toZ2YqWTLbUSlDN0gY4w4iQVo58zfqDKQFTBmfgVY=;
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1ioNKs-00AvrS-Se
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 06 Jan 2020 08:02:05 +0000
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id D99BBB0FD549768C145A;
 Mon,  6 Jan 2020 16:01:55 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Mon, 6 Jan 2020 16:01:49 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Mon, 6 Jan 2020 16:01:44 +0800
Message-ID: <20200106080144.52363-4-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20200106080144.52363-1-yuchao0@huawei.com>
References: <20200106080144.52363-1-yuchao0@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1ioNKs-00AvrS-Se
Subject: [f2fs-dev] [PATCH 4/4] f2fs: compress: release compress context in
 caller of f2fs_read_multi_pages()
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

Execute initialize/destroy flow of compress context outside of
f2fs_read_multi_pages()

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c |  1 +
 fs/f2fs/data.c     | 10 +++-------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 3390351d2e39..7727b6553a14 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -615,6 +615,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 
 		ret = f2fs_read_multi_pages(cc, &bio, cc->cluster_size,
 						&last_block_in_bio, false);
+		f2fs_destroy_compress_ctx(cc);
 		if (ret)
 			goto release_pages;
 		if (bio)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5476d33f2d76..e68b9f4b7913 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2121,7 +2121,6 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 							false);
 				f2fs_free_dic(dic);
 				f2fs_put_dnode(&dn);
-				f2fs_destroy_compress_ctx(cc);
 				*bio_ret = bio;
 				return ret;
 			}
@@ -2139,7 +2138,6 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 
 	f2fs_put_dnode(&dn);
 
-	f2fs_destroy_compress_ctx(cc);
 	*bio_ret = bio;
 	return 0;
 
@@ -2213,10 +2211,9 @@ int f2fs_mpage_readpages(struct address_space *mapping,
 							max_nr_pages,
 							&last_block_in_bio,
 							is_readahead);
-				if (ret) {
-					f2fs_destroy_compress_ctx(&cc);
+				f2fs_destroy_compress_ctx(&cc);
+				if (ret)
 					goto set_error_page;
-				}
 			}
 			ret = f2fs_is_compressed_cluster(inode, page->index);
 			if (ret < 0)
@@ -2257,8 +2254,7 @@ int f2fs_mpage_readpages(struct address_space *mapping,
 							max_nr_pages,
 							&last_block_in_bio,
 							is_readahead);
-				if (ret)
-					f2fs_destroy_compress_ctx(&cc);
+				f2fs_destroy_compress_ctx(&cc);
 			}
 		}
 #endif
-- 
2.18.0.rc1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
