Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0F6C43217
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Nov 2022 15:29:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oyEAV-0005su-OG;
	Thu, 24 Nov 2022 15:29:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1oyEAU-0005so-9O
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Nov 2022 15:29:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xbMVaUichRMtXY6bCeUP/gE23l0EZRkWaSxA3R91LhU=; b=SzjO/4Oek2EsMP4m+uJjVNVv78
 26kWEPGkjHZSnHGP5ieEj8XcDosbJtg7An6iVJmdVV43zLAm8uFveAcEzlokX0S9oZXya83hH38MY
 v1hp5HkJmHe/lNu+z9sexe6LDdhVezcB5rZB1Qv4YOIHp6vVtuhgZhJkM2K0O3k7gkgE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xbMVaUichRMtXY6bCeUP/gE23l0EZRkWaSxA3R91LhU=; b=i
 g3B4tSUyzYBXd39DP7c9JJ43KENPgKqR096OgOzSvc4Qr8zRqbIBsF+rF1cJOlK1O7EB9M1dWzsIU
 DI2tXh7wtTYaPrMIAk4xR5A3Lu64X9qBiFbKrSpBMgUkUfshFsBzd/S+QRwpKleqw/FmOSf69O58X
 P2Cwhxifbsg4NgeI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oyEAT-000390-Oy for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Nov 2022 15:29:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 615BE621AE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 24 Nov 2022 15:29:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B535BC433C1;
 Thu, 24 Nov 2022 15:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669303771;
 bh=nZmcBIjikcEpAdjorTMsfW0ArzMzZX6J9glvIy0+9Yw=;
 h=From:To:Cc:Subject:Date:From;
 b=tkuxkiYOSeWe0QbVkD9Dlmy23oS/T0Tt5/2VBM58HOLromEZHVxNJV2PcqUPsdOkO
 /oyJIXaZoPTgxQegyG7pD6FU/dfKNfefVD45zuumcwYYo13g6UTTjJZ6en/A8wFOzE
 Sqz9Ff+OTiV8zo9enx8lGqlYzs/ULL1e/Ub2j+/3GI+9/RQdQDFHlWsoPRht+kvPCc
 +OXLppCW/FxuNZUC8UOKiSNW6hHVSJ/bC6YCgKoY3cU3xiU4u0THV/nbzbiqM4yeI0
 QoYB8I1ib9WADog6LGeoVN1YH/CFZ1fTEec0pjT/5nej1cyjkRWpH/qf8tuogPcY3I
 Z650TEeDglG6w==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Wed, 23 Nov 2022 06:42:52 +0800
Message-Id: <20221122224252.73270-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Headers-End: 1oyEAT-000390-Oy
Subject: [f2fs-dev] [PATCH] f2fs: truncate blocks in batch in
 __complete_revoke_list()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Use f2fs_do_truncate_blocks() to truncate all blocks in-batch in
__complete_revoke_list().

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 14ece4bf7c7e..37c721e1eb03 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -262,24 +262,19 @@ static void __complete_revoke_list(struct inode *inode, struct list_head *head,
 					bool revoke)
 {
 	struct revoke_entry *cur, *tmp;
-	pgoff_t start_index = 0;
 	bool truncate = is_inode_flag_set(inode, FI_ATOMIC_REPLACE);
 
 	list_for_each_entry_safe(cur, tmp, head, list) {
-		if (revoke) {
+		if (revoke)
 			__replace_atomic_write_block(inode, cur->index,
 						cur->old_addr, NULL, true);
-		} else if (truncate) {
-			f2fs_truncate_hole(inode, start_index, cur->index);
-			start_index = cur->index + 1;
-		}
 
 		list_del(&cur->list);
 		kmem_cache_free(revoke_entry_slab, cur);
 	}
 
 	if (!revoke && truncate)
-		f2fs_do_truncate_blocks(inode, start_index * PAGE_SIZE, false);
+		f2fs_do_truncate_blocks(inode, 0, false);
 }
 
 static int __f2fs_commit_atomic_write(struct inode *inode)
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
