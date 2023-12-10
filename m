Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B972C4167B
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 10 Dec 2023 11:36:21 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rCI6d-0006B7-1b;
	Sun, 10 Dec 2023 11:36:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rCI6a-0006Az-P5
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 10 Dec 2023 11:36:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iU1aT0mmJyAWhLFKiZQwM8RSU3RFe2MlFfjAeYq2rx0=; b=lNuekq+H67b9d8to61KfWHxZS1
 5F0dDiUt8zqGKBpgEmsur4SlOEEvAnVDwMJWzczQcvKfLb8vvPhO+Safn2s5rStX1F0HRockG3Jdj
 WeigSXT6Qi9hUiprhI0MEWNOlzLRVI0151WftA4dPmJpoES0EYXPbL2bsh8TljVdz2TM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iU1aT0mmJyAWhLFKiZQwM8RSU3RFe2MlFfjAeYq2rx0=; b=eyjRuRZ0bm23BpRPLxarnGVmvA
 oEAakpr3bswQHKzeOyjnGVCEmuElxWVkizzGZjoQHz1VcmWHHLAh9hFcX02QqAEXeGpaEGxN/8qRg
 NBo2d63PGFW1j3fja5UM3CEfSVqTroPq65MUUT4YclQeGz+wfUFa0LtpOZfv3LvIsyx4=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rCI6a-0000Uo-BM for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 10 Dec 2023 11:36:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id B807DCE0AD4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 10 Dec 2023 11:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A48C433CA;
 Sun, 10 Dec 2023 11:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702208164;
 bh=VE5AOlHytLIsYFQS7gWhjGZv4ckuyxkhp1hOk55UcyY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tdPbIg6hNIf4BrSLKKH6gkTlFHSLALJrVqs3hKrjjDzV1Z7N4lyErMKyrSrhPqF7d
 iDT98jSa2Mz2myBQzmpz0LGNxShqhREACRFoJFP8z9mMvMC4j7W5fVpKMk9dvkoEht
 ZBJYvH5X4Eb4MjaeI0gwVC6rd7/wMWDI09mb4LImSzt8t/LBzhR1tibOn1tVzB831a
 kyx429rqHwieBBykrwNU6dE2nr8JRecr3bFGyPcb873PK3V2sKqqhhLxiSkvC9A+Cf
 qdJCcEvhTGnogiltiFqOifxY4+RzPMm8+eZanbGQJTjrsqQF0hP6+oDYrsX8KmHQnS
 /RHhQZ8M3q9aw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Sun, 10 Dec 2023 19:35:44 +0800
Message-Id: <20231210113547.3412782-3-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231210113547.3412782-1-chao@kernel.org>
References: <20231210113547.3412782-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1rCI6a-0000Uo-BM
Subject: [f2fs-dev] [PATCH 3/6] f2fs: fix to check compress file in
 f2fs_move_file_range()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs_move_file_range() doesn't support migrating compressed cluster
data, let's add the missing check condition and return -EOPNOTSUPP
for the case until we support it.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 156b0ff05a3b..5c2f99ada6be 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2813,6 +2813,11 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 			goto out;
 	}
 
+	if (f2fs_compressed_file(src) || f2fs_compressed_file(dst)) {
+		ret = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
 	ret = -EINVAL;
 	if (pos_in + len > src->i_size || pos_in + len < pos_in)
 		goto out_unlock;
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
