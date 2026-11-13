Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACE7606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 13 Nov 2026 07:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=eISLHynZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=exS+/uez;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fUaHp0ci;
	dkim=neutral header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VI25OFxG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:References:Mime-Version:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=IGjpzNlzv2oiHHU8DSHTZZ9ddK8z5GIjYlyjOh8KrpQ=; b=eISLHynZGOx2psJ9uuYjNYLFtB
	Nkz7d/ydn82MNTjucg9fOFpIxAXchzSeW9Vzc9FdJ2vd0xnmFHe3irb9nj6IpGdbyBNtU3lE2FbxT
	NIopmb2BX1J9LhfyVbcT0PP9ANEhcCVZoYP/EVhP/9v9X6JCWc6FaZGyXLBBxm5bq/f4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRm14-000000003NR-0DBQ;
	Fri, 13 Nov 2026 07:48:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1) (envelope-from
 <3-LP2ag4KAJkL3KMA3DDNDK7MB9HH9E7.5HF@flex--sarthakkukreti.bounces.google.com>)
 id 1xRm10-000000003NI-49XS
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 07:48:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZXZy87FYbCuQ3bk0rNuxzYnSFzxorcUKJ7haQiR5YMs=; b=e
 xS+/uez6c+km1kKrgr+vkvW9u5MARReiX+IizO0GiZDI/KlpGUZvm7Yuc5j+Nr4kLduNbqGOlhclI
 SePaclw0VhDcvDjuEn/UdZJeX+p8CtH6/AGnD2C2eSHvIrSB2AlsVjZ6XWken6tGlBmRpBtu/Z17f
 JRUg8Xacv/eMDPNY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZXZy87FYbCuQ3bk0rNuxzYnSFzxorcUKJ7haQiR5YMs=; b=fUaHp0ciHY1dQMlofJH8S1gwwR
 qRwFtCDCp4R0hU99VNlEzM33oFVEF3W8iPA1QXvrfjx5aO0I6BNMXWW63rIL44p4S+m7MpZjijjY0
 eNLk3J2qzx4XKK46FKJG5pC9K8I75YtTtB1wr4lyvviuHjs0CoSuoYQj7LjJ61hfSifg=;
Received: from mail-pf1-f197.google.com ([209.85.210.197])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRm0x-000000002lH-0tol
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 07:48:06 +0000
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8b60129a46eso1000664b3a.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 23:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794556077; x=1795160877;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZXZy87FYbCuQ3bk0rNuxzYnSFzxorcUKJ7haQiR5YMs=;
 b=VI25OFxG9S0JX4/i94/rL37COo4dsiTab4tyzRtxBcPl6reYiYMPLa+eRGeUcnyAWP
 zj3bzMqbI29AMC6bpZxN3finxhLB1QM6sfUlftfcDQxFM4YSszHz4xHZ0xJD7cdlGLLX
 QcQdFila+zKZHmixZ1rrHUiclk9hVAeJ6WLPF7GoLieyGJUNyaVDGfTj4kcpUgy34QC+
 X5Hc8iqX3YsV8GiVQCSb/R4zXWwkWF36d9aJZ1gHec5CvFXwe4hxRdDxPWkYTivb6B2F
 msWHrw4ZPZMBbfXKGqD3ZNXkRSZQ9cdVGhllzLkGkR6b/RXwXmjPOkk67vUF2Fy5eUaX
 B0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794556077; x=1795160877;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZXZy87FYbCuQ3bk0rNuxzYnSFzxorcUKJ7haQiR5YMs=;
 b=pM6wBimXwzeMwTwYHzQIKXfp4zlpovCyCdntfNdqt8Nu/hMWtpH6qv7b2qym2uCehh
 aiSy+FbmH8Qi2uYjYYEdvjU9oCzURa+61O7leHb8tZUfG7Y2TxE4+Gdr5D8QoDK30tZD
 TWzAS/hMiG0yrJywkb5v6hxC6VbL+d8TbYUk+eE+ngVMXCL5DQ91TuU9AjzDuQg3AY8m
 FR+DyPD447yRglCbgKsBuv+DTGproHWF3PMhCmyRZTO7t+Sm5W/XJD7pOo9ieUEdqh/0
 N04B8Zzn+SzJWK4atl8eJ6ReVggXiAXLYxzY+J7cOGJfnQ3xbDspCqd/mUwU0i0d6/Md
 APQg==
X-Forwarded-Encrypted: i=1;
 AL+hErGF2I8Z2I94oJlZ6lX4YExXrGplK1ygBu9YxxfNkR/LhINiC5kUhtALO1Fl5I9SAEl18fi6lMwg/HQ8lPrTZqtg@lists.sourceforge.net
X-Gm-Message-State: APuU4Z84MugXtrAvfI6D8WQRZi/tuD7jDROuJqVzwnRKb5KxY5iz+Znk
 iTLh+mWrS+wd4lTli0ZkG0hEu9RwSNXGCXgNxsqC4UyTDn4Xyu/vtsVatVUDogfIJvAmOQ8CRTd
 HxNLtU7Cq/B9zfq/OM8CPRIVgwkI6V9UhZXa6ug==
X-Received: from dlbrl10.prod.google.com
 ([2002:a05:7022:f50a:b0:1b2:4b7e:5356])
 (user=sarthakkukreti job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:170f:b0:190:8f72:445e with SMTP id
 a92af1059eb24-1b5030e2d75mr1782938c88.11.1794552824499; 
 Thu, 12 Nov 2026 22:53:44 -0800 (PST)
Date: Thu, 12 Nov 2026 22:53:32 -0800
In-Reply-To: <20261113065332.929085-1-sarthakkukreti@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261113065332.929085-1-sarthakkukreti@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261113065332.929085-4-sarthakkukreti@google.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
X-Spam-Score: -7.6 (-------)
X-Headers-End: 1xRm0x-000000002lH-0tol
Subject: [f2fs-dev] [PATCH 3/3] f2fs: reject casefolded names that fold to
 ".", "..", or empty
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Sarthak Kukreti via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Sarthak Kukreti <sarthakkukreti@google.com>
Cc: Eric Biggers <ebiggers@google.com>,
 Sarthak Kukreti <sarthakkukreti@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
 Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dmitry Torokhov <dtor@google.com>

Filenames consisting only of ignorable Unicode characters fold to empty
strings, and names with leading dots and ignorable characters can fold
to "." or "..". Allowing such names in casefolded directories can corrupt
directory structure or cause confusion with special entries.

Reject any non-dot names that fold to empty, ".", or ".." during
casefolded name setup, while still allowing invalid UTF-8 sequences to
be handled as opaque byte sequences when strict mode is not enabled.

Fixes: 2c2eb7a300cd ("f2fs: Support case-insensitive file name lookups")
Signed-off-by: Dmitry Torokhov <dtor@google.com>
Signed-off-by: Sarthak Kukreti <sarthakkukreti@google.com>
---
 fs/f2fs/dir.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index fd0e2cd31a81..a20723edb724 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -77,13 +77,17 @@ int f2fs_init_casefolded_name(const struct inode *dir,
 
 		len = utf8_casefold(sb->s_encoding, fname->usr_fname,
 				    buf, F2FS_NAME_LEN);
-		if (len <= 0) {
+		if (len < 0) {
 			kmem_cache_free(f2fs_cf_name_slab, buf);
 			if (sb_has_strict_encoding(sb))
 				return -EINVAL;
 			/* fall back to treating name as opaque byte sequence */
 			return 0;
 		}
+		if (len == 0 || name_is_dot_dotdot(buf, len)) {
+			kmem_cache_free(f2fs_cf_name_slab, buf);
+			return -EINVAL;
+		}
 		fname->cf_name.name = buf;
 		fname->cf_name.len = len;
 	}
-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
