Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBC9C79F9F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Sep 2026 14:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=m/d6ySbxCfsUCE4jJRsrm9YICuD4ZoyxLoQIWlYAPDs=; b=KHNFnVoVNCEY+dldsN2ilOysP0
	2BQUsbVmoWFnEKDUUyzoO7ZDeuh8yF8npm3OirlImw3+/aruJ/2nyLon4SvPkOCKwfP2/BzmLrqaX
	f93IJ4swFfNmOEx0Ch6WANqT78CQiqwOCEzI/wrEnE7uWMUj3u554xNxOok36cfNs0AA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4fV7-0004wl-C5;
	Thu, 10 Sep 2026 14:11:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x4fV5-0004wZ-8h
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 14:11:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lLAqtjys13v8tLrbWLlIUVt/Fd351A9zIJ5wib7pFzk=; b=dsvoofxj1ac9jRdr0F546h7Yhn
 vk5WTfkQY03Y/SH3DW6eSV27aMs4J1Jdzc1k6MJwwoLbwVySjH10My9D+GlD440f9MkNCWHR0NWHa
 8NnF7HKmTPdsVq3+U7NteW+N9sS7/WmsUMj+a3IymKq1EBbGyGjpDrO3zZmX1T+Mg3oE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lLAqtjys13v8tLrbWLlIUVt/Fd351A9zIJ5wib7pFzk=; b=U
 DI1Fnp4qd8yscPr8NuCPx2UrbvBb+HWu8QM2J2E2q3SBOHMQVUvI98tyVpXX6novH7Yp098hsn0Cu
 yMioDwmc507UUddAaBI8twf34TqAyxbtetZn5PxdFismsJSGxBFpzqeYkbLkydG+JAundMlUFCjVm
 dm/7I6adj/4ttKmg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4fV4-0002hO-DH for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 14:11:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F0104408C0;
 Thu, 10 Sep 2026 14:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932041F000FF;
 Thu, 10 Sep 2026 14:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789049492;
 bh=lLAqtjys13v8tLrbWLlIUVt/Fd351A9zIJ5wib7pFzk=;
 h=From:To:Cc:Subject:Date;
 b=FQsyExdwj3+gfD/vJkurNxCcccf6ZwHpcfxTLN7KvYLmoL/SaFvLZAwDdIOMe2AQ7
 9EN0Ahc9ZsjmvSf4ZTcqWRkA8laqj7mPz1fDMDKfi90+STB2T4dRrYwrU3BVwWarDC
 5G/Bbmwmr7REdRhhQIEgASmhqv4LxW8p1Op3S+ypqhUBJmkN5NKjyFNhQUbwrv1RUn
 J687HNkvyuOpuYyRbWYaHx8SGdvQZk50GShHer1np1FMrdKLlr+lNaRJTCxOqm6PHt
 RdDFDYv/tZ4OA2lXUDwFPHxJym3Za1cBm0TUtFE2pYJJ4Aa5YCeeuIOwjVBEFStns8
 /xivgPQA4U6Sg==
To: jaegeuk@kernel.org
Date: Thu, 10 Sep 2026 22:11:26 +0800
Message-ID: <20260910141126.1309794-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
MIME-Version: 1.0
X-Headers-End: 1x4fV4-0002hO-DH
Subject: [f2fs-dev] [PATCH v2] f2fs: compress: fix to handle race between
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
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, stable@kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
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
Reviewed-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/compress.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index ce88092d9ce2..b71107604012 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1222,6 +1222,7 @@ int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
 	int i;
 	int err;
 
+repeat:
 	err = f2fs_is_compressed_cluster(inode, start_idx);
 	if (err < 0)
 		return err;
@@ -1233,12 +1234,11 @@ int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
 	/* truncate compressed cluster */
 	err = f2fs_prepare_compress_overwrite(inode, &pagep,
 						start_idx, &fsdata);
-
-	/* should not be a normal cluster */
-	f2fs_bug_on(F2FS_I_SB(inode), err == 0);
-
-	if (err <= 0)
+	if (err < 0)
 		return err;
+	else if (err == 0)
+		/* the cluster became non-compressed one due to race case */
+		goto repeat;
 
 	rpages = fsdata;
 
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
