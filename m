Return-Path: <SRS0=3yZJ=NZ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DD4C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  3 Sep 2021 03:03:23 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 630D660F56
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  3 Sep 2021 03:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 630D660F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mLzUA-0004pu-5V; Fri, 03 Sep 2021 03:03:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mLzU8-0004po-Bv
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Sep 2021 03:03:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V4DmJnswoUlCh6to+2nJxFp2OInFJiLwiDlDz4KQb+Q=; b=XkxK/6R800fgRPoh1GdR15o/AC
 x4VwUuDqcLZahiWgjyeBOq/+jLKPZ6eSARoTie9rJcHJlT56tiRi1bpQ3uSbaX4BpEUKgzcs+rbr5
 PMwghQfd4YvC6Qw9DesfquBxeOPNapwFrRCDLg1JiQrjAXhuttujH20eIGLsn92hEMQM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=V4DmJnswoUlCh6to+2nJxFp2OInFJiLwiDlDz4KQb+Q=; b=a
 3ZsVZJ3DpFEVoUOlwIpiyuQigyl393zDK1yD4Xw3YJcCeKrCzTYTsjzKVnObIubQ2GUkARiGd6MDA
 IgDSuGF+Sr95R0BNCE1YykSxeWIlk6CDMdkw8xNFNzf9ph7muMBw6MMxFMNKFQOtXYnFb4zNCFr6J
 gwhKgpEb/qxnoYis=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mLzU3-00CVTG-UI
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Sep 2021 03:03:20 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5896360F56;
 Fri,  3 Sep 2021 03:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630638182;
 bh=gJtmSNZbKkbrzgxaPATLp8mnWtEdxwbpYMxFsan2BfI=;
 h=From:To:Cc:Subject:Date:From;
 b=LKME0aF4ROlzKUsehwZ5IRbV0HB3u23lNk6s3UluHX/esb12hgt/O9Pgv8u/iZZxn
 PMFSpEFh7OBLiaZ2TuY1Z8nset3Ak0WT8VXRiXULLApsopxoH8oec4tkK/Qb/tXcrh
 XbkHxpAzO3iZ5Pi+tRiECMVFqCSWiN9oC2OK6atMDQPczNMHVVyhz3S1iwzx9kEKNF
 iCFDbYaamZCVFEnVQJHI3jY1fW0lGyHVgxaQVirr1t2pVPbQedn9aAKhLM9PE122ZM
 sCxQKiTPKYBNdLPXZHQFOeIJh9tWczn3JcfNNZaZi8wPcGLGsrz1VRE8yKQSS23k2V
 +domrfjCm341A==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Fri,  3 Sep 2021 10:38:11 +0800
Message-Id: <20210903023811.3458-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Headers-End: 1mLzU3-00CVTG-UI
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
Cc: linux-kernel@vger.kernel.org, Yi Zhuang <zhuangyi1@huawei.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

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
---
 fs/f2fs/checkpoint.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 7d8803a4cbc2..6f6a7d812d60 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1159,7 +1159,8 @@ static bool __need_flush_quota(struct f2fs_sb_info *sbi)
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
