Return-Path: <SRS0=MRh2=XG=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799BCC49ED6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Sep 2019 16:45:39 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E21220838;
	Wed, 11 Sep 2019 16:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="e1j3w8Is";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="mINAdQsd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E21220838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1i85kQ-0005o2-TQ; Wed, 11 Sep 2019 16:45:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <rgoldwyn@suse.de>) id 1i85kP-0005nv-TP
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Sep 2019 16:45:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7QZ/BQaWKfAVJoFfDoB2ec0Eu/3bxYcPh8mK+ZnBEOc=; b=e1j3w8IsgnQHxvlqB3cRJtRHzQ
 SD4nJCbYniUrz009/LEbFrWe5qbKq1FhBwcfBHstUpGQJSdYDc99H/VBOnlBtSN07W6pw5ndq4TQH
 uHr/wf4exel+hVWGkxQXmiJBuEbZzXPT/y3G5lOIsiS191lKoWFSXmFsFaTTTNDrtaKo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7QZ/BQaWKfAVJoFfDoB2ec0Eu/3bxYcPh8mK+ZnBEOc=; b=mINAdQsdJpjsx/O1UDPJVfG2OJ
 51vzgsuPXcBAL5U19fTAVjyQAYXe11Wcs/FIE1wjuNK9Yj6gWGt09898pN01qWzRBLxqzFAm14VTm
 OU8YrnWvd8GqUnEvbJZ3qajTxgD6NR+ve2EorKlXqRKQoWKE5chU32uRzsqqg1QoiJBA=;
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1i85kO-000Vwq-LJ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Sep 2019 16:45:37 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 2F975AF89;
 Wed, 11 Sep 2019 16:45:30 +0000 (UTC)
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-fsdevel@vger.kernel.org
Date: Wed, 11 Sep 2019 11:45:17 -0500
Message-Id: <20190911164517.16130-4-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190911164517.16130-1-rgoldwyn@suse.de>
References: <20190911093926.pfkkx25mffzeuo32@alap3.anarazel.de>
 <20190911164517.16130-1-rgoldwyn@suse.de>
X-Headers-End: 1i85kO-000Vwq-LJ
Subject: [f2fs-dev] [PATCH 3/3] f2fs: fix inode rwsem regression
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
Cc: david@fromorbit.com, linux-f2fs-devel@lists.sourceforge.net,
 hch@infradead.org, Goldwyn Rodrigues <rgoldwyn@suse.com>,
 linux-ext4@vger.kernel.org, andres@anarazel.de, linux-btrfs@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

This is similar to 942491c9e6d6 ("xfs: fix AIM7 regression")
Apparently our current rwsem code doesn't like doing the trylock, then
lock for real scheme.  So change our read/write methods to just do the
trylock for the RWF_NOWAIT case.

We don't need a check for IOCB_NOWAIT and !direct-IO because it
is checked in generic_write_checks().

Fixes: b91050a80cec ("f2fs: add nowait aio support")
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/f2fs/file.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3e58a6f697dd..c6f3ef815c05 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3134,16 +3134,12 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 	}
 
-	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	if (!inode_trylock(inode)) {
-		if (iocb->ki_flags & IOCB_NOWAIT) {
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock(inode)) {
 			ret = -EAGAIN;
 			goto out;
 		}
+	} else {
 		inode_lock(inode);
 	}
 
-- 
2.16.4



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
