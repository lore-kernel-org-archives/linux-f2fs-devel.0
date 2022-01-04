Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC50C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Jan 2022 13:05:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1n4jVT-0006Zv-1X; Tue, 04 Jan 2022 13:05:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1n4jVS-0006Zl-Dy
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 04 Jan 2022 13:05:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=03x4eGWB78986kG+unUk7JW4YI7nmnBKExoUII5MGa0=; b=iaPSn/sOrt8ZVnfEihK49Ih2+J
 9oBDszVndF0qmkJ8ceAJzextuNfoJyGNfybgvQp/YjnXP3KY+hae2/37/4GU9W0nYwA+1laPUTL2C
 lMzOnhpVsdNwCeY1B5/6XegCfISUYq6+npQ6pRZ15deq/QUhJTuYNU9mZ/bEzVCE5QqQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=03x4eGWB78986kG+unUk7JW4YI7nmnBKExoUII5MGa0=; b=O
 8E8jAiOUIjR3yCsEDnyf55tx18Kwy6cCne5TR/jNc/nmDd8Rf6vx15+s1EtGOWLqR0s8HQB5XRcqS
 h66C4Sga1YJ+18zPqHaXxDL0b99uCuZUQzJsosRSfoJwa45MdVkD20eZB8tSe+PZ0sXHrLWRGO8yT
 TD9s00nu15gDMdDs=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1n4jVN-001rH0-WD
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 04 Jan 2022 13:05:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id BD2C8B815A2;
 Tue,  4 Jan 2022 13:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C349C36AE7;
 Tue,  4 Jan 2022 13:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641301518;
 bh=WQZf7CvnX1LxzlL0YMO3/J4eF+eJB21Yuse9m5LcN18=;
 h=From:To:Cc:Subject:Date:From;
 b=TNpouWFjDcQY2jfiaytG/RI02cQPN3FA9/ua67R2IpZ71C+d1axYGkA+EhVInc63p
 zNZsLnoHAP9f6xOZkTmic8zbQVo1bM/XWhsQnktvnfmTNv5dN0pzAow4J2ZJRglFDi
 6HlisIbmd18l6nXVJGZ6fz1OGKi1h6fGURLP6ou+HfZiADg2mV0qrF7Y1xgdxwaF6b
 rOSi+389iziMBWXdyoedq6yIpGi9YaiMZuqHhWY7nDog7geY8NztibvRIIugMo5S00
 oBSn5owSf1Zi4M2Sj4jfVbh76cI8vB0Jc0n+e8GxHMu4KZafXLC2dgWm908wmhWbvE
 csmwfluurojsg==
From: Chao Yu <chao@kernel.org>
To: stable@vger.kernel.org
Date: Tue,  4 Jan 2022 21:05:13 +0800
Message-Id: <20220104130513.3077-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Headers-End: 1n4jVN-001rH0-WD
Subject: [f2fs-dev] [PATCH] f2fs: quota: fix potential deadlock
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
Cc: jaegeuk@kernel.org, Yi Zhuang <zhuangyi1@huawei.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

commit a5c0042200b28fff3bde6fa128ddeaef97990f8d upstream.

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

Fixes: db6ec53b7e03 ("f2fs: add a rw_sem to cover quota flag changes")
Cc: stable@vger.kernel.org # v5.3+
Reported-by: Yi Zhuang <zhuangyi1@huawei.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 83e9bc0f91ff..7b0282724231 100644
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
2.32.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
