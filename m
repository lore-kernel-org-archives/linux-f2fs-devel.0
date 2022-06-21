Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D67C43334
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jun 2022 20:06:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o3k8T-00010Z-05; Tue, 21 Jun 2022 20:06:05 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1o3k8R-00010T-F1
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 21 Jun 2022 20:06:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ndsKJnxW08/VOIOS7m8WVCA38jUgQ06zHCAJ9wrl6DM=; b=MT17T3G43lIihUYY0TYitH7LvU
 veoQUHOqpLegS0Ypn6hMccAr5kN/Pi5AAHaY37oQIze1XWPiGgLMX+bOyZLPptKizJdu+7PeUYdW9
 BgQ3b1B6q31YabDdbw0xwik6iAuSOqlLKwtdLg5JXnZp8h2eA88Su6+G3WjGrYXwtVQw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ndsKJnxW08/VOIOS7m8WVCA38jUgQ06zHCAJ9wrl6DM=; b=L
 F1MuvhYPS/aUd+0kH/ROcP0qMMZd/a7/rSDtM+5PW6DNULXJiMiCOarbDcSYT2wifcXe3LguuqHgx
 WoM1/wHvGlUT8PkASTI4GjJF11oLwb0UJ7LoEOlIXsqmN/QL7VND3VWw+EHRwrgjs2e6MgzwzIkQj
 dm6fNsin9bVu7QEk=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o3k8M-00081A-Ty
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 21 Jun 2022 20:06:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 9FA24B81B0A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 21 Jun 2022 20:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C72BC3411C;
 Tue, 21 Jun 2022 20:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655841951;
 bh=OILXA9EAMh9tuhGWVWxQBF9Rm7oQxNgoiXsNt77TGmk=;
 h=From:To:Cc:Subject:Date:From;
 b=sKccg1eAu2FwB+urb090mpIDNYXrwMBbteJmVv+D9NGYFdZM5Ui0K6ZNT8vVRXtWX
 FVNzBpFMwDUaaQa9sWDf/7JjjDs57kKTgwCImChzVnmmngEDtIHtueniLI4m41vCSk
 7J02TXc7VJ4aUng2wli66eyl0BARWKus0a4H43kSD6g5w7JnIcwaKKfiPzSnhtqWpe
 mfOqsGQ4e04qlINIj8e8oW2DyiqHChGekyQ55MmphhB2jgH1q+AmUZF6AU74vXPvKM
 MacKxCBCSZzgoqcpIA6REBm74EGQAFMoYMOY5M6W+CgdTJRFcVQphfyx0mf0z9ARYW
 wTBkgwAIsrlUg==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 21 Jun 2022 13:05:48 -0700
Message-Id: <20220621200548.3485092-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
MIME-Version: 1.0
X-Headers-End: 1o3k8M-00081A-Ty
Subject: [f2fs-dev] [PATCH] fsck.f2fs: drop compression bit if inline_data
 is set
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The kernel enforced not to have compression and inline_data bits
together, but old kernel created files with them. Let's disable
compression in that case.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 4b546aeff995..b1b6722566ef 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -712,7 +712,10 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 	int ret;
 	u32 cluster_size = 1 << node_blk->i.i_log_cluster_size;
 
-	if (!compr_supported && compressed) {
+	if (!compressed)
+		goto check_next;
+
+	if (!compr_supported || (node_blk->i.i_inline & F2FS_INLINE_DATA)) {
 		/*
 		 * The 'compression' flag in i_flags affects the traverse of
 		 * the node tree.  Thus, it must be fixed unconditionally
@@ -727,6 +730,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 		}
 		i_flags &= ~F2FS_COMPR_FL;
 	}
+check_next:
 	memset(&child, 0, sizeof(child));
 	child.links = 2;
 	child.p_ino = nid;
-- 
2.37.0.rc0.104.g0611611a94-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
