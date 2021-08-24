Return-Path: <SRS0=FIBF=NP=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D37C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Aug 2021 01:20:09 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE832613A7
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Aug 2021 01:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE832613A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mIL6m-0001YM-6g; Tue, 24 Aug 2021 01:20:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mIL6k-0001YC-81
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Aug 2021 01:20:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2sBrzslN3z6tcRV86SDTjHGYg5jYol69ZJ4a12vGLFU=; b=GUlKM9681nsunAhzTpV5kZVZkl
 eA0OdtMtazBb9lwP0bI+mgvLpRrKhiENwmZV2vpaKW/CtfmLg4pJN1Mn2dQMi3VdiDoQO8iB7TZgY
 Cc7t2LbeOtqfQHKOf+HOp487YswfGqFd6dT8VtAyP/aEYMHsHfYNktnV0+4pTLzJWz6k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2sBrzslN3z6tcRV86SDTjHGYg5jYol69ZJ4a12vGLFU=; b=F
 HN//qJqbG7piPb2IrMg6m9WiNaD4OV8skHGYGUjFwtxQZslfosJgec343jgRY/05eYFo2u8Jh/nZE
 qptH9wM1x+sUovqXqpBoFVO+zhAB0auRxkD5EnnKPrl1USdWAMpsCsSltZiZFc7tMhi39LXv3qVc/
 Jev0DC5Lx2LL7Ry8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mIL6g-00GKRP-UV
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Aug 2021 01:20:06 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7794861056;
 Tue, 24 Aug 2021 01:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629767992;
 bh=HVZTqOmU6yGjrnUz9nZy965JrWb9oPWaPbk7egBfE2Y=;
 h=From:To:Cc:Subject:Date:From;
 b=X9GgP3p07uB8vlItd0PUdqd+/ogUgdCMVK4ZKLbx0zCX3UNQyqJkLwdzu7IntfhnW
 MPG8g+b37v0gi/vD+VaAJAb5gOZjzZv4zzuhOFh6Gj+nXwM7z+dJO+YPGMSbFjkltL
 nDnNgbQi/jKiPTe94gRMgbKaoM7FP8JTOJkFV7rDiKxYqlHUzVjJRNem6X9dEc7wkI
 8LcY3zZB5WWAG8ry7uRx/C6Du1kOVuQQUTr3QdmQOSyk2fDhDv8QU6JrHtd/zY1XpU
 N6zOllcfjo0+tsBrvLKf/yJJ1HfW/2njdP+tV+s+7ZpJJxlkmDeX5wU2Qb5HTnOD9M
 i4b5fVkkFxwKQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Tue, 24 Aug 2021 09:19:48 +0800
Message-Id: <20210824011948.15408-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Headers-End: 1mIL6g-00GKRP-UV
Subject: [f2fs-dev] [PATCH] f2fs: fix wrong option name printed by
 parse_options()
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
Cc: Chao Yu <chao.yu@linux.dev>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

It prints below kernel message during mounting w/ checkpoint=disable
option:

"F2FS-fs (pmem0): checkpoint=merge cannot be used with checkpoint=disable"

Fix typo "checkpoint=merge" w/ "checkpoint_merge"

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 49e153fd8183..88c66e46bd5c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1289,6 +1289,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		return -EINVAL;
 	}
 
+	if (test_opt(sbi, DISABLE_CHECKPOINT) &&
+			test_opt(sbi, MERGE_CHECKPOINT)) {
+		f2fs_err(sbi, "checkpoint_merge cannot be used with checkpoint=disable\n");
+		return -EINVAL;
+	}
+
 	/* Not pass down write hints if the number of active logs is lesser
 	 * than NR_CURSEG_PERSIST_TYPE.
 	 */
-- 
2.32.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
