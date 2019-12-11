Return-Path: <SRS0=No8/=2B=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FADAC2D0C7
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Dec 2019 15:28:10 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43521208C3;
	Wed, 11 Dec 2019 15:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="dj38xJ7R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="PjWe8p38";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTXkhJe9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43521208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1if3uL-0005Gj-Sr; Wed, 11 Dec 2019 15:28:09 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1if3uH-0005GX-V8
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Dec 2019 15:28:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Vr7htY3iUwGGZU0d0gpOBI1BpNM9IkA9GG60TnWTM0M=; b=dj38xJ7RaGkKcviW7GQ/Sgm1AD
 VrOp0UFYQec1u3mTDvfCUBuQkVRkCcs6Nm2mLQOVyWcvY82y+AuzORwn3rJfh1j7FMiMViJEzngsb
 9KG+AqOxq1BQVJQsy7FClidWtGCpJ3bV3fVMpqIa0r21Zoz6nF/W/7qXpsE2YfrxFh2M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Vr7htY3iUwGGZU0d0gpOBI1BpNM9IkA9GG60TnWTM0M=; b=PjWe8p38FQJkIqyOqgoK3GDWYt
 9QA7k2lzxxe+1jugzSO7SGBofQQPP5Tl1oZyl6FDbkB1UCdL7aEaMPFLVyNUo8SXGffPzsHH9aZB3
 6c1CvnidIYuqAzQO0Vf3VRjEUyro1dbLfhXEe9WWcaLaV7jo8C0AR622hf5n0Gs2WOLg=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1if3uE-001DkR-4E
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Dec 2019 15:28:04 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C31632465B;
 Wed, 11 Dec 2019 15:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576078076;
 bh=/u13mj4dQXc8/OvMb5WuTa4PoenXQs6Y8XQYTXC0M2c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mTXkhJe9yhAiJ+BQqNIT17zyvW6aCgSVkBs182PzoWFZWf1NYHtAIitZha7IoZo2r
 DRZSybdmugKuTzNp/eoH/0dNFgLq8lodibnm4y7BcNfvSYofA2ukminRoqPdMRiE1N
 F8KvmolJIVTYiYT4FHys0N0KjApV7YOvPdmLqZSw=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Wed, 11 Dec 2019 10:26:31 -0500
Message-Id: <20191211152643.23056-67-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211152643.23056-1-sashal@kernel.org>
References: <20191211152643.23056-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-Headers-End: 1if3uE-001DkR-4E
Subject: [f2fs-dev] [PATCH AUTOSEL 4.19 67/79] f2fs: choose hardlimit when
 softlimit is larger than hardlimit in f2fs_statfs_project()
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
Cc: Chengguang Xu <cgxu519@mykernel.net>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chengguang Xu <cgxu519@mykernel.net>

[ Upstream commit 909110c060f22e65756659ec6fa957ae75777e00 ]

Setting softlimit larger than hardlimit seems meaningless
for disk quota but currently it is allowed. In this case,
there may be a bit of comfusion for users when they run
df comamnd to directory which has project quota.

For example, we set 20M softlimit and 10M hardlimit of
block usage limit for project quota of test_dir(project id 123).

[root@hades f2fs]# repquota -P -a
*** Report for project quotas on device /dev/nvme0n1p8
Block grace time: 7days; Inode grace time: 7days
Block limits File limits
Project used soft hard grace used soft hard grace
----------------------------------------------------------------------
0 -- 4 0 0 1 0 0
123 +- 10248 20480 10240 2 0 0

The result of df command as below:

[root@hades f2fs]# df -h /mnt/f2fs/test
Filesystem Size Used Avail Use% Mounted on
/dev/nvme0n1p8 20M 11M 10M 51% /mnt/f2fs

Even though it looks like there is another 10M free space to use,
if we write new data to diretory test(inherit project id),
the write will fail with errno(-EDQUOT).

After this patch, the df result looks like below.

[root@hades f2fs]# df -h /mnt/f2fs/test
Filesystem Size Used Avail Use% Mounted on
/dev/nvme0n1p8 10M 10M 0 100% /mnt/f2fs

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7a9cc64f5ca37..662c7de58b990 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1148,9 +1148,13 @@ static int f2fs_statfs_project(struct super_block *sb,
 		return PTR_ERR(dquot);
 	spin_lock(&dquot->dq_dqb_lock);
 
-	limit = (dquot->dq_dqb.dqb_bsoftlimit ?
-		 dquot->dq_dqb.dqb_bsoftlimit :
-		 dquot->dq_dqb.dqb_bhardlimit) >> sb->s_blocksize_bits;
+	limit = 0;
+	if (dquot->dq_dqb.dqb_bsoftlimit)
+		limit = dquot->dq_dqb.dqb_bsoftlimit;
+	if (dquot->dq_dqb.dqb_bhardlimit &&
+			(!limit || dquot->dq_dqb.dqb_bhardlimit < limit))
+		limit = dquot->dq_dqb.dqb_bhardlimit;
+
 	if (limit && buf->f_blocks > limit) {
 		curblock = dquot->dq_dqb.dqb_curspace >> sb->s_blocksize_bits;
 		buf->f_blocks = limit;
@@ -1159,9 +1163,13 @@ static int f2fs_statfs_project(struct super_block *sb,
 			 (buf->f_blocks - curblock) : 0;
 	}
 
-	limit = dquot->dq_dqb.dqb_isoftlimit ?
-		dquot->dq_dqb.dqb_isoftlimit :
-		dquot->dq_dqb.dqb_ihardlimit;
+	limit = 0;
+	if (dquot->dq_dqb.dqb_isoftlimit)
+		limit = dquot->dq_dqb.dqb_isoftlimit;
+	if (dquot->dq_dqb.dqb_ihardlimit &&
+			(!limit || dquot->dq_dqb.dqb_ihardlimit < limit))
+		limit = dquot->dq_dqb.dqb_ihardlimit;
+
 	if (limit && buf->f_files > limit) {
 		buf->f_files = limit;
 		buf->f_ffree =
-- 
2.20.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
