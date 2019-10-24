Return-Path: <SRS0=euTy=YR=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E7FCA9EBB
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Oct 2019 21:57:26 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8637320578;
	Thu, 24 Oct 2019 21:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="lWDgNl5W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="hE8xhjpa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB1L+riM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8637320578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iNl6k-00065Q-79; Thu, 24 Oct 2019 21:57:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1iNl6i-00064p-8e
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 Oct 2019 21:57:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WHBcw56up4++AUbWLiEkHDnD/7Rje98EefkB0UZLFFc=; b=lWDgNl5WfXJJkxin1IoDmHzAmT
 y17jy0vswcKpgQXZTsiYkVFQuObqpdIggMKyHS6Z5jq4Nr8knrCrYlm2MNyNnxoMxh3flOPOCl9lV
 tLTZ5JlddQ1QJhsHpxeWkH4giwURT72a0T4XcYts+yXl/X3HpjPvovM8kOS4KdUEVfvY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WHBcw56up4++AUbWLiEkHDnD/7Rje98EefkB0UZLFFc=; b=hE8xhjpa+2evS7RZB205YkoFEz
 7EkFf9mc2IO9MplvRuJ6JQUwUW9id9wADXomA2sqT3MfliSGH6R1nNgsjo/QwAlMNuef+0dS5UWWJ
 ZMDllk8QdFHDuFqPRr8BI0bVKdJ2XSW5aMYo6UjxzjnLav6qbtaH7o0jbUs2Tymfhg1M=;
Received: from [198.145.29.99] (helo=mail.kernel.org)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iNl6h-002UV7-4Q
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 Oct 2019 21:57:24 +0000
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown
 [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 93FF421D71;
 Thu, 24 Oct 2019 21:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1571954228;
 bh=Iflj5s90gCCWa+Mfxg9ykmv/6MqmPaOcygtr7/UlNBA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oB1L+riMoL5N7sC4SZNAem0Wu0oZ0ChBwrvhO/JgjhncHZvOmASCxFqtgWo8fGRux
 iay4z5tusW3UjYF9XXR2K/PR6sW/mqz5f58HnhVQvcc2Lzm13cIQmwsXq6YrDOyX2t
 yxDS8oybc72F9Yt5eb8ST+azvTaHkk4M/wbn3BfA=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Thu, 24 Oct 2019 14:54:38 -0700
Message-Id: <20191024215438.138489-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191024215438.138489-1-ebiggers@kernel.org>
References: <20191024215438.138489-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1iNl6h-002UV7-4Q
Subject: [f2fs-dev] [PATCH v2 3/3] f2fs: add support for IV_INO_LBLK_64
 encryption policies
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
Cc: linux-f2fs-devel@lists.sourceforge.net, "Theodore Y . Ts'o" <tytso@mit.edu>,
 Satya Tangirala <satyat@google.com>, Paul Lawrence <paullawrence@google.com>,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org, Paul Crowley <paulcrowley@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

f2fs inode numbers are stable across filesystem resizing, and f2fs inode
and file logical block numbers are always 32-bit.  So f2fs can always
support IV_INO_LBLK_64 encryption policies.  Wire up the needed
fscrypt_operations to declare support.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/super.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1443cee158633..851ac95229263 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2308,13 +2308,27 @@ static bool f2fs_dummy_context(struct inode *inode)
 	return DUMMY_ENCRYPTION_ENABLED(F2FS_I_SB(inode));
 }
 
+static bool f2fs_has_stable_inodes(struct super_block *sb)
+{
+	return true;
+}
+
+static void f2fs_get_ino_and_lblk_bits(struct super_block *sb,
+				       int *ino_bits_ret, int *lblk_bits_ret)
+{
+	*ino_bits_ret = 8 * sizeof(nid_t);
+	*lblk_bits_ret = 8 * sizeof(block_t);
+}
+
 static const struct fscrypt_operations f2fs_cryptops = {
-	.key_prefix	= "f2fs:",
-	.get_context	= f2fs_get_context,
-	.set_context	= f2fs_set_context,
-	.dummy_context	= f2fs_dummy_context,
-	.empty_dir	= f2fs_empty_dir,
-	.max_namelen	= F2FS_NAME_LEN,
+	.key_prefix		= "f2fs:",
+	.get_context		= f2fs_get_context,
+	.set_context		= f2fs_set_context,
+	.dummy_context		= f2fs_dummy_context,
+	.empty_dir		= f2fs_empty_dir,
+	.max_namelen		= F2FS_NAME_LEN,
+	.has_stable_inodes	= f2fs_has_stable_inodes,
+	.get_ino_and_lblk_bits	= f2fs_get_ino_and_lblk_bits,
 };
 #endif
 
-- 
2.24.0.rc0.303.g954a862665-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
