Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A9DC05027
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Feb 2023 02:47:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pPE1K-0007VK-R2;
	Tue, 07 Feb 2023 02:47:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1pPE1F-0007V9-IP
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Feb 2023 02:47:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I1HwyJl+R5vC29SbKGw6FjpINF262tPPv325uIIRljU=; b=lEtdAMHbPGuUyom/6J4VlS9oMv
 cKxMrBwlAPTLsamjk5XKFq+mZlxZGxI7rZb3It3RIA9+MnBNNZq7isEZt1BwgLp91nw/QQWK/QoGW
 hlyFrdyWzulfdragCvbLHC2ayMfNJY/oPKj5aMqL4SWm9KToFVSqjV1XMTylh5ztH3tw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=I1HwyJl+R5vC29SbKGw6FjpINF262tPPv325uIIRljU=; b=g
 STIzNiq45wV0XCrlz76h0j1QNk9vgcychW7I1a4iU6S/R7cMfwzMuQeV7lPNN5/3Pxn0vuxA8xUtq
 inDWZSvEF6JeaNc7z7xYU5Iln02R+nSZWjCJN/XIvzg1yM5kHldIeThFKLtdClsDVdFTTjSzxR4nm
 mjuajcWai6hgQut0=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pPE1A-00DB45-HK for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Feb 2023 02:47:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id CD4ADB81626
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  7 Feb 2023 02:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EE9C433EF;
 Tue,  7 Feb 2023 02:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675738046;
 bh=yGtnMhYY54FfgJR3V5+3Wp6+COLxxfVCgnOIbJ4U2UM=;
 h=From:To:Cc:Subject:Date:From;
 b=PB55QXNpMgTvjLbpjTjrwsVONQgYkE9RBvGFb7lWuRc2hfghX+2wD1O7hYgrwG7Wg
 u1MDT6XmL6o1SM1LrVMpa92k/Y/5trz9C2d6d1BRZW3RTHqGVTl1URqmgPF5RoNWJt
 JHjAD8KkP+pTggkpo+lx4pWfxdRteTmulPp+GZtWR/jB4UkXCXFwzQZ0sqElKtA4RG
 V6huPRfqlVgrxlTZF2ehwlAtzl1N9q0lSFn4hjWZzEvrt3siclqlGl3U8SeoKhxYjh
 JMXN/OwKq7iXl3ckBbu9kTl6M0CFzWMwNa9YWf2ZmvcVwQD1JepDRQdqMO/skrt2vI
 uO8pZnKahyqHQ==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon,  6 Feb 2023 18:47:25 -0800
Message-Id: <20230207024725.260092-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
MIME-Version: 1.0
X-Headers-End: 1pPE1A-00DB45-HK
Subject: [f2fs-dev] [PATCH] f2fs_io: support AES_256_HCTR2
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tools/f2fs_io/f2fs_io.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 6dcd84091583..5bc0baf40421 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -1195,16 +1195,17 @@ static void do_get_filename_encrypt_mode (int argc, char **argv,
 						const struct cmd_desc *cmd)
 {
 	static const char *enc_name[] = {
-		"invalid", /* FS_ENCRYPTION_MODE_INVALID (0) */
-		"aes-256-xts", /* FS_ENCRYPTION_MODE_AES_256_XTS (1) */
-		"aes-256-gcm", /* FS_ENCRYPTION_MODE_AES_256_GCM (2) */
-		"aes-256-cbc", /* FS_ENCRYPTION_MODE_AES_256_CBC (3) */
-		"aes-256-cts", /* FS_ENCRYPTION_MODE_AES_256_CTS (4) */
-		"aes-128-cbc", /* FS_ENCRYPTION_MODE_AES_128_CBC (5) */
-		"aes-128-cts", /* FS_ENCRYPTION_MODE_AES_128_CTS (6) */
-		"speck128-256-xts", /* FS_ENCRYPTION_MODE_SPECK128_256_XTS (7) */
-		"speck128-256-cts", /* FS_ENCRYPTION_MODE_SPECK128_256_CTS (8) */
-		"adiantum", /* FS_ENCRYPTION_MODE_ADIANTUM (9) */
+		"invalid", /* FSCRYPT_MODE_INVALID (0) */
+		"aes-256-xts", /* FSCRYPT_MODE_AES_256_XTS (1) */
+		"aes-256-gcm", /* FSCRYPT_MODE_AES_256_GCM (2) */
+		"aes-256-cbc", /* FSCRYPT_MODE_AES_256_CBC (3) */
+		"aes-256-cts", /* FSCRYPT_MODE_AES_256_CTS (4) */
+		"aes-128-cbc", /* FSCRYPT_MODE_AES_128_CBC (5) */
+		"aes-128-cts", /* FSCRYPT_MODE_AES_128_CTS (6) */
+		"speck128-256-xts", /* FSCRYPT_MODE_SPECK128_256_XTS (7) */
+		"speck128-256-cts", /* FSCRYPT_MODE_SPECK128_256_CTS (8) */
+		"adiantum", /* FSCRYPT_MODE_ADIANTUM (9) */
+		"aes-256-hctr2", /* FSCRYPT_MODE_AES_256_HCTR2 (10) */
 	};
 	int fd, mode, ret;
 	struct fscrypt_get_policy_ex_arg arg;
-- 
2.39.1.519.gcb327c4b5f-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
