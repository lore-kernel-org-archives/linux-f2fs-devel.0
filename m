Return-Path: <SRS0=onZI=YW=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484B0CA9EC3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 29 Oct 2019 20:44:08 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A461208E3;
	Tue, 29 Oct 2019 20:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Hhb14SQ/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="eVs0xX0v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1vqZRv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A461208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iPYLX-0000cK-Pb; Tue, 29 Oct 2019 20:44:07 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1iPYLW-0000c4-HR
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 29 Oct 2019 20:44:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZoqXEVoMd/Zb8073EJGrjHX6xvE7y80eM5XUcJCac1E=; b=Hhb14SQ/0xmXBcNQ7tWBRwbqsu
 Qkq5ERxUE0Ir8twYJXmwagjl4ze88hO0Uf5v+KMmRlrZIhI6z+QLBEGVFLNGcU9z1PPHA8A1kEkVI
 +ejI/eTma6nqjQaCdP1JvN0rBaYwxmd76c/NrwP/phLBlHvdnhxCaiZtosddidXYn+sg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZoqXEVoMd/Zb8073EJGrjHX6xvE7y80eM5XUcJCac1E=; b=eVs0xX0vZ5AP5gOJrJInN9oKVI
 WV+iSSrVbfNmlP3TUJlU+WEKCUSshLUMEAT81LCCOdPOePlyz7MffEivDXAVhE8Jc5ZovtNT+xUKv
 Ywh1kHqp1NcOa9owZkRfTNvku/HOuAak5ES5upwtXDrEC5ye7LFS/cFumTZ7Y2J5SokQ=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iPYLR-006wyn-Gn
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 29 Oct 2019 20:44:06 +0000
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown
 [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 928D521479;
 Tue, 29 Oct 2019 20:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572381835;
 bh=6uKinpfPcLRaz3evDg6XWZp9GRM69VU/7RKl098ZYrc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=F1vqZRv2eFon0GtBrubS3F8e3n4v3lX+Jc7jDQg+EZxKCGfEixUVBHBkysbExqltN
 roBhndZO2TwSgAGdgGQDvkeehTBKaAmzZ3De6S2jApC8pcFCkEdmVptT1PczW0qk0K
 jbi9gPsqlqJrizoOxtRc9vp5wHXzAHRlP9oxJ79A=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Tue, 29 Oct 2019 13:41:39 -0700
Message-Id: <20191029204141.145309-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191029204141.145309-1-ebiggers@kernel.org>
References: <20191029204141.145309-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1iPYLR-006wyn-Gn
Subject: [f2fs-dev] [PATCH 2/4] ext4: support STATX_ATTR_VERITY
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
Cc: Theodore Ts'o <tytso@mit.edu>, linux-api@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, David Howells <dhowells@redhat.com>,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org, Victor Hsieh <victorhsieh@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Set the STATX_ATTR_VERITY bit when the statx() system call is used on a
verity file on ext4.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 516faa280ceda8..a7ca6517798008 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5717,12 +5717,15 @@ int ext4_getattr(const struct path *path, struct kstat *stat,
 		stat->attributes |= STATX_ATTR_IMMUTABLE;
 	if (flags & EXT4_NODUMP_FL)
 		stat->attributes |= STATX_ATTR_NODUMP;
+	if (flags & EXT4_VERITY_FL)
+		stat->attributes |= STATX_ATTR_VERITY;
 
 	stat->attributes_mask |= (STATX_ATTR_APPEND |
 				  STATX_ATTR_COMPRESSED |
 				  STATX_ATTR_ENCRYPTED |
 				  STATX_ATTR_IMMUTABLE |
-				  STATX_ATTR_NODUMP);
+				  STATX_ATTR_NODUMP |
+				  STATX_ATTR_VERITY);
 
 	generic_fillattr(inode, stat);
 	return 0;
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
