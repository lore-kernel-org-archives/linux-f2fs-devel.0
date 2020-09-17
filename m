Return-Path: <SRS0=dtVZ=C2=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EA5C2BBD1
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Sep 2020 04:13:43 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57AD22205;
	Thu, 17 Sep 2020 04:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="CJwBmzBO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="FcbNLLDM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjOZn/iF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57AD22205
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kIlIk-0006Dl-Fl; Thu, 17 Sep 2020 04:13:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1kIlIe-0006CY-V2
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 17 Sep 2020 04:13:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dlZh8CacO0jmMHNg0hq1/LPjo+9l+arjszSTZwB7Chg=; b=CJwBmzBOjCRScdCV+tICTYeCxC
 sH8RETXUfCa2gVfeO5pLjBeTHBwdVp2MtF9h9OEqRHqLEHgVgLgsHiswbbFf0fSqoYMO2LokfH87h
 5td6b6jeof7Pdr1rvX8oToQCXzHa1Bh759fszPM99beYb+lHwu3j4u6QMLy7b0XLOerA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dlZh8CacO0jmMHNg0hq1/LPjo+9l+arjszSTZwB7Chg=; b=FcbNLLDMc5yjOG7TKc+hHcgOTq
 gDtCfTlDSWxSAkAWbDmn8VPh2UR4vqDSYtRS8of5mJ3JBDRBb3g0xm7awq7BmdrVvyW3mKBn5Ayvh
 tRw6er+StZmFT5gEd5AytGA7kPa/QvwHWXPzI3xmepPZiPInIOTCto2mbNWFQBTNgKK0=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kIlIb-00DZed-JJ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 17 Sep 2020 04:13:36 +0000
Received: from sol.attlocal.net
 (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9750121D41;
 Thu, 17 Sep 2020 04:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600315989;
 bh=pcuDTH9STD/mcWVjY9xk4V3olh0O7QdLKYJXVZYhQo8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WjOZn/iFKAnidcOCFe+ysawmOaq+wZI9ahIoTC+JpTCuGheF3T5BHxOwXh1kL3zCZ
 3bymu2kDogYINSoFHUgY+sOPCKrKs0XS/Hi5wozjy5gL6kj6NUPkMa8IZcCNDveVRT
 WvDDwm829kBpdreaI9WfPgzWgY3w2UuXhMRU3Kk4=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Wed, 16 Sep 2020 21:11:29 -0700
Message-Id: <20200917041136.178600-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917041136.178600-1-ebiggers@kernel.org>
References: <20200917041136.178600-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1kIlIb-00DZed-JJ
Subject: [f2fs-dev] [PATCH v3 06/13] fscrypt: adjust logging for in-creation
 inodes
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
Cc: Daniel Rosenberg <drosen@google.com>, Jeff Layton <jlayton@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org,
 ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Now that a fscrypt_info may be set up for inodes that are currently
being created and haven't yet had an inode number assigned, avoid
logging confusing messages about "inode 0".

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/crypto.c  | 4 +++-
 fs/crypto/keyring.c | 9 +++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 9212325763b0f..4ef3f714046aa 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -343,9 +343,11 @@ void fscrypt_msg(const struct inode *inode, const char *level,
 	va_start(args, fmt);
 	vaf.fmt = fmt;
 	vaf.va = &args;
-	if (inode)
+	if (inode && inode->i_ino)
 		printk("%sfscrypt (%s, inode %lu): %pV\n",
 		       level, inode->i_sb->s_id, inode->i_ino, &vaf);
+	else if (inode)
+		printk("%sfscrypt (%s): %pV\n", level, inode->i_sb->s_id, &vaf);
 	else
 		printk("%sfscrypt: %pV\n", level, &vaf);
 	va_end(args);
diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index e74f239c44280..53cc552a7b8fd 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -817,6 +817,7 @@ static int check_for_busy_inodes(struct super_block *sb,
 	struct list_head *pos;
 	size_t busy_count = 0;
 	unsigned long ino;
+	char ino_str[50] = "";
 
 	spin_lock(&mk->mk_decrypted_inodes_lock);
 
@@ -838,11 +839,15 @@ static int check_for_busy_inodes(struct super_block *sb,
 	}
 	spin_unlock(&mk->mk_decrypted_inodes_lock);
 
+	/* If the inode is currently being created, ino may still be 0. */
+	if (ino)
+		snprintf(ino_str, sizeof(ino_str), ", including ino %lu", ino);
+
 	fscrypt_warn(NULL,
-		     "%s: %zu inode(s) still busy after removing key with %s %*phN, including ino %lu",
+		     "%s: %zu inode(s) still busy after removing key with %s %*phN%s",
 		     sb->s_id, busy_count, master_key_spec_type(&mk->mk_spec),
 		     master_key_spec_len(&mk->mk_spec), (u8 *)&mk->mk_spec.u,
-		     ino);
+		     ino_str);
 	return -EBUSY;
 }
 
-- 
2.28.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
