Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF07C87FCA
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  2 Aug 2025 02:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HAIYDQaCV/MlGt3amOZYCHxtWfZQFCnxQ7kADScQAMA=; b=fX0vK1/MGU2Lxcupd9Py3SvmZl
	UH+M32Iuj/fUvzupIH4AthZj24j3kYX+B55E8Q2V7dxMhQDURyfYJ/d0vTZUEosOXoktVNa0K2bKo
	VqXyaPNzQYHZ6gSjI3LPvQ0r4Lds1f9M6Nblj2pOp9V9w6dde4xgk0Y9vWIhGzevsgVw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ui1pd-0000gQ-Um;
	Sat, 02 Aug 2025 02:18:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ui1pc-0000gK-MA
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 02 Aug 2025 02:18:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Vaq9Yco3vTyBJ8qZvlsAf5lq3aFYkZW7PDRrVBSIqA4=; b=BjRybNlkOT/bRWL+T5TlUWBedu
 uJeSmYoJHEzfLBs80H9T3PJgs8NXBzWpjiig0NIqphP7Nus/31SElyIu5CtL81xeJGO4rTYMxGi6u
 Nk9JSMvJn1mlIlCSN1zaXUQYbuZDIKbr4jUYBGm0Y4JOvmQRam4PyEeQsf1EDNwHyXuk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Vaq9Yco3vTyBJ8qZvlsAf5lq3aFYkZW7PDRrVBSIqA4=; b=I
 DurNEL8q/4svmo5f2l2YwxPpDkBon4HN54Fzbe5QETb/Yx9Ry+h6h1xJ/VopKchhUg0zNxPJoqQRn
 0qhvHfxHHIFebun2RrwAsa1qZyLXQfhV5CEg9EHF7yEh6fcCIu8fMUV0Na5C2JY241YbauMblm+Nu
 2x3QkIcaofb9UyBQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ui1pc-00039P-Ac for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 02 Aug 2025 02:18:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id BACC240C0F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat,  2 Aug 2025 02:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808E1C4CEE7;
 Sat,  2 Aug 2025 02:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1754101118;
 bh=nibfP85OrtQzeUHNPYnVq5ZQtUssf0yOK2wCjiWDsmE=;
 h=From:To:Cc:Subject:Date:From;
 b=bWU7vWbimIMVndFC530TTgufAznJTWo+RTd6VsHaXB5mUuDa8fFH9Ozg14b9l9QMk
 bOOldw1HYVehhVtm/iyEOQJt+AqgfhtnaGgq9TCWe7uOdjF+3bpDp4O49jviccgUQ0
 vj0O6h4+iy5i2f5IgHGuu+aWOuTWhWxgj2Kt2jGWkB0AVL5Bq2CZsEDmIq3Ex+hjBo
 IdzqXTll8CW+WEXjkcNOwbch3Ko1YT2oLlVa2UD9fuSOtsddEtFAKeNNuMXiLmQScu
 yekkwBLGksZJCuTAwoMSUJJ+MzB+WOIHsU3HjSLyziRrCnbLGTuorlfL+lf4HAlI5Z
 tGxTEKGLZ3gZg==
To: jaegeuk@kernel.org
Date: Sat,  2 Aug 2025 10:18:30 +0800
Message-ID: <20250802021832.1882302-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
MIME-Version: 1.0
X-Headers-End: 1ui1pc-00039P-Ac
Subject: [f2fs-dev] [PATCH 1/3] f2fs: fix to avoid overflow while left shift
 operation
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Should cast type of folio->index from pgoff_t to loff_t to avoid overflow
while left shift operation.

Fixes: 3265d3db1f16 ("f2fs: support partial truncation on compressed inode")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 5c1f47e45dab..6cd8902849cf 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1245,7 +1245,7 @@ int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
 
 		for (i = cluster_size - 1; i >= 0; i--) {
 			struct folio *folio = page_folio(rpages[i]);
-			loff_t start = folio->index << PAGE_SHIFT;
+			loff_t start = (loff_t)folio->index << PAGE_SHIFT;
 
 			if (from <= start) {
 				folio_zero_segment(folio, 0, folio_size(folio));
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
