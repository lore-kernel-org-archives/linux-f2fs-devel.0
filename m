Return-Path: <SRS0=FtoV=47=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6831C5ACBF
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 14 Mar 2020 20:53:33 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B850F20828;
	Sat, 14 Mar 2020 20:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="dv8b1y8Q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="NL13iRZY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZfFkIOM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B850F20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jDDmn-0006bx-Dc; Sat, 14 Mar 2020 20:53:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jDDmj-0006bE-9y
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 14 Mar 2020 20:53:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Pp6U9zxw1ahQ6NP++1Emk0WMyLUkSoYXAFsBl+jYMSw=; b=dv8b1y8QCajI3RSfokJW3BbgxI
 EbtgL4ajo9JcvnDOfwJvPTYTYKgiwYJmBn2uARewrcjyvf9SumiG9a/yLAwh4COnSFKxdsN2ECdP3
 UGYG/KDqS5qdXtMKHrGiiJYhqG/Ozvyhs7PrChWXCyJTrObb2XHU31uL7tV72sVuMcds=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Pp6U9zxw1ahQ6NP++1Emk0WMyLUkSoYXAFsBl+jYMSw=; b=NL13iRZY+zYVj6XbS4W+TFAfYY
 OZcO1zfDvj+U/5e7U4VM0aA1GyiQMVH6NiMlzKS4CbhkKFnkXbtf7yDiYgHpI2tbkhk5vlS5r2d7D
 qaGX0Usoypug7YfeAcvIMUzaskHZREzuvfBME3sExu9hYskWCKfRhBHIFsP1CPPRcPUs=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jDDmi-001Nos-8H
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 14 Mar 2020 20:53:29 +0000
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9A95620790;
 Sat, 14 Mar 2020 20:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584219193;
 bh=CmnZSp1cD9W7GBGuNrZlONVYibn7gCqqoj6gfIP9vA4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gZfFkIOMgxmssruP+ea9EmjgNTu0xB1lPyOJtKrZoCw0s+W9sImhe8b8XapQ7wupz
 k50I7OFwE0y6DZSyUAaqAE1YEnztPP4sMCFh4vnyxj01ht3I67/QjbWDkGypsH3cxy
 winlpMSIqpy6GLkVeR2z71N6lCVDH7b4zg7GOjn8=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Sat, 14 Mar 2020 13:50:50 -0700
Message-Id: <20200314205052.93294-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200314205052.93294-1-ebiggers@kernel.org>
References: <20200314205052.93294-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1jDDmi-001Nos-8H
Subject: [f2fs-dev] [PATCH 2/4] ext4: wire up FS_IOC_GET_ENCRYPTION_NONCE
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
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

This new ioctl retrieves a file's encryption nonce, which is useful for
testing.  See the corresponding fs/crypto/ patch for more details.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/ioctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index a0ec750018dd3..0c1d1720cf1ae 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1210,6 +1210,11 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			return -EOPNOTSUPP;
 		return fscrypt_ioctl_get_key_status(filp, (void __user *)arg);
 
+	case FS_IOC_GET_ENCRYPTION_NONCE:
+		if (!ext4_has_feature_encrypt(sb))
+			return -EOPNOTSUPP;
+		return fscrypt_ioctl_get_nonce(filp, (void __user *)arg);
+
 	case EXT4_IOC_CLEAR_ES_CACHE:
 	{
 		if (!inode_owner_or_capable(inode))
@@ -1370,6 +1375,7 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case FS_IOC_REMOVE_ENCRYPTION_KEY:
 	case FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS:
 	case FS_IOC_GET_ENCRYPTION_KEY_STATUS:
+	case FS_IOC_GET_ENCRYPTION_NONCE:
 	case EXT4_IOC_SHUTDOWN:
 	case FS_IOC_GETFSMAP:
 	case FS_IOC_ENABLE_VERITY:
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
