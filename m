Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A2ECAC582
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  9 Sep 2025 00:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gG8Fkt6sSE3xV3KvTIYeIws6VTRNn0JJ8aRJhLCwVAg=; b=jgsZMvnCoYRywXICs6nKC4J/K+
	iAIpGv+EJCt1ape33mmba15KUQDKyeo1byeFULXNZYNKcYE2/FGosDjoVR+7TRKnaTseY/9seeetE
	z6Z3Gog2UvksbReKl7IfcAb1UWY0ImQ8/5byZuojDymhSAniGTHc/nrc/PvrXHvnTL/I=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uvmCk-0000zk-Qk;
	Tue, 09 Sep 2025 00:27:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1uvmCj-0000zd-Fx
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 09 Sep 2025 00:27:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IWpqUvAQPcJ395hGdu1RTTzWGtNBtuC1KVYUVPsfw2A=; b=IEXm3ecimKxiFTS1krMTtukixz
 dT1U0qjLl56TZkMMTLhStj287XwSdkTim0acyPr6NY6gphpB2Vzgc14TEP3yZs7OwXSvfA0gbDaqK
 Yj6w+TfRcU526pCZoDOrPgzYEC3e+miKiQmvLon+kh9xP+kINeYuytArrg19FROfW8l0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IWpqUvAQPcJ395hGdu1RTTzWGtNBtuC1KVYUVPsfw2A=; b=k
 KW2Nps7SNlgijY/2q0dy6sEB+m/4IjHw7WIKqDTsAOKpPlGE5HlMCCQGBOisB0rIthPc8D9bX7CHu
 oNxQZ7N0wlHbUzFbrnegdOoRqMbOPzETsFXGNoyek4WA1gCFFHlvsgi0Fh6lkhvxkToDLu6EUN0hL
 nvOFWiHp5548dttE=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uvmCj-0003cx-3k for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 09 Sep 2025 00:27:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 63505601A9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  9 Sep 2025 00:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016C6C4CEF7;
 Tue,  9 Sep 2025 00:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1757377639;
 bh=ymn40pBf8LMcuZYP5kWQIkMelBS3xU8pf1c4kutJg+0=;
 h=From:To:Cc:Subject:Date:From;
 b=rxPv38FPv6SzcgcaBlO1bOGAT+bYTKL3t+lXi3OMJaHpcJzeM8aRP+mxubyO8Bbdx
 PfXK/7M8yXavlrAnYLglfGqYEThc7Osp6bSCp48hW0Zo1XvYBzjQYUdzaRuoJnrT1o
 UD7ErKQw+elPr9lU3a6LMvnX4cFvX1MvKVw+lesgjZIvE0gJjx2h2wuMRnW3+X38N1
 80PgsqYcLF3xyt54bHmwxxunLWZu7vuw7zMr19y3+WW1861xRrxD9T7N5DSTnJUmEb
 papeGFYceQiNK0FEnpjjLg9h3PM6zUwI/ab0cCYlPZFQr3OEWVBvEc2U961dIzgfBl
 b4RGQ3gyxqxtA==
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Tue,  9 Sep 2025 00:27:17 +0000
Message-ID: <20250909002717.829981-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
MIME-Version: 1.0
X-Headers-End: 1uvmCj-0003cx-3k
Subject: [f2fs-dev] [PATCH] f2fs: fix wrong layout information on 16KB page
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch fixes to support different block size.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/sysfs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 081b5df0e664..7992386fb9e6 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1768,12 +1768,15 @@ static int __maybe_unused disk_map_seq_show(struct seq_file *seq,
 	seq_printf(seq, " Main          : 0x%010x (%10d)\n",
 			SM_I(sbi)->main_blkaddr,
 			le32_to_cpu(F2FS_RAW_SUPER(sbi)->segment_count_main));
-	seq_printf(seq, " # of Sections : %12d\n",
-			le32_to_cpu(F2FS_RAW_SUPER(sbi)->section_count));
+	seq_printf(seq, " Block size    : %12lu KB\n", F2FS_BLKSIZE >> 10);
+	seq_printf(seq, " Segment size  : %12d MB\n",
+			(BLKS_PER_SEG(sbi) << (F2FS_BLKSIZE_BITS - 10)) >> 10);
 	seq_printf(seq, " Segs/Sections : %12d\n",
 			SEGS_PER_SEC(sbi));
 	seq_printf(seq, " Section size  : %12d MB\n",
-			SEGS_PER_SEC(sbi) << 1);
+			(BLKS_PER_SEC(sbi) << (F2FS_BLKSIZE_BITS - 10)) >> 10);
+	seq_printf(seq, " # of Sections : %12d\n",
+			le32_to_cpu(F2FS_RAW_SUPER(sbi)->section_count));
 
 	if (!f2fs_is_multi_device(sbi))
 		return 0;
-- 
2.51.0.384.g4c02a37b29-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
