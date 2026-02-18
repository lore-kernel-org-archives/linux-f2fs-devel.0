Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6BFE9A03B
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 Feb 2026 01:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E9U3ROjupcRDPBqX0VNCXDgD1oUwOlGbhIb5a3Bye80=; b=A5BviRJZRl/Wg75F2FE/9F0SH2
	tm3ddr8a8AGESJmoq4cNC6MXLa+njFETfWq0hzObzt0Ac1+XPBvZr77Yt2IvwaUaJTvhkokYLiVpb
	ROl8utmTrwAMivYVJ13yv2KGUlVi+AzJDSVh9IdxUlSV3n6DcEurAFs17yT6YxQ9qR70=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vsW2W-00069O-Oe;
	Wed, 18 Feb 2026 01:07:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1vsW2U-000697-Sl
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Feb 2026 01:07:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BXy5KqNWFtLtS/qbNofrKIB8/a8lipAH+LponxctFjM=; b=Uhp9EuhFI7dEQJBCWHyGdFyAsm
 +gkARTpY4IdsYaC2Ib2skg2U09TGUODcmd/RoiS1y1KXDjjGyVRDnIyo28qChMEvMqYZ45A9AbkGZ
 uJiJMNBdOraafotTT+98ysn50T0+9IbTuTV1ipL+7v0UuIGfe2gF/IzXoPPEi7XVqbSE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BXy5KqNWFtLtS/qbNofrKIB8/a8lipAH+LponxctFjM=; b=QuQPSrU0JlY6AbTxYobuvCiEIN
 6XuHRQzzrLijwqsGEishSkrhXRK0BQOXrcD/8r3T9R3vI6PrewRZ1S+8xu++WWt0U7xIu5Xz4XE/K
 fCEU8RXqSPBXlBMU+E2NJi6ouYE2CEwA27ndKxFB1AIZ62ZJYwwykZPUxJC8P/Ut8Ou4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vsW2V-0003lk-2k for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Feb 2026 01:07:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 806F26132E;
 Wed, 18 Feb 2026 01:07:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4E6C19423;
 Wed, 18 Feb 2026 01:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771376847;
 bh=J7ZTZq4X/3Y2QVbeFUP412jblzsMRFo21pG26WCfQTI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Srd+C08vslHfUG9Tw6b9RpfoD8kuvADMCGD9LgpLl4y8mGX/pOFAu3ZGA6SgxTvu9
 dHVt4Dc2MEm1svIi/8k1sRp1CgiQSkxrahw3glADDWMylDGUF0t0Sbk9087myC+yyh
 ZpTlwWDmmonBJuxCAQb4NACAKFz/aai1cxMcp7Xo7phkTV5bSigWidaaIN1qkIP/rU
 uvJP5Fb8NhSn971Fj3HlHbH7+VUX2OB6SM/KAuRXmqa+KkZgkRMUpGo8U1zy+cTlx0
 fuCiNbRb0IyitVwK733pAgdvf9kuDH3oA9R5D5g2cSUtrje97rDbQO4Ow/Cf0erZFK
 kSGVPXobOtdjQ==
To: fsverity@lists.linux.dev
Date: Tue, 17 Feb 2026 17:06:30 -0800
Message-ID: <20260218010630.7407-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218010630.7407-1-ebiggers@kernel.org>
References: <20260218010630.7407-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1vsW2V-0003lk-2k
Subject: [f2fs-dev] [PATCH v4 3/3] fsverity: remove fsverity_verify_page()
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Now that fsverity_verify_page() has no callers, remove it.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/verity/verify.c       | 4 ++--
 include/linux/fsverity.h | 6 ------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 31797f9b24d0..3e38749fbc82 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -431,12 +431,12 @@ EXPORT_SYMBOL_GPL(fsverity_verify_blocks);
  * verification, then bio->bi_status is set to an error status.
  *
  * This is a helper function for use by the ->readahead() method of filesystems
  * that issue bios to read data directly into the page cache.  Filesystems that
  * populate the page cache without issuing bios (e.g. non block-based
- * filesystems) must instead call fsverity_verify_page() directly on each page.
- * All filesystems must also call fsverity_verify_page() on holes.
+ * filesystems) must instead call fsverity_verify_blocks() directly.  All
+ * filesystems must also call fsverity_verify_blocks() on holes.
  */
 void fsverity_verify_bio(struct fsverity_info *vi, struct bio *bio)
 {
 	struct fsverity_verification_context ctx;
 	struct folio_iter fi;
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index fed91023bea9..6de3ddf0b148 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -280,16 +280,10 @@ static inline bool fsverity_verify_folio(struct fsverity_info *vi,
 					 struct folio *folio)
 {
 	return fsverity_verify_blocks(vi, folio, folio_size(folio), 0);
 }
 
-static inline bool fsverity_verify_page(struct fsverity_info *vi,
-					struct page *page)
-{
-	return fsverity_verify_blocks(vi, page_folio(page), PAGE_SIZE, 0);
-}
-
 /**
  * fsverity_file_open() - prepare to open a verity file
  * @inode: the inode being opened
  * @filp: the struct file being set up
  *
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
