Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB29EE77188
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Jan 2025 18:19:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tVaeJ-0005Y0-E6;
	Wed, 08 Jan 2025 18:19:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1tVaeH-0005Xu-NK
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Jan 2025 18:19:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FFoOc/D0bc3cMRVuK6jExI+EHr43E2Z65yCO9tUapVQ=; b=YFrY5xIkPNvrwzPd0uZkVNP4G1
 zOlVnLIR6DgQg4CTPLjevqL1C/jzKRlxXWIchLRtm6KYAyvigFbFWk7+9m4Fb0CnAoZs0XJ6bcBpS
 3KJFOvaQabZIsMLkghFx6V3jlXncDhN++oP8NWzvUzavH6m4p4mYRHb2gJ2T14ij7oGI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FFoOc/D0bc3cMRVuK6jExI+EHr43E2Z65yCO9tUapVQ=; b=H
 eaDr95KCxxvcyOv/A3TnXQH+yeugdDG2Ys/ZtuwSlP3vRwRPM7ujcv7gHIpzwv+rksjh8R8w2f8z2
 kRhi2jFB66GcrcKFqbsiVm87Yta2fHfX1xxjvk0TCYGcnL7aJFmuM3FX4DqryBvcKPWzIWpI/gmAF
 Ru+E7Q0baTLIHq+s=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tVaeH-0006R1-2J for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Jan 2025 18:19:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id A619CA40EAE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  8 Jan 2025 18:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC09EC4CED3;
 Wed,  8 Jan 2025 18:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736360350;
 bh=8ckgbBwMKniwKd9OMfUyoVrJErDAYYC2Smo8nMzoVmw=;
 h=From:To:Cc:Subject:Date:From;
 b=Oa6dUHope68h1lBCSPUPnsHqEvFSzdahtMxjzij0cptzrgwqFx9lz/B9T6iZql2HO
 jfQPf5cnYyuwlFlKkaEZdzLbkFXXDoesMc6syAaKHc/Bjg9Qoni5Z0evdQktOmJPvM
 aaUrJeUiVNAUSdKz9tEwunz5WCUyERXUoQSg4A8RwaCQF90jORRSZEdwEg80cYWTIu
 1P84oHoK7ypU06df+udWzgJzSFhF0bOfULfUS3Rfl7LNBBGC38RybDwyZc4FsFASM6
 rfEMAKbbaSHrTmpsQreFL5JYR7Uc8Cm9q1GzgVem2EzSLxFwjxsROQPVTkJTpMHNPP
 1L+OqhMsGTJ2A==
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Wed,  8 Jan 2025 18:19:08 +0000
Message-ID: <20250108181908.4148111-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
MIME-Version: 1.0
X-Headers-End: 1tVaeH-0006R1-2J
Subject: [f2fs-dev] [PATCH] f2fs: remove blk_finish_plug
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Let's remove unclear blk_finish_plug.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 35b9455fb899..f681742ebecb 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -511,10 +511,6 @@ static void f2fs_submit_write_bio(struct f2fs_sb_info *sbi, struct bio *bio,
 				  enum page_type type)
 {
 	WARN_ON_ONCE(is_read_io(bio_op(bio)));
-
-	if (f2fs_lfs_mode(sbi) && current->plug && PAGE_TYPE_ON_MAIN(type))
-		blk_finish_plug(current->plug);
-
 	trace_f2fs_submit_write_bio(sbi->sb, type, bio);
 	iostat_update_submit_ctx(bio, type);
 	submit_bio(bio);
-- 
2.47.1.613.gc27f4b7a9f-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
