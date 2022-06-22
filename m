Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6007C43334
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Jun 2022 19:46:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o46JA-0007da-7I; Wed, 22 Jun 2022 19:46:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <krisman@collabora.com>) id 1o46J8-0007dR-JC
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Jun 2022 19:46:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ARS9sCr8hTgHVmXjCG765oPkuNaZ5ttZWVD1LamEXM8=; b=AXIm8rCZLNm5ITcVPz4oskN1q7
 omKBjpU9yYO1vKyvHoFsx5su43V8SHRXrsyloWusUX5llvzjBPBUj4qkFa0XTqp455jGS2CGTA3LU
 un8qKK9oGoXQplQCpmZGeF2RIndSttgvEVgixGC4QvTowwdIzn+TAIuKDdBLe9mh6pUo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ARS9sCr8hTgHVmXjCG765oPkuNaZ5ttZWVD1LamEXM8=; b=j/kct6HqUVNyT45KiH1Gb8lK64
 zq7d9tNb4uHLcShd/JbHdmnriP/nWEezvUg7+upmN41ij5E2NyXwJuSqg3b1CFsVOqsdvP3m4PPN8
 6DFdy2bxvJK86cXzMOmzRDHeXAYz9kZFzkU9e8qhqmrWjpo/QE3z0egcLnBSZKbJMeA0=;
Received: from madras.collabora.co.uk ([46.235.227.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o46J6-0001Sz-JB
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Jun 2022 19:46:33 +0000
Received: from localhost (mtl.collabora.ca [66.171.169.34])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: krisman)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 2E82D66016F3;
 Wed, 22 Jun 2022 20:46:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1655927186;
 bh=NSq4T8R/1LjZv5IrK3mdyn3xE+5FT2PzLu7hjGyXJ8I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AUR+/OEvMPXYmzpyw/GFzzW5OiytNveWhrXb2oYJeS9fEZ0LnRb8yh6MfmRs9tEAb
 Id+mlGvra+nHetd3FS22lYbDCH0WGAPrzXsS6hvZaS+yGy1od5zt2u/77M2/JMBwzA
 HTjyWE6dySUG6yDZF4AWU5gPGAgfYtoe2gVHNc3qYJHmd3591VXef+9Relpb5HZKjq
 mOnOl3dCSKl1dyC+vIRKnRgI0R84ZDjftOKWP467LPbR2kSAC12cxaO3H/2YF1zF+r
 862dIo+COp+HkW6oq338S/otfs2MQSfBHpmyFKhyYIVdFYf+/HgdVNaPBaFwbpI93w
 qQM1yas2MV+wA==
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: viro@zeniv.linux.org.uk,
	tytso@mit.edu,
	jaegeuk@kernel.org
Date: Wed, 22 Jun 2022 15:46:00 -0400
Message-Id: <20220622194603.102655-5-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622194603.102655-1-krisman@collabora.com>
References: <20220622194603.102655-1-krisman@collabora.com>
MIME-Version: 1.0
X-Headers-End: 1o46J6-0001Sz-JB
Subject: [f2fs-dev] [PATCH 4/7] libfs: Support revalidation of encrypted
 case-insensitive dentries
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
Cc: kernel@collabora.com, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Preserve the existing behavior for encrypted directories, by rejecting
negative dentries of encrypted+casefolded directories.  This allows
generic_ci_d_revalidate to be used by filesystems with both features
enabled, as long as the directory is either casefolded or encrypted, but
not both at the same time.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/libfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index de43f3f585f1..e4da68ebd618 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1461,6 +1461,9 @@ static inline int generic_ci_d_revalidate(struct dentry *dentry,
 		const struct inode *dir = READ_ONCE(parent->d_inode);
 
 		if (dir && needs_casefold(dir)) {
+			if (IS_ENCRYPTED(dir))
+				return 0;
+
 			if (!d_is_casefold_lookup(dentry))
 				return 0;
 
@@ -1470,7 +1473,8 @@ static inline int generic_ci_d_revalidate(struct dentry *dentry,
 				return 0;
 		}
 	}
-	return 1;
+
+	return fscrypt_d_revalidate(dentry, flags);
 }
 
 static const struct dentry_operations generic_ci_dentry_ops = {
@@ -1490,7 +1494,7 @@ static const struct dentry_operations generic_encrypted_dentry_ops = {
 static const struct dentry_operations generic_encrypted_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
 	.d_compare = generic_ci_d_compare,
-	.d_revalidate = fscrypt_d_revalidate,
+	.d_revalidate_name = generic_ci_d_revalidate,
 };
 #endif
 
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
