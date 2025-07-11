Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFC4C8303C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 11 Jul 2025 07:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=peirtaKpGuH33dtVRBM3TFUoeM5Ehknhd4lvmUKp7g8=; b=CwmFq3xzAKpypI2MlOh32ZWXp2
	xl2S5CWM4IYeO8um+ofvRFlqIy10lyu/dhuL1mIkLOvOau0ML0nPZgxCpne8yhtKgDGQ0JeGzvJUm
	cH6uKORkbCE575qUWg3vqbAvnEnkqWDLbxQL/FSuNashQNlr1LuTiFeIjGwhSWRsNId0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ua7yY-0000PI-RP;
	Fri, 11 Jul 2025 07:15:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ua7yS-0000P7-BD
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Jul 2025 07:15:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xiUCVPXofvnwebWdiJ2vVzIV+Xhht+zTWMQxCIFhVzs=; b=MDMIVlVMuiWm2Gq1flXZgqRtGP
 viz72Ytpq+CaWuZNZJ3PqS7yuvBiuvPgYVwVSBgl0xNs9Va09pHBtuAAVwEVGJ8MRVVyZj+DTmYYw
 bZJZa1wGrAlm155k+dTi++qFOEAKoYGrkcLAjMAM35ngEJWkgZgaiDt4io6m2IcPGJ5I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xiUCVPXofvnwebWdiJ2vVzIV+Xhht+zTWMQxCIFhVzs=; b=i
 FP87q46Ik54ppALIRlBx2R7XpM8JxLAMWOT3sBOH9XPswOSmxyHqQOo8JVFbm2TV232FchcggRZT7
 4FZR5oLhfELe+W+9NFdmUiYPx/KSbjj5rYU8eXW6UkYbRN2gUsVbmOiZI7c4rqTa+frR29mjSHI2P
 B5fdiuCWKL33TlJI=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ua7yR-0000xc-U5 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Jul 2025 07:15:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 0B5B9A54C81
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 11 Jul 2025 07:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99509C4CEED;
 Fri, 11 Jul 2025 07:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752218100;
 bh=LYUnlcYQnWCTsg1aj82TguyO32RcRYUeONZaChGaCJY=;
 h=From:To:Cc:Subject:Date:From;
 b=K1d2b/OGNdgkm5rLx5K8x5P4J0Hn5PcYJTz5zTjCkBFbNUuByIbBp7wJ2EqZAIm9k
 K5kVO0rc+jtE4GJ7H6E0SvKV6fEphptwoQnZuDYON0wRR0HfygjvUCH7pcHvKZ7wzv
 kyUT8BUap4aJElFn0y0N+SHOvxxDiDSTEyFnponRQK9SPELQKdrmoBIS/MEXnkZy5P
 XFmj3rF7RPftLb4nHgchIcNPDPQqf18f+zsW3vW2ih0OE8D0EOg5Wq45Bekn87TKjD
 PNKKMnGUsWhVrgGTv6u6trhB9PlfLOmgVKz1qc5ZGvv+uX3DovVYm+WMs8qWLawOAX
 ravwo3h4x7Cmg==
To: jaegeuk@kernel.org
Date: Fri, 11 Jul 2025 15:14:50 +0800
Message-ID: <20250711071450.207302-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
MIME-Version: 1.0
X-Headers-End: 1ua7yR-0000xc-U5
Subject: [f2fs-dev] [PATCH] f2fs: fix to avoid out-of-boundary access in
 devs.path
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

- touch /mnt/f2fs/012345678901234567890123456789012345678901234567890123
- truncate -s $((1024*1024*1024)) \
  /mnt/f2fs/012345678901234567890123456789012345678901234567890123
- touch /mnt/f2fs/file
- truncate -s $((1024*1024*1024)) /mnt/f2fs/file
- mkfs.f2fs /mnt/f2fs/012345678901234567890123456789012345678901234567890123 \
  -c /mnt/f2fs/file
- mount /mnt/f2fs/012345678901234567890123456789012345678901234567890123 \
  /mnt/f2fs/loop

[16937.192225] F2FS-fs (loop0): Mount Device [ 0]: /mnt/f2fs/012345678901234567890123456789012345678901234567890123\xff\x01,      511,        0 -    3ffff
[16937.192268] F2FS-fs (loop0): Failed to find devices

If device path length equals to MAX_PATH_LEN, sbi->devs.path[] may
not end up w/ null character due to path array is fully filled, So
accidently, fields locate after path[] may be treated as part of
device path, result in parsing wrong device path.

struct f2fs_dev_info {
...
	char path[MAX_PATH_LEN];
...
};

Let's add one byte space for sbi->devs.path[] to store null
character of device path string.

Fixes: 3c62be17d4f5 ("f2fs: support multiple devices")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8cded45cfbc7..64996153e4c8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1289,7 +1289,7 @@ struct f2fs_bio_info {
 struct f2fs_dev_info {
 	struct file *bdev_file;
 	struct block_device *bdev;
-	char path[MAX_PATH_LEN];
+	char path[MAX_PATH_LEN + 1];
 	unsigned int total_segments;
 	block_t start_blk;
 	block_t end_blk;
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
