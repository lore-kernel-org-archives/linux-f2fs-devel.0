Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC69CD1293
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  2 Apr 2024 15:49:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rrgNu-0005Eq-Ch;
	Tue, 02 Apr 2024 15:49:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <eugen.hristev@collabora.com>) id 1rrgNo-0005EI-Gu
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 02 Apr 2024 15:49:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CHRzt4jsIq4Oa125HeJ+JV37wGYiasMe0OFhsxhy3w8=; b=Fayn2UhgozalRGqeIK400q9aF7
 AV+q0qZHkYpt3ubhYp6N2HwAqhIU0yMZqs38SIaZH5RbERd/SawHt1dJjB7MMM0CjQdJXvgGE7zJ/
 IhUjpXUPevfTnuZ6HXRqNIEiVUyAD5NW30dXlIoRQ13EeIOpqzzU5ajCsH1u42jYkY5Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CHRzt4jsIq4Oa125HeJ+JV37wGYiasMe0OFhsxhy3w8=; b=GmwQakR178kZngpsga3BiMBOi0
 Xkf5jYJppaYCbKBWK5puoOqPOgL7evHTHzccPN6+3rIjkTvVObz0yCkXBe1fqM22iw6xfa1TjmkYe
 esxSku+J+jJnLRyE2bhdhB6sNm9oajv7ukCRk9DpQ0KeM5UO+rm2UdSWpUmn56yD1yFE=;
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rrgNn-00043K-Sx for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 02 Apr 2024 15:49:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1712072936;
 bh=IfRmBs/VQkfKjJFkvo6pie00L4VVXFYihT/akWQE4ic=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DOrp/SL4kYewXK66WVjQc1/mDm1Tmp7wW7CniDjHoGxjckveBZJKXBF9PkUkRw0dt
 /8Gg8nKilcx92NCErLQF4hTJ4XO+qzFjh8nAz4ZgNOJduwAlISMXqHwAsJp4yXesCR
 F9RXo5Lhhj1Bn3DsE/ZELAptMvrhcYnSANtSj9Eq6rR51dUIBKiU7NZBHxQWdDgI2L
 qlGy5py7/8LavzFbWm8PDVEhOzU8owFrpXtKV7dF3oAqWmx4d8Q8RiTeYdx7GK8pme
 ulyb8ATrbw+S3jrqBCwTbcxMQN4OI+ybvlQ9vy5fDK4oZSfvPhVg3PHn5/MKM+EoX9
 KXXd9Hw+88QtA==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id E417337820F9;
 Tue,  2 Apr 2024 15:48:55 +0000 (UTC)
To: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 jaegeuk@kernel.org, chao@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Date: Tue,  2 Apr 2024 18:48:40 +0300
Message-Id: <20240402154842.508032-8-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402154842.508032-1-eugen.hristev@collabora.com>
References: <20240402154842.508032-1-eugen.hristev@collabora.com>
MIME-Version: 1.0
X-Headers-End: 1rrgNn-00043K-Sx
Subject: [f2fs-dev] [PATCH v15 7/9] f2fs: Log error when lookup of encoded
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
 linux-kernel@vger.kernel.org, eugen.hristev@collabora.com,
 viro@zeniv.linux.org.uk, kernel@collabora.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

If the volume is in strict mode, generi c_ci_compare can report a broken
encoding name.  This will not trigger on a bad lookup, which is caught
earlier, only if the actual disk name is bad.

Suggested-by: Gabriel Krisman Bertazi <krisman@suse.de>
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 fs/f2fs/dir.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 88b0045d0c4f..64286d80dd30 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -192,11 +192,16 @@ static inline int f2fs_match_name(const struct inode *dir,
 	struct fscrypt_name f;
 
 #if IS_ENABLED(CONFIG_UNICODE)
-	if (fname->cf_name.name)
-		return generic_ci_match(dir, fname->usr_fname,
-					&fname->cf_name,
-					de_name, de_name_len);
-
+	if (fname->cf_name.name) {
+		int ret = generic_ci_match(dir, fname->usr_fname,
+					   &fname->cf_name,
+					   de_name, de_name_len);
+		if (ret == -EINVAL)
+			f2fs_warn(F2FS_SB(dir->i_sb),
+				"Directory contains filename that is invalid UTF-8");
+
+		return ret;
+	}
 #endif
 	f.usr_fname = fname->usr_fname;
 	f.disk_name = fname->disk_name;
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
