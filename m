Return-Path: <SRS0=7Pho=52=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE9AC2BB85
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Apr 2020 08:51:49 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5528F21556
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Apr 2020 08:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="E1vuLfdY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="cFzK8yur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5528F21556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jMpO7-0000iG-TH; Fri, 10 Apr 2020 08:51:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jMpO6-0000i9-Om
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 10 Apr 2020 08:51:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eFp4r9TuO7nhB/o6mlAplvQVN633vdti8uT3w9Id10w=; b=E1vuLfdYIJMh9cujLrGp6zukEt
 XCqibuvsSF3Wc9MlLQ3BK64/xsXoJccsctbqf8oAdagJf8hL/3Mnhu+JBLds23FbNGwVfvLQV6D88
 aYVzID78tE3VnCFRqOvs/rkylNh9VZJeq1jUsQl+/n8p8iZ9sF8FJvlZO2iDaAzkS/mk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=eFp4r9TuO7nhB/o6mlAplvQVN633vdti8uT3w9Id10w=; b=c
 FzK8yurRYTrzilqweQ6G/azpkmKehlaPcTi+t3gL3bfqE0ohfGA8OB7jkqI+oOJBgxg2koAVuZDRV
 fw3upWVs+jbHOJqk0TYm2t10B/5v5lZH196heta6N53+EU9gCo8lDmUW3qT5lEcTK+MfkyJN9NhZo
 F13Gn83wMI41EDnk=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jMpO4-00AZhS-C8
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 10 Apr 2020 08:51:46 +0000
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 75DFB55D413CE05A1BE4;
 Fri, 10 Apr 2020 16:51:35 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 10 Apr 2020 16:51:25 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Fri, 10 Apr 2020 16:51:23 +0800
Message-ID: <20200410085123.55118-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1jMpO4-00AZhS-C8
Subject: [f2fs-dev] [PATCH] f2fs: fix to avoid page count leak
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

In below error path, we missed to release reference count of pages
in compressed cluster, fix it.
- f2fs_mpage_readpages()
 - f2fs_read_multi_pages()

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 2 +-
 fs/f2fs/data.c     | 6 +++++-
 fs/f2fs/f2fs.h     | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 25d72e18ac30..d83dfbe624b0 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -88,7 +88,7 @@ static void f2fs_drop_rpages(struct compress_ctx *cc, int len, bool unlock)
 	}
 }
 
-static void f2fs_put_rpages(struct compress_ctx *cc)
+void f2fs_put_rpages(struct compress_ctx *cc)
 {
 	f2fs_drop_rpages(cc, cc->cluster_size, false);
 }
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0a829a89f596..896887c9febe 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2115,7 +2115,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 		} else if (!PageUptodate(page)) {
 			continue;
 		}
-		unlock_page(page);
+		f2fs_put_page(page, 1);
 		cc->rpages[i] = NULL;
 		cc->nr_rpages--;
 	}
@@ -2280,6 +2280,8 @@ int f2fs_mpage_readpages(struct address_space *mapping,
 							max_nr_pages,
 							&last_block_in_bio,
 							is_readahead, false);
+				if (ret)
+					f2fs_put_rpages(&cc);
 				f2fs_destroy_compress_ctx(&cc);
 				if (ret)
 					goto set_error_page;
@@ -2323,6 +2325,8 @@ int f2fs_mpage_readpages(struct address_space *mapping,
 							max_nr_pages,
 							&last_block_in_bio,
 							is_readahead, false);
+				if (ret)
+					f2fs_put_rpages(&cc);
 				f2fs_destroy_compress_ctx(&cc);
 			}
 		}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ed354af78966..25cc202adc50 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3790,6 +3790,7 @@ static inline bool f2fs_post_read_required(struct inode *inode)
  */
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 bool f2fs_is_compressed_page(struct page *page);
+void f2fs_put_rpages(struct compress_ctx *cc);
 struct page *f2fs_compress_control_page(struct page *page);
 int f2fs_prepare_compress_overwrite(struct inode *inode,
 			struct page **pagep, pgoff_t index, void **fsdata);
-- 
2.18.0.rc1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
