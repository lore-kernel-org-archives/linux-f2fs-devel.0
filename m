Return-Path: <SRS0=JHSz=OA=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB90BC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Sep 2021 00:21:57 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B862760FE3
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Sep 2021 00:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B862760FE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mOUIn-0006pw-8B; Fri, 10 Sep 2021 00:21:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1mOUIl-0006pg-P4
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 10 Sep 2021 00:21:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C7BS6InU2OecS4CY+QXX7pIGKW4dPL5XGonXLSlV3qQ=; b=GkJRjnku3itRZw3TboA8EdyW8B
 a/UbuUjPlA3WsNneViC64KPneDGgjJkF75u7zd/37FvbhIQVyo108A4wJU0KRchBn/7iOT+OGen4B
 Hd8hn6U4k5FvBSxD0oPBxJco6Y/QjWoCMHIYzYjXNuLq2HrdODXZk5+PPaLioAp70rsI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=C7BS6InU2OecS4CY+QXX7pIGKW4dPL5XGonXLSlV3qQ=; b=GpUcVR3BobxBYaqyqd0lkMV0xO
 WcAlTnU6OFZmS2PLTesEKq6YAT7Y37gy6Oe8QPsiwFjMXI3qTzjWfaH1lJchUjLHXuKh/XjMb497Z
 4X7iK22hO755qCqbh1yI6DTGj9+A/lfv4B+BtyZKQY0imvIwhmrjwjEZtiCWjOg+4BA0=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mOUIl-0004em-8b
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 10 Sep 2021 00:21:55 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 497AB60FDA;
 Fri, 10 Sep 2021 00:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631233309;
 bh=n/v+KpbYLzu6XxAJStKkikqPZU9/FjMVaU997xlo8DE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ijpCvUtMrs5tgZq03MICO2EIdypY6YpRxCIsKyF7c2ALemgVrS0+xbEX3s4x2EDIS
 rka+nME+3X6SkC8hSQMLYybm7Ab1t4aXKi4IO+K8cZsovvn0WlNAHRlZkrkmK9RW0g
 lVPY3joUeNX/XZ3oE6hl6j6eHCw/AilQC9Ku5PRgi7l4yrwYB4dk6826FlyNvIGcSt
 6Fkg3audB2hSRKQsqnUztc4xcmHGDEDm8o7iEE0H145JP29NHq+AReWjhaxIRtAQae
 VwAs4i36KveGgCmo7gReyvJH/7OdnAFJsfJ2ohh+zfgROFOBpvdVi7BNenw1opIaKp
 RxGHxOcpIlVcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Thu,  9 Sep 2021 20:21:09 -0400
Message-Id: <20210910002143.175731-4-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210910002143.175731-1-sashal@kernel.org>
References: <20210910002143.175731-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-Headers-End: 1mOUIl-0004em-8b
Subject: [f2fs-dev] [PATCH AUTOSEL 5.4 04/37] f2fs: Revert "f2fs: Fix
 indefinite loop in f2fs_gc() v1"
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
Cc: Sasha Levin <sashal@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Jia Yang <jiayang5@huawei.com>

[ Upstream commit 10d0786b39b3b91c4fbf8c2926e97ab456a4eea1 ]

This reverts commit 957fa47823dfe449c5a15a944e4e7a299a6601db.

The patch "f2fs: Fix indefinite loop in f2fs_gc()" v1 and v4 are all
merged. Patch v4 is test info for patch v1. Patch v1 doesn't work and
may cause that sbi->cur_victim_sec can't be resetted to NULL_SEGNO,
which makes SSR unable to get segment of sbi->cur_victim_sec.
So it should be reverted.

The mails record:
[1] https://lore.kernel.org/linux-f2fs-devel/7288dcd4-b168-7656-d1af-7e2cafa4f720@huawei.com/T/
[2] https://lore.kernel.org/linux-f2fs-devel/20190809153653.GD93481@jaegeuk-macbookpro.roam.corp.google.com/T/

Signed-off-by: Jia Yang <jiayang5@huawei.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a78aa5480454..67e2b0de1ef4 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1332,7 +1332,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 		round++;
 	}
 
-	if (gc_type == FG_GC && seg_freed)
+	if (gc_type == FG_GC)
 		sbi->cur_victim_sec = NULL_SEGNO;
 
 	if (sync)
-- 
2.30.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
