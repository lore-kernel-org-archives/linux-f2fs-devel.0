Return-Path: <SRS0=weNy=KU=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4023DC47086
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 May 2021 20:50:21 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3DF06140B;
	Tue, 25 May 2021 20:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3DF06140B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lle0J-0000PU-Px; Tue, 25 May 2021 20:50:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1lle09-0000O9-Tm
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 25 May 2021 20:50:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vK16TajSWSWt8KZai0G6GLFprkniDqQQUNF3YiQCuSI=; b=RQPNz9A2oseUsPlt2FHWHzfcHs
 TT6uVCC8YmcxhsQnOVwXc2Xy5DeOq1SRdWLT8GV/7DeZIlewxid0loK7u8+90lDuAIxnRR1B6bJPX
 o59YI6miqNns4CQumJ1Mhi4fJ0TumnttGIke7ql/3YSWUvZoLG3kIePmVZILF13IDSsg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vK16TajSWSWt8KZai0G6GLFprkniDqQQUNF3YiQCuSI=; b=F
 ejFUN3ev0pknsB8Pnmd+Ss7TmBi7tS+dFSNMRTEhTycnVAXZkrQ0840cQfFYfFfQlrQT4AKjdqBVT
 Yq1DlprG/L2B4o61i8+NTglUC5EwntMTANq4LQPp/uov07bFmID2f46DzhiOnuubMyA+Q/USvNoqQ
 EoXD0mznmlNGOLsQ=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lle03-00035I-8R
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 25 May 2021 20:50:09 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5FAF6140B;
 Tue, 25 May 2021 20:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621975798;
 bh=geFDm1hfESSrv4FhIDHlYbHKdE/pWgZd003DvoGhi84=;
 h=From:To:Cc:Subject:Date:From;
 b=EzTDQ3bin0jBFm0kogkX3AOwC4klpfJI9abSvGhy3mQntOCmug8Pr5WGB6TjFRLhE
 m745FlJkrhmKcYOlokMzRj0y8dpRZvo0IOdfmsN9mJZufVHeiPTqeMd/DPzL+eVVsW
 WSNFbenV3sR9BoyXCN/78tFNQp01Lo4WQTc3TpYm9lCPeLcpX4jdB2mocBOc+bG/lk
 M3AB1gwisdJs6KBlIyoc/SLpLCfsqyxnkXEKEYmeCNB6xUScNDwEm8FhmiDfIwU6iH
 QqxDfmHe181alL7nQRBpv4Unoy1LbT4xE8fdkK9CcEUagMalJk0Sh6OUKlEvoxSzkz
 HeY6Kc4ZoseWw==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 25 May 2021 13:49:54 -0700
Message-Id: <20210525204955.2512409-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
MIME-Version: 1.0
X-Headers-End: 1lle03-00035I-8R
Subject: [f2fs-dev] [PATCH 1/2] f2fs: let's allow compression for mmap files
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch allows to compress mmap files. E.g., for so files.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/compress.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 1189740aa141..bec92ff5ee7d 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -955,8 +955,6 @@ static bool cluster_may_compress(struct compress_ctx *cc)
 		return false;
 	if (f2fs_is_atomic_file(cc->inode))
 		return false;
-	if (f2fs_is_mmap_file(cc->inode))
-		return false;
 	if (!f2fs_cluster_is_full(cc))
 		return false;
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(cc->inode))))
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
