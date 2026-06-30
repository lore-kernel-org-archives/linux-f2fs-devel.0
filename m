Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA72C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3/x0kiTq2yO9PH8i1/jt0Iy8drzZhoII4CCKGecrg/4=; b=HEYMyTdOPo1pt87A/dHkZzxJq6
	RCG6vKBskfBxJhcUsvXbCduvju57WWrR1344OUqm1+uoRDQNPhqqGG2OJ9q0kDWOmqaUVh4Yrhn8B
	lcHs9LY3PqOffKNtPwHE17h5I4ca5QcgfcSMFjHOBQGffwBj6m2PbOkAm6b7fg1uzigk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1weTky-0005Et-0H;
	Tue, 30 Jun 2026 08:23:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1weTkw-0005Em-Ko
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 08:23:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ai7j7K4SitNJNYHWTCBnxrcpwUg65/T2eSrR4aBgQtw=; b=W+kA94T+WvYk3R/w1aDyA5FhjD
 QHL5Ai9eAH9BHUBp/Lyhh2cQn1qqi+UTRHlUSsi58cq/MmJ0J21pxyedjHrVckz2phUWCTGbT+owl
 Mq6gQxiPeKo0o/fgc8j0u1vcVHDMHefEqGtl3PRvfZfDXA74v1J00AaDmBxznetf7v7Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Ai7j7K4SitNJNYHWTCBnxrcpwUg65/T2eSrR4aBgQtw=; b=j
 KBFXrtv4656TwWsLm3NdeJuXZ+dI6BfrS8gwZML2z5d9yrm33LzAn+TGICfBDPd+mOvvfrc/RaXLW
 pdXdfhHojSugmQ9mXcoyD2UGBU0wjVceJMldlDbWtqGk5JIlQxh1mBdqUzdeN68xt/NmykzpzYbQv
 13Gq5g7IU47XfLCI=;
Received: from mail-pj1-f51.google.com ([209.85.216.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weTkt-0002EO-IZ for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 08:23:46 +0000
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-36b9d265355so2070191a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 30 Jun 2026 01:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782807818; x=1783412618; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ai7j7K4SitNJNYHWTCBnxrcpwUg65/T2eSrR4aBgQtw=;
 b=W0qnczOIdMZKKG8HCbHf54L+bVo7k6hmPM6lKqNksU7qCvUCZjUeMKOsN73LNV8w+A
 NYo5nmFsA4+H5kHl4jMWZz3oWjl7bgaVH1fwdZnPsKjCH2g8Lh61as5cjVcGDCuO41OH
 T1R+HLK+1MbI17z5tacZUw23cfQ9rU2ZB8QKve27JOskjs2uYkfIJm2XbzB7outqLTrf
 JyWdKIx30mUGXmX69nBpyYp08uLFAIqzLv+QYqxuMRbk1vlzfAt6DVts45s5vQjdYFP2
 +7mtrJR2gsm9IWoCf6MCwX10Ln/m/U/MIUb1yE0iDCcLkguXuEzWVex2ebnWjdbUGYlf
 34YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782807818; x=1783412618;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ai7j7K4SitNJNYHWTCBnxrcpwUg65/T2eSrR4aBgQtw=;
 b=Zwdn6tCpaZnRg0DaeUx8UQ2POtFwqp0bRzRQOg84t8/7/oX0ggc4XK6zlzQ/aA29rn
 ZXVKOc00T8XmhxY9rA9uLkLrocGdRUiosgBqgDxXC18FXTqDBICPoc7lef8A5u241L3I
 Ul/vak2XA+O5I+d0/dAvqhP96sv4xW5EsEkTamjgZvYwgYow8MMaOJVjSA+5gYmf165I
 4XjVQinebxP0je44TnMYQ/N3QcAl9Za5wcfz07ryvTygBKiKpLaeJPdZ36J5f9s72LBQ
 QoUFRlDShqRHcvOhw2nSx4VbGw2t9QQeV8kwpiyUpOyoRRDroJ/OVs/ALFm2LCvhQ+W0
 wgHw==
X-Gm-Message-State: AOJu0YxbQBvj3FoDWz8uwXHQFJZtY7Deow6hxxhSSTj0+q9rdq9btVLA
 k5yUkS1kOgF/NWFaDhuoJoGojMsMW+qf0i+Zpq497drhZPT8d8/Q6WFD
X-Gm-Gg: AfdE7ckgWd3g2I4iIbUShwH9h6juSSiryyGWHRP3Yd/RMe/L+y7ifMCKaqawWyq3AF5
 HEEGutavOFd795D7WQy+ISkPjRxrWIQzkeKq3TJ72QGrTRKR73BI5i5QsxuHMXf5ubODmKbvxa1
 cb8vO7cDioJ4w4xeps5zciJo6avbE6Gq5RcR0NGYSX6+YrCfhoGI7/CbjrBaeg+Tx86tFLVLRDo
 1SdupF1L90SBo9aTbOaUz64sohuSYwwphJKKsIvRO+wLDKjrrr97mqVCc4b6zZ6qpr7dfTAW12O
 02XbiIBBr+6AKv/iWo2nedhhtIJhVLH/ysB15d/7vQVgpCFTCDaxLiL+7ncLtbUk2h9f1L+C4gR
 yU87tMJi/8k2EMiO6nIHRHeMs/RkiRxPR5Zt1oaf+43rNlDLuEi1GRwb4KOSLmixjGbmr0j/TcR
 j8Ql7IS/oDhj07hVXhY7fQqs1XupujUHEXR/bdxTOFqDN7z1mn
X-Received: by 2002:a05:6a21:3949:b0:3aa:f9cb:d438 with SMTP id
 adf61e73a8af0-3bfc50b3d1bmr2362651637.21.1782807818196; 
 Tue, 30 Jun 2026 01:23:38 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9bbc6d9ed9sm1108183a12.7.2026.06.30.01.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 01:23:37 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Tue, 30 Jun 2026 16:23:30 +0800
Message-ID: <20260630082331.2757376-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1weTkt-0002EO-IZ
Subject: [f2fs-dev] [PATCH] f2fs: limit recovery filename logging to stored
 length
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
Cc: qwjhust@gmail.com, stable@kernel.org, qiwenjie@xiaomi.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

F2FS stores recovery filenames as a length plus a fixed-size i_name
buffer.  The buffer is not NUL-terminated, but recover_inode() and
recover_dentry() print it with %s.

For a 255-byte filename, recovery logging can read past i_name into the
following raw inode fields.

Print the name with a precision bounded by i_namelen and F2FS_NAME_LEN.

Fixes: f356fe0cba0e ("f2fs: add debug msgs in the recovery routine")
Cc: stable@kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/recovery.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 89af8407b667..3fecfdbd5958 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -158,6 +158,22 @@ static int init_recovered_filename(const struct inode *dir,
 	return 0;
 }
 
+static const char *recover_printable_name(struct inode *inode,
+					  struct f2fs_inode *raw,
+					  int *name_len)
+{
+	static const char encrypted_name[] = "<encrypted>";
+
+	if (file_enc_name(inode)) {
+		*name_len = sizeof(encrypted_name) - 1;
+		return encrypted_name;
+	}
+
+	*name_len = min_t(unsigned int, le32_to_cpu(raw->i_namelen),
+			  F2FS_NAME_LEN);
+	return raw->i_name;
+}
+
 static int recover_dentry(struct inode *inode, struct folio *ifolio,
 						struct list_head *dir_list)
 {
@@ -170,7 +186,8 @@ static int recover_dentry(struct inode *inode, struct folio *ifolio,
 	struct inode *dir, *einode;
 	struct fsync_inode_entry *entry;
 	int err = 0;
-	char *name;
+	const char *name;
+	int name_len;
 
 	entry = get_fsync_inode(dir_list, pino);
 	if (!entry) {
@@ -229,12 +246,9 @@ static int recover_dentry(struct inode *inode, struct folio *ifolio,
 out_put:
 	f2fs_folio_put(folio, false);
 out:
-	if (file_enc_name(inode))
-		name = "<encrypted>";
-	else
-		name = raw_inode->i_name;
-	f2fs_notice(F2FS_I_SB(inode), "%s: ino = %x, name = %s, dir = %llu, err = %d",
-		    __func__, ino_of_node(ifolio), name,
+	name = recover_printable_name(inode, raw_inode, &name_len);
+	f2fs_notice(F2FS_I_SB(inode), "%s: ino = %x, name = %.*s, dir = %llu, err = %d",
+		    __func__, ino_of_node(ifolio), name_len, name,
 		    IS_ERR(dir) ? 0 : dir->i_ino, err);
 	return err;
 }
@@ -282,7 +296,8 @@ static int recover_inode(struct inode *inode, struct folio *folio)
 {
 	struct f2fs_inode *raw = F2FS_INODE(folio);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	char *name;
+	const char *name;
+	int name_len;
 	int err;
 
 	inode->i_mode = le16_to_cpu(raw->i_mode);
@@ -331,13 +346,11 @@ static int recover_inode(struct inode *inode, struct folio *folio)
 
 	f2fs_mark_inode_dirty_sync(inode, true);
 
-	if (file_enc_name(inode))
-		name = "<encrypted>";
-	else
-		name = F2FS_INODE(folio)->i_name;
+	name = recover_printable_name(inode, raw, &name_len);
 
-	f2fs_notice(F2FS_I_SB(inode), "recover_inode: ino = %x, name = %s, inline = %x",
-		    ino_of_node(folio), name, raw->i_inline);
+	f2fs_notice(F2FS_I_SB(inode), "%s: ino = %x, name = %.*s, inline = %x",
+		    __func__, ino_of_node(folio), name_len, name,
+		    raw->i_inline);
 	return 0;
 }
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
