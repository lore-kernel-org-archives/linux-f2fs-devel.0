Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531E1E68954
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 31 Oct 2024 06:00:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t6OEo-0004fG-Vx;
	Thu, 31 Oct 2024 06:00:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <Zhiguo.Niu@unisoc.com>) id 1t6OEn-0004fA-0v
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 31 Oct 2024 06:00:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UE/1sMJeXnGzAf4XnLEKGu6OzGvYw6Lc8o+ME1KBvFY=; b=kjeCQW5s6Y6J3FmjCOjtjmgEG2
 Pe+vUgLUlIPRQfYlOct/2TLvkV0WW8d2V6QL93YQOYBZuSLpuMNtWE+soIYduh1EnrCZpCTq42NWj
 HMgqMWk9Py/G9zzQx8XWVcWel+R2Y4jWu35tLExZZR/1Y3va/cwt79sptRd0Ysfekchw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UE/1sMJeXnGzAf4XnLEKGu6OzGvYw6Lc8o+ME1KBvFY=; b=hv+olvJObudEsjFOUthh+w6Ez8
 BwLUDDf+INGWnD6GeObPpXbUwH9EI3zrr9odCt1onN1TJqKf1fzvNix5thE0myJmRstl0jSaovyfk
 aGTjlGyfqRzyikngXutPqww8q/ejM2NlSikejYYhQgqtiZeys9wx6Ut87hba5LRHQLsE=;
Received: from mx1.unisoc.com ([222.66.158.135] helo=SHSQR01.spreadtrum.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t6OEm-00038O-22 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 31 Oct 2024 06:00:52 +0000
Received: from dlp.unisoc.com ([10.29.3.86])
 by SHSQR01.spreadtrum.com with ESMTP id 49V60FJl088526;
 Thu, 31 Oct 2024 14:00:15 +0800 (+08)
 (envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
 by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XfCxh4Zv5z2K4gjP;
 Thu, 31 Oct 2024 13:59:36 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 31 Oct 2024 14:00:13 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
Date: Thu, 31 Oct 2024 13:59:53 +0800
Message-ID: <1730354393-19672-2-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1730354393-19672-1-git-send-email-zhiguo.niu@unisoc.com>
References: <1730354393-19672-1-git-send-email-zhiguo.niu@unisoc.com>
MIME-Version: 1.0
X-Originating-IP: [10.0.73.87]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 49V60FJl088526
X-Headers-End: 1t6OEm-00038O-22
Subject: [f2fs-dev] [PATCH 2/2] f2fs: fix to adjust appropriate length for
 fiemap
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, zhiguo.niu@unisoc.com,
 Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

If user give a file size as "length" parameter for fiemap
operations, but this size is non-block size aligned,
it will show 2 segments fiemap results even this whole file
is contiguous on disk, such as the following results, please
note that this f2fs_io has been modified for testing.

 ./f2fs_io fiemap 0 19304 ylog/analyzer.py
Fiemap: offset = 0 len = 19304
        logical addr.    physical addr.   length           flags
0       0000000000000000 0000000020baa000 0000000000004000 00001000
1       0000000000004000 0000000020bae000 0000000000001000 00001001

after this patch:
 ./f2fs_io fiemap 0 19304 ylog/analyzer.py
Fiemap: offset = 0 len = 19304
	logical addr.    physical addr.   length           flags
0	0000000000000000 00000000315f3000 0000000000005000 00001000

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
f2fs_io has been modified for testing, the length for fiemap is
real file size, not block number
---
 fs/f2fs/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 90fa8ab..8c9bb42 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1966,8 +1966,8 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			goto out;
 	}
 
-	if (bytes_to_blks(inode, len) == 0)
-		len = blks_to_bytes(inode, 1);
+	if (len & (blks_to_bytes(inode, 1) - 1))
+		len = round_up(len, blks_to_bytes(inode, 1));
 
 	start_blk = bytes_to_blks(inode, start);
 	last_blk = bytes_to_blks(inode, start + len - 1);
-- 
1.9.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
