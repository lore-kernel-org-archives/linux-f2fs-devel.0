Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47238C5DF7D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uVaF+lTVXdlhtbnOX9/Ut9Fo7V/GWQAP/4RMWFep/0k=; b=TDz+MkMYzuyeI3EW7KXz7s/DGz
	efmDGJKEtN1qG3ruVOhX4+oDGyeXQLFPiHXkBiKjDzfUO1QemDQ89xAw1EbnISZsuqll7AIABhy3c
	2J6V01uWKZtNMpWZX6EjY81RBj2s8oDkwJyOO4cfaaQmKX6lPluhQUlgpkUu75j+gQTk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwQ0C-0008LB-I3;
	Tue, 18 Aug 2026 20:01:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wwQ05-0008L1-RR
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 20:01:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oApSZ+xjQqEGnmtA+2OFzN0u4dpf13tcnX0/NXjKHu0=; b=XPaepgW5/WBOd4bOixvO8kttaE
 TF80rtE3Cyu8J8pDrEfU3+OgzF7j1FeAb6y9M1wiwTUxB2D7pTlT6JLI1+LQeiwmWj5HYDz+z2tSq
 p8P93nN7hr5hyW6pBbZcgJOwt/3yW7y5XT1CouCXkMrUrt0CHhkQ/vcdYGjI5LBXcVpY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=oApSZ+xjQqEGnmtA+2OFzN0u4dpf13tcnX0/NXjKHu0=; b=J
 cgC1y1gYk7p7lwZxoTZOF9prPdTS09VQpnfcciKWlMocWdWgVYiVyuVgfO/dhHF0uDXXE0dWBHQWj
 oEGuLNtgSA/UvDpIBNSCjDOvTg2AkDaO8OfN296zYDgtR+5FiY35uv2ft49gOOV2NiqD8BpFdJXZu
 Zc9adbJDH46HxOOQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwQ05-000085-5w for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 20:01:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8B70E601DE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 18 Aug 2026 20:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276411F000E9;
 Tue, 18 Aug 2026 20:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787083287;
 bh=oApSZ+xjQqEGnmtA+2OFzN0u4dpf13tcnX0/NXjKHu0=;
 h=From:To:Cc:Subject:Date;
 b=ji+zKFAn9xvUtWV98Des7jh1qzOyQoeXFyUeV83Iw0PEbCFB/GUClwzFW7666lbQo
 uwcFgDn8T+DfGqxL5InK64aonW9iNZtV7Jd10C1uKe7WJSHaQqvuUBMWsKMLj3+R2S
 7CQuwe3UoQgbGZbGZw82Yw/SBp2F+Tqjo0jdxgCPkzDkzQ4aXY9vguKGOQWqcQrJDV
 /yIEsEsGHyhqkIfJ7DUPM6iJXZKyUyfxp9iP30I9lGD/s7uYdhQMSRQieJ5J/0Mamf
 KKmqxVry3/EhfOrl3YgO9Fls1nnYBHKyvqCBxaP40jmWpppuQp3qBoyjVLnq0dqprZ
 QTggyKUfz7udQ==
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 18 Aug 2026 20:01:21 +0000
Message-ID: <20260818200121.2684318-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
MIME-Version: 1.0
X-Headers-End: 1wwQ05-000085-5w
Subject: [f2fs-dev] [PATCH] f2fs: don't leave the hashed inode while it's
 unlinked
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs_symlink()
1. f2fs_new_inode
2. f2fs_add_link
3. page_symlink
4. flush dirty pages and or checkpoint

Step 4 is nice to succeed, which doesn't become a reason to roll back
the created symlink. OTOH, if we get an error till step 3, let's roll
back and remove the cached inode.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 37897f4321c0..7b318cee2ed6 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -704,14 +704,16 @@ static int f2fs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	f2fs_alloc_nid_done(sbi, inode->i_ino);
 
 	err = fscrypt_encrypt_symlink(inode, symname, len, &disk_link);
-	if (err)
-		goto err_out;
-
-	err = page_symlink(inode, disk_link.name, disk_link.len);
+	if (!err)
+		err = page_symlink(inode, disk_link.name, disk_link.len);
 
-err_out:
 	d_instantiate_new(dentry, inode);
 
+	if (err) {
+		f2fs_unlink(dir, dentry);
+		goto out_f2fs_handle_failed_inode;
+	}
+
 	/*
 	 * Let's flush symlink data in order to avoid broken symlink as much as
 	 * possible. Nevertheless, fsyncing is the best way, but there is no
@@ -721,16 +723,10 @@ static int f2fs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	 * If the symlink path is stored into inline_data, there is no
 	 * performance regression.
 	 */
-	if (!err) {
-		err = filemap_write_and_wait_range(inode->i_mapping, 0,
-						   disk_link.len - 1);
-
-		if (!err && IS_DIRSYNC(dir))
-			err = f2fs_sync_fs(sbi->sb, 1);
-	}
-
-	if (err)
-		f2fs_unlink(dir, dentry);
+	err = filemap_write_and_wait_range(inode->i_mapping, 0,
+					   disk_link.len - 1);
+	if (!err && IS_DIRSYNC(dir))
+		f2fs_sync_fs(sbi->sb, 1);
 
 	f2fs_balance_fs(sbi, true);
 	goto out_free_encrypted_link;
-- 
2.55.0.737.g08866a6d13-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
