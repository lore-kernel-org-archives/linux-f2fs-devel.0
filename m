Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EFEE9A049
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 Feb 2026 01:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wFr+VP2Xwj8gEvsfWJeJAkN0jhYe2K7DxiMRe38UHMA=; b=lBYP0p6zg1t/5nRHgGIzS/20ir
	KJ8K6zMqEwN0MmvaerlCmLQ1JkCQOss04dg/6AOpi5OsO77zMYUMrmnqCkXKJLuS20MK16eLf1CRc
	WmzAfvM/ylwApUdJDHGlswKB17uFs5uAQSkm7551K4vCZcNqwNw1Et2Sne6gDVZlsU2M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vsW2U-0004nd-Ep;
	Wed, 18 Feb 2026 01:07:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1vsW2T-0004nX-4s
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Feb 2026 01:07:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tWrbmgpRiLzXZ9ITjMHKS1nYex7FN8+4+W3itHTUlpU=; b=EI0jl8VWJSKj6YIXJrYuR1Y79/
 PXZlg3mxwLTUtyMyP/D4aGthNCd8YCQmioeYWuFM8cwLJ+8xg9pds2YjY0dMmVYz4n9g3S/bEEtBo
 nsZLEwvkxSKFZZU+n3DO1lOwvdQOOU6LVsULIEGUEyHl0xRzjuL9M5w77UmihlR/86ps=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tWrbmgpRiLzXZ9ITjMHKS1nYex7FN8+4+W3itHTUlpU=; b=N
 1CZzEZDVQHcII7Gf2QGzxTxBwDYVuVnnYUtpPghZyn1tmuyy36CgNOr+whlLMHQUS4HF4ukiOn9Wa
 IVrPKrSXDIYs54QU0spbuqEOlOxZu+yv3lIvBjx44ExF/TZ5oIcpnHQP/qN2O7lG1T6ny3A4A+V8G
 /uFGBlnrQb5wOrks=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vsW2S-0003li-IE for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Feb 2026 01:07:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 36C29443F2;
 Wed, 18 Feb 2026 01:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D40C4CEF7;
 Wed, 18 Feb 2026 01:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771376846;
 bh=X/yfr8WHeaSkcZAFT81kIwzbFHKp17KQujASvuEnUZw=;
 h=From:To:Cc:Subject:Date:From;
 b=WbzbNl92alzjhUHtJoa1oJTeRoBkDtW804+fnYL+QtQH492kJT1uu2dvIY2jOncEB
 BUUqa/zR24ZYz5WaKq7dpvNFbOWNJ415LhpCs73TpTpm1wshlA03OLH/CNqSNvurPi
 Op5tdXe06unR/mY+AJzNjcLN9BjDdsuxR+yeGoHuVtSHIxM2MA2SJGFFx6y2nt+dJl
 Mmlc8q965nmfB6S7lha++CAw+15GCsPO3PVs92le649KXt9E9oV7ZAPv47irTVP+Yy
 K6wL4Y3TLZFvOIqSXGjzhpN7yKNG1geDNl4LRhVD+iU9+KcBvccN0zvQRcTtReFit+
 5yxLYp0Vb1zGA==
To: fsverity@lists.linux.dev
Date: Tue, 17 Feb 2026 17:06:27 -0800
Message-ID: <20260218010630.7407-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Headers-End: 1vsW2S-0003li-IE
Subject: [f2fs-dev] [PATCH v4 0/3] fsverity: remove fsverity_verify_page()
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This series removes the non-large-folio-aware function
fsverity_verify_page(), which is no longer needed.

Changed in v4:
    - Split ClearPageUptodate removal into a separate patch

Changed in v3:
    - Additional scope creep: verify the entire folio, switch to
      several more folio functions, and stop clearing PG_uptodate

Changed in v2:
    - Made one specific part of f2fs_verify_cluster() large-folio-aware

Eric Biggers (3):
  f2fs: remove unnecessary ClearPageUptodate in f2fs_verify_cluster()
  f2fs: make f2fs_verify_cluster() partially large-folio-aware
  fsverity: remove fsverity_verify_page()

 fs/f2fs/compress.c       | 11 +++++------
 fs/verity/verify.c       |  4 ++--
 include/linux/fsverity.h |  6 ------
 3 files changed, 7 insertions(+), 14 deletions(-)


base-commit: 64275e9fda3702bfb5ab3b95f7c2b9b414667164
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
