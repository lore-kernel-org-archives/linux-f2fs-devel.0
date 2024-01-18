Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21E8C4707B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 18 Jan 2024 05:50:20 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rQLI9-0002X8-DB;
	Thu, 18 Jan 2024 05:50:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <Zhiguo.Niu@unisoc.com>) id 1rQLI6-0002X2-Of
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 18 Jan 2024 05:50:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bJTDG2W+IpQw4On63VaiPKbnP5F0lxlOX1RN6Rnrk2I=; b=CwbnupfB5OzWRIQdKEXtEON/95
 3G41+IIvUpdMi4qX2i6vp/7fuzHhRK7rvpkJKLYmBLPqRIyi1NVFg4vGcyquIUnlWi0TY37TAeZuI
 /CrDVK8r4kX+JvolevV8fBlyxLYE/qxFwzcGA2ElfG5iNVUnYzQ+7HtpZaOQcToGEwzM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bJTDG2W+IpQw4On63VaiPKbnP5F0lxlOX1RN6Rnrk2I=; b=m
 KOJi8KxUoxDvWzXF198PXKAjE35c1OnLPf55xRzhHCM/MCgz23N7TTOnsrYV0rHZQpvrAAmPEJtwz
 EqwE18Xh1+PbOzbGGlDFqYQZ+0StwLeSCtNbZs/f6djYfqUiDr6Dxezc/K+V5cCmSqAnF5EhakmlP
 EPlzi29WMve9wtXQ=;
Received: from mx1.unisoc.com ([222.66.158.135] helo=SHSQR01.spreadtrum.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rQLI0-0006ie-F2 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 18 Jan 2024 05:50:13 +0000
Received: from dlp.unisoc.com ([10.29.3.86])
 by SHSQR01.spreadtrum.com with ESMTP id 40I5nDeo046157;
 Thu, 18 Jan 2024 13:49:13 +0800 (+08)
 (envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
 by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TFs7t2BQSz2RRs0w;
 Thu, 18 Jan 2024 13:42:02 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 18 Jan 2024 13:49:11 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
Date: Thu, 18 Jan 2024 13:48:31 +0800
Message-ID: <1705556911-24117-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [10.0.73.87]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 40I5nDeo046157
X-Headers-End: 1rQLI0-0006ie-F2
Subject: [f2fs-dev] [PATCH] f2fs: compress: remove some redundant codes in
 f2fs_cache_compressed_page
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
Cc: ke.wang@unisoc.com, zhiguo.niu@unisoc.com, niuzhiguo84@gmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Just remove some redundant codes, no logic change.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/compress.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index ff26b49..624212d 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1889,12 +1889,8 @@ void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
 
 	set_page_private_data(cpage, ino);
 
-	if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE_READ))
-		goto out;
-
 	memcpy(page_address(cpage), page_address(page), PAGE_SIZE);
 	SetPageUptodate(cpage);
-out:
 	f2fs_put_page(cpage, 1);
 }
 
-- 
1.9.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
