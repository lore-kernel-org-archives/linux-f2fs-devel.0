Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E64E87827
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Feb 2026 13:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+exkb4R7+jWN4/9O+vEYKDbfQoaIMgM1poqJEI6LxP4=; b=jZDt91ZxsYg/cXuMoXYaA5pGcV
	8hBxic9RwVAukst9LTo975ChHi3g8zRkqTY9xemJhTRVaMngh0Lcvh8HON0MgQn1tMVdwkaMdRci9
	NC/lKbuSIeJXu0h47EpMeq45Yxu/vN+XE9kz268ekIF7/XXMT3O1ZkOPG+iRXVa5R/28=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vnGad-00070Z-Ra;
	Tue, 03 Feb 2026 13:37:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1vnGaY-00070Q-VY
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Feb 2026 13:37:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w+GbeC98O5vzmfqAP/q9sZjQ4VUlhcsfdv75zAd/vaI=; b=AeQ6q9/pa9uExpLNn6+CKnc6+y
 fYTjGfB+C5m8z41gkxwkbZpX4BUKCsvaBzuTAFN1oTrm+m4T4kFS+PdzqNeas7K8byTGMa73/oNeI
 9XvQi/KZErNFcGEnlfTosNTdi4SMASLMyTFlJhETS2/k6fjbCubvC5XqTL/AcLMlcp8Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=w+GbeC98O5vzmfqAP/q9sZjQ4VUlhcsfdv75zAd/vaI=; b=Z
 JQ8T1KFvpcu0tv1YbWjvf9/ubJUD6UutovflXTMoZTkuRDAA6nyPu6ALj3XGSOvQl3XiVhAOjTXJX
 tdpfaL1NzptoUOdHdemeWqq6Xs3DR/fUdWPxeiDfTSoSYMEplr9KdZabxqz67vChLtBYUjs8hpHO3
 qSB6rpHLtz5iRHPA=;
Received: from smtp153-166.sina.com.cn ([61.135.153.166])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vnGaW-0004kX-Qy for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Feb 2026 13:37:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1770125825; bh=w+GbeC98O5vzmfqAP/q9sZjQ4VUlhcsfdv75zAd/vaI=;
 h=From:Subject:Date:Message-ID;
 b=QZ04mrL1hDL/V/XASbv47xvNZAq3sDyYkZAQwfeQwvGi9A7BEhVqp+gVOdFu34f3g
 ChqjMPiEyz4QYCmDT+LRSjvUTPeBMcRVRY0q5w6YUne10VeNpNLFEIXDuVcmWvTrrd
 7uvmUxCzqGt/2fenvSAkxjgpz/2qsmWiOfNnBLzw=
X-SMAIL-HELO: xiaomi-ThinkCentre-M760t.mioffice.cn
Received: from unknown (HELO
 xiaomi-ThinkCentre-M760t.mioffice.cn)([114.247.175.249])
 by sina.com (10.54.253.33) with ESMTP
 id 6981F9EC00006DDB; Tue, 3 Feb 2026 21:36:49 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 5378346684990
X-SMAIL-UIID: 03129D2EB78F48AEA7582200B4183F55-20260203-213649-1
From: Yongpeng Yang <monty_pavel@sina.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue,  3 Feb 2026 21:36:33 +0800
Message-ID: <20260203133635.3942502-2-monty_pavel@sina.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1vnGaW-0004kX-Qy
Subject: [f2fs-dev] [PATCH 1/4] f2fs: fix incorrect extent flag when
 physical addr is NEW_ADDR in f2fs_fiemap
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

When the file block's address is mapped to NEW_ADDR, the extent is
currently marked with the FIEMAP_EXTENT_UNWRITTEN flag in f2fs_fiemap().
This flag indicates that the block has been allocated but not yet
written to. However, NEW_ADDR indicates delayed writing, meaning the
block has not been allocated yet. Therefore, this should be modified
such that when a file block's address is mapped to NEW_ADDR, the extent
is marked with the FIEMAP_EXTENT_DELALLOC flags instead.

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 84746a06cd58..42f15fd9c68e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2102,7 +2102,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 				size += F2FS_BLKSIZE;
 			}
 		} else if (map.m_flags & F2FS_MAP_DELALLOC) {
-			flags = FIEMAP_EXTENT_UNWRITTEN;
+			flags = FIEMAP_EXTENT_DELALLOC;
 		}
 
 		start_blk += F2FS_BYTES_TO_BLK(size);
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
