Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7161B606A31E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Oct 2026 05:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YRZwFre9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=C4WSuk7W;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=W17YHdx5;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DGf6VaI9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=N1qd3AWfSCfoMTk+8Vl9TO/DuV7DjnrMEWFw/oWie4g=; b=YRZwFre9jCTQnmisafexSduyKu
	VFu8Mq4D3UT0AktHS7S3xQUjbkEC1xw7j5dcoCGVPKP2gWd8Tg7gyl48VfoFO8qNUTYaVkNDnOLC7
	fY8w2HU+T7D7hxiX/yWzrpox8PRIJsJ1vchIjE+dVrE0seWYr3HcCHbLPoqtpD42typo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLvrl-000000005z6-49ws;
	Wed, 28 Oct 2026 05:06:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <jaegeuk@kernel.org>) id 1xLvrl-000000005z0-1L2H
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 05:06:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yUD5YLynuGYaqf6Oqfvw56LrdLQlN9UTWI1HrgotyIY=; b=C4WSuk7WFUO5klwsWA7DQcSZRG
 DFQwGR5xRLzljVVdjYJ2g51GCqHjuHhEEDbeORUYGCIwBh7Aon4Z+rQCkeY8UB4Zt7AkTXDjhEnjH
 qq9pwvRYTP+Bp47/8lDOCaTVK64pNED55ty4t9iN2aiD9VgDobr9cIWF7jR62hSKb3W4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yUD5YLynuGYaqf6Oqfvw56LrdLQlN9UTWI1HrgotyIY=; b=W17YHdx5OnI+R6/xDyLwWWvX38
 vSGVf8iHsdhLTy+J8hm2G3NFPib8DtayDxnLsQ2DJ7u5y/BP5JPkEsw4vSe8ZMAmCXr+3TrsFYSDa
 ElntF4tuYuf99QO+MG8EwVBW7C+9cJ8BwdQteoSDeWOA5ZyqDUcea/xC4qB1ZsPujiE8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xLvrj-000000003AM-44Zu
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 05:06:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8FD9C41783
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 05:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B46C1F01825;
 Wed, 28 Oct 2026 05:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793163978;
 bh=yUD5YLynuGYaqf6Oqfvw56LrdLQlN9UTWI1HrgotyIY=;
 h=From:To:Cc:Subject:Date;
 b=DGf6VaI9HWZBDnKA7ThUJVLSYVDRALZFi2xNTtp21abzgugYZLGqVxKCrNuyTipT3
 u4b/FM4ALSP+LOiU1/7xVBcGJCdTJzJz6RswfHVX1O1y3RoV7DuMMm+NKifAPtfMZJ
 V+e0ABCE3p4EqHmumtOAPja7hkEaPjtcIa0Kp/f1nSavBzAmH//ZYyYlfECpMZcvCQ
 DGbydqsfJSBqg92OxgoRvg+WmJGX0y1DCYfl4gdjK8JmrTy1hpT7EW4r3Ixrrkul3X
 PEYsZV0+Vv05O5UPv8016hBkPhyMo/R6OrQocqPBbLmwflYsOrHA/ltiTL59IjEB+6
 2jeMspYGIA6Fg==
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 28 Oct 2026 05:06:15 +0000
Message-ID: <20261028050615.259268-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLvrj-000000003AM-44Zu
Subject: [f2fs-dev] [PATCH] f2fs: do f2fs_zero_post_eof_page for all the time
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This fixes xfstests/generic/794, since the issue is not related to the
posix=strict mode only.

Cc: stable@kernel.org
Fixes: 5eced87b7d19 ("f2fs: fix to zero post-EOF data when extending file size")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8b4a7a9d7dbe..823df06ae0f2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -74,15 +74,10 @@ static int f2fs_zero_post_eof_page(struct inode *inode,
 					loff_t new_size, bool lock, bool writeback)
 {
 	loff_t old_size = i_size_read(inode);
-	bool strict =
-		F2FS_OPTION(F2FS_I_SB(inode)).fsync_mode == FSYNC_MODE_STRICT;
 
 	if (old_size >= new_size)
 		return 0;
 
-	if (!strict && mapping_empty(inode->i_mapping))
-		return 0;
-
 	if (lock)
 		filemap_invalidate_lock(inode->i_mapping);
 	/* zero or drop pages only in range of [old_size, new_size] */
@@ -90,14 +85,9 @@ static int f2fs_zero_post_eof_page(struct inode *inode,
 	if (lock)
 		filemap_invalidate_unlock(inode->i_mapping);
 
-	if (!writeback || !strict)
+	if (!writeback)
 		return 0;
-	/*
-	 * In fsync_mode=strict, when we expand an unaligned EOF size, we
-	 * should zero post EOF data and writeback the data immediately,
-	 * so that it can avoid exposing stale data after metadata flush
-	 * and POR.
-	 */
+
 	return do_zero_post_eof_page(inode, new_size);
 }
 
-- 
2.56.0.307.g5fe7bd680c-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
