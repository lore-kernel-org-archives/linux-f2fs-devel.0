Return-Path: <SRS0=MGGM=V2=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAC9C7618B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jul 2019 14:31:24 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89676204EC;
	Mon, 29 Jul 2019 14:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="DMz9zWUy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="W1LbcutI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5dxupUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89676204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hs6gN-0001qm-RC; Mon, 29 Jul 2019 14:31:23 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1hs6gK-0001qB-1U
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jul 2019 14:31:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jtFIr1RIGX2b6dlykb3oU4OxoiiCBNM6AQTdy7Grdbg=; b=DMz9zWUy6gDNvAZoYdxRRT994b
 xRLCDCGG/Z8rSAYsNirUdyB2IL6vo+40MhNLGh/rmLqduEtamiSPmjfSoA4cUDpIAxp7J8x+JLH+9
 71GdjgVoqTiygu6sUiPiQXJJkBkIe/HODwHORznpJl2tcmVjelQFKjbuT0WQJNpRCDik=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jtFIr1RIGX2b6dlykb3oU4OxoiiCBNM6AQTdy7Grdbg=; b=W
 1LbcutIkucub+q3MoOlCv3wR8jXP9F4ACZgHljVvgn3IhXVRIckRNxAEUmO4DOmRSlCveT++doth5
 dmxs3x9HHyrjhh+P5F3JU24MXPzEfYONiCLDGtTDvgzUQSvklAlYBRy9Qgt+tel3ijhRO5SuD5Oun
 JXqWpZOGyYyTiN/Y=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hs6gG-003UBh-I7
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jul 2019 14:31:19 +0000
Received: from localhost.localdomain (unknown [180.111.32.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DDD51206DD;
 Mon, 29 Jul 2019 14:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1564410670;
 bh=UjF/AwvKhVxU6D/HTh8Hq1nLgczmyOG6CMrKwunrSbc=;
 h=From:To:Cc:Subject:Date:From;
 b=V5dxupUlfgUZEBYpjvlt723xj/TcjTDF9WMaKoEZENPx/o+C8axJ7+2DL915XzMHT
 eLvON8oyYmDW03M6gYX5TmSFYAC1hrf6qdp6i6kZfbJHy8fIDz3xBDw2tZHEcqQOeg
 eUp1nCiwek9wdItlegOE6c9ShlnKpDle7SKw+oKA=
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Sun, 28 Jul 2019 23:01:52 +0800
Message-Id: <20190728150152.8533-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-Headers-End: 1hs6gG-003UBh-I7
Subject: [f2fs-dev] [PATCH] f2fs: fix to migrate blocks correctly during
 defragment
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

From: Chao Yu <yuchao0@huawei.com>

During defragment, we missed to trigger fragmented blocks migration
for below condition:

In defragment region:
- total number of valid blocks is smaller than 512;
- the tail part of the region are all holes;

In addtion, return zero to user via range->len if there is no
fragmented blocks.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ff93066ed515..ff2ffa850a6f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2384,8 +2384,10 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 		map.m_lblk += map.m_len;
 	}
 
-	if (!fragmented)
+	if (!fragmented) {
+		total = 0;
 		goto out;
+	}
 
 	sec_num = DIV_ROUND_UP(total, BLKS_PER_SEC(sbi));
 
@@ -2415,7 +2417,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 
 		if (!(map.m_flags & F2FS_MAP_FLAGS)) {
 			map.m_lblk = next_pgofs;
-			continue;
+			goto check;
 		}
 
 		set_inode_flag(inode, FI_DO_DEFRAG);
@@ -2439,8 +2441,8 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 		}
 
 		map.m_lblk = idx;
-
-		if (idx < pg_end && cnt < blk_per_seg)
+check:
+		if (map.m_lblk < pg_end && cnt < blk_per_seg)
 			goto do_map;
 
 		clear_inode_flag(inode, FI_DO_DEFRAG);
-- 
2.22.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
