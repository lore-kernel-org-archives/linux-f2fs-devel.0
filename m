Return-Path: <SRS0=U42b=WH=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E34C32756
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 11 Aug 2019 21:37:27 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A1BD20818;
	Sun, 11 Aug 2019 21:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="LXsZldUc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="f9ZZieS/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xzkZzx7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1BD20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hwvWp-0003Ci-9x; Sun, 11 Aug 2019 21:37:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hwvWo-0003CW-Ko
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 11 Aug 2019 21:37:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7uRd7fDvi3Zf6LZuHtUtPKu6J9j+Xc2IzHvXNmQZQIk=; b=LXsZldUcWzx2wKdPNndxUrH/lM
 lXsq8Tduk/e4+c4AFHGLsMpWSZ2eLo8hOmHMbYVMR4JtrybcKsRHJAAZllsGlzKgPlEKERBQfSY89
 anwXekGpDToC1siAml6a3HFo68hPwor+jIjUWBdO75qUIPi8F16b877QypLZ55za4J2I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7uRd7fDvi3Zf6LZuHtUtPKu6J9j+Xc2IzHvXNmQZQIk=; b=f9ZZieS/pIyCl00H4OnFxDNO91
 LQ3ONPZO1HPbA47y8hF4/thbCuj+6j5ENsMANRDQuAbyhX7CbpPufhz2WtBcjN34AuEEGMs/fOxsd
 XBdLW1LDM5fq6aU/woJ2hKUbJOP9HTu2EeBiDREMOkoA3qmQfE7MKe95zAUhRVSEpS6s=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hwvWn-000YlR-IV
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 11 Aug 2019 21:37:26 +0000
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net
 [24.5.143.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6E842216F4;
 Sun, 11 Aug 2019 21:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1565559433;
 bh=p/SZRYcADvPD/FuvRi8uPfjTa+Ri4JfMVG7sxvqkbAc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=xzkZzx7MZETwgWv7D7aFx91csOHB28dyd6s+TrD52+T1/aASBZcbWvrg4J5chjSfr
 CUKVkJv1IaQYj7PXsiKRu2IpxBRYzEmPfdaQO6yA0mNU+XUJLEg9jvbGPH95m3DegH
 ZzFpHKz0y61SdzkGZTEyCxSofY5+xsab/e2wYfG8=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Sun, 11 Aug 2019 14:35:56 -0700
Message-Id: <20190811213557.1970-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811213557.1970-1-ebiggers@kernel.org>
References: <20190811213557.1970-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1hwvWn-000YlR-IV
Subject: [f2fs-dev] [PATCH 5/6] ext4: fix comment in ext4_end_enable_verity()
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
Cc: linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/verity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index bb0a3b8e6ea71..d0d8a9795dd62 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -196,7 +196,7 @@ static int ext4_end_enable_verity(struct file *filp, const void *desc,
 				  size_t desc_size, u64 merkle_tree_size)
 {
 	struct inode *inode = file_inode(filp);
-	const int credits = 2; /* superblock and inode for ext4_orphan_add() */
+	const int credits = 2; /* superblock and inode for ext4_orphan_del() */
 	handle_t *handle;
 	int err = 0;
 	int err2;
-- 
2.22.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
