Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B9EC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 26 Nov 2021 02:30:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mqR0J-00084z-J8; Fri, 26 Nov 2021 02:30:23 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <sashal@kernel.org>) id 1mqR0B-00084n-GD
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 26 Nov 2021 02:30:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HwInmJEZPJam8YN8H3Q65RfyR98Rpt4cSi9rP6OSII8=; b=GwLGNlXkoXVdziVlUSKcL+eC1J
 LXd89z1cREi3TBucnulQlu8TLOLOjJuaHXpll/S5h6gj7j3NMNEuHoyg3ZSv95iYMpnNZxCxMkESU
 IKUSSkKcAd4KHZ8k2g9m7mIBt8YfIr8lqL6Meszw2s6WsDCXFLRAWJt5+aXpGjUnYc9s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HwInmJEZPJam8YN8H3Q65RfyR98Rpt4cSi9rP6OSII8=; b=k
 kGNNhk06NdXnm5vEBR9ZKkqsBJyBBftEVFK9m8gQzUeBvJe5qPI/qLCXngCfQ2Nfvg7MQ6vBztze3
 UulDBr8QBPoYRQlL3j8WYTa4W8Pome4FnHAkYWfSAtJFoItysWgGKKRhs/ybFZTCyRNHHVEe44lNx
 5a5K6nE9ZQwmtly8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mqR0A-009XXT-3r
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 26 Nov 2021 02:30:15 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF78A61139;
 Fri, 26 Nov 2021 02:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637893808;
 bh=jx7FhoL2r/nh8GzjL+YOzztn+6+ZcFtosRvBUb3cDuI=;
 h=From:To:Cc:Subject:Date:From;
 b=uuWw4TA/tbiAATVbBo2JGx6YvCYFs0Q2RyNd7UB39bw8T9dUBHr2zYjk/x+nGql5M
 BsNX4CUysGSWhzPjzuwJyj1RYlJhkzzh02Me1PUcC2gXijR5P7urNKVfLjRNIKewYk
 DLQ1gxsUcoAOtN7LI85tYmH5oxfXvt+5dqp7ohmu1xeqbn3hSzt7biQ8Gg7J4ctzID
 bC2Ksaow++pN3xEOQbyhr+bk7jRoyxV543+Uhx4appk6u2gTuxQw/cl+8GRe5SngKU
 h0pcF5tfkGDY2utOyvqa4Fdo5CkkvhoeQyUy9BdIs1rIEuZTiLGH4qY8kW5MywwVSU
 VqKs/xhook/gw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Thu, 25 Nov 2021 21:30:00 -0500
Message-Id: <20211126023006.440839-1-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-Headers-End: 1mqR0A-009XXT-3r
Subject: [f2fs-dev] [PATCH AUTOSEL 5.15 1/7] f2fs: quota: fix potential
 deadlock
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
 Yi Zhuang <zhuangyi1@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

[ Upstream commit a5c0042200b28fff3bde6fa128ddeaef97990f8d ]

As Yi Zhuang reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=214299

There is potential deadlock during quota data flush as below:

Thread A:			Thread B:
f2fs_dquot_acquire
down_read(&sbi->quota_sem)
				f2fs_write_checkpoint
				block_operations
				f2fs_look_all
				down_write(&sbi->cp_rwsem)
f2fs_quota_write
f2fs_write_begin
__do_map_lock
f2fs_lock_op
down_read(&sbi->cp_rwsem)
				__need_flush_qutoa
				down_write(&sbi->quota_sem)

This patch changes block_operations() to use trylock, if it fails,
it means there is potential quota data updater, in this condition,
let's flush quota data first and then trylock again to check dirty
status of quota data.

The side effect is: in heavy race condition (e.g. multi quota data
upaters vs quota data flusher), it may decrease the probability of
synchronizing quota data successfully in checkpoint() due to limited
retry time of quota flush.

Reported-by: Yi Zhuang <zhuangyi1@huawei.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/checkpoint.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 83e9bc0f91ffd..7b02827242312 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1162,7 +1162,8 @@ static bool __need_flush_quota(struct f2fs_sb_info *sbi)
 	if (!is_journalled_quota(sbi))
 		return false;
 
-	down_write(&sbi->quota_sem);
+	if (!down_write_trylock(&sbi->quota_sem))
+		return true;
 	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH)) {
 		ret = false;
 	} else if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR)) {
-- 
2.33.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
