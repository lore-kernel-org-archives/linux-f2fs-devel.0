Return-Path: <SRS0=DLtH=EC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45DAC2D0A3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 27 Oct 2020 00:11:01 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B14020754;
	Tue, 27 Oct 2020 00:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="EFFyFZ/3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="BKuBDuAb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTvDtOMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B14020754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kXCZo-0002Gt-Jw; Tue, 27 Oct 2020 00:11:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1kXCZm-0002Gl-Or
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Oct 2020 00:10:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ojH4olxxeezmrjwX+Q7owAjQvG5FLwN9oIZ7gKusuK0=; b=EFFyFZ/3L1Qs38cG3mkRqX27n4
 l6V9n9tG32WnktvY0pRQHt80lv5yLsS+Nv4xCQ1Z63qYnIGO9gwYJCLGE5ramYIjSqS3VsasbvM1Y
 NWw01o63J0Q3Pi/nOIfizQ54nWipXXujmUzIk1U1rCjCdTAYuMAp5WhNCdCJ8cFKUREY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ojH4olxxeezmrjwX+Q7owAjQvG5FLwN9oIZ7gKusuK0=; b=BKuBDuAbqRhHOe7APWIQEHPTcD
 RqhGwqIHm3h3uxR7NrUNkC5twNz5Y8BKlbSN3BnRZrUkqJI41YpNrDnVqiBuqyD1krd94Y6gouyXG
 oD8qXrrQZBKvaFZW23iO4XHHdT/TLb9/AJIu2/SP34nK/xMnasedKZt7TuLRU2kp3DQI=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kXCZj-008DAh-6t
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Oct 2020 00:10:58 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2D04C218AC;
 Tue, 27 Oct 2020 00:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603757449;
 bh=2VHM0s3UGyJ1I4JvIiHynEIil4VKfhimv7JJCAe7QMo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XTvDtOMuHjEW7vBxKP+tIquEodTwV/8Bj8DlcjgXskaErVe7D5aSM+u+T7aJc9K9I
 8eP+ppXZU6crpM9BvHUVL25OSRP8s/kk6jlZOe1jTCU7b5ugwm4rQ5Dzura9p5XDQQ
 k9qPugg30urfXTQ79Z9YlAbXLjlOpCCwgHXNj048=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Mon, 26 Oct 2020 20:10:18 -0400
Message-Id: <20201027001044.1027349-4-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027001044.1027349-1-sashal@kernel.org>
References: <20201027001044.1027349-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-Headers-End: 1kXCZj-008DAh-6t
Subject: [f2fs-dev] [PATCH AUTOSEL 4.9 04/30] f2fs: fix to check segment
 boundary during SIT page readahead
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
Cc: Sasha Levin <sashal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 syzbot+3698081bcf0bb2d12174@syzkaller.appspotmail.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 6a257471fa42c8c9c04a875cd3a2a22db148e0f0 ]

As syzbot reported:

kernel BUG at fs/f2fs/segment.h:657!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 16220 Comm: syz-executor.0 Not tainted 5.9.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:f2fs_ra_meta_pages+0xa51/0xdc0 fs/f2fs/segment.h:657
Call Trace:
 build_sit_entries fs/f2fs/segment.c:4195 [inline]
 f2fs_build_segment_manager+0x4b8a/0xa3c0 fs/f2fs/segment.c:4779
 f2fs_fill_super+0x377d/0x6b80 fs/f2fs/super.c:3633
 mount_bdev+0x32e/0x3f0 fs/super.c:1417
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x1387/0x2070 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount fs/namespace.c:3390 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3390
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

@blkno in f2fs_ra_meta_pages could exceed max segment count, causing panic
in following sanity check in current_sit_addr(), add check condition to
avoid this issue.

Reported-by: syzbot+3698081bcf0bb2d12174@syzkaller.appspotmail.com
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/checkpoint.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index c1b24d7aa6ef1..5e9f8ec8251d3 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -201,6 +201,8 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 					blkno * NAT_ENTRY_PER_BLOCK);
 			break;
 		case META_SIT:
+			if (unlikely(blkno >= TOTAL_SEGS(sbi)))
+				goto out;
 			/* get sit block addr */
 			fio.new_blkaddr = current_sit_addr(sbi,
 					blkno * SIT_ENTRY_PER_BLOCK);
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
