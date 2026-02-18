Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F0BE9A03B
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 Feb 2026 01:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=etGvOmZyvIKnEADdcAVt7EPFDw6eC+jmymbzQZiBA6c=; b=S7zm9l9TVS3xcPxy2EFQqjUgIJ
	u0MbA6BbjjSxolxS/WFCy0a+x8QtIJbQTJh7MP9ezld2N660DdtBH+7p+6z+C3x8oWCgghweYWC/L
	AQMHGAqr3DU+HLu+/rgWXXU2jgZZ0thL+TRPYwdjWeQPOpcRoQxIEOMT6B/pQe3I08Ho=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vsW2R-000381-15;
	Wed, 18 Feb 2026 01:07:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1vsW2P-00037u-S4
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Feb 2026 01:07:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Unjw52H6GCPrjSSLt/SEpFHawli/3r44mVK3fbKq5bg=; b=TSJS/4kVjsKUZV10uPEWSPNYuE
 JVmTHKCtwKIPxUNVbUaH/KBBu8NxCaeF3+q0efWHgx5FkgTbNDuOh93etolRRTSOo0xv/pzgXdEyi
 ZJhHnu4xR7P5fHrbo4E+Jvrxqobx5uQne2sIxb32K/sTlh9rOotsA9UPdDQIZIE2x7uY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Unjw52H6GCPrjSSLt/SEpFHawli/3r44mVK3fbKq5bg=; b=m8jxi3PSBqWmEGz+okw16+S5mK
 JdrnnWGZ2sAUjSycDDB4zley6iqEJYxHjwun578w64gjV5xpU3jMsKB0CnFuyuj7ARs1vyKBjVkDp
 bNjnA1eJOIOu/qe0g0ByUgK2QuNMaDW9soPtRHq6ymJSLCriQZZZwm3WEZJwGL1lQHNc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vsW2P-0003la-7C for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Feb 2026 01:07:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1A9A36185D;
 Wed, 18 Feb 2026 01:07:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CB0C4CEF7;
 Wed, 18 Feb 2026 01:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771376846;
 bh=O3dLk96HCqOP4bm+/UDISNUGuTY/kvHS6P5aQSKjx4g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pooA/22OZ652zP3398OFf3SBzvc/c/IZCczNVV1m4nv627hVgkyiDDvAaTmCOKuWG
 ooYfTy/B/24rpuWhNynwE3Sxs6nGdQ+qTmBF3+ASssVhKdRdefv+7PxD7LEGJFtaiY
 Ozx/3UeBCS4X34viDZ+/UFhzfqM86A7G3+C/ZAbDEfnPeAWFaBMkV9qRCYglR2R+ZO
 LXjtGH4r5rF/V1sBhEjGVHns02OyqLYQsEKpbYGKC3JAwBmtfzILt/vycSEHKtcTJX
 kiYqM34iVvgeWR92JjYpmPtKh9/oT+vldkSqmKP1rJfGfKpZeHCJ5qvid5Bzk1hx5p
 23a9yF38TKO2A==
To: fsverity@lists.linux.dev
Date: Tue, 17 Feb 2026 17:06:29 -0800
Message-ID: <20260218010630.7407-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218010630.7407-1-ebiggers@kernel.org>
References: <20260218010630.7407-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1vsW2P-0003la-7C
Subject: [f2fs-dev] [PATCH v4 2/3] f2fs: make f2fs_verify_cluster()
 partially large-folio-aware
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
 Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs_verify_cluster() is the only remaining caller of the
non-large-folio-aware function fsverity_verify_page().   To unblock the
removal of that function, change f2fs_verify_cluster() to verify the
entire folio of each page and mark it up-to-date.

Note that this doesn't actually make f2fs_verify_cluster()
large-folio-aware, as it is still passed an array of pages.  Currently,
it's never called with large folios.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/f2fs/compress.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 355762d11e25..8c76400ba631 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1811,17 +1811,18 @@ static void f2fs_verify_cluster(struct work_struct *work)
 	int i;
 
 	/* Verify, update, and unlock the decompressed pages. */
 	for (i = 0; i < dic->cluster_size; i++) {
 		struct page *rpage = dic->rpages[i];
+		struct folio *rfolio;
 
 		if (!rpage)
 			continue;
-
-		if (fsverity_verify_page(dic->vi, rpage))
-			SetPageUptodate(rpage);
-		unlock_page(rpage);
+		rfolio = page_folio(rpage);
+		if (fsverity_verify_folio(dic->vi, rfolio))
+			folio_mark_uptodate(rfolio);
+		folio_unlock(rfolio);
 	}
 
 	f2fs_put_dic(dic, true);
 }
 
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
