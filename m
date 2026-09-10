Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4963C79FB6
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Sep 2026 02:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fVS8dDZT/4AlqDk6CRW3hTeHLNaCmQSPpi3QbiOAh2o=; b=LL3zd2hv8jMkbjW1crHR0qcITa
	1sQ7Q6MpvV/iFDacKnXS/COqcc5nvt2bch3vY1nJAAhtmfnAOQSF4HNgzYo229YXOgA/RSzus9Vq0
	4wHy3NYB9peWU1vsGWud4akP89H2DR9T1c4THbRYOeIJOtJTeTtL+x3DeKVVYsgPrBuQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4URb-0003Es-Rj;
	Thu, 10 Sep 2026 02:23:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x4URa-0003Em-LQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 02:23:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o0oj7nh9eRthVBf+tZ/MxSqTlPk5TjQhyQrW6C85nI0=; b=FjagTOLWisGfMypUYGI4x+GdJu
 7bIhUNEYXN1Pb6fPBYyw+1BLBEJWUMPWyHUJ05FlTCijdBUxuSiYaNMjePokH8jq1dp2aZLoQF4hX
 i9cN95/V7YuWEgTlztZjfsZBK5CLhm5g2BHqtSlAzawQONEF1KtzqSxhS+NpjrrMDpwo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=o0oj7nh9eRthVBf+tZ/MxSqTlPk5TjQhyQrW6C85nI0=; b=f
 3Iua/SheueiiMc68SRrWHjTfV0zYiguTBTcLH8W0f9WT4Dlq8F2/agiBYRhlE/6O7LWHhmNT2r/FW
 Ly5guAIEHuuaJKCISJ67KIT93pGmY3jqMMzMPDw/T4fvq9H/DV5IdEMoM+UHQLh/X8VdkA7X7ebH/
 u+6nZszT1D9ewf1k=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4URW-0007Fn-Mm for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 02:23:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 743A4601F0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 10 Sep 2026 02:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1E71F000FF;
 Thu, 10 Sep 2026 02:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789006988;
 bh=o0oj7nh9eRthVBf+tZ/MxSqTlPk5TjQhyQrW6C85nI0=;
 h=From:To:Cc:Subject:Date;
 b=KeZ+JwCu7dEybred9UTUBTLysnUWeM0YI1VCqTdEnFTiM3Y/xw89jQJ8BvgyMGCzH
 TS8fCpQ8NJ2nrNFdsbEGizMWXKVLwkbLSwnGPbWDodezxrF6Ydc4GHdtaQENZ34sRM
 aZkcgmR1NDWgm3vUseVeB1ArJ1VEaKDTcOqUNxojgwVwQ/A6Xaztaa/GwtV0+039Qj
 ScWP7y6OhcrRp8YDWyQ0AqaHRRRsIzf94Ma2XHjzOfn9Hw61ebDJnVObAruErT8jPZ
 wWnMHCA2NgaLrRxHMgZqvZWqWRyDQmMP7y6XIswUunhsGwb6WsaXnqe+WM6I4lY8NG
 yHMxPREU0ZNsA==
To: jaegeuk@kernel.org
Date: Thu, 10 Sep 2026 02:22:58 +0000
Message-ID: <20260910022258.3308187-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
MIME-Version: 1.0
X-Headers-End: 1x4URW-0007Fn-Mm
Subject: [f2fs-dev] [PATCH] f2fs: compress: fix to handle race between
 truncate and writeback
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
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

fsstress reports a kernel BUG in f2fs_truncate_partial_cluster():

kernel BUG at fs/f2fs/compress.c:1238!
RIP: 0010:f2fs_truncate_partial_cluster+0x292/0x2a0
Call Trace:
 <TASK>
 f2fs_truncate+0xf6/0x210
 f2fs_setattr+0x6b7/0x770
 notify_change+0x33b/0x520
 do_truncate+0xc2/0xf0
 vfs_truncate+0x153/0x1d0
 ksys_truncate+0x78/0xd0
 __x64_sys_truncate+0x16/0x20
 do_syscall_64+0xbe/0x540

The root cause is that Thread A (truncate) and Thread B (background
writeback or fsync) can race as follows:

Thread A                             Thread B
- f2fs_setattr
 - f2fs_truncate
  - f2fs_truncate_blocks
   - f2fs_truncate_partial_cluster
    - f2fs_is_compressed_cluster
      return 1
                                     - f2fs_write_cache_pages
                                      - f2fs_write_multi_pages
                                       - f2fs_write_raw_pages
                                        - f2fs_write_single_data_page
                                          dn.data_blkaddr != COMPRESS_ADDR
                                          (cluster converted to normal)
    - f2fs_prepare_compress_overwrite
     - f2fs_is_compressed_cluster
       return 0
     - return 0
    - f2fs_bug_on(sbi, err == 0): BUG!

Writeback path does not acquire i_gc_rwsem or filemap_invalidate_lock.
When a compressed cluster fails compression during writeback, it is
overwritten with raw data blocks. If Thread A checked
f2fs_is_compressed_cluster() before the conversion, but calls
f2fs_prepare_compress_overwrite() after the conversion,
f2fs_prepare_compress_overwrite() returns 0 because the cluster is no
longer a compressed cluster.

To fix this, remove the f2fs_bug_on() and retry checking the cluster status
when f2fs_prepare_compress_overwrite() returns 0, so that it can fall back
to f2fs_do_truncate_blocks() to handle it as a normal cluster.

Cc: stable@kernel.org
Fixes: 3265d3db1f16 ("f2fs: support partial truncation on compressed inode")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/compress.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index ce88092d9ce2..e1cc7185428e 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1222,6 +1222,7 @@ int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
 	int i;
 	int err;
 
+repeat:
 	err = f2fs_is_compressed_cluster(inode, start_idx);
 	if (err < 0)
 		return err;
@@ -1233,11 +1234,10 @@ int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
 	/* truncate compressed cluster */
 	err = f2fs_prepare_compress_overwrite(inode, &pagep,
 						start_idx, &fsdata);
+	if (err == 0)
+		goto repeat;
 
-	/* should not be a normal cluster */
-	f2fs_bug_on(F2FS_I_SB(inode), err == 0);
-
-	if (err <= 0)
+	if (err < 0)
 		return err;
 
 	rpages = fsdata;
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
