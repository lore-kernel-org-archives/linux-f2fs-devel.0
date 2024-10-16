Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2609D1AD24
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Oct 2024 08:14:06 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t0zAS-0007YW-Qa;
	Wed, 16 Oct 2024 08:14:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1t0zAK-0007Xh-GO
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Oct 2024 08:13:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cAXphR/REZqw2fy8/d/Y1G/NzeNxPvb0Dycb1fCAFi8=; b=KHEBO/21UrKTa9dw5i39Xqtzq8
 Eq8S9G/ZExLgnPZgQpIdDuR0zBNBTo3OFbVZyD5EzKgStcv1Mcb5rcat1BdtSR7tq59Md07aBd7ha
 GuvQkrq01qDxh/93ROKNCETy3UaI1yPwUOMD51QThrovs7IfHGLTEWHGUPEqvYIvscQA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cAXphR/REZqw2fy8/d/Y1G/NzeNxPvb0Dycb1fCAFi8=; b=G
 LCylzbqc1vJX0YUyi+p6urXiRGbFJnVviiWLC5nCilaPpmCeQWQw7xwchg9RW4q4RG2x0W3NXSKRA
 A6WIVpRoOthwMvM3bPShjBYPHmnNi79J2LFEioBIrGxIOzKuHaFXdDwfytq3VfU1/oRr5Pqq2PdwQ
 r+Y2+QseLOlBhZhk=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t0zAJ-0003cj-RK for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Oct 2024 08:13:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 17D355C0535;
 Wed, 16 Oct 2024 08:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1588C4CEC5;
 Wed, 16 Oct 2024 08:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729066430;
 bh=rmBpEhEVE7Cfx7/ProAaXt8OTkpq/W8XwrVpBLTEBaE=;
 h=From:To:Cc:Subject:Date:From;
 b=oQMz4nxjw8XiQMqw+jnIJ2KCrRngUSdK7bnkfdIXO9mQSS/8HctPkl61bB5jM9HaI
 V7Luh8sxwgdamIvfGCk+aAE1zMxmJQ04kbp57Gpveew1w0y4mxGwba7IQnGmq1+ggu
 vONY2hqqmYztjDluJBp4DWB6OQ7raYdT8hB4/RpRC6W82MxZY1Wv54NW4NMMM2yZZx
 5QimjJP6TH3QPTMmxqfYGJhzzotOtnIlo7d0YDsyvq3AMnNoMiwdjRkI3xxJX0E8G4
 +aTOseBks9euO3u0VZze2cP/iYC9MkrNuFNXKQk+rjaao5DYNkAX3V/5MggQCmZb0S
 KHuxH0A1laWvg==
To: jaegeuk@kernel.org
Date: Wed, 16 Oct 2024 16:13:37 +0800
Message-Id: <20241016081337.598979-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1t0zAJ-0003cj-RK
Subject: [f2fs-dev] [PATCH] f2fs: fix to do sanity check on node blkaddr in
 truncate_node()
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
Cc: syzbot+33379ce4ac76acf7d0c7@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

syzbot reports a f2fs bug as below:

------------[ cut here ]------------
kernel BUG at fs/f2fs/segment.c:2534!
RIP: 0010:f2fs_invalidate_blocks+0x35f/0x370 fs/f2fs/segment.c:2534
Call Trace:
 truncate_node+0x1ae/0x8c0 fs/f2fs/node.c:909
 f2fs_remove_inode_page+0x5c2/0x870 fs/f2fs/node.c:1288
 f2fs_evict_inode+0x879/0x15c0 fs/f2fs/inode.c:856
 evict+0x4e8/0x9b0 fs/inode.c:723
 f2fs_handle_failed_inode+0x271/0x2e0 fs/f2fs/inode.c:986
 f2fs_create+0x357/0x530 fs/f2fs/namei.c:394
 lookup_open fs/namei.c:3595 [inline]
 open_last_lookups fs/namei.c:3694 [inline]
 path_openat+0x1c03/0x3590 fs/namei.c:3930
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0010:f2fs_invalidate_blocks+0x35f/0x370 fs/f2fs/segment.c:2534

The root cause is: on a fuzzed image, blkaddr in nat entry may be
corrupted, then it will cause system panic when using it in
f2fs_invalidate_blocks(), to avoid this, let's add sanity check on
nat blkaddr in truncate_node().

Reported-by: syzbot+33379ce4ac76acf7d0c7@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/0000000000009a6cd706224ca720@google.com/
Cc: stable@vger.kernel.org
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 59b13ff243fa..af36c6d6542b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -905,6 +905,16 @@ static int truncate_node(struct dnode_of_data *dn)
 	if (err)
 		return err;
 
+	if (ni.blk_addr != NEW_ADDR &&
+		!f2fs_is_valid_blkaddr(sbi, ni.blk_addr, DATA_GENERIC_ENHANCE)) {
+		f2fs_err_ratelimited(sbi,
+			"nat entry is corrupted, run fsck to fix it, ino:%u, "
+			"nid:%u, blkaddr:%u", ni.ino, ni.nid, ni.blk_addr);
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		f2fs_handle_error(sbi, ERROR_INCONSISTENT_NAT);
+		return -EFSCORRUPTED;
+	}
+
 	/* Deallocate node address */
 	f2fs_invalidate_blocks(sbi, ni.blk_addr);
 	dec_valid_node_count(sbi, dn->inode, dn->nid == dn->inode->i_ino);
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
