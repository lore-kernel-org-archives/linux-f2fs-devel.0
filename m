Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3283C76196
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  7 Apr 2023 20:26:02 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pkseo-0008R5-F6;
	Fri, 07 Apr 2023 20:26:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1pksen-0008Qm-Hc
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Apr 2023 20:26:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ghq4VNVMpsScX+3Dvpo+A66b2ZT6ORhVvC6+Xx0AZvI=; b=OIc+O9AulvURY6B5EDddxJjI9D
 BA7tSWUpozVkgz6+W9AdMDyqaKE/tlbhvj/O/wg+6mLylgQXCHjIqYnQB8Tm/vhtN7S+nP5X8cszD
 TtlALIcfNs1Xzxm3jn7tCxdEvb5qDzhjAi7xxAOzA9I3D2CiyM3G8ef68kINBPnMG7n0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ghq4VNVMpsScX+3Dvpo+A66b2ZT6ORhVvC6+Xx0AZvI=; b=KoHPd2NfhwsQgKpPUhgoRk7+Ky
 JI1yQWuifon4QKSGtiVdr1FP9BLfxVgyjZtOK8lHT6NDelmy9np8hPPU74IR15PZFYq2KHlQwx9kz
 +r5gXhAnWA7upyHjZIgUlNR1zvcgbSRr0mhICZ8bmZXujBnKw+bpOyF+OhCmz84y+o44=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pkseg-0006ne-Rj for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Apr 2023 20:26:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7AA2264BBB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  7 Apr 2023 20:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5630C433D2;
 Fri,  7 Apr 2023 20:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680899148;
 bh=ZEchsXqHGNTUcdc5FDBSUGFuzWklWQiC3R7YM9A4Wpo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MMW87bEJD+5bvT+wrXZkLGCCLNzNWmx4hSPZmoZmWQAid9ojd80rkocQ19U8a0f3h
 4eZMZwPZP8bAxssV+4n5+VeD1ODt2+tIc/T8QdVXJqJZt0gJq8J3lagrTTFSIElJ98
 aWHj9FY5wRu+B71ygDjjLuTiZYgKSTaBpEeR6FFqhz74oYp9CKo7L4SMi9HI/K/3eO
 qyUUA3NLcssWIo2ADxnQLhgawBnAvzMUKSC7xR5xxgPzn2jkp07Dybvd4o/h7WXopC
 GbzZCGVX0iDupDX7fJhgYP/PgY4j2Bt3BFFF2E6K0Pr/9H9Lizp2buAE9y/NPexa8p
 yH9v73Pa8PrgQ==
Date: Fri, 7 Apr 2023 13:25:47 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Message-ID: <ZDB8S4ea6DBRHklN@google.com>
References: <20230405204321.2056498-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230405204321.2056498-1-jaegeuk@kernel.org>
X-Headers-End: 1pkseg-0006ne-Rj
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: attach/detach private value in pair
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
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

set_page_private_# increases a refcount after attaching page->private, and
clear_page_private_# decreases it.
But, f2fs_release_folio and f2fs_invalidate_folio call folio_detach_private()
which decreases the refcount again, which corrupts the page cache.

Cc: <stable@vger.kernel.org>
Fixes: b763f3bedc2d ("f2fs: restructure f2fs page.private layout")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

Change log from v1:
 - update comment
 - remove unnecessary zeroing bits in invalidate/release page

 fs/f2fs/compress.c |  4 ++--
 fs/f2fs/data.c     | 21 -------------------
 fs/f2fs/f2fs.h     | 50 ++++++++++++++++------------------------------
 3 files changed, 19 insertions(+), 56 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 11653fa79289..70b3910db413 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1854,7 +1854,7 @@ void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
 		return;
 	}
 
-	set_page_private_data(cpage, ino);
+	set_page_private_ino(cpage, ino);
 
 	if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE_READ))
 		goto out;
@@ -1917,7 +1917,7 @@ void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi, nid_t ino)
 				continue;
 			}
 
-			if (ino != get_page_private_data(&folio->page)) {
+			if (ino != get_page_private_ino(&folio->page)) {
 				folio_unlock(folio);
 				continue;
 			}
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index fa931fb768e7..0a5832ec4046 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3722,36 +3722,15 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 			f2fs_remove_dirty_inode(inode);
 		}
 	}
-
-	clear_page_private_reference(&folio->page);
-	clear_page_private_gcing(&folio->page);
-
-	if (test_opt(sbi, COMPRESS_CACHE) &&
-			inode->i_ino == F2FS_COMPRESS_INO(sbi))
-		clear_page_private_data(&folio->page);
-
 	folio_detach_private(folio);
 }
 
 bool f2fs_release_folio(struct folio *folio, gfp_t wait)
 {
-	struct f2fs_sb_info *sbi;
-
 	/* If this is dirty folio, keep private data */
 	if (folio_test_dirty(folio))
 		return false;
 
-	sbi = F2FS_M_SB(folio->mapping);
-	if (test_opt(sbi, COMPRESS_CACHE)) {
-		struct inode *inode = folio->mapping->host;
-
-		if (inode->i_ino == F2FS_COMPRESS_INO(sbi))
-			clear_page_private_data(&folio->page);
-	}
-
-	clear_page_private_reference(&folio->page);
-	clear_page_private_gcing(&folio->page);
-
 	folio_detach_private(folio);
 	return true;
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index dfead8160a51..5d025eae40b8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1384,7 +1384,7 @@ static inline void f2fs_clear_bit(unsigned int nr, char *addr);
  * bit 2	PAGE_PRIVATE_ONGOING_MIGRATION
  * bit 3	PAGE_PRIVATE_INLINE_INODE
  * bit 4	PAGE_PRIVATE_REF_RESOURCE
- * bit 5-	f2fs private data
+ * bit 5-	PAGE_PRIVATE_DATA followed by additional info
  *
  * Layout B: lowest bit should be 0
  * page.private is a wrapped pointer.
@@ -1395,6 +1395,7 @@ enum {
 	PAGE_PRIVATE_ONGOING_MIGRATION,		/* data page which is on-going migrating */
 	PAGE_PRIVATE_INLINE_INODE,		/* inode page contains inline data */
 	PAGE_PRIVATE_REF_RESOURCE,		/* dirty page has referenced resources */
+	PAGE_PRIVATE_DATA,			/* page has referenced data */
 	PAGE_PRIVATE_MAX
 };
 
@@ -1409,73 +1410,56 @@ static inline bool page_private_##name(struct page *page) \
 #define PAGE_PRIVATE_SET_FUNC(name, flagname) \
 static inline void set_page_private_##name(struct page *page) \
 { \
-	if (!PagePrivate(page)) { \
-		get_page(page); \
-		SetPagePrivate(page); \
-		set_page_private(page, 0); \
-	} \
+	if (!PagePrivate(page)) \
+		attach_page_private(page, 0); \
 	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)); \
 	set_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
 }
 
+/* clear private by f2fs_release_folio or f2fs_invalidate_folio */
 #define PAGE_PRIVATE_CLEAR_FUNC(name, flagname) \
 static inline void clear_page_private_##name(struct page *page) \
 { \
 	clear_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
-	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER)) { \
+	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER)) \
 		set_page_private(page, 0); \
-		if (PagePrivate(page)) { \
-			ClearPagePrivate(page); \
-			put_page(page); \
-		}\
-	} \
 }
 
 PAGE_PRIVATE_GET_FUNC(nonpointer, NOT_POINTER);
 PAGE_PRIVATE_GET_FUNC(inline, INLINE_INODE);
 PAGE_PRIVATE_GET_FUNC(gcing, ONGOING_MIGRATION);
 PAGE_PRIVATE_GET_FUNC(dummy, DUMMY_WRITE);
+PAGE_PRIVATE_GET_FUNC(data, DATA);
 
 PAGE_PRIVATE_SET_FUNC(reference, REF_RESOURCE);
 PAGE_PRIVATE_SET_FUNC(inline, INLINE_INODE);
 PAGE_PRIVATE_SET_FUNC(gcing, ONGOING_MIGRATION);
 PAGE_PRIVATE_SET_FUNC(dummy, DUMMY_WRITE);
+PAGE_PRIVATE_SET_FUNC(data, DATA);
 
 PAGE_PRIVATE_CLEAR_FUNC(reference, REF_RESOURCE);
 PAGE_PRIVATE_CLEAR_FUNC(inline, INLINE_INODE);
 PAGE_PRIVATE_CLEAR_FUNC(gcing, ONGOING_MIGRATION);
 PAGE_PRIVATE_CLEAR_FUNC(dummy, DUMMY_WRITE);
+PAGE_PRIVATE_CLEAR_FUNC(data, DATA);
 
-static inline unsigned long get_page_private_data(struct page *page)
+static inline nid_t get_page_private_ino(struct page *page)
 {
-	unsigned long data = page_private(page);
-
-	if (!test_bit(PAGE_PRIVATE_NOT_POINTER, &data))
+	if (!page_private_data(page))
 		return 0;
-	return data >> PAGE_PRIVATE_MAX;
+	return page_private(page) >> PAGE_PRIVATE_MAX;
 }
 
-static inline void set_page_private_data(struct page *page, unsigned long data)
+static inline void set_page_private_ino(struct page *page, nid_t ino)
 {
-	if (!PagePrivate(page)) {
-		get_page(page);
-		SetPagePrivate(page);
-		set_page_private(page, 0);
-	}
-	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page));
-	page_private(page) |= data << PAGE_PRIVATE_MAX;
+	set_page_private_data(page);
+	page_private(page) |= ino << PAGE_PRIVATE_MAX;
 }
 
-static inline void clear_page_private_data(struct page *page)
+static inline void clear_page_private_ino(struct page *page)
 {
 	page_private(page) &= GENMASK(PAGE_PRIVATE_MAX - 1, 0);
-	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER)) {
-		set_page_private(page, 0);
-		if (PagePrivate(page)) {
-			ClearPagePrivate(page);
-			put_page(page);
-		}
-	}
+	clear_page_private_data(page);
 }
 
 /* For compression */
-- 
2.40.0.577.gac1e443424-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
