Return-Path: <SRS0=Klf2=NC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB831C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Aug 2021 08:40:26 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78BEB60F41
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Aug 2021 08:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 78BEB60F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mDjmi-0005Ku-Q2; Wed, 11 Aug 2021 08:40:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <changfengnan@vivo.com>) id 1mDjmg-0005Km-J4
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Aug 2021 08:40:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v7/5rwPCBeYNXAK3S3rBMBT+HQizS4snKCLC4735Pa4=; b=mbBfcNJ6axq1+nrqCbbtuVR+pw
 J6ydVUNRm09ALr8VI6j0c34B4mcddZFie0X4EJ31TuG6bGQIjop27ZlztEgeG0L0mNbQCPnO3jTGx
 AHvm8TDMnz5/2Jexc/DBClmU2+1VcJmG6m9rjUvWxeI1jfWV3BEQVxhl5+q+AId+2xTk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=v7/5rwPCBeYNXAK3S3rBMBT+HQizS4snKCLC4735Pa4=; b=L
 Bo88LQ0jFMFuYhPjL0UYMFtoF7tSAzNP9JQ/o8Zn6ZGJcxHmZDa9heICpebshvlLXUROzk7bp3WHY
 ULTarIsW//Qsk5J+QHOWafsApW/aM6woS4wxtiuQtHvcsVFg+6HpJG6zwDSSDTnn4uMbwvdMEFjfd
 ULyFf2YsLm6V0oP4=;
Received: from mail-m17654.qiye.163.com ([59.111.176.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mDjmb-0003RD-5m
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Aug 2021 08:40:22 +0000
Received: from comdg01144017.vivo.xyz (unknown [218.104.188.164])
 by mail-m17654.qiye.163.com (Hmail) with ESMTPA id 4BDEA201D5;
 Wed, 11 Aug 2021 16:40:06 +0800 (CST)
From: Fengnan Chang <changfengnan@vivo.com>
To: jaegeuk@kernel.org, chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 11 Aug 2021 16:40:04 +0800
Message-Id: <20210811084004.3664-1-changfengnan@vivo.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
 kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRofTU5WTEkdSUJLGh5LGU
 hOVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRQ6ARw6SD9KNSMaHxovIjEx
 MggaCx1VSlVKTUlDTUxKSUtNQ0NCVTMWGhIXVRgTGhUcHR4VHBUaFTsNEg0UVRgUFkVZV1kSC1lB
 WUlKQ1VKS09VSkNDVUpNT1lXWQgBWUFIT0xONwY+
X-HM-Tid: 0a7b345e642cd9fdkuws4bdea201d5
X-Headers-End: 1mDjmb-0003RD-5m
Subject: [f2fs-dev] [PATCH v2] f2fs: compress: avoid duplicate counting of
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
 fs/f2fs/compress.c |  1 +
 fs/f2fs/data.c     | 21 ++++++++++++++++-----
 fs/f2fs/f2fs.h     |  1 +
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 7dbfd6965b97..71768f15752a 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -152,6 +152,7 @@ void f2fs_destroy_compress_ctx(struct compress_ctx *cc, bool reuse)
 	cc->rpages = NULL;
 	cc->nr_rpages = 0;
 	cc->nr_cpages = 0;
+	cc->nc_cluster_idx = NULL_CLUSTER;
 	if (!reuse)
 		cc->cluster_idx = NULL_CLUSTER;
 }
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index df5e8d8c654e..3ee1a88d8400 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2294,6 +2294,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 		.log_cluster_size = F2FS_I(inode)->i_log_cluster_size,
 		.cluster_size = F2FS_I(inode)->i_cluster_size,
 		.cluster_idx = NULL_CLUSTER,
+		.nc_cluster_idx = NULL_CLUSTER,
 		.rpages = NULL,
 		.cpages = NULL,
 		.nr_rpages = 0,
@@ -2331,12 +2332,22 @@ static int f2fs_mpage_readpages(struct inode *inode,
 				if (ret)
 					goto set_error_page;
 			}
-			ret = f2fs_is_compressed_cluster(inode, page->index);
-			if (ret < 0)
-				goto set_error_page;
-			else if (!ret)
-				goto read_single_page;
+			if (cc.cluster_idx == NULL_CLUSTER) {
+				if (cc.nc_cluster_idx != NULL_CLUSTER &&
+					cc.nc_cluster_idx == page->index >> cc.log_cluster_size) {
+					goto read_single_page;
+				}
+
+				ret = f2fs_is_compressed_cluster(inode, page->index);
+				if (ret < 0)
+					goto set_error_page;
+				else if (!ret) {
+					cc.nc_cluster_idx = page->index >> cc.log_cluster_size;
+					goto read_single_page;
+				}
 
+				cc.nc_cluster_idx = NULL_CLUSTER;
+			}
 			ret = f2fs_init_compress_ctx(&cc);
 			if (ret)
 				goto set_error_page;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e97b4d8c5efc..e9b6890a3f19 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1471,6 +1471,7 @@ struct compress_data {
 struct compress_ctx {
 	struct inode *inode;		/* inode the context belong to */
 	pgoff_t cluster_idx;		/* cluster index number */
+	pgoff_t nc_cluster_idx;		/* cluster index number for non-compressed cluster use*/
 	unsigned int cluster_size;	/* page count in cluster */
 	unsigned int log_cluster_size;	/* log of cluster size */
 	struct page **rpages;		/* pages store raw data in cluster */
-- 
2.32.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
