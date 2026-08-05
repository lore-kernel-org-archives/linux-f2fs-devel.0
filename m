Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3B0C55ABF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 12:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ws+geaiES46Ym/vToC3tWT5GK6A/efjvdHfx+PePlLA=; b=bfkeFsSvsFlcn4z+DCSKUqVrl+
	pGcos/b/fwVqsf1VbVo+CRgz59KlyprzJONbfisKYNl0JfyzgG8Y9Fvtz77xdS7d5iEM1MfnfQviu
	8qM0ATyiYEyCymSAFld8NbOyrtiRbuSGEqg/rOYEowv4d0G9FEepyWXEvuMDxUtOmIJY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrac0-0003Sh-Ne;
	Wed, 05 Aug 2026 12:20:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wrabk-0003SQ-4R
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 12:20:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BDAKUyxujDr9taO6Md8miTEaoxJXMva05Mkp+oddg5w=; b=Z5D3wQDt6KnfW95Lz0R4eSbXve
 iAaDCGjfh9MNEAqJVHMHOA+fXB7RNSBWXV7yLGq067Bq3aB3DdjSgNkw5x760zPpzctZ5glep55ln
 G6j2bZvt7L45xHuo/DepDdUk0hqbRVveA/EfOuKH5rfTpoFDDE7aDvMTtxO1gC3w+Zew=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BDAKUyxujDr9taO6Md8miTEaoxJXMva05Mkp+oddg5w=; b=W
 qHpTQjXTBlwtnXaRhtd7/kAqNaaALe6PicastJLhDqv2orKv4B9pWOiSxzConNey4yke5zEPQnFQ1
 4Y19N4bGIT5to8EC07BUjKtjilCMZ7yKmY1zpKAxBr39f4MCSmb8LZ2as+kksjC6z0iFFSS3WFhGj
 i4hcb+kfGkjE+yvs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrabj-0005y0-QP for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 12:20:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9250E60A79
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  5 Aug 2026 12:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400331F00A3E;
 Wed,  5 Aug 2026 12:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785932418;
 bh=BDAKUyxujDr9taO6Md8miTEaoxJXMva05Mkp+oddg5w=;
 h=From:To:Cc:Subject:Date;
 b=OAgohVDNwjK17UhWqLYTIqHn8Hd8AzZYyI/WbNLHr1BgQcec2dK8OAywJ+4OrKPy5
 V7SHjJZN0qkBsH++/E355+OtTpAJNNJIDx3+AR9+W5MC8CjMgEqaOZCnOhnki+UkZw
 7Gmi1ln+Ex03lcJDJzpX1U40mz/vrTUe9UhCE6wfzcYvBubZjZt1ZDX4If4Z4VtGAy
 HZzy+lcy14N0dFfIG2n+6KJVR/LpLiwS5Ea1bewbGarOS0ge46onv+KkRfdf2FnfjT
 aPyBCD7pNsZzdL46geJlGQk5uz3Cz0VbfkNXEOdb9T2KedFOFx81SKmtbXmcYHKGpV
 MFUeWsO888HKQ==
To: jaegeuk@kernel.org
Date: Wed,  5 Aug 2026 12:20:08 +0000
Message-ID: <20260805122008.664576-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
MIME-Version: 1.0
X-Headers-End: 1wrabj-0005y0-QP
Subject: [f2fs-dev] [PATCH] f2fs: fix to return -EFSCORRUPTED in
 f2fs_get_node_info() correctly
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

Otherwise, it will cache wrong nat info in cache.

Cc: stable@kernel.org
Fixes: 3cb396a2c790 ("f2fs: fix to do sanity check on nat entry of quota inode")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 38917e4a7319..9775fa90636a 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -660,6 +660,7 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
 			__builtin_return_address(0),
 			ni->ino, ni->nid, ni->blk_addr, ni->version, ni->flag);
 		f2fs_handle_error(sbi, ERROR_INCONSISTENT_NAT);
+		return -EFSCORRUPTED;
 	}
 
 	/* cache nat entry */
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
