Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27BAC3601B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Mar 2025 20:13:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tzLVc-0000wp-Ja;
	Mon, 31 Mar 2025 20:13:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tzLVZ-0000uX-FH
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BNGvCEaDEl8pok8qGO9aFIkJSy8IRWgdJAJ2V6z0o08=; b=V8iRlEpGAgj3crMgJOg3ruLVoc
 9YttD2Qq1QmIHMxhxjplvff6oVX63/7fBQO0tHxMCeqBf22UijbH9nFX8xrEXPrQaE9olq3oxNebb
 gk6yUQq7MVCC4ZxHouRldR57u8FphFXUBZktdbeft0dMWMG66WtSbawlIzdrGiwSwsoM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BNGvCEaDEl8pok8qGO9aFIkJSy8IRWgdJAJ2V6z0o08=; b=SSkQxkNRrqpC4svRp0S0HBurLS
 lk3kkgZgT9UeQJfowciojXGV71Zfs8CXegRdyUzDQuoHjAL7SmP4ZT9We/zgtkkdzITHC/UyqMwQu
 As07XppoPZUKMeMCcGS+E1SzSuEJQX3ACYvOP5xLvonFo+70DVblUF6w8LAFrZIuWL/4=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tzLVP-0003Yb-KJ for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=BNGvCEaDEl8pok8qGO9aFIkJSy8IRWgdJAJ2V6z0o08=; b=wWhNpjk5EFMOBWM4Fn7AR7CV78
 tKJpbXnuoY8QNxelURDTyr0XXXMHRm+Ib+/e7Vt4sxvR3NuCMA8NGxPsGeSeIm1TRrkLx0ju1tF1j
 XotBSfFUbztyO821A5yT1p1/Zxt5d33k8XxOkATsDCfdCqHjkg4lTpZsjuIHvtwMlJC+908qxJpZN
 PhiKCdUdoEvPc5mGSWZLAjdBXRqiWRJdOelaMOSgNxUySmlM9VNhAy2k/jMXem/pxYn4y1/eQc+hX
 787zoRhQ+gq5A7Q7i0Ay79NF/gdUNYUY8/EQC3nlDnKOg05jNd9HwCJDIXO1TZ+RWAvKU/nwtzP/G
 o6U6Y7nQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red
 Hat Linux)) id 1tzLVJ-00000004RbO-15pk;
 Mon, 31 Mar 2025 20:13:05 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 31 Mar 2025 21:10:50 +0100
Message-ID: <20250331201256.1057782-31-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331201256.1057782-1-willy@infradead.org>
References: <20250331201256.1057782-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tzLVP-0003Yb-KJ
Subject: [f2fs-dev] [PATCH 030/153] f2fs: Use a folio in
 validate_checkpoint()
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
Cc: "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Convert get_checkpoint_version() to take a folio and use it throughout
validate_checkpoint().  Saves five hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/checkpoint.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 10fdbf48a6bc..8ae015b304db 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -849,29 +849,29 @@ static __u32 f2fs_checkpoint_chksum(struct f2fs_sb_info *sbi,
 }
 
 static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
-		struct f2fs_checkpoint **cp_block, struct page **cp_page,
+		struct f2fs_checkpoint **cp_block, struct folio **cp_folio,
 		unsigned long long *version)
 {
 	size_t crc_offset = 0;
 	__u32 crc;
 
-	*cp_page = f2fs_get_meta_page(sbi, cp_addr);
-	if (IS_ERR(*cp_page))
-		return PTR_ERR(*cp_page);
+	*cp_folio = f2fs_get_meta_folio(sbi, cp_addr);
+	if (IS_ERR(*cp_folio))
+		return PTR_ERR(*cp_folio);
 
-	*cp_block = (struct f2fs_checkpoint *)page_address(*cp_page);
+	*cp_block = folio_address(*cp_folio);
 
 	crc_offset = le32_to_cpu((*cp_block)->checksum_offset);
 	if (crc_offset < CP_MIN_CHKSUM_OFFSET ||
 			crc_offset > CP_CHKSUM_OFFSET) {
-		f2fs_put_page(*cp_page, 1);
+		f2fs_folio_put(*cp_folio, true);
 		f2fs_warn(sbi, "invalid crc_offset: %zu", crc_offset);
 		return -EINVAL;
 	}
 
 	crc = f2fs_checkpoint_chksum(sbi, *cp_block);
 	if (crc != cur_cp_crc(*cp_block)) {
-		f2fs_put_page(*cp_page, 1);
+		f2fs_folio_put(*cp_folio, true);
 		f2fs_warn(sbi, "invalid crc value");
 		return -EINVAL;
 	}
@@ -883,14 +883,14 @@ static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
 static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
 				block_t cp_addr, unsigned long long *version)
 {
-	struct page *cp_page_1 = NULL, *cp_page_2 = NULL;
+	struct folio *cp_folio_1 = NULL, *cp_folio_2 = NULL;
 	struct f2fs_checkpoint *cp_block = NULL;
 	unsigned long long cur_version = 0, pre_version = 0;
 	unsigned int cp_blocks;
 	int err;
 
 	err = get_checkpoint_version(sbi, cp_addr, &cp_block,
-					&cp_page_1, version);
+					&cp_folio_1, version);
 	if (err)
 		return NULL;
 
@@ -905,19 +905,19 @@ static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
 
 	cp_addr += cp_blocks - 1;
 	err = get_checkpoint_version(sbi, cp_addr, &cp_block,
-					&cp_page_2, version);
+					&cp_folio_2, version);
 	if (err)
 		goto invalid_cp;
 	cur_version = *version;
 
 	if (cur_version == pre_version) {
 		*version = cur_version;
-		f2fs_put_page(cp_page_2, 1);
-		return cp_page_1;
+		f2fs_folio_put(cp_folio_2, true);
+		return &cp_folio_1->page;
 	}
-	f2fs_put_page(cp_page_2, 1);
+	f2fs_folio_put(cp_folio_2, true);
 invalid_cp:
-	f2fs_put_page(cp_page_1, 1);
+	f2fs_folio_put(cp_folio_1, true);
 	return NULL;
 }
 
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
