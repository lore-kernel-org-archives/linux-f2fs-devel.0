Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B9FC3ABB6
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 May 2025 23:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=holNvDKN0CfaoMaQvjfpTcwyFHuyDZTBXr5IQylNzgI=; b=J9WUqyHsqDwu1ww/xzcKnkfBAV
	9fBmSmaFKLd+tvYReBO206KytWEgt99yfgSpWU0OjlL8Tr6vdxSEGmx0MtBwhOvr2ExOHDeYfly/3
	GnVWIu4bhcKqUK/GoWEpWN+LHOAao88vpr8yq1g2RMlvqzgIHsQbbHJYXfBvyYzv2N5g=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uC51l-0007OF-Q4;
	Mon, 05 May 2025 23:15:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1uC51k-0007O9-SA
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 May 2025 23:15:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hC1YkrpYpXgNUx0wuTFF6Lfc8y0tqXxXfv5gDai3Y+w=; b=nIxPWpyDXn0f1R5uRVgIwvhLBy
 3CVAiWf3Xy7v5cakCpCU/03e5nBrxVRL2rSXRB0dlkq/wgJ9yOh7IKOwt6S8Ys2cWde5tfeNLY2Fe
 ETSS2ETroNPqk3Ke7G4AhDZJGxsI9aTqTyYkbha2XM//UCyGq6l3OfZHfPDlkTbz84Qk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hC1YkrpYpXgNUx0wuTFF6Lfc8y0tqXxXfv5gDai3Y+w=; b=T+PEXqlbOU0C7n6x92qv4P99t6
 8bL+J1Q7QTsj9CeDc7XYj1wcDBmZplUxWZD9um3iSxJlSfb5ZOEWgvCqcW066yyARD7up6A/fs4Qu
 B0PN4q4ywxveIAtRJp6I8MeeICeFgRaeus1Rjkaq8ul48a8XJQ6N1jLMlOLDllzavgyE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uC51V-0004YR-5u for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 May 2025 23:15:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E35614376A;
 Mon,  5 May 2025 23:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9B3C4CEEE;
 Mon,  5 May 2025 23:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746486886;
 bh=SsB4YWj0Wp+JdtD/I74jyR9V7Tx+JLtGyt37WCHYMwQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SJWcSAydeJUcFNv7PPnOP2RRnxvzmUKsqW4oLggwnV+4ulnnWSPAgQ/Yj+Oc6BDAq
 W2MLg080cRCRn+tBEqwWqFJzl1UTJ9QgNl5KnQjnomSyv7K3yRvCG1lvuxgX0h/n0P
 lj5FqjAjX6Xoerj7MUjC/+3lTRDaJ9ZITi3b64hIfekAZNiukvQ0caV3afqAXuFain
 7N3KGH2L/q2OUc4m2R17FZhHcu0fY5FeOdKi48BivA0kov2/7OaDSlBwX17Ri1TSQz
 39C+HAP6TDxEyEVsnhlWE2ageUQQ39FrZtxTgZDhyzDZ8tdO02CDzeB08JWfdtYqgU
 3Fh8iP7uPxEQQ==
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Mon,  5 May 2025 19:11:31 -0400
Message-Id: <20250505231320.2695319-44-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
X-Headers-End: 1uC51V-0004YR-5u
Subject: [f2fs-dev] [PATCH AUTOSEL 5.15 044/153] f2fs: defer readonly check
 vs norecovery
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
From: Sasha Levin via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Eric Sandeen <sandeen@redhat.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Sandeen <sandeen@redhat.com>

[ Upstream commit 9cca49875997a1a7e92800a828a62bacb0f577b9 ]

Defer the readonly-vs-norecovery check until after option parsing is done
so that option parsing does not require an active superblock for the test.
Add a helpful message, while we're at it.

(I think could be moved back into parsing after we switch to the new mount
API if desired, as the fs context will have RO state available.)

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0cf564ded140a..77a7b789e32ad 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -729,10 +729,8 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			set_opt(sbi, DISABLE_ROLL_FORWARD);
 			break;
 		case Opt_norecovery:
-			/* this option mounts f2fs with ro */
+			/* requires ro mount, checked in f2fs_default_check */
 			set_opt(sbi, NORECOVERY);
-			if (!f2fs_readonly(sb))
-				return -EINVAL;
 			break;
 		case Opt_discard:
 			if (!f2fs_hw_support_discard(sbi)) {
@@ -1386,6 +1384,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		f2fs_err(sbi, "Allow to mount readonly mode only");
 		return -EROFS;
 	}
+
+	if (test_opt(sbi, NORECOVERY) && !f2fs_readonly(sbi->sb)) {
+		f2fs_err(sbi, "norecovery requires readonly mount");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
