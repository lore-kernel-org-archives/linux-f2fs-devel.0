Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D7CC55ABF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Aug 2026 12:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=duXIWxUUDzAug6CV+dAvNzJEKbc+wGhBBvxn8+kX6Zg=; b=h6LzQ2IcGTniyh+mXuxyz9iRrm
	3LY3SMmxjY52ddlwYr7ospQkzUDctCt8x3++LLb5blDn3HGVpJet7de3Uvv0EVxzD0xtcgV56BQgm
	9wQLBtGO5pGyEvvYT2gBFouIjZl778inycfZYcXlQUBmNS+j//kvVdCrwJpyiG1jwQF8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrxKB-0005Dd-6p;
	Thu, 06 Aug 2026 12:35:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wrxK9-0005DX-O2
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 12:35:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VPnD5PgL0+1BxIewVr3ebrJTMvRb1YeQYDZaYPbjX2Q=; b=Dr+QLAXapl+yh3MH3ektO5rGgc
 oy6xW7Nc6cYHe0J+PDiwndlqZQfsq1i+kceerwBfcxFUslx7qHSkIW30vQlth52mil4ZxnD5d3Ywi
 B+2EQMu9XgyQ6TH0eUC/PcUE/Uk9JkyMJWP9rF/S3dhtQRk9ZTu9mCmQ4TLkl9nm1sGo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VPnD5PgL0+1BxIewVr3ebrJTMvRb1YeQYDZaYPbjX2Q=; b=H
 l58hpEnoek8fN9JaVPbLyRWgB90h9kJGQIT4YMxzKoBLzz5Eyv1gW6c5fnN2waOJQMLmXVZK1v28w
 SLqdIfamHijMwc9BVmCiyoZrlD2sRmNIJi9+S1n8GjneAC2TU4UhKNB8n0mHyUCCcVK+lBoLA6eBI
 3IGhwhQFtZfHGmig=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrxK9-0000BY-9q for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 12:35:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DB24D418AB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  6 Aug 2026 12:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C701F000E9;
 Thu,  6 Aug 2026 12:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786019743;
 bh=VPnD5PgL0+1BxIewVr3ebrJTMvRb1YeQYDZaYPbjX2Q=;
 h=From:To:Cc:Subject:Date;
 b=lrFy32Nlmv1HIRtu9P6iuXLQ6EDyLz8vbc6F5RSl1Re5azSlyQpCmBN55BF1p0tA6
 vbnS37pKnBzYKDoKkmHAntorQzz3jU79CAfpqWojZKfIDssTxM/qOCXwQyjOn2MfGq
 orTuAHCk54qmJfcdOr7G+fCd8lF2u5IZhxIGu5GaF8FoAelkIijsL8M6ilMrDzSGiY
 h9heIsWr1A9HbFIs/IBo6AYRkYfFmLtPAKwiOclHr/yxKjukZw8XzcoA8OBGbpAGJy
 HP9Z859NC6Q7GnLMrYnY7u9FXFp5hGflbljVT8omIrImSp08MZDcMyMU46VaS59w0d
 81S+XGNPjM8xQ==
To: jaegeuk@kernel.org
Date: Thu,  6 Aug 2026 20:35:37 +0800
Message-ID: <20260806123537.1516699-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
MIME-Version: 1.0
X-Headers-End: 1wrxK9-0000BY-9q
Subject: [f2fs-dev] [PATCH] f2fs: fix to pass folio->index to
 f2fs_sanity_check_node_footer()
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Otherwise in f2fs_sanity_check_node_footer(), it will check the
same nid incorrectly.

Cc: stable@kernel.org
Fixes: 0a736109c9d2 ("f2fs: fix to do sanity check on node footer in __write_node_folio()")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index a98855b8cc5e..46bea52e35c3 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1790,7 +1790,7 @@ static bool __write_node_folio(struct folio *folio, bool atomic, bool do_fsync,
 	/* get old block addr of this node page */
 	nid = nid_of_node(folio);
 
-	if (f2fs_sanity_check_node_footer(sbi, folio, nid,
+	if (f2fs_sanity_check_node_footer(sbi, folio, folio->index,
 					NODE_TYPE_REGULAR, false)) {
 		fserror_report_metadata(sbi->sb, -EFSCORRUPTED, GFP_NOFS);
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_CORRUPTED_NID);
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
