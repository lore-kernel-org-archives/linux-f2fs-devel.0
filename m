Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E761090222
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Mar 2026 13:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vTSNNVxPFHsi5UfrCIeGq0tqYInZP5Sod1zbfrXufDg=; b=cmsiCSG5ZrKRgTqYNHSwVwpRNd
	u9eHizCj9130UnH+RhTvV1Ld8QtnfnniKdEZjpME7/PeKmmZB7YYewyjHDuis04oJAwgeV7IaMWd2
	ABz6HcpSCZ9ndI5KsbV1H5coKWeZWqs5Vvl9mB6eCIvKh/WiKQkofd2EfhlFF/Wxh6Qc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w3DOU-0005OQ-7H;
	Thu, 19 Mar 2026 13:26:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1w3DOS-0005OK-TS
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Mar 2026 13:26:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z0hrsjPezAbUmzKvV7kNmpceMYIRiTllZHWg0HQ+PEM=; b=Xh7RBhm5sG3qY4RV9r2Opw4oc9
 5HoxXi2U9iGzDrQWLJ28yVL+LrLRcVC1n7r1kdmYDPPPssAAu94tNLHgPumyzLj9ETFhve4xNTUd/
 j/sj0vURxE+4KLQbwxciatqEhHQe3s2Hg3mc0MbYU8auadJ3JaxCR+jvOj184RokWvDo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Z0hrsjPezAbUmzKvV7kNmpceMYIRiTllZHWg0HQ+PEM=; b=E
 T7NmMdn+l1YNL/46Dl1jwI6lfp20OdLoBwplb61vkgd0NuHWb6p/9jIGz2A+8cAXaKOvO5JMF1vHT
 mRswlOKiPb9BBN6RNICBrj+Adh1jLPdHLXP6tRLP/LXBOsN34G6geY1nQc8XQ9dEhk/CaB1gUPjjf
 Ujj7Hnfn1BxePWYE=;
Received: from mail3-166.sinamail.sina.com.cn ([202.108.3.166])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w3DOR-0007LA-MV for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Mar 2026 13:26:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1773926791; bh=Z0hrsjPezAbUmzKvV7kNmpceMYIRiTllZHWg0HQ+PEM=;
 h=From:Subject:Date:Message-ID;
 b=aTtKabG8HYZMge8BN73BSbEwnKM3hbg7gpsvc0dKsYEXaT6kAKSIQVP/Fx5zZH9PP
 qbaaqoJeBKdLRK3kzPiZGrcp1eea8ZUSFYn5FMnhs29xF5TX6g9W7YKL/106WiPQdu
 0knCAV+I39GI0Y/XvLewEB9qhfzzbSJEZnnqgJks=
X-SMAIL-HELO: xiaomi-ThinkCentre-M760t.mioffice.cn
Received: from unknown (HELO
 xiaomi-ThinkCentre-M760t.mioffice.cn)([114.247.175.249])
 by sina.com (10.54.253.31) with ESMTP
 id 69BBF97600007AED; Thu, 19 Mar 2026 21:26:16 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 3963946816127
X-SMAIL-UIID: CBAD9171F54A4C03A4502F1DA56341D4-20260319-212616-1
From: Yongpeng Yang <monty_pavel@sina.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 19 Mar 2026 21:26:07 +0800
Message-ID: <20260319132607.686096-2-monty_pavel@sina.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1w3DOR-0007LA-MV
Subject: [f2fs-dev] [PATCH v3 1/2] f2fs: fix incorrect multidevice info in
 trace_f2fs_map_blocks()
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>, stable@kernel.org,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

When f2fs_map_blocks()->f2fs_map_blocks_cached() hits the read extent
cache, map->m_multidev_dio is not updated, which leads to incorrect
multidevice information being reported by trace_f2fs_map_blocks().

This patch updates map->m_multidev_dio in f2fs_map_blocks_cached() when
the read extent cache is hit.

Cc: stable@kernel.org
Fixes: 0094e98bd147 ("f2fs: factor a f2fs_map_blocks_cached helper")
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
v3:
- Add Fixes line and Cc to stable kernel.
---
 fs/f2fs/data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9ade0669d615..9e4db6f0508a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1576,7 +1576,8 @@ static bool f2fs_map_blocks_cached(struct inode *inode,
 		f2fs_wait_on_block_writeback_range(inode,
 					map->m_pblk, map->m_len);
 
-	if (f2fs_allow_multi_device_dio(sbi, flag)) {
+	map->m_multidev_dio = f2fs_allow_multi_device_dio(sbi, flag);
+	if (map->m_multidev_dio) {
 		int bidx = f2fs_target_device_index(sbi, map->m_pblk);
 		struct f2fs_dev_info *dev = &sbi->devs[bidx];
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
