Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E583CC87FCB
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  4 Aug 2025 01:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HAIYDQaCV/MlGt3amOZYCHxtWfZQFCnxQ7kADScQAMA=; b=Rcl0/F8teQp+NcuGRb9tWHzLFG
	xXlBYtv7fzpS6koxWuy3ZuVvGTT6mB92/gWER6OIR6Au7r0hN7X5W1gaaXAg1SPAzAXNVaOXyT338
	7nL9oFLD1qP48aMblPavkhspY3UD9W1x6ANBRScDReE/Y8HtZVbrTSIdoiEc0MRIccvk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uikF3-0006I4-LF;
	Mon, 04 Aug 2025 01:43:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uikF1-0006Ht-RL
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Aug 2025 01:43:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Vaq9Yco3vTyBJ8qZvlsAf5lq3aFYkZW7PDRrVBSIqA4=; b=W56zBAFi/5IRlfrKXnXVrvidib
 V5hnwjQN5Sul5jN93fc9Ju/hl6dThwBFSB26XilwpizMzJMBR7q/37fjEGiWouLva5aVecKDILkeb
 /4tkdfIavR0ghzArwSeEYy5H1m4ZWtv38iI+YtOspcKnTnvH7VQSEQChN2/e8pz6HIIM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Vaq9Yco3vTyBJ8qZvlsAf5lq3aFYkZW7PDRrVBSIqA4=; b=G
 XGARJJLX7udeA2RrXk5tupsqZoWo8kCy75iZvhIuAjG95JdxV8MIhIYgGGsd37fD49e/EM0VlAzHb
 HfFuLuhim7GvS+Ah05w0zSl5LqciGK98BDt+TY+QZwFG+rk7eiJwtFrTPXuPUz+I8u831n87b9Di9
 SuYkyGmbN8HSz7uQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uikF1-00075y-DB for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Aug 2025 01:43:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0723F4588E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  4 Aug 2025 01:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF72C4CEF8;
 Mon,  4 Aug 2025 01:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1754271829;
 bh=nibfP85OrtQzeUHNPYnVq5ZQtUssf0yOK2wCjiWDsmE=;
 h=From:To:Cc:Subject:Date:From;
 b=iTSx3zh+gqf/MThibBenMuDDY61d02mzxXv15NFvfCjb41Dy525Sanmacot6ViukC
 H7YeVoPFALoZ49tP9dLou0gI8k+L9L9E9jAJY+X7NAYCL48NEjw3x/iuDLR0sERqmS
 ue6IMYDGhwLl0y8oIysX6MTKiCZihRRDrKXB9VwjN0sVFPdX/GanoMJV+6eJTms+YQ
 ZOH2aQxso4VEU3NhRqtIATB+uhpfVAfzsRPBG9y1T0CC38pfNZ7fAyCnDucur8TwQ0
 uCka/5mbpAS0qp5Ay8FplWM2mPz+seqAtfgACW1Seb3Odhqti4+/26PELhWt7+j8If
 04Dis7gDocDxA==
To: jaegeuk@kernel.org
Date: Mon,  4 Aug 2025 09:43:37 +0800
Message-ID: <20250804014340.2537172-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
MIME-Version: 1.0
X-Headers-End: 1uikF1-00075y-DB
Subject: [f2fs-dev] [PATCH v2 1/3] f2fs: fix to avoid overflow while left
 shift operation
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
