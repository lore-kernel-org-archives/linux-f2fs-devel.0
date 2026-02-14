Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C041EF5855
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 14 Feb 2026 21:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gwwGD+Hb/Jt1PQUX1hxIQZLHd1HrKGxWIlwZCf8y3VM=; b=VM0jykGoqJ0oEotLksYyNhL0ma
	jUxvUzGkU96sNyVSXSHf5ZEN/E1nIDKeivfoiOJdiroCrxNdE5BXN+MMq2/M/k9zUSZ+9s7t8N/mW
	kFsl43NE+z1/7ddchIGXG55XNe+q2YKaYhSBS/+uKdzy+0FZMy4nKvZmWqSD3P0o6a6I=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vrN33-0003k5-Ns;
	Sat, 14 Feb 2026 21:19:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1vrN32-0003jz-It
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 14 Feb 2026 21:19:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8Hqat0nFdv0xdH+7Ah8oxjp0yU2UFgBBWeeUacK+Rgk=; b=GneNaw/4hbZfnSIdUt4MST9Wrf
 pFljCSmJgrB5WW3o2BpdgzoDMNSUJlNepmItmRYWvxtAsPqjGBhWQKwu6ruGxl/hnz84eA3fmf7ig
 LyeyGuSEgCOgk8UAP4Cc+dOvxzlmqEXvJJEiI0DVLu1R4JeovMZVkyELK7P4ikeaAFBM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8Hqat0nFdv0xdH+7Ah8oxjp0yU2UFgBBWeeUacK+Rgk=; b=gVH7aM5mlMEMfzh6udxurd6B79
 8bB6lsXaXqfckWvndTTnWSjTYkYc1b6KquA+v0txGk2zW9nqql7TVNQjcc61KCujRP8w48CqL23m3
 PkL1hyoCc6N6brPlilLxWrAOk0rBFw1SIPDIbOI85KhzaKd8VI/0fNq19SuSozVm3Ahc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vrN32-0004Oo-6J for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 14 Feb 2026 21:19:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 83D5F600BB;
 Sat, 14 Feb 2026 21:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E93C19422;
 Sat, 14 Feb 2026 21:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771103957;
 bh=l4tyUf9SoYD1pZQH8FZhtNk80NNflOB68ZUcN5ikYDY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=um1xgCahK2mQl1wJccCYYWfO4+eDF4HjkTN7eps3jFKzaxoU2PMU2LbL3QE405CTa
 cIlxMxxIDL6Jn+12TIrCTz+vD56mri1y9hLXk/U2ld8R8pCW6/OIQ07bUewXatV/YH
 1Xp+hpf/aNGg7FY/xeI+wcVOcc/SWa9QnW4EzR59DGYzH6/aCxwGvbY2IPmIYTMfsQ
 1XmpVinih/tytBAG32cGGMzdDV9mTvp3znTynI1Iim6Lguvb80WnJ+MWdUKuBs0Dse
 08c4tW6wZ7d/qN0henb5wMFqcCPeSCzuD97ZvtIrTUVvgOmJsQ3yYSev1meYPELA7j
 AjDgR0BvA92nQ==
To: fsverity@lists.linux.dev
Date: Sat, 14 Feb 2026 13:18:29 -0800
Message-ID: <20260214211830.15437-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260214211830.15437-1-ebiggers@kernel.org>
References: <20260214211830.15437-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1vrN32-0004Oo-6J
Subject: [f2fs-dev] [PATCH v2 1/2] f2fs: use fsverity_verify_blocks()
 instead of fsverity_verify_page()
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
Cc: linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Replace the only remaining caller of fsverity_verify_page() with a
direct call to fsverity_verify_blocks().  This will allow
fsverity_verify_page() to be removed.

Make it large-folio-aware by using the page's offset in the folio
instead of 0, though the rest of f2fs_verify_cluster() and f2fs
decompression as a whole still assumes small folios.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/f2fs/compress.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 006a80acd1de..11c4de515f98 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1811,15 +1811,19 @@ static void f2fs_verify_cluster(struct work_struct *work)
 	int i;
 
 	/* Verify, update, and unlock the decompressed pages. */
 	for (i = 0; i < dic->cluster_size; i++) {
 		struct page *rpage = dic->rpages[i];
+		struct folio *rfolio;
+		size_t offset;
 
 		if (!rpage)
 			continue;
+		rfolio = page_folio(rpage);
+		offset = folio_page_idx(rfolio, rpage) * PAGE_SIZE;
 
-		if (fsverity_verify_page(dic->vi, rpage))
+		if (fsverity_verify_blocks(dic->vi, rfolio, PAGE_SIZE, offset))
 			SetPageUptodate(rpage);
 		else
 			ClearPageUptodate(rpage);
 		unlock_page(rpage);
 	}
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
