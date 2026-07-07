Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F8FC44500
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8KLU6a7gcPiOyNYi3Za1tzCGQ2vYT560CSko9cw8f0U=; b=iHnIh0p+/mulb+N0mo3Qw5ZLxr
	LvwInmqSWgTAkX9e4e1aCWDI6hQXWNGQPr5Tlgpoe0Q6vyS7hXPYNPSC8s1HgsdTXr7pnnZLgkYjC
	ivwem6lpL/5Q69DtHRhPeUqC0U1eZcyHWAtCtIdLDwdmS93US3E1ybmfHnctlG++k6DU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wh49g-0008PW-24;
	Tue, 07 Jul 2026 11:40:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wh49e-0008PN-LS
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Jul 2026 11:39:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xpG7zF2XtrUQxf5E81O8+yc7rNhR3bN8KjXT1FV1NCo=; b=KVA7R3ok2KIr6Z6/4hkjdWOnMf
 QNNUzxfntEyubhmixjRg683oi0ngqEfpXSpEXb6bNOnkIDeSfmPcBdXZ9GciKn2CmN/Pt89csyN5i
 ybqzDMQO4XN8GQqK6juAwRYv3cm1E+Lvp78Ey70zG6o8R1dN9+CArqJ4H77FSar/yLnk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xpG7zF2XtrUQxf5E81O8+yc7rNhR3bN8KjXT1FV1NCo=; b=kpNRNGPQ5ITK0wGVCoTTb8WiTC
 1XUKAa3nYMJKyzs/MNKAWyAXkoSwtYsUVdxcg4G5cIBUoUO+ExB5eiRAoruqZCic6UVSUkQGnL+m8
 MLmzaI9mQ3Is25qovqXy7jJoBLMzZB4pgw1XVng4aJf+VlAusQUMnIjpbAlTWiaRF1S8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wh49c-00052B-Sr for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Jul 2026 11:39:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CB554618B0;
 Tue,  7 Jul 2026 11:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADAD1F00A3A;
 Tue,  7 Jul 2026 11:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783424386;
 bh=xpG7zF2XtrUQxf5E81O8+yc7rNhR3bN8KjXT1FV1NCo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QsmyTKhakPVGBz/7sYQ1hi2DjLP8CNqTRHJuZwUuM5puMBES8umhGzyg4/Y6YOqnw
 0pmJARfb0DT0Zuf42iRp5CokIqSjhE4cttQJsdtb3EXgF/rhAcyw+vK+1f/ouyio+A
 Qaowud/6PwnxzBpOhKwu2D3ey6wCUvFVQSOIBfLSfKoUCOXkgJt/S2fC1/0iUnAxdZ
 F//yMiIEn1gVfqh6ZNpnEHCztGCXaYECaPfZ2rY6KRC0KWdUyo3QGRZ69c+OBPc2wh
 sr9Ssf69dQh2l0Pr8/t2druUSbObRjMt62XZWlc+NgFaDj3Nr6thAVp1KdvKp5CMmd
 6nqihuTnl5Xtw==
To: jaegeuk@kernel.org
Date: Tue,  7 Jul 2026 19:39:34 +0800
Message-ID: <20260707113934.3003158-2-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
In-Reply-To: <20260707113934.3003158-1-chao@kernel.org>
References: <20260707113934.3003158-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wh49c-00052B-Sr
Subject: [f2fs-dev] [PATCH v2 2/2] f2fs: drop FGP_NOFS in f2fs_write_begin()
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
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch proposes to drop FGP_NOFS from f2fs_filemap_get_folio()
in f2fs_write_begin(), I don't see there is potential deadlock issue
when __filemap_get_folio() calling into filesystem reclaim interfaces,
e.g. .writepages, evict_inode, shrinker.

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- just drop FGP_NOFS rather than use memalloc_nofs_* helpers.
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ac1cf4de3d62..be4c1d4ed6b2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3994,7 +3994,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	 * Will wait that below with our IO control.
 	 */
 	folio = f2fs_filemap_get_folio(mapping, index,
-				FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_NOFS,
+				FGP_LOCK | FGP_WRITE | FGP_CREAT,
 				mapping_gfp_mask(mapping));
 	if (IS_ERR(folio)) {
 		err = PTR_ERR(folio);
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
