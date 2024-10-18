Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA98CD3C54C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 18 Oct 2024 06:26:58 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t1gRs-0006fg-RZ;
	Fri, 18 Oct 2024 06:26:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1t1gRr-0006fX-VI
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Oct 2024 06:26:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W4oWhutGt4EgCpIj5NVKahiwOGXeQI7gyWPoKAnn+tE=; b=bt+aqcXlDTLe5qN1Hh9YIWFpFu
 KdUtK43KPeBnRaL3OXW6tzcL6PvsOmSYqhsOxtOJcbA1lM630wUFgfRwdNEQgWZFrpTx+gja0zGJA
 ms2LjOlVDPOQyieZxmeY4/ZAhtLIp3gigz+yKWelENZ29Kj17gzGAoL6gif/7ZEi1st4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=W4oWhutGt4EgCpIj5NVKahiwOGXeQI7gyWPoKAnn+tE=; b=d83GsjeNJ8Qt8jC8FeLoFwpmT4
 k9oGnrhALH+wcv6Oz8duvEwePM3PDFYLBQyVp8vGQKuvFzWupfbs9wC90j5z5dSkb/UlsnSzaR516
 6zfEIT9A6sANKZ89dCiJgmcpmcFI3HUhCI1MQWowsvuUNgll/rxTYmH4s17B+fpl5moc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t1gRr-0005LO-Ai for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Oct 2024 06:26:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 84C4B5C5EC0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 18 Oct 2024 06:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B60AC4CECF;
 Fri, 18 Oct 2024 06:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729232809;
 bh=YDbEYfqH5QdtjigKgVD4ialWiRbwxPVZKrn1ldhPIkE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=K8jlWh+44XiVhSGiHFKsH8jsPXnXCnFNl4ojrKKfU8rPpQK8KWLVaq7ZyM2mESb7a
 T2l33YpKCdAqrgMO78A8mkqq9/epz38zcQdkKWER5s5k1RZbclnYWjNqshCarShtgc
 2STOsuK8jGm/bSfAP9mCg9aBW5vL6xnn7TuHimBq7PqKYoYnLMRHsZOjHunhz8QbFU
 5Vy4rx2uzM95z2lDKxPo1Ghot2tHozVK9yrCzwWNdJ83rxT+FyFQCrla6prY0/LWsu
 p6Yt3w6ArJFj/E4Y5xtN1jYgvqSVviFlzJnVkuOXA6DVnGU6iQpgyQ33GSHN57MNiu
 3cjW37nI5IF7Q==
To: jaegeuk@kernel.org
Date: Fri, 18 Oct 2024 14:26:37 +0800
Message-Id: <20241018062638.2619214-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241018062638.2619214-1-chao@kernel.org>
References: <20241018062638.2619214-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1t1gRr-0005LO-Ai
Subject: [f2fs-dev] [PATCH 2/3] f2fs: zone: allow IPU for regular file in
 regular block device
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

blkzoned feature enables lfs mode by default, for data updates from
regular file, it only allow to use OPU, this patch changes to allow
to use IPU if regular file's data block locates in regular block
device, if data block locates in zoned block device, it still uses
OPU.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 12 ++++++++++--
 fs/f2fs/f2fs.h |  5 +++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 949b6bb957c7..c6d0e4aa12e3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2648,8 +2648,16 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 		return false;
 	if (fio && is_sbi_flag_set(sbi, SBI_NEED_FSCK))
 		return true;
-	if (f2fs_lfs_mode(sbi))
-		return true;
+	if (f2fs_lfs_mode(sbi)) {
+		/* no regular block device in mainarea */
+		if (!f2fs_blkzoned_has_regular_section(sbi))
+			return true;
+		/* blkaddr locates in sequential zone */
+		if (fio && __is_valid_data_blkaddr(fio->old_blkaddr) &&
+			GET_SEGNO(sbi, fio->old_blkaddr) >=
+					sbi->first_zoned_segno)
+			return true;
+	}
 	if (S_ISDIR(inode->i_mode))
 		return true;
 	if (IS_NOQUOTA(inode))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 55bcd411257a..6781b4fab43f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4790,6 +4790,11 @@ static inline void f2fs_invalidate_internal_cache(struct f2fs_sb_info *sbi,
 	f2fs_invalidate_compress_page(sbi, blkaddr);
 }
 
+static inline bool f2fs_blkzoned_has_regular_section(struct f2fs_sb_info *sbi)
+{
+	return f2fs_sb_has_blkzoned(sbi) && sbi->first_zoned_segno;
+}
+
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
 #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
