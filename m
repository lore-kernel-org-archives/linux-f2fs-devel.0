Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB421C0015E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Jul 2023 15:37:20 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qJbu3-0003Mx-VD;
	Wed, 12 Jul 2023 15:37:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1qJbu2-0003Mm-9U
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Jul 2023 15:37:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=38qP+1kODye9qfaroRwtN/krv5NvSfk1Hm/pVS8TmHE=; b=dza4uGGPdzSOZZkehaycF1qaQl
 ZVHqTFxGqqyHo7INQcS/wkcooI6ck6L5DBBhzX44TY2Gt2T/pKBjS3G/O3ina2QwsITzTm1O0y6Uw
 V32q0LHOpLVPTUq5nu8jz2SOZ0Lql2A0KU9Gooy1mvURU+j6Rh7kcF8LR/qZGNX1d4QE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=38qP+1kODye9qfaroRwtN/krv5NvSfk1Hm/pVS8TmHE=; b=ewkeLA1Rln6gtTITtLQA7uHPTy
 IHiQ++g+D7oT0BhSSoL2FnP/ydFOFYMTa3pDEASP6Pf1iaLXmFUk0BolYGTjfjLBYssSdVxWk+5Af
 8AoDH/cbRMG3fTUcKA270TwRHbLalj12se4UYD7OyqkOT+Ns6w9sJLz6OT1PqgKOH3zc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qJbu0-005dH3-Mf for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Jul 2023 15:37:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B7AA461874
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Jul 2023 15:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D66CC433CB;
 Wed, 12 Jul 2023 15:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1689176227;
 bh=jc2J4H1tl9tgCU64obhJD7vtLmPv1NxjiyiMrRi0nP0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mMb3cYSHrRSH4npwBLyUFpiFCf1EvxpvrdF7v1oe5x+SeBU19wQisO1/uhLglhibD
 jX59ayIP7pKY5uwJ/JsHXg+/2frEze6FSnRNNXSTbP0pbB/Kkfer2aqk7cCU/o+gTW
 B5kkNtiiiEhHOHR0cKJLWGlQ8mSkrm68D9AzpeWq+43n8WAghRchJ9gTEj8UFpCB16
 ptIvBWqs22lSQEQ1fi8w4DZDiwrqrIed8Tj8I0eeuiouS+9Bu4F8KKHVyLSti4BT4c
 OHoYfi8SRmAIMvVrqO1wvTPzqelcuTO04eVtr68Ng2GVkmlJj260fid/JEsUazfDkq
 QUfE3Hpy7bTkg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Wed, 12 Jul 2023 04:08:06 +0800
Message-Id: <20230711200806.4884-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230711200806.4884-1-chao@kernel.org>
References: <20230711200806.4884-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1qJbu0-005dH3-Mf
Subject: [f2fs-dev] [PATCH 2/2] f2fs: compress: don't {,
 de}compress non-full cluster
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs won't compress non-full cluster in tail of file, let's skip
dirtying and rewrite such cluster during f2fs_ioc_{,de}compress_file.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 79cb6a41f128..74f79e7c8c02 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4092,10 +4092,8 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
 
 	count = last_idx - page_idx;
-	while (count) {
-		int len = min(cluster_size, count);
-
-		ret = redirty_blocks(inode, page_idx, len);
+	while (count && count >= cluster_size) {
+		ret = redirty_blocks(inode, page_idx, cluster_size);
 		if (ret < 0)
 			break;
 
@@ -4105,8 +4103,8 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 				break;
 		}
 
-		count -= len;
-		page_idx += len;
+		count -= cluster_size;
+		page_idx += cluster_size;
 
 		cond_resched();
 		if (fatal_signal_pending(current)) {
@@ -4172,10 +4170,8 @@ static int f2fs_ioc_compress_file(struct file *filp)
 	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
 
 	count = last_idx - page_idx;
-	while (count) {
-		int len = min(cluster_size, count);
-
-		ret = redirty_blocks(inode, page_idx, len);
+	while (count && count >= cluster_size) {
+		ret = redirty_blocks(inode, page_idx, cluster_size);
 		if (ret < 0)
 			break;
 
@@ -4185,8 +4181,8 @@ static int f2fs_ioc_compress_file(struct file *filp)
 				break;
 		}
 
-		count -= len;
-		page_idx += len;
+		count -= cluster_size;
+		page_idx += cluster_size;
 
 		cond_resched();
 		if (fatal_signal_pending(current)) {
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
