Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EB6C7EE2C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Aug 2023 14:04:19 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qZXQC-00016z-ID;
	Fri, 25 Aug 2023 14:04:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hao.xu@linux.dev>) id 1qZXQB-00016o-8N
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Aug 2023 14:04:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZAHRQkTlH3B9Ayy3ByDVW6IFO8x4JKviNIiMKvNnRxw=; b=Hy4xaP4RBgwXCe1LEvolm6vBRP
 8AFoKpXRmgkT2sCxZFE3JjItoTuKIzHzEimc6rKRXACZuddiHDg1MKraP8JRW6q93RclbZ5RbSaqG
 Pt3qsaSxdvRsKuZuQVpnjRO38lsRQLTgv0ZrIF9D5a1SdOEFsvt26dCsrIgLHMux6PEs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZAHRQkTlH3B9Ayy3ByDVW6IFO8x4JKviNIiMKvNnRxw=; b=W3XZ4wZ0DAhS8LIA4MaSI//V85
 DzRZR6tozUhDOzLFKshR5SoqsHmqgasy77sLJ3RD7WxX1UqHNfFVcVcuvrpHOkQHvsQ7+aGugYTDH
 ZpMt8b13WMMKWJ9wtevcJUZ1IFi4r4lbq4E5dXLMohEizQRortPe79baqYCCHnwjIxHs=;
Received: from out-250.mta1.migadu.com ([95.215.58.250])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qZXQ9-0007i4-8t for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Aug 2023 14:04:18 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1692972248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZAHRQkTlH3B9Ayy3ByDVW6IFO8x4JKviNIiMKvNnRxw=;
 b=rqq9t63T1b93nHdvHPb4iPnifbVgNhCPhaGA0/+lVUtdq72oLevGN3oePkSOWgj4tFeMJO
 883BuPqR+igY5LuYYZDHjdap5mSmKgc54EL0giqHkQRTPmks0t1/1oKfHQU1t1pMyd2ThX
 7baCMPgFPzeqpA42kG/A+w1RFMlPw/c=
From: Hao Xu <hao.xu@linux.dev>
To: io-uring@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri, 25 Aug 2023 21:54:24 +0800
Message-Id: <20230825135431.1317785-23-hao.xu@linux.dev>
In-Reply-To: <20230825135431.1317785-1-hao.xu@linux.dev>
References: <20230825135431.1317785-1-hao.xu@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Headers-End: 1qZXQ9-0007i4-8t
Subject: [f2fs-dev] [PATCH 22/29] xfs: comment page allocation for nowait
 case in xfs_buf_find_insert()
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
Cc: Wanpeng Li <wanpengli@tencent.com>, "Darrick J . Wong" <djwong@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Stefan Roesch <shr@fb.com>, Clay Harris <bugs@claycon.org>,
 linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
 codalist@coda.cs.cmu.edu, cluster-devel@redhat.com, linux-cachefs@redhat.com,
 linux-ext4@vger.kernel.org, devel@lists.orangefs.org,
 linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-block@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org,
 samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
 bpf@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Hao Xu <howeyxu@tencent.com>

Add comments for page allocation in nowait case in xfs_buf_find_insert()

Signed-off-by: Hao Xu <howeyxu@tencent.com>
---
 fs/xfs/xfs_buf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index eb3cd7702545..57bdc4c5dde1 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -633,6 +633,8 @@ xfs_buf_find_insert(
 	 * allocate the memory from the heap to minimise memory usage. If we
 	 * can't get heap memory for these small buffers, we fall back to using
 	 * the page allocator.
+	 * xfs_buf_alloc_kmem may return -EAGAIN, let's not return it but turn
+	 * to page allocator as well.
 	 */
 	if (BBTOB(new_bp->b_length) >= PAGE_SIZE ||
 	    xfs_buf_alloc_kmem(new_bp, flags) < 0) {
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
