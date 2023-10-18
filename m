Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0451ECDB47E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 Oct 2023 06:52:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qt0QA-0002rf-JG;
	Wed, 18 Oct 2023 06:52:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <Zhiguo.Niu@unisoc.com>) id 1qt0Q9-0002rZ-Aa
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Oct 2023 06:52:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iYzQhZWJn/nbGVXJffvQm1RZ6jrHzfVteFolX83VpOQ=; b=auRcmFjfOvaPVIqwjTEfVLSOkV
 6XHYTanIln5+RgdIN3FuCGoaZReMH69aYTD/tnvph7LnqE2ifJ1dvj3czAxxjaEuGVX1Ue2+b/ORk
 Ruv4JoSc9t7j8fJzNEKVqIPoDX7e9n/rbYhYRO/mQzyDVs8pWpN4+JAPvZaavl2stnm4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iYzQhZWJn/nbGVXJffvQm1RZ6jrHzfVteFolX83VpOQ=; b=D
 dX72vCKHNT3tqR8YuzvAQ45qjslnR6qV9zGV4avO+U0XjVIjPxacra5MEbUq+9FpSPUCTBdtntpEd
 LC42Uz5r9g5AkgMnNbItwXBCAHkw9qFuAzVrdtkRjtu3HbFemExoncftSnQlprrfA82tXdmkfWa8H
 KG+sxQhSaXh5EUEw=;
Received: from mx1.unisoc.com ([222.66.158.135] helo=SHSQR01.spreadtrum.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qt0Q8-001Jpa-8i for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Oct 2023 06:52:45 +0000
Received: from dlp.unisoc.com ([10.29.3.86])
 by SHSQR01.spreadtrum.com with ESMTP id 39I6q22d003506;
 Wed, 18 Oct 2023 14:52:02 +0800 (+08)
 (envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
 by dlp.unisoc.com (SkyGuard) with ESMTPS id 4S9LyD6mfQz2KFmlh;
 Wed, 18 Oct 2023 14:47:48 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 18 Oct 2023 14:51:59 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
Date: Wed, 18 Oct 2023 14:51:02 +0800
Message-ID: <1697611862-25239-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [10.0.73.87]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 39I6q22d003506
X-Headers-End: 1qt0Q8-001Jpa-8i
Subject: [f2fs-dev] [PATCH] f2fs: fix error handling of __get_node_page
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
Cc: zhiguo.niu@unisoc.com, niuzhiguo84@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Use f2fs_handle_error to record inconsistent node block error
and return -EFSCORRUPTED instead of -EINVAL.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/node.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 248764b..ed963c56 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1467,7 +1467,8 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 			  ofs_of_node(page), cpver_of_node(page),
 			  next_blkaddr_of_node(page));
 	set_sbi_flag(sbi, SBI_NEED_FSCK);
-	err = -EINVAL;
+	f2fs_handle_error(sbi, ERROR_INCONSISTENT_FOOTER);
+	err = -EFSCORRUPTED;
 out_err:
 	ClearPageUptodate(page);
 out_put_err:
-- 
1.9.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
