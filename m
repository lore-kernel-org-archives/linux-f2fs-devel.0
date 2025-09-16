Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BFCCAC599
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 Sep 2025 08:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=khdv/I7bXYTTf2We92LF3eUEH2GyEw3Dw0c7D8+21us=; b=kcnnjsCl+V9mUN6N2lvmJ9rlBV
	M0AlrNYjtJ2T7TUyjmQTkMcoYGY8B0UshruoPsB60fYUy5qohqmJpqPKOecO3J+LGOcnFLAm9fsJA
	L1JtOcs8YUC9EFwJfZ1QtFYyEC1AuWYtl5tdd/jpbgAgwNW0OP9c0SxcBlQputoc5Y/4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uyRQu-0005eE-EQ;
	Tue, 16 Sep 2025 08:53:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uyRQs-0005e7-QU
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Sep 2025 08:53:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cKpaRFQ97Kl1wHrpAfladZ68eRCth+EuYH4q+05TZ6o=; b=fQ9uusAX2syTEsOXjppI6P9UXG
 6zvSBQfYbPocfsak1Sue1qf+4S5vwwy9XxndRzd2EDaEG62XR66u7qx20jNZ38UAskVmM91EcYRX3
 6bTUa8z7K+Cq1QRD45/aVjUASLReV00CiHy7rD2zWIqP+c3qlehQTdVFHZUQ1FQyoyJA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cKpaRFQ97Kl1wHrpAfladZ68eRCth+EuYH4q+05TZ6o=; b=V
 bU/vtrB5b4T8uQFZAzFxxZJhRCfCMKn/v9j6NLVogVlP3kEgIP8g77afqpFvykvj5PMIuDy+xTjRE
 ww65XTKkPTrNGx2QDT+r2YH07n4xby/A/40coTENc9po1tFsrpLy4im9ZxCfgLdYlKg7WUaAj76fp
 pS9x7K/+y9OnlSuQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uyRQs-0000GP-EQ for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Sep 2025 08:53:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B5C3C6013D;
 Tue, 16 Sep 2025 08:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CE5C4CEEB;
 Tue, 16 Sep 2025 08:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758012771;
 bh=l+/RfK5g9GcKZEi3R7jcYPPpt2faVDSXRVeA7XJaeK4=;
 h=From:To:Cc:Subject:Date:From;
 b=UDIGtnuxXKhrcfFxMujVhMcCkz+lFOPx+UXHahOdQKUTYvwK5ib5XvpKX1DD/4YVr
 sKAtzo8vSa8l/0iIu13rpb2Mhs6urb5HWLHZaG8gpFtTj9AUzftvTB6Eu8XwJ6SH3x
 lK2h6cSUnNVzSRtrsfsm8cR0AUGNO2Y1YGbc/da8cHbLpN51FqVksa6ijWold2JeTy
 UqMpS858IUl8TGpQYbIPQoplKiqebGltNX3PIB7gp771vGxaJPJGFYl3Klv7MeN3Sk
 PfGPXrMTwYF+hHq5e8g5bmBHYVxvNAjn2IcX2yJUaU+EMle3fQbRynk7WWLnWp/BAi
 cAsSF97WaB8bw==
To: jaegeuk@kernel.org
Date: Tue, 16 Sep 2025 16:52:43 +0800
Message-ID: <20250916085243.4165099-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
MIME-Version: 1.0
X-Headers-End: 1uyRQs-0000GP-EQ
Subject: [f2fs-dev] [PATCH] f2fs: add sanity check on ei.len in
 __update_extent_tree_range()
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
Cc: wangzijie <wangzijie1@honor.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Add a sanity check in __update_extent_tree_range() to detect any
zero-sized extent update.

Signed-off-by: wangzijie <wangzijie1@honor.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/extent_cache.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 199c1e7a83ef..3070d1cb0676 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -664,6 +664,15 @@ static void __update_extent_tree_range(struct inode *inode,
 	if (!et)
 		return;
 
+	if (unlikely(len == 0)) {
+		f2fs_err_ratelimited(sbi, "%s: extent len is zero, type: %d, "
+			"extent [%u, %u, %u], age [%llu, %llu]",
+			__func__, type, tei->fofs, tei->blk, tei->len,
+			tei->age, tei->last_blocks);
+		f2fs_bug_on(sbi, 1);
+		return;
+	}
+
 	if (type == EX_READ)
 		trace_f2fs_update_read_extent_tree_range(inode, fofs, len,
 						tei->blk, 0);
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
