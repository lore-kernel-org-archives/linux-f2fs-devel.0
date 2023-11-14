Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45C1C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 14 Nov 2023 21:24:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1r30to-0007Hs-2T;
	Tue, 14 Nov 2023 21:24:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1r30tc-0007Hj-91
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Nov 2023 21:24:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LuIPnnYr5TSO+onvsDHgfP1mjgy8YnI6AehTZ/YphVU=; b=alulw1elx3cSnYd+J1fSAVvhcd
 DlJmbvcw9O6E+nnYomXX+FMagHLo1UXj8YwJv8h+XOX4Zl8KwzNlDPqnQxFUeY7uPJr4/YtMWpzoO
 Gk19jUkFuEIMr79pRVbhJ3CrIOuaGR6eg7U/X63uElVLS5Q0FTK+rdDPoIOUxp85m/tM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LuIPnnYr5TSO+onvsDHgfP1mjgy8YnI6AehTZ/YphVU=; b=R
 1d34wYa18fcQ5PVRYa/A1+ZsE//yrzlBlWoTG7sqbFiO/IpG1/pnfY/MRr/zcBotj5g+vTjt+usV4
 m4VcCaFWsumWDrexvqcFDZFOMO7+IPK4AxU1UU1MsNkGgmotukMe61RlbbmhGuOlfxZXamiEln06W
 Dyg4Bgeuc4wZ+OHY=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1r30tW-0004pY-C3 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Nov 2023 21:24:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id D8310B81675
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 14 Nov 2023 21:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BCCC433C8;
 Tue, 14 Nov 2023 21:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1699997056;
 bh=Xg3Aq8eLknKwR53mKiNNcoHu3xpZPIqvXq+7lnhfHuE=;
 h=From:To:Cc:Subject:Date:From;
 b=KICe4scFNWNDvIMI8aCanOcqY/ivc4C1xjtVGG06F94sRN0kpvqyA2cZtgUiREMYM
 ExBjEfJLAJb/zJ/Aftrsy+DexxEps+vAiLUcHPqQUIHOjOyiOcQ/H7a6ZXqkORUiB8
 lkZqsQeiqKgV9WbEmQzZBYhZ+6p8d5vuo5mP8r7R+Q186yeOtRjxg7buYw4T+8uvEO
 WscsZfHi44cMJogwDcC77Eo74UXohsiQ6ECTVj7QBnWeaMPQCipBHnqJNrKfLrGpGg
 Vm0rpnsMaPL7q/O2UB2BmGYGouokvO7USre1sLHr0XIg4lhdTxjuFeoaw7E5LiJa2O
 QzKkJUDWBKE7g==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 14 Nov 2023 13:24:14 -0800
Message-ID: <20231114212414.3498074-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
MIME-Version: 1.0
X-Headers-End: 1r30tW-0004pY-C3
Subject: [f2fs-dev] [PATCH] f2fs: skip adding a discard command if exists
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

When recovering zoned UFS, sometimes we add the same zone to discard multiple
times. Simple workaround is to bypass adding it.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 727d016318f9..f4ffd64b44b2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1380,7 +1380,8 @@ static void __insert_discard_cmd(struct f2fs_sb_info *sbi,
 			p = &(*p)->rb_right;
 			leftmost = false;
 		} else {
-			f2fs_bug_on(sbi, 1);
+			/* Let's skip to add, if exists */
+			return;
 		}
 	}
 
-- 
2.43.0.rc0.421.g78406f8d94-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
