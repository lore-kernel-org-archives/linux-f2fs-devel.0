Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EE7C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Jan 2022 03:48:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1n9fU7-0001as-5l; Tue, 18 Jan 2022 03:48:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1n9fU5-0001am-H6
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 18 Jan 2022 03:48:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UD69wSrU2xK+Na6HCyFOEwTPwpNxwu/cPE7AHLcMt4c=; b=aq1cIDJNjFWDUP99TPC1rnV0zA
 9+z1CPzGMOnIK8quAr1Zg9sWYwbI4PlmC3C88CGRnKY9yDDJk0Ij6G+fcbeeorr1QYDiST72gs8Lf
 dlg0D/PghfQzMglzrQwLpt0tjnBfWpG/sCxMENhzyvxMdMWAtf7rPF/KnD9XzokJL4FQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UD69wSrU2xK+Na6HCyFOEwTPwpNxwu/cPE7AHLcMt4c=; b=Q
 kgtCZ+q7s2QrWSmYK7ly4NgnMCcnQAiyPVayBoqFQn+vsftOuQv0aTZoeeJ6gowTJkG28+FjYbqZQ
 BSb+vGYxbYxCe5LAyln/GNqJs96ba93LOFQ2f1JljDnso3Lkh9tQXQsyj+QSsnCf9XcAh1VS0zguW
 qsYAb30Xw5U9oOms=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1n9fU3-0004dj-7c
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 18 Jan 2022 03:48:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 08507B811CE;
 Tue, 18 Jan 2022 03:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06943C00446;
 Tue, 18 Jan 2022 03:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642477707;
 bh=YMzf0J7TGo4osL4tfYFJ5TLiS5QRWtju4uRDZy0maY8=;
 h=From:To:Cc:Subject:Date:From;
 b=e0QlkVsgMKOtxE53nySgnELzDh5PRH9DzKxvVAhZue7sug5oBbmECyFumAvSsNOvY
 nDWukECWisT6AZt3VpkwCRP3coMrloRWzp9KOYr7Ce/Rj0GUmDPjuRx+ajFf4TDLnT
 tuonX5AOV6JzrBy3nt/UA9OoCFXhaXJ4uvOCCU26m54qvZeHQ8VJRvZf6ZgcvqYN4j
 BIdO7+oKuicFIp+zb1NqGYoycNmvg56UQhB6W7GkbVmp/7sM/Dcoz1U1LrYEJfIvWC
 e9yRUwxxxjPdqRBwMO4xDSqBPGwCzgttndOlIV5p6QNsj1HPyvE03v2D5W8osP3Kem
 X5Y//7Np9P9Sg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Tue, 18 Jan 2022 11:48:02 +0800
Message-Id: <20220118034802.98403-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1n9fU3-0004dj-7c
Subject: [f2fs-dev] [PATCH] f2fs: fix to enable ATGC correctly via gc_idle
 sysfs interface
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
Cc: Zhipeng Tan <tanzhipeng@hust.edu.cn>,
 Jicheng Shao <shaojicheng@hust.edu.cn>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

It needs to assign sbi->gc_mode with GC_IDLE_AT rather than GC_AT when
user tries to enable ATGC via gc_idle sysfs interface, fix it.

Fixes: 093749e296e2 ("f2fs: support age threshold based garbage collection")
Cc: Zhipeng Tan <tanzhipeng@hust.edu.cn>
Signed-off-by: Jicheng Shao <shaojicheng@hust.edu.cn>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index f8a14b1e2ef7..699f97610e8a 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -482,7 +482,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		} else if (t == GC_IDLE_AT) {
 			if (!sbi->am.atgc_enabled)
 				return -EINVAL;
-			sbi->gc_mode = GC_AT;
+			sbi->gc_mode = GC_IDLE_AT;
 		} else {
 			sbi->gc_mode = GC_NORMAL;
 		}
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
