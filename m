Return-Path: <SRS0=92aX=WY=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4319C3A5A1
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:34:07 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AEC8208CB
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="fpFDTHPU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="JEHurMUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AEC8208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1i2uL9-0006PH-Ab; Wed, 28 Aug 2019 09:34:07 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1i2uL3-0006On-Rp
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Aug 2019 09:34:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QmngYB22lHHye7spz6ZnIB210vcpFU3nI8kXtsE8iAo=; b=fpFDTHPU6+k+3x+vPZ1CoMyf2Y
 VX9oXuloG4y6K7VGSOmrU+MOdGMfSdiAw+FiQyCg4PNHkzeMv3zS3EiILR+LvxDXr0LkwMjg5bjqz
 6TAoeN505YQPfTEn5cHX1agrJp2WoWuq0ZiGrFMiO8c3I1fFzM7cmkbyHS8wg2FX53Qc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QmngYB22lHHye7spz6ZnIB210vcpFU3nI8kXtsE8iAo=; b=JEHurMUPSRnRClMPpN2HeDrtwJ
 UCgvIn73SLr3/5ZVBVk1ygEPtkXoj3xSgun9mnskIW9RmWC5Pa30fFdKv/nIssgOlA4Qk0QkHS8jM
 HXOo29K4mj+zI+T7Ms1gyGz7mkSFSqAbA24HHwmK4plxCajgPUMX4XXmyetbMxSusvQw=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1i2uL1-000in6-Fk
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Aug 2019 09:34:01 +0000
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id B0EEFFD2F2F809C798B3;
 Wed, 28 Aug 2019 17:33:51 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Wed, 28 Aug 2019 17:33:41 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Wed, 28 Aug 2019 17:33:37 +0800
Message-ID: <20190828093338.29446-3-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20190828093338.29446-1-yuchao0@huawei.com>
References: <20190828093338.29446-1-yuchao0@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1i2uL1-000in6-Fk
Subject: [f2fs-dev] [PATCH 3/4] f2fs: fix to fallback to buffered IO in IO
 aligned mode
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

In LFS mode, we allow OPU for direct IO, however, we didn't consider
IO alignment feature, so direct IO can trigger unaligned IO, let's
just fallback to buffered IO to keep correct IO alignment semantics
in all places.

Fixes: f847c699cff3 ("f2fs: allow out-place-update for direct IO in LFS mode")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4b21ac42d44e..0522641c0c17 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3733,9 +3733,12 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 	 */
 	if (f2fs_sb_has_blkzoned(sbi))
 		return true;
-	if (test_opt(sbi, LFS) && (rw == WRITE) &&
-				block_unaligned_IO(inode, iocb, iter))
-		return true;
+	if (test_opt(sbi, LFS) && (rw == WRITE)) {
+		if (block_unaligned_IO(inode, iocb, iter))
+			return true;
+		if (F2FS_IO_ALIGNED(sbi))
+			return true;
+	}
 	if (is_sbi_flag_set(F2FS_I_SB(inode), SBI_CP_DISABLED) &&
 					!IS_SWAPFILE(inode))
 		return true;
-- 
2.18.0.rc1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
