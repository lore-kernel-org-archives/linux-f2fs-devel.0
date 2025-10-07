Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2BBCCA470
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Oct 2025 03:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PZ5UB9nnvIiNJQJdTxt6CtpPTP2roqHUB0cZJ2AcYzw=; b=TebVU6+L506sm0GvFxQ7+YY0l2
	gR3dTV/3MHMUzzvWC8jIBddogetznC4tgxtu7mZ9uWQCN8BIb8t2d0zBfCEWPz9qoLGYOsl5wccWT
	tOsbrhV4jbkgXqX5+Ax5TsHhzr8DWQtgLfQoGmWOOzQt9ST+dGlGYwLnQ0dIqxlZlOFM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1v5yly-0006gv-It;
	Tue, 07 Oct 2025 03:53:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1v5ylw-0006gm-NX
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Oct 2025 03:53:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xBwbMUG7Z6xPMgmoIb/mFy8YbpMdVuCzF+AwND9eaak=; b=l+RMibM81GBJ329zBkR+ILtWeN
 9J0BY6oVzfQnp2SwbekN8+UMHbHqfACudTyhp+NGJYSCWLiTR+xfCJVWrPqagfTmhMDjS9ql/4aC9
 Q/cjX9Kd4LbIHPWF25Q3p/y/qcYmdRlsfbCbCRW2yk/t1M0YkAA7FfN0pz3YmlTKk4GQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xBwbMUG7Z6xPMgmoIb/mFy8YbpMdVuCzF+AwND9eaak=; b=F
 B+T4M3kTk3waRz2bDyFGhJQUPeyxWQY5iQPlyQMcJPlnwcNzx/D+CQGrXozlAgO98kLg1+x/QqlIh
 5IdzZhp9nEETmeJaHnQ1rDtbWtEqH62VXfXeCO84M+4bkOb0EFlavcPe2UiLsAUuC8KyfsElxEfwY
 KjHUvNBg5b0XTc1g=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1v5ylw-0002ml-9A for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Oct 2025 03:53:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 78532600BB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  7 Oct 2025 03:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122C1C4CEF1;
 Tue,  7 Oct 2025 03:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759809225;
 bh=h6Jczh/Fz0AUxzV1CKO9gaYdchSp5gAD7ftbxcwDyUg=;
 h=From:To:Cc:Subject:Date:From;
 b=PzFhcbwmmInvQaN42CgurB0j8XEH+v3cidshNWYZ4JAIdaIBPibAuFlo4m1fCXZ08
 XjDdk7mH4pti7Ro0oNMX+jrD1RIF3TroxgtuVRaoqhgQPVNVeCxqA/qVEzfiMtpNlL
 ZrC4QPwFUpIWkUfzsqUHSF68vWi4hI2G+Xezo0DZpW0P5eU/ZQ7A2y4R/CbqZhBnoO
 M59W99HS6wSGK3vJGngL60qnYy5RPcuUIsHIzquaB2OvNxps2pRr+qNJj/ylm5vfYk
 8mBZgXj/3a2Q9qnqat63q64mg6F+HgWhHeTe+6fK8qw/eAvY+Ajq3Z9+fx3TkUIbbT
 sX9PGjWlttJAQ==
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Tue,  7 Oct 2025 03:53:43 +0000
Message-ID: <20251007035343.806273-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
MIME-Version: 1.0
X-Headers-End: 1v5ylw-0002ml-9A
Subject: [f2fs-dev] [PATCH] f2fs: fix wrong block mapping for multi-devices
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Assuming the disk layout as below,

disk0: 0            --- 0x00035abfff
disk1: 0x00035ac000 --- 0x00037abfff
disk2: 0x00037ac000 --- 0x00037ebfff

and we want to read data from offset=13568 having len=128 across the block
devices, we can illustrate the block addresses like below.

0 .. 0x00037ac000 ------------------- 0x00037ebfff, 0x00037ec000 -------
          |          ^            ^                                ^
          |   fofs   0            13568                            13568+128
          |       ------------------------------------------------------
          |   LBA    0x37e8aa9    0x37ebfa9                        0x37ec029
          --- map    0x3caa9      0x3ffa9

In this example, we should give the relative map of the target block device
ranging from 0x3caa9 to 0x3ffa9 where the length should be calculated by
0x37ebfff + 1 - 0x37ebfa9.

In the below equation, however, map->m_pblk was supposed to be the original
address instead of the one from the target block address.

 - map->m_len = min(map->m_len, dev->end_blk + 1 - map->m_pblk);

Cc: stable@vger.kernel.org
Fixes: 71f2c8206202 ("f2fs: multidevice: support direct IO")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ef38e62cda8f..775aa4f63aa3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1497,8 +1497,8 @@ static bool f2fs_map_blocks_cached(struct inode *inode,
 		struct f2fs_dev_info *dev = &sbi->devs[bidx];
 
 		map->m_bdev = dev->bdev;
-		map->m_pblk -= dev->start_blk;
 		map->m_len = min(map->m_len, dev->end_blk + 1 - map->m_pblk);
+		map->m_pblk -= dev->start_blk;
 	} else {
 		map->m_bdev = inode->i_sb->s_bdev;
 	}
-- 
2.51.0.710.ga91ca5db03-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
