Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80743C9830D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Sep 2026 01:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=41xH5+hoCIyM8fBz3o2ueg89Q7J/1AsrcO4dDbirt9g=; b=cnc1dlScdzGYxtHlLRgEw54HNd
	ZKKN3EaafrUutvPqVrBdN8mdlva6XtfKudGakjE5442pwXN7rGokkYb49R5Se68KYGjXDoa2yVvB/
	6mhvgsMUFDdzWe4/+Dvo8oiPy4io+ngSOPWfwTNNICulmh10spJfG9SyvtHh5307P4LQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x9Yem-0005RE-OL;
	Thu, 24 Sep 2026 01:53:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <Zhiguo.Niu@unisoc.com>) id 1x9Yek-0005R6-Eu
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 01:53:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kpV47N4iACM0QHYGcErxwKRhkVDQb41yNEqNk4FFwIs=; b=lM59yXr9T+T9dEadD++DYBTckr
 5If0DIyFICYmfAWz8HkYWDH2/+/RxcR1XciyJySztbtbbgVdzfYgSRe594MPQommA1F3iKzu8qiHc
 JTU0HvqPgPRyn4BTAc1szA29IAmErc+R9x/mvcDJ0FAS0MlnR8hO8zHc7KrgBXpblDLE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kpV47N4iACM0QHYGcErxwKRhkVDQb41yNEqNk4FFwIs=; b=JsFgZfV4Nx5z146GSu33NDcpMj
 cMGrjUNH2iZoyfTykmMNo8Zbd5GMP4ycBVDZqLKV2hI5GMEHSHV+2DHCsYVP/Y1gm8V5i5rMSfFFS
 ZJC0VN+Pl66TYH5D02ry1Ef82uqrRuW9Ya1JoOuyE4jw+DrRssQzAI6xO9iFzoHFSeKE=;
Received: from mx1.unisoc.com ([222.66.158.135] helo=SHSQR01.spreadtrum.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x9Yeg-0007er-I1 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 01:53:47 +0000
Received: from dlp.unisoc.com ([10.29.3.86])
 by SHSQR01.spreadtrum.com with ESMTPS id 68O1rDnJ017311
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Thu, 24 Sep 2026 09:53:13 +0800 (+08)
 (envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (BJMBX02.spreadtrum.com [10.0.64.8])
 by dlp.unisoc.com (SkyGuard) with ESMTPS id 4hqxcN5bC4z2N3TjZ;
 Thu, 24 Sep 2026 09:50:28 +0800 (CST)
Received: from bj08434pcu10.spreadtrum.com (10.0.70.50) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Thu, 24 Sep 2026 09:53:11 +0800
To: <jaegeuk@kernel.org>, <chao@kernel.org>
Date: Thu, 24 Sep 2026 09:52:13 +0800
Message-ID: <20260924015213.1196491-2-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924015213.1196491-1-zhiguo.niu@unisoc.com>
References: <20260924015213.1196491-1-zhiguo.niu@unisoc.com>
MIME-Version: 1.0
X-Originating-IP: [10.0.70.50]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 68O1rDnJ017311
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
 s=default; t=1790214811;
 bh=kpV47N4iACM0QHYGcErxwKRhkVDQb41yNEqNk4FFwIs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=OiGKIDkVsyLYW/7cW0+1BRFL5z7KNvlCGOO4UaOSNOaF7AHEWY216WtVh80PNUkPf
 ZnoSdUq7L5d52M8KN8bVeokx1Als/175IF2HhgmEZU1znuyjKcMWzpFbVA8t0WqQkH
 MlCYRlnq4hOyzhOzYbfDo4SH8dztD3Za+pLXw39e1A3kEOBSMN5J5LMXbj5JHICexw
 OXq8zV/tCjn2bj3J+enTH6C1qQKKILFHR6aFwSKb9Y/I+mBu73gS0QdLRgtKlCUZRM
 MrD5iA0qP2oZoOFabLtvFo+UOQ3uVoa+fWezVCApCbQ6jyzFNajr8pbiGC9ilFGws2
 1H0PFZeesYV6A==
X-Headers-End: 1x9Yeg-0007er-I1
Subject: [f2fs-dev] [PATCH 2/2] f2fs: remove some stale and unused codes
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
From: Zhiguo Niu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: ke.wang@unisoc.com, zhiguo.niu@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

- drop the extern declaration of f2fs_compress_aops which is only
  used by inode->i_mapping->a_ops = &f2fs_compress_aops, was removed
  by commit 6a78d0488116 ("f2fs: cache: use compress cache").

- folio_get_f2fs_data() and folio_set_f2fs_data() in f2fs.h belong to
  the old compress cache inode mechanism; neither is referenced anywhere.

- iostat_set_post_read_ctx() in iostat.h (both the CONFIG_F2FS_IOSTAT
  and the stub branches) is never called: the post-read context is
  assigned directly at both call sites, bio->bi_private = ctx in
  data.c and iostat_ctx->post_read_ctx = ctx in iostat.c.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/f2fs.h   | 19 -------------------
 fs/f2fs/inode.c  |  4 ----
 fs/f2fs/iostat.h | 11 -----------
 3 files changed, 34 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 089a62c054ea..991deeb9ee1b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2821,25 +2821,6 @@ PAGE_PRIVATE_CLEAR_FUNC(reference, REF_RESOURCE);
 PAGE_PRIVATE_CLEAR_FUNC(gcing, ONGOING_MIGRATION);
 PAGE_PRIVATE_CLEAR_FUNC(atomic, ATOMIC_WRITE);
 
-static inline unsigned long folio_get_f2fs_data(struct folio *folio)
-{
-	unsigned long data = (unsigned long)folio->private;
-
-	if (!test_bit(PAGE_PRIVATE_NOT_POINTER, &data))
-		return 0;
-	return data >> PAGE_PRIVATE_MAX;
-}
-
-static inline void folio_set_f2fs_data(struct folio *folio, unsigned long data)
-{
-	data = (1UL << PAGE_PRIVATE_NOT_POINTER) | (data << PAGE_PRIVATE_MAX);
-
-	if (!folio_test_private(folio))
-		folio_attach_private(folio, (void *)data);
-	else
-		folio->private = (void *)((unsigned long)folio->private | data);
-}
-
 static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 						struct inode *inode,
 						block_t count)
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 9164a2b5d9f0..5627259295fa 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -21,10 +21,6 @@
 
 #include <trace/events/f2fs.h>
 
-#ifdef CONFIG_F2FS_FS_COMPRESSION
-extern const struct address_space_operations f2fs_compress_aops;
-#endif
-
 #define NUM_PREALLOC_EVICT_INODE_WORK 8
 
 static struct kmem_cache *evict_inode_work_cache;
diff --git a/fs/f2fs/iostat.h b/fs/f2fs/iostat.h
index 61c6bc8e3119..2025225b5bed 100644
--- a/fs/f2fs/iostat.h
+++ b/fs/f2fs/iostat.h
@@ -60,13 +60,6 @@ static inline struct bio_post_read_ctx *get_post_read_ctx(struct bio *bio)
 	return iostat_ctx->post_read_ctx;
 }
 
-static inline void iostat_set_post_read_ctx(struct bio *bio, void *ctx)
-{
-	struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
-
-	iostat_ctx->post_read_ctx = ctx;
-}
-
 extern void iostat_update_and_unbind_ctx(struct bio *bio);
 extern void iostat_alloc_and_bind_ctx(struct f2fs_sb_info *sbi,
 		struct bio *bio, struct bio_post_read_ctx *ctx);
@@ -88,10 +81,6 @@ static inline struct bio_post_read_ctx *get_post_read_ctx(struct bio *bio)
 {
 	return bio->bi_private;
 }
-static inline void iostat_set_post_read_ctx(struct bio *bio, void *ctx)
-{
-	bio->bi_private = ctx;
-}
 static inline int f2fs_init_iostat_processing(void) { return 0; }
 static inline void f2fs_destroy_iostat_processing(void) {}
 static inline int f2fs_init_iostat(struct f2fs_sb_info *sbi) { return 0; }
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
