Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC7DC71153
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  5 Sep 2023 01:04:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qdKUf-0000Op-BU;
	Tue, 05 Sep 2023 01:04:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1qdKUc-0000Od-Qo
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 05 Sep 2023 01:04:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bsEiP5/yz8kruujdT+NFC+HAM3mz/oSNQ4lCmRHgtoU=; b=FVj630IWcntKL4tmYE47NMi8ob
 Onb37uOvbkdtWZDlSptUiag39i7LNCgs62Ny52DXPqmPOwusQXeaJ/1IuS29F5Af7B1O13FzDqYD0
 4+QLpqQkXeBWYi6E3lkPAGp9OkvU3vhN00S6i8x3O11IAwdBpEa8lpTk34V16MVTgjT4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bsEiP5/yz8kruujdT+NFC+HAM3mz/oSNQ4lCmRHgtoU=; b=IQTZH4PUxG9ZDoLMAnIBmAf0ql
 H5bcxvW/WwA8nyQU24NHpzbAblf3120yAHSOf4qvCTmpXGlnWUQDin6jkzTz6QBdAqDObHX8m4hVE
 Isay8FgBopqhwNEfP5ifxrRpejGJrI3G3t4fSpBnmP2VKedn9M7ntfLe+5wKvVFLdxfU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qdKUa-00048q-S0 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 05 Sep 2023 01:04:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7494260C1A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  5 Sep 2023 01:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00CCC433C8;
 Tue,  5 Sep 2023 01:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693875866;
 bh=mA/Dvgn43PcLulCBha8yDFRXAbYYmz0W5UhWW5k2V0U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DqsUKpp+DESWe4xI4x4m+43TguAisfpiOWMlga8z5er8oM3F0oHOQNRAnTX5TBQg3
 UuV8aCgTuSbhnsofkbhOgSDf0l/QqCr45WJpwvrizqcDgOfltg8/pUM3ncdj3vm8yl
 9kS3Y1jc06DxH/qbMp2iyLyZXHd97llvlE6NM+FbNiX7cvB/vbctzzz926HgBKzJZS
 bbuT3LIkc6AyHdfhm2duWA3lHHBnTSQ9bwVfrbP7nFRm02mVBn4Lx+mnJmAa9O7y1w
 I2/0k/V5UIEUTO22Al89dZxI+miSnWEaIEPvzMHck9D8TGtuveZqlitVPKFBjyGXDX
 8T56f8ALmUVgQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Mon,  4 Sep 2023 17:58:27 -0700
Message-ID: <20230905005830.365985-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230905005830.365985-1-ebiggers@kernel.org>
References: <20230905005830.365985-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1qdKUa-00048q-S0
Subject: [f2fs-dev] [PATCH 2/5] fscrypt: make the bounce page pool opt-in
 instead of opt-out
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
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Replace FS_CFLG_OWN_PAGES with a bit flag 'needs_bounce_pages' which has
the opposite meaning.  I.e., filesystems now opt into the bounce page
pool instead of opt out.  Make fscrypt_alloc_bounce_page() check that
the bounce page pool has been initialized.

I believe the opt in makes more sense, since nothing else in
fscrypt_operations is opt out, and these days filesystems can choose to
use blk-crypto which doesn't need the fscrypt bounce page pool.  Also, I
happen to be planning to add two more flags, and I wanted to fix the
"FS_CFLG_" name anyway as it wasn't prefixed with "FSCRYPT_".

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/crypto.c      |  9 ++++++++-
 fs/ext4/crypto.c        |  1 +
 fs/f2fs/super.c         |  1 +
 fs/ubifs/crypto.c       |  1 -
 include/linux/fscrypt.h | 19 ++++++++++---------
 5 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 6a837e4b80dcb..803347a5d0a6d 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -49,6 +49,13 @@ EXPORT_SYMBOL(fscrypt_enqueue_decrypt_work);
 
 struct page *fscrypt_alloc_bounce_page(gfp_t gfp_flags)
 {
+	if (WARN_ON_ONCE(!fscrypt_bounce_page_pool)) {
+		/*
+		 * Oops, the filesystem called a function that uses the bounce
+		 * page pool, but it forgot to set needs_bounce_pages.
+		 */
+		return NULL;
+	}
 	return mempool_alloc(fscrypt_bounce_page_pool, gfp_flags);
 }
 
@@ -325,7 +332,7 @@ int fscrypt_initialize(struct super_block *sb)
 		return 0;
 
 	/* No need to allocate a bounce page pool if this FS won't use it. */
-	if (sb->s_cop->flags & FS_CFLG_OWN_PAGES)
+	if (!sb->s_cop->needs_bounce_pages)
 		return 0;
 
 	mutex_lock(&fscrypt_init_mutex);
diff --git a/fs/ext4/crypto.c b/fs/ext4/crypto.c
index 8cdb7bbc655b0..a9221be67f2a7 100644
--- a/fs/ext4/crypto.c
+++ b/fs/ext4/crypto.c
@@ -240,6 +240,7 @@ static void ext4_get_ino_and_lblk_bits(struct super_block *sb,
 }
 
 const struct fscrypt_operations ext4_cryptops = {
+	.needs_bounce_pages	= 1,
 	.legacy_key_prefix_for_backcompat = "ext4:",
 	.get_context		= ext4_get_context,
 	.set_context		= ext4_set_context,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8de799a8bad04..276535af5bf3c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3231,6 +3231,7 @@ static struct block_device **f2fs_get_devices(struct super_block *sb,
 }
 
 static const struct fscrypt_operations f2fs_cryptops = {
+	.needs_bounce_pages	= 1,
 	.legacy_key_prefix_for_backcompat = "f2fs:",
 	.get_context		= f2fs_get_context,
 	.set_context		= f2fs_set_context,
diff --git a/fs/ubifs/crypto.c b/fs/ubifs/crypto.c
index fab90f9a8eaff..f0ca403777d9a 100644
--- a/fs/ubifs/crypto.c
+++ b/fs/ubifs/crypto.c
@@ -88,7 +88,6 @@ int ubifs_decrypt(const struct inode *inode, struct ubifs_data_node *dn,
 }
 
 const struct fscrypt_operations ubifs_crypt_operations = {
-	.flags			= FS_CFLG_OWN_PAGES,
 	.legacy_key_prefix_for_backcompat = "ubifs:",
 	.get_context		= ubifs_crypt_get_context,
 	.set_context		= ubifs_crypt_set_context,
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 85574282c7e52..ac684f688d488 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -59,18 +59,19 @@ struct fscrypt_name {
 
 #ifdef CONFIG_FS_ENCRYPTION
 
-/*
- * If set, the fscrypt bounce page pool won't be allocated (unless another
- * filesystem needs it).  Set this if the filesystem always uses its own bounce
- * pages for writes and therefore won't need the fscrypt bounce page pool.
- */
-#define FS_CFLG_OWN_PAGES (1U << 1)
-
 /* Crypto operations for filesystems */
 struct fscrypt_operations {
 
-	/* Set of optional flags; see above for allowed flags */
-	unsigned int flags;
+	/*
+	 * If set, then fs/crypto/ will allocate a global bounce page pool.  The
+	 * bounce page pool is required by the following functions:
+	 *
+	 * - fscrypt_encrypt_pagecache_blocks()
+	 * - fscrypt_zeroout_range() for files not using inline crypto
+	 *
+	 * If the filesystem doesn't use those, it doesn't need to set this.
+	 */
+	unsigned int needs_bounce_pages : 1;
 
 	/*
 	 * This field exists only for backwards compatibility reasons and should
-- 
2.42.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
