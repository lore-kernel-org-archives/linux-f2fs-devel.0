Return-Path: <SRS0=iwUc=I7=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B80CC433ED
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  2 Apr 2021 00:43:41 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1A94610E9;
	Fri,  2 Apr 2021 00:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A94610E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lS7uV-0004zI-1N; Fri, 02 Apr 2021 00:43:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1lS7uU-0004z7-5V
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 02 Apr 2021 00:43:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Wwpn0Hhu1K+f/ZqarUaQ9F7glr1MeT9c3lShxBFNqeg=; b=D8iP2CQvrJ/rvykLE23VDvVPuM
 sbalRhvWCJGrUDp+Cls3mqhAH0zvCJ4BUQf6htApcASg57fysz8HGsng/CkgPhMXU4Ad9AJ2G5vuJ
 k3/e7/xa5mVUqp1oCDrs04D3BzOSJ0R1Ny9WapRk3Mdof4gBrAe5XrCu9fIwrC3eygfI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Wwpn0Hhu1K+f/ZqarUaQ9F7glr1MeT9c3lShxBFNqeg=; b=U
 fPMn7aoWtxqaPBRiVZvuQcnXq2sf6vYsZlGYAOIGTc980JJ8u1u8EYFgXfj8LmqlyMdRJb+oQlPaI
 8wJHNirfFS0l3HLxAXhKQCNiFvGJADbjeyaINUZmUnVl9CvqC9Pne/DOAfBP2Jk/WHZB1ZwYH245C
 83gc54y09ERSrAKs=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lS7uF-0003Yp-SD
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 02 Apr 2021 00:43:38 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9409D61139;
 Fri,  2 Apr 2021 00:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617324156;
 bh=SPMgnl2lvjKL7Nrcau9zmsRqNKdUgqnXCr8UGhAzo9Y=;
 h=From:To:Cc:Subject:Date:From;
 b=sY/UaNb+etD7V3umzRPHbLO+NlxgkPixM8MEF4lv4MlTs8JuvJI+/85K8PHLF2pq/
 AD7DxDa22Lhy/PIEhM2dMXlUQX3dbXiU9UUg2fZhhnUAEMSmncI7Iz3iQxGkdoaDIg
 txppSVRcSHjpOwezLXfRvwu0A6wq2MYka4XEEZauS1r7i2kM7mlRIX7iZISucPX+0d
 brm3+/eW4JkRGJ2r2TH9RxGdkQvBafLmbmyo5B84VLqAQ1kazK8zGDnHXg+aXKaIM7
 PEji1wSPVK1GOnU9A98/8DPLmp/l+0zIS/ExykcpAzFlw5XOcrqgVO6SUk2XpdzPlc
 u56d6InQY5rQw==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Thu,  1 Apr 2021 17:42:25 -0700
Message-Id: <20210402004225.1677382-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
MIME-Version: 1.0
X-Headers-End: 1lS7uF-0003Yp-SD
Subject: [f2fs-dev] [PATCH] f2fs: set checkpoint_merge by default
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

Once we introduced checkpoint_merge, we've seen some contention w/o the option.
In order to avoid it, let's set it by default.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 14239e2b7ae7..c15800c3cdb1 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1839,6 +1839,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, EXTENT_CACHE);
 	set_opt(sbi, NOHEAP);
 	clear_opt(sbi, DISABLE_CHECKPOINT);
+	set_opt(sbi, MERGE_CHECKPOINT);
 	F2FS_OPTION(sbi).unusable_cap = 0;
 	sbi->sb->s_flags |= SB_LAZYTIME;
 	set_opt(sbi, FLUSH_MERGE);
-- 
2.31.0.208.g409f899ff0-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
