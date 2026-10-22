Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D09E606A319
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 02:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mKHySVdb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=XxpTNOcA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AWDHpIxH;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FLbEd1D4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=qC4929d2e8bVGw1ikTIsfCK4TEnlg95w+QqZ+Q5Wh1Y=; b=mKHySVdbhg/QdUW6NcK/W68dVZ
	U/kitkpKsuah8JQNB9oEOmMIuicGL4tj5Ck4YTbnkWId/NEw1hU1tSLlXZghUu1ZZKMXW0umWw+V+
	6hXQqjn4w2ySqvUDIekA0x1C3y2SM4qc/jyGQ20hc2rheLn+c1DWCYqYHv9VJuluf7xE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJiSF-000000002dt-1Tkn;
	Thu, 22 Oct 2026 02:22:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xJiSE-000000002dn-0EAB
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 02:22:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i91IextAwQtyto3JwcboWuxOtr/zAylf2Na72nZI7O0=; b=XxpTNOcAZWLjvVH/Gw/a/V/k+z
 hvmL6bl6AQLtDX5Q4L1o3r6NG6ekP+9qX1xWaJ0ANFFzk02nSwNnHFlK6RWJpnNRYuq+WrYjTEtG9
 hKZCo/LI9bavDU/vwPUsdFG49MXlfpR7EAlCWb2K0l4T5mQtN1rne73yUvqte1PBPkQE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
 Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i91IextAwQtyto3JwcboWuxOtr/zAylf2Na72nZI7O0=; b=AWDHpIxHWhqP+EedGu2CpBcKA2
 U1pYFksrybUeS0qEdo6YPZPEqIVIEcH1Nazo/Z/Ryi9Yp1mbtgCLAGElNsxgpdsvBDbpLRwXMKFvc
 wSFOMwXh+Pu26SJnznppw3CP3n84DbBsN1OrEpDZcm18jgvHEP9ZGGnPR+r2ADTQVoqo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xJiSD-0000000068s-2X4R
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 02:22:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4DBAE4033E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 02:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83C01F000C1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 02:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792635768;
 bh=i91IextAwQtyto3JwcboWuxOtr/zAylf2Na72nZI7O0=;
 h=From:To:Subject:Date;
 b=FLbEd1D4B+XGCXnE2caaLI/3VFPJl8nc0xyRPaSo+ZOheWjjj7jy0Sqh9mdNgVcsr
 idfCDn0vXTGe3ubY5oTA08l943OyT19qb3cDCgMfutWEAE6LUcaZvmTHMuGZPD8SL7
 qu0B24DDZ3wt6Hp+3/piX81uWuxYcMztSD66XwR91QZJvHX4DymgVoM30fFx7PtbIy
 4qioVXPJ1zGaNBqeVkvW8tgpw0KGYXyvPPoWEGsdYkToGDu7ipclOQOwqFTga11YG5
 XRUOBJAD9h64XnldQFUaRkiOxJeJ1dM+KGWyuCZOCCgTvvPRPzTZhc18UqcJl06uh0
 /0yDO42fWjL5w==
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 22 Oct 2026 02:22:43 +0000
Message-ID: <20261021110521.12345-1-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJiSD-0000000068s-2X4R
Subject: [f2fs-dev] [PATCH] f2fs: compress: don't overwrite populated
 compress cache entry
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chao Yu <chao@kernel.org>

f2fs_cache_compressed_page() looks up the entry of blkaddr w/
f2fs_find_cache(), and then grabs it w/ f2fs_grab_cache() and
F2FS_CACHE_LOCK_CREATE. If another reader populates the entry in
between, f2fs_grab_cache() returns that uptodate entry, and we will
overwrite its ino and data.

Before the compress cache was converted to the generic cache,
add_to_page_cache_lru() failed w/ -EEXIST in this case, and the
existing page was left untouched.

Normally, the racer is a reader of the same block of the same inode,
so both copies are the same, let's just back off, as
f2fs_ra_meta_caches() does.

A block address can only be owned by one inode at a time, the block
can not be freed and reused by another inode during population, since
the reader holds the locks of the cluster's pagecache pages until
decompression completes, and truncation must lock these pages before
freeing blocks. So if the uptodate entry was cached by another inode,
it's a bug, and one of the copies must be stale, let's report the bug,
and drop the entry, then readers will load the block from disk.

Cc: stable@kernel.org
Fixes: 6a78d0488116 ("f2fs: cache: use compress cache")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/compress.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 747141c79900..9cc77d4dc63f 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1928,6 +1928,24 @@ static void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi,
 	if (IS_ERR(entry))
 		return;
 
+	/* someone else has populated the entry after f2fs_find_cache() */
+	if (f2fs_cache_test_uptodate(entry)) {
+		/*
+		 * a block address can only be owned by one inode, if the
+		 * entry was cached by another inode, one of copies must be
+		 * stale, drop it and let readers load the block from disk.
+		 */
+		if (unlikely(entry->ino != ino)) {
+			f2fs_bug_on(sbi, 1);
+			f2fs_warn_ratelimited(sbi,
+				"%s: blkaddr %u was cached by ino %u, current ino %u",
+				__func__, blkaddr, entry->ino, ino);
+			f2fs_truncate_locked_cache(entry, false);
+		}
+		f2fs_put_cache(entry, true);
+		return;
+	}
+
 	entry->ino = ino;
 	memcpy(cache_address(entry), folio_address(folio), sbi->blocksize);
 	f2fs_cache_set_uptodate(entry);
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
