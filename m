Return-Path: <SRS0=Ue33=ND=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024EEC4320A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Aug 2021 11:37:06 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD9C96104F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Aug 2021 11:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD9C96104F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mE91E-0002VX-4w; Thu, 12 Aug 2021 11:37:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <changfengnan@vivo.com>) id 1mE91C-0002VQ-Cy
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Aug 2021 11:37:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y/Y6PBBZlprVaQEV9jDayIJwVqvyw5Kun+gOsFVkv7E=; b=D9rrjfmo/IgKHeC4TJfuLZuiZp
 B8uTK1kZCaHg+72ftTtveYUF+Z0pCDOmA9X6tI1w4CvVdtN/b1sIvCWie3r314foJO979Vm3vMBvi
 7ZHlh9ycpYdw9DRZbP4ClJ0/oQAIoIvPnnVw5mHrysXYqFkAoyhAUpzPiiwfNJM1Uh40=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=y/Y6PBBZlprVaQEV9jDayIJwVqvyw5Kun+gOsFVkv7E=; b=E
 y1BK76cCoobWlUmYM8Hjqq6ht+Iy22hQQ8ahSfoKeOqEP2WgV8SSE58zTUYJ3JXfj3IEMWxauRCnf
 E8fsPh3/q+EEBgBhDuRoXChR8D3W3ofvzAHkqFQ5eRfBDniEWY9ujB3SBG5Y8joAZr8kbE+FuZ1F+
 wzdVD/QS5HNSw6as=;
Received: from mail-m17654.qiye.163.com ([59.111.176.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mE918-0043hU-SW
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Aug 2021 11:37:02 +0000
Received: from comdg01144017.vivo.xyz (unknown [218.104.188.164])
 by mail-m17654.qiye.163.com (Hmail) with ESMTPA id 31BB12021E;
 Thu, 12 Aug 2021 19:36:49 +0800 (CST)
From: Fengnan Chang <changfengnan@vivo.com>
To: jaegeuk@kernel.org, chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 12 Aug 2021 19:36:41 +0800
Message-Id: <20210812113641.217670-1-changfengnan@vivo.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
 kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRofShpWTx0YHRhOTxgZGk
 IdVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kxg6HDo4HT9JSBpKSiMoMkIJ
 Ny4KFChVSlVKTUlDTE1DSUtCTE5IVTMWGhIXVRgTGhUcHR4VHBUaFTsNEg0UVRgUFkVZV1kSC1lB
 WUlKQ1VKS09VSkNDVUpNT1lXWQgBWUFJSE5MNwY+
X-HM-Tid: 0a7b3a2689bdd9fdkuws31bb12021e
X-Headers-End: 1mE918-0043hU-SW
Subject: [f2fs-dev] [PATCH v5] f2fs: compress: avoid duplicate counting of
 valid blocks when read compressed file
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
Cc: Fengnan Chang <changfengnan@vivo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Since cluster is basic unit of compression, one cluster is compressed or
not, so we can calculate valid blocks only for first page in cluster,
the other pages just skip.

Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
---
 fs/f2fs/data.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index df5e8d8c654e..cec084806725 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2299,6 +2299,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 		.nr_rpages = 0,
 		.nr_cpages = 0,
 	};
+	pgoff_t nc_cluster_idx = NULL_CLUSTER;
 #endif
 	unsigned nr_pages = rac ? readahead_count(rac) : 1;
 	unsigned max_nr_pages = nr_pages;
@@ -2331,12 +2332,23 @@ static int f2fs_mpage_readpages(struct inode *inode,
 				if (ret)
 					goto set_error_page;
 			}
-			ret = f2fs_is_compressed_cluster(inode, page->index);
-			if (ret < 0)
-				goto set_error_page;
-			else if (!ret)
-				goto read_single_page;
+			if (cc.cluster_idx == NULL_CLUSTER) {
+				if (nc_cluster_idx ==
+					page->index >> cc.log_cluster_size) {
+					goto read_single_page;
+				}
+
+				ret = f2fs_is_compressed_cluster(inode, page->index);
+				if (ret < 0)
+					goto set_error_page;
+				else if (!ret) {
+					nc_cluster_idx =
+						page->index >> cc.log_cluster_size;
+					goto read_single_page;
+				}
 
+				nc_cluster_idx = NULL_CLUSTER;
+			}
 			ret = f2fs_init_compress_ctx(&cc);
 			if (ret)
 				goto set_error_page;
-- 
2.32.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
