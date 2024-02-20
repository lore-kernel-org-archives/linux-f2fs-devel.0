Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6F5C48BC3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:53:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rcLsU-0000F6-QF;
	Tue, 20 Feb 2024 08:53:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <eugen.hristev@collabora.com>) id 1rcLsT-0000Eq-AO
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Feb 2024 08:53:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a10dU96oUgbeeU2HILozQQtbAHEtwkt6EHOQl3WO/6M=; b=JZChYRGecbuBYe8Mck7J2G7OV/
 30u8gBAoNRH6BdZ6xb7OhrXcG9CVRziCublgxb+QfevbPmT3bv11DlTFactJdjNSMIQ0XZ+VIMnv8
 q7t5GVA//sj4CMu7LTyTRbrkMkMCieYhp5Et1eUVTkGVq+tVpG5pBgNaWTC7e16hEz9g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=a10dU96oUgbeeU2HILozQQtbAHEtwkt6EHOQl3WO/6M=; b=ApzTGDAS+TQVsDYU7hnpy7I3IS
 qVuP13WeaGEMBBzscWLx8l+o7YWzaYrp/tISBB5VUCECtJ9GaFEObRllVcfspMnziE07D98MwRydW
 qjYZF9qLb1fkxzmQXsAMqeYPmwcRz7pH88OR4wFn9USRGCV4qInegwCSAlvFCdai80qs=;
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rcLsR-0004H3-7E for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Feb 2024 08:53:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1708419193;
 bh=cVITJNZ35p97HDzRx3PUv0ugSW5S2fLqOWH88XqFex0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rRouZNa9WuyH+2RWTe+Ze9yMxCMI9N+ShmaKvWeh1NHyPiBFohuYsrp+BI4Y6rKXS
 xAcOVr9u4APwRw6P4xazTNUOPOyAtfIp4B7+sK7HWRPOQpc0dmNOBkY8Ztz9yAXWpL
 VfjzHrBO/dV9kMLqB33qT0087G4pEIFNvt0taSd/9jKL5SlfMXN1LC+6WghW+aafcd
 7QklPcIE0D5RO382XXp8LIto0Nstgeb76lCTZbox6qyIAzRORRj6vhIT+gufCgyFpd
 JtnFhcAhuamsP4C7FtX4TGoO41pQ28M8AYWPdDZWXBQQXLpfQ2YXJyTvyEGZBLTXZV
 YnTEWxSd64Sfw==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 925723782098;
 Tue, 20 Feb 2024 08:53:09 +0000 (UTC)
To: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 jaegeuk@kernel.org, chao@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Date: Tue, 20 Feb 2024 10:52:33 +0200
Message-Id: <20240220085235.71132-7-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220085235.71132-1-eugen.hristev@collabora.com>
References: <20240220085235.71132-1-eugen.hristev@collabora.com>
MIME-Version: 1.0
X-Headers-End: 1rcLsR-0004H3-7E
Subject: [f2fs-dev] [PATCH v12 6/8] ext4: Log error when lookup of encoded
 dentry fails
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
From: Eugen Hristev via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: krisman@suse.de, brauner@kernel.org, jack@suse.cz,
 Eric Biggers <ebiggers@google.com>, linux-kernel@vger.kernel.org,
 eugen.hristev@collabora.com, viro@zeniv.linux.org.uk, kernel@collabora.com,
 Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Gabriel Krisman Bertazi <krisman@collabora.com>

If the volume is in strict mode, ext4_ci_compare can report a broken
encoding name.  This will not trigger on a bad lookup, which is caught
earlier, only if the actual disk name is bad.

Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 fs/ext4/namei.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 6e7af8dc4dde..7d357c417475 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1477,6 +1477,9 @@ static bool ext4_match(struct inode *parent,
 			 * only case where it happens is on a disk
 			 * corruption or ENOMEM.
 			 */
+			if (ret == -EINVAL)
+				EXT4_ERROR_INODE(parent,
+					"Directory contains filename that is invalid UTF-8");
 			return false;
 		}
 		return ret;
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
