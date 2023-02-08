Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82317C636CC
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Feb 2023 06:21:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pPdq8-0006LB-Fv;
	Wed, 08 Feb 2023 06:21:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1pPdpx-0006Kn-BI
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Feb 2023 06:21:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qrrmuw3XnvQUPWSh2rYSo7BzQ8UPQb+RFl56nqNFV7E=; b=FX718Atr4OFbA7n+broTw/TiAY
 tbtgxLHjUtu8MFniZTFJt3wFdLDNl8RHuD8jM/MykjVZi6hDW9YnbOpp5fsgPQr/wK4HG3qsFpK47
 0UgL+yOMua1NTAM7JvOUChgu3vevrLUDbHw6k80HGN3RbN8pde82Sy0kEJ4BAfkollsQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Qrrmuw3XnvQUPWSh2rYSo7BzQ8UPQb+RFl56nqNFV7E=; b=hGnZ2KSuTAYjIZJPb9NPKLbgUD
 E9HDxu8QuBYOlUa9BMyWXY2XJw/r/1ro13B+RwfP2gljNF6isDOUq/WpNhcSIoUsWGOp09jhIqD8/
 CRvYW7YqypFc+UOE26LvrTcvlB1Dtt+ejgKpQNVC+KkzV98XpMVjqN/cuy5Fa05w9rpw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pPdpu-0008Qo-Gl for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Feb 2023 06:21:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 16F91614E1;
 Wed,  8 Feb 2023 06:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C26C4339B;
 Wed,  8 Feb 2023 06:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675837295;
 bh=kfr98bGzVCZ89v5RF0C39SP0fCvbpfqJYzf6QFQbhlc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vNp1UKHXj/Iwfo2wnOJu9HISJGFDp8Ak2VghNEydsMfUfm14hT+A1VvSuRDmI4/LA
 LqQ9bHnJnch8CTDA7s2xPU6WlgwbiMVvZMkX+2NytMXtsPa7nOAREhPr+2TwKTDNr1
 +U6RBTgwmam283E1xcZPMK8gMOHQOJjTUEYUoux7Y8DW+HVKvc2xqnri4n4kHiBInS
 UpuhbJObRfKNnaexU7Deca24KaeQf3c7O8szvMDNcM1A0r5+aw1hUTeXLwkmjs/h1l
 /ym4oDpYxxXjQQ9VqyNRpsPX1S1er6TsJ401l5ReYKH9DPPDcmzsimS7idcPDQDvjj
 IegFclMH9Bm8w==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Tue,  7 Feb 2023 22:21:04 -0800
Message-Id: <20230208062107.199831-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208062107.199831-1-ebiggers@kernel.org>
References: <20230208062107.199831-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1pPdpu-0008Qo-Gl
Subject: [f2fs-dev] [PATCH 2/5] ext4: stop calling
 fscrypt_add_test_dummy_key()
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
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Now that fs/crypto/ adds the test dummy encryption key on-demand when
it's needed, there's no need for individual filesystems to call
fscrypt_add_test_dummy_key().  Remove the call to it from ext4.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/super.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 260c1b3e3ef2c..260bbab25db38 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2635,7 +2635,6 @@ static int ext4_check_test_dummy_encryption(const struct fs_context *fc,
 {
 	const struct ext4_fs_context *ctx = fc->fs_private;
 	const struct ext4_sb_info *sbi = EXT4_SB(sb);
-	int err;
 
 	if (!fscrypt_is_dummy_policy_set(&ctx->dummy_enc_policy))
 		return 0;
@@ -2668,17 +2667,7 @@ static int ext4_check_test_dummy_encryption(const struct fs_context *fc,
 			 "Conflicting test_dummy_encryption options");
 		return -EINVAL;
 	}
-	/*
-	 * fscrypt_add_test_dummy_key() technically changes the super_block, so
-	 * technically it should be delayed until ext4_apply_options() like the
-	 * other changes.  But since we never get here for remounts (see above),
-	 * and this is the last chance to report errors, we do it here.
-	 */
-	err = fscrypt_add_test_dummy_key(sb, &ctx->dummy_enc_policy);
-	if (err)
-		ext4_msg(NULL, KERN_WARNING,
-			 "Error adding test dummy encryption key [%d]", err);
-	return err;
+	return 0;
 }
 
 static void ext4_apply_test_dummy_encryption(struct ext4_fs_context *ctx,
-- 
2.39.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
