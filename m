Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6599AC4708B
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Nov 2022 16:11:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oqGLL-0000US-Tt;
	Wed, 02 Nov 2022 16:11:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1oqGL7-0000RK-Jw
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Nov 2022 16:11:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KDRTYxfyvxtJ8nlExLPdZpgWJ/su4BLXKUXaNb8lkhE=; b=JfT8Wjmw/MJdQYMS30clJzHUM7
 Do9qU3dD+ZAhq+Ga/qNRfpBog7GZwjA6NshB80tinvya8ASXCy7TopFMAcd9DEzPtnA/iRCfik/OZ
 2jLk88Bdb5Qxr0tU1JGKwjXKmxH5PuhaIYQ4frFWoLh0WEVjW2whxnBXHbzcpraEPnow=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KDRTYxfyvxtJ8nlExLPdZpgWJ/su4BLXKUXaNb8lkhE=; b=ZSdGrWAalrH/JIvcZoSIgOzbWT
 XufxEPwx3GuGZfSKhlZ7QvSNa+c91Ka7cyeVGdwp6E8/MIpoaHy8dSP5IU15M0XMtihUENDldDGZD
 +ErsYL6jkx516e9VlSFcKiA9GR9dAcmIqWuKoXx6qzTcJQ+zkHDvRwVGCK+BkGBDbYNc=;
Received: from mail-pl1-f178.google.com ([209.85.214.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1oqGL7-009aAc-44 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Nov 2022 16:11:41 +0000
Received: by mail-pl1-f178.google.com with SMTP id y4so17044913plb.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 02 Nov 2022 09:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KDRTYxfyvxtJ8nlExLPdZpgWJ/su4BLXKUXaNb8lkhE=;
 b=LzbfvJ+o7+PPEWAo4w8AKJBmrzmPbRkBu3ORC/K7IBEBc4H7+EY6jlr3kPMKdC+kLo
 AmeRyK5Dh8JnM5M6037m8XCwwaveHP3T1zWfXQL5PNN2l8Ar7mvAlRUfGrHxX9l4CAlx
 lo3QVGXXrSxrr9dWf3dkPnZsG+uP9YkyrIkUspxdhnyIO5H9xO3I2khrWtyjrsb3beRJ
 4OTNnGP/tYO4gLRsXwP7dLPwn1T8Eyszj0QvmzUxq1RtDQ9iIk0vaxsCgNdXJmRDiqCT
 sM3lyaFW63RiGf2IUhiE4Hi5Q9YJbodgMXUOnMDzbZK/PBDDWhOYiUrWWg5ys/RBXgc/
 FTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KDRTYxfyvxtJ8nlExLPdZpgWJ/su4BLXKUXaNb8lkhE=;
 b=afsreBPpLdmrJPTd1JyKSqdcbhc+5jygawXqOmJWy/Ck0H3IFDENzrNArz5NCJJiOI
 1XDaviI/jqV/uYXKJIzV2G0LRRxiF3d+oKPTVvacWMTVj0t1Yc+p/5gEpycp1F5utXc2
 2YTQJm9my+g+RWiCJWEIcBMFFnHEcNczUT4Tg89gThxRTaW6LNVJ/EQbycDH3LHpllPg
 R/ED2Z1dL78hgpOMvlkgvvCdpln1GYHE2ZfakTSG0jccgtjd8RtmYo+g6sYTMGN3wJwD
 D3aG9C3n7ekJCBtYwCPk1dZMIjQvZ3rUo6YRqHnys6f/xwdLU9f+NZ84zvs8xhPZIv1a
 NnFg==
X-Gm-Message-State: ACrzQf2FzSOdYqIfqC0CmOffmIjq7HknuJP+lArQKPPyO9an9HYbUKOd
 L4wZ3X71iVB5R3+T9Cro39s=
X-Google-Smtp-Source: AMsMyM5Gg7NNdqkkD0qRog5my+HvLc2ALPLnjteIt7psDYOA2pBRYr6Rk+9oY34/AO+uIwffHowUkA==
X-Received: by 2002:a17:902:e5cb:b0:187:2d8c:a4fa with SMTP id
 u11-20020a170902e5cb00b001872d8ca4famr12910612plf.151.1667405495543; 
 Wed, 02 Nov 2022 09:11:35 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::8080])
 by smtp.googlemail.com with ESMTPSA id
 ms4-20020a17090b234400b00210c84b8ae5sm1632101pjb.35.2022.11.02.09.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Nov 2022 09:11:35 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Wed,  2 Nov 2022 09:10:27 -0700
Message-Id: <20221102161031.5820-20-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102161031.5820-1-vishal.moola@gmail.com>
References: <20221102161031.5820-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1oqGL7-009aAc-44
Subject: [f2fs-dev] [PATCH v4 19/23] nilfs2: Convert
 nilfs_lookup_dirty_node_buffers() to use filemap_get_folios_tag()
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
Cc: linux-cifs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 "Vishal Moola \(Oracle\)" <vishal.moola@gmail.com>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Convert function to use folios throughout. This is in preparation for
the removal of find_get_pages_range_tag(). This change removes 1 call to
compound_head().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/segment.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 2183e1698f8e..fe984def1b1c 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -737,20 +737,19 @@ static void nilfs_lookup_dirty_node_buffers(struct inode *inode,
 {
 	struct nilfs_inode_info *ii = NILFS_I(inode);
 	struct inode *btnc_inode = ii->i_assoc_inode;
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	struct buffer_head *bh, *head;
 	unsigned int i;
 	pgoff_t index = 0;
 
 	if (!btnc_inode)
 		return;
+	folio_batch_init(&fbatch);
 
-	pagevec_init(&pvec);
-
-	while (pagevec_lookup_tag(&pvec, btnc_inode->i_mapping, &index,
-					PAGECACHE_TAG_DIRTY)) {
-		for (i = 0; i < pagevec_count(&pvec); i++) {
-			bh = head = page_buffers(pvec.pages[i]);
+	while (filemap_get_folios_tag(btnc_inode->i_mapping, &index,
+				(pgoff_t)-1, PAGECACHE_TAG_DIRTY, &fbatch)) {
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			bh = head = folio_buffers(fbatch.folios[i]);
 			do {
 				if (buffer_dirty(bh) &&
 						!buffer_async_write(bh)) {
@@ -761,7 +760,7 @@ static void nilfs_lookup_dirty_node_buffers(struct inode *inode,
 				bh = bh->b_this_page;
 			} while (bh != head);
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 }
-- 
2.38.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
