Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAAFE810BE
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 27 Sep 2023 09:35:01 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qlQwe-0006gX-GB;
	Wed, 27 Sep 2023 09:34:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jack@suse.cz>) id 1qlQwc-0006gQ-Ue
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 27 Sep 2023 09:34:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iUa4qiF0fK+FCGgvHHglsbXPmDmw8P3lWfMQ2r3au+0=; b=IXCSEaF6p4XMRw+ExGAMtqfEzz
 eycwYgxuGmUK163r9CsUeCQdjxIaFR98Rxhk9Tv+b6qTFqXTb7CDJ96DZVlYrcFBc91VvgK55HqdZ
 VCZTwXbS8eX0AY2j42BA900oldp+mnJqd3pBsBWJXyoMg2kYdMJCzuyIeD9IW3tDortM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iUa4qiF0fK+FCGgvHHglsbXPmDmw8P3lWfMQ2r3au+0=; b=ia6Ci9uH2RwHVw2YmXGD9EhQMp
 iwMxs2sQ7kN2Ia9U0Nf8w6CGFM17IKMZDzV3crujSj6TBrzGxzoE6PwbZ/DD3E9kNaFqBrBXBqOLX
 b2O69dTkwidgHVH8oDMHgnx+YGwhJJLfXTW08EuMkaRijwoiUj0hYyctyda5sTxpTJmo=;
Received: from smtp-out1.suse.de ([195.135.220.28])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qlQwY-0006rU-8s for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 27 Sep 2023 09:34:57 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EFE4821972;
 Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695807284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iUa4qiF0fK+FCGgvHHglsbXPmDmw8P3lWfMQ2r3au+0=;
 b=B/YNdch69PAQ4ZS2OtdNjt5ZhU4b9W9zRKz9038QVXOYEQO8gd0xFjrnATN26SI5LPLAQW
 g5mNQ1i1Ij77Jz4bI0+0vIICKS66Ln+l7r0pHhPHvfqdLDmvoHTGzSVNjh/1/yNiU/et4k
 SkHw6ASek0lur8rj063TrpDcxJuY8Dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695807284;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iUa4qiF0fK+FCGgvHHglsbXPmDmw8P3lWfMQ2r3au+0=;
 b=zcl5zqM3retFqVWaPZL6Y4GgBBCAiiYaI1InZZDJHqaAtx2Azila68Ie45hUQ0kDZAknnL
 kRsVChJhgG75vDAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DE3B713AC6;
 Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PQA+NjT3E2U2EwAAMHmgww
 (envelope-from <jack@suse.cz>); Wed, 27 Sep 2023 09:34:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 946BCA07CF; Wed, 27 Sep 2023 11:34:43 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Date: Wed, 27 Sep 2023 11:34:29 +0200
Message-Id: <20230927093442.25915-23-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2195; i=jack@suse.cz;
 h=from:subject; bh=EfNWf25rG2sdLblSTrWJS5psCk0G25MPE7O29FeYgqA=;
 b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlE/clgXVcj1Zx/OgudGuoqAk0hSGl4fLTx+MB3LRD
 +R/h59+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZRP3JQAKCRCcnaoHP2RA2dYrCA
 CO5TgKgITfqgA+lj4x64uTVQHKzhHpSPPD6NNiafZkszAYkIkiOC/1j1vERuvZm4+FwdHqB7D0BBwW
 e3gjBvqhiCgQwv3/+JOaHGCQBhxb+3nlPSDLNulwAl/w7qBEre/B93mC5naEV58uCF/m59HQscatzX
 DKq3crirY01XE9eHNh4jXLit9TFiZFN+qGTQtPWx3zptAKz72u8dBrZAnQXtBBACI67eTm2BeoQyAc
 Zs+0dPVqT7lrnm5WmtnI3Sv3F+kZKGV2WSor4yhQnGmUbQptp51I7twr8HlXpUBnA14vUtzRXBrkfr
 l54aU1ckgv08LxPiobVKJaHDBQ5z6O
X-Developer-Key: i=jack@suse.cz; a=openpgp;
 fpr=93C6099A142276A28BBE35D815BC833443038D8C
X-Headers-End: 1qlQwY-0006rU-8s
Subject: [f2fs-dev] [PATCH 23/29] f2fs: Convert to bdev_open_by_dev/path()
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
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Convert f2fs to use bdev_open_by_dev/path() and pass the handle around.

CC: Jaegeuk Kim <jaegeuk@kernel.org>
CC: Chao Yu <chao@kernel.org>
CC: linux-f2fs-devel@lists.sourceforge.net
Acked-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/super.c | 13 +++++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6d688e42d89c..3878288122ee 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1234,6 +1234,7 @@ struct f2fs_bio_info {
 #define FDEV(i)				(sbi->devs[i])
 #define RDEV(i)				(raw_super->devs[i])
 struct f2fs_dev_info {
+	struct bdev_handle *bdev_handle;
 	struct block_device *bdev;
 	char path[MAX_PATH_LEN];
 	unsigned int total_segments;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a8c8232852bb..027c3ee03985 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1562,7 +1562,7 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
 
 	for (i = 0; i < sbi->s_ndevs; i++) {
 		if (i > 0)
-			blkdev_put(FDEV(i).bdev, sbi->sb);
+			bdev_release(FDEV(i).bdev_handle);
 #ifdef CONFIG_BLK_DEV_ZONED
 		kvfree(FDEV(i).blkz_seq);
 #endif
@@ -4198,7 +4198,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 
 	for (i = 0; i < max_devices; i++) {
 		if (i == 0)
-			FDEV(0).bdev = sbi->sb->s_bdev;
+			FDEV(0).bdev_handle = sbi->sb->s_bdev_handle;
 		else if (!RDEV(i).path[0])
 			break;
 
@@ -4218,13 +4218,14 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 				FDEV(i).end_blk = FDEV(i).start_blk +
 					(FDEV(i).total_segments <<
 					sbi->log_blocks_per_seg) - 1;
-				FDEV(i).bdev = blkdev_get_by_path(FDEV(i).path,
-					mode, sbi->sb, NULL);
+				FDEV(i).bdev_handle = bdev_open_by_path(
+					FDEV(i).path, mode, sbi->sb, NULL);
 			}
 		}
-		if (IS_ERR(FDEV(i).bdev))
-			return PTR_ERR(FDEV(i).bdev);
+		if (IS_ERR(FDEV(i).bdev_handle))
+			return PTR_ERR(FDEV(i).bdev_handle);
 
+		FDEV(i).bdev = FDEV(i).bdev_handle->bdev;
 		/* to release errored devices */
 		sbi->s_ndevs = i + 1;
 
-- 
2.35.3



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
