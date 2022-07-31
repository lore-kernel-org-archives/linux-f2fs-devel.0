Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A50C19F2C
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 31 Jul 2022 03:34:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oHzii-0001C1-FI; Sun, 31 Jul 2022 03:34:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <fengnanchang@gmail.com>) id 1oHzih-0001Bv-C2
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 31 Jul 2022 03:34:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0NUrc0W1QWb//2ivdbxpNU8D3AKbtKApqcDsuJkuddQ=; b=HK5kDuROhL08tJO8IdBhWTB9r8
 YpJMR1axof0Q9is6pUwjcog984QmeUmG/zN7WmgFahk4QrZoMHvGxLzqLzVjKmAZNro3noDGxI+Sx
 Exx1bgvmTWi0ZG+8wslPD7Nzt4v+IQmw0ECj7P0V0r+bjNwr5Rn4uKvwTQE+LK2mDwGo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0NUrc0W1QWb//2ivdbxpNU8D3AKbtKApqcDsuJkuddQ=; b=MJ008gkidzcAR7ONIX6NO4nk/B
 JufhV1yv42ULpG6chLf8bcfHENUar5o9lEvpURLeAvnn2ArerHL2tFApqxzuexM+7vjtrSuOuasTL
 KXeiPUDvIwKM8VoW4rmD4QvHQDzb4TOsflQFtQlRS2tbI8dAP3I0cdQ8Lxnyf4aJmajE=;
Received: from mail-pg1-f175.google.com ([209.85.215.175])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1oHzic-0002se-UH
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 31 Jul 2022 03:34:23 +0000
Received: by mail-pg1-f175.google.com with SMTP id f11so6986425pgj.7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 30 Jul 2022 20:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0NUrc0W1QWb//2ivdbxpNU8D3AKbtKApqcDsuJkuddQ=;
 b=YM1i8sm2SCn8+w5o7efjgX9kZM+x+Q3Gomww3pOaJAWeyq2cXU0WUC3Xziz8x6WL+u
 z7M9yF1Z/zuH1u2UBNfKREj71mGWWy/sGmrFY4Jj05AFIclAw22GvwLzihWEHsd698hY
 ogQtVytKGJ4pMtd2FPD3zC97J3QV8YvUa5xnGDEiObwVNq2d08HdMx4DdeC/IOexD5w8
 0kY9Qc/B0TZWX7TeEfnM4LXCbYgr1JwANsopRi2NEli5eT2OeIk1FUB4AkvG2Rd17cWP
 Q9YOnZCn21MT+Nopsw0cniaOC0ywyGxoL217KWqUE+VGVSHxVSCIEqpVRR0NWzr7x0SD
 P2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0NUrc0W1QWb//2ivdbxpNU8D3AKbtKApqcDsuJkuddQ=;
 b=iIRS+RgMa/xuWyZdPh7P9GmnlEeI+zP2EIWTgFTFDSeJgoywgz7nkCnll18AoVR7kI
 Tcx08SRLqpH9Jn7ChivebkLxsuqVr4Uz/Dh7BFQBKhW8cF9k61z4eBs/WGEIrB8mABHj
 0ZiAxqUHQ/ubENf0Gbci5zdp0xsxB0nW4mcL+I6KLpOvJfaY6zilBataVwf3tdg6y3/s
 JJHSYbirDw022X64al4e7c+mUxcu8zcuQxAz7xbz20+rTlW6uZ3cTB7x2jn80GdB/GWh
 CM135pJjTpZc5jS43Lya6A7cGIx6CZokpq3sdvS2T3TkeDbDRAQqahBkOlVKT2Xoqo4f
 /bIA==
X-Gm-Message-State: AJIora9qRrn5x4zQB35JsHAmB/Na2XtsrW2BWU5oGA2FdoPwHAtvTkej
 L2upPpSmII4L/xebkL7kN48=
X-Google-Smtp-Source: AGRyM1vwTIO5hDsjW3+CHC47O8nvOIPfm/+WETD2P+ttTHozF2mH131nFwlw4RtKVqz20jvBnjzmNg==
X-Received: by 2002:a05:6a00:1496:b0:52a:c3fb:8ec7 with SMTP id
 v22-20020a056a00149600b0052ac3fb8ec7mr10548646pfu.25.1659238453397; 
 Sat, 30 Jul 2022 20:34:13 -0700 (PDT)
Received: from localhost.localdomain ([103.215.126.52])
 by smtp.googlemail.com with ESMTPSA id
 e10-20020a63500a000000b0040dd052ab11sm5026631pgb.58.2022.07.30.20.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Jul 2022 20:34:12 -0700 (PDT)
From: Fengnan Chang <fengnanchang@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Sun, 31 Jul 2022 11:33:45 +0800
Message-Id: <20220731033347.455209-2-fengnanchang@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220731033347.455209-1-fengnanchang@gmail.com>
References: <20220731033347.455209-1-fengnanchang@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1oHzic-0002se-UH
Subject: [f2fs-dev] [PATCH v4 1/3] f2fs: intorduce
 f2fs_all_cluster_page_ready
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
Cc: Fengnan Chang <changfengnan@vivo.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Fengnan Chang <changfengnan@vivo.com>

When write total cluster, all pages is uptodate, there is not need to call
f2fs_prepare_compress_overwrite, intorduce f2fs_all_cluster_page_ready
to avoid this.

Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
---
 fs/f2fs/compress.c | 21 ++++++++++++++-------
 fs/f2fs/data.c     |  8 ++++++--
 fs/f2fs/f2fs.h     |  4 ++--
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 2e06a301bf12..4677300e87fe 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -929,20 +929,27 @@ bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index)
 	return is_page_in_cluster(cc, index);
 }
 
-bool f2fs_all_cluster_page_loaded(struct compress_ctx *cc, struct pagevec *pvec,
-				int index, int nr_pages)
+bool f2fs_all_cluster_page_ready(struct compress_ctx *cc, struct pagevec *pvec,
+				int index, int nr_pages, bool uptodate)
 {
-	unsigned long pgidx;
-	int i;
+	unsigned long pgidx = pvec->pages[index]->index;
+	int i = uptodate ? 0 : 1;
 
-	if (nr_pages - index < cc->cluster_size)
+	/*
+	 * when uptodate set to true, try to check all pages in cluster is
+	 * uptodate or not.
+	 */
+	if (uptodate && (pgidx % cc->cluster_size))
 		return false;
 
-	pgidx = pvec->pages[index]->index;
+	if (nr_pages - index < cc->cluster_size)
+		return false;
 
-	for (i = 1; i < cc->cluster_size; i++) {
+	for (; i < cc->cluster_size; i++) {
 		if (pvec->pages[index + i]->index != pgidx + i)
 			return false;
+		if (uptodate && !PageUptodate(pvec->pages[index + i]))
+			return false;
 	}
 
 	return true;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f48eec8f93e2..34a7a9affea0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3011,6 +3011,10 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				if (!f2fs_cluster_is_empty(&cc))
 					goto lock_page;
 
+				if (f2fs_all_cluster_page_ready(&cc,
+					&pvec, i, nr_pages, true))
+					goto lock_page;
+
 				ret2 = f2fs_prepare_compress_overwrite(
 							inode, &pagep,
 							page->index, &fsdata);
@@ -3021,8 +3025,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				} else if (ret2 &&
 					(!f2fs_compress_write_end(inode,
 						fsdata, page->index, 1) ||
-					 !f2fs_all_cluster_page_loaded(&cc,
-						&pvec, i, nr_pages))) {
+					 !f2fs_all_cluster_page_ready(&cc,
+						&pvec, i, nr_pages, false))) {
 					retry = 1;
 					break;
 				}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3f669f851240..ac3788d0345d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4193,8 +4193,8 @@ void f2fs_end_read_compressed_page(struct page *page, bool failed,
 				block_t blkaddr, bool in_task);
 bool f2fs_cluster_is_empty(struct compress_ctx *cc);
 bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index);
-bool f2fs_all_cluster_page_loaded(struct compress_ctx *cc, struct pagevec *pvec,
-				int index, int nr_pages);
+bool f2fs_all_cluster_page_ready(struct compress_ctx *cc, struct pagevec *pvec,
+				int index, int nr_pages, bool uptodate);
 bool f2fs_sanity_check_cluster(struct dnode_of_data *dn);
 void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct page *page);
 int f2fs_write_multi_pages(struct compress_ctx *cc,
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
