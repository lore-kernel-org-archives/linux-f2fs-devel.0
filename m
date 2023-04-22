Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1CDC77B61
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 22 Apr 2023 00:03:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pq0ix-0008CM-TD;
	Sat, 22 Apr 2023 00:03:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <krisman@suse.de>) id 1pq0iv-0008CD-NN
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 22 Apr 2023 00:03:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6JwRiXt7Z0INDOdagK+P+QdTiJUoiuESrT1A53nUDzg=; b=kFYGJhHK3bkznvPgiSZrN25K9n
 Tp2HYFNgwH25eAZy0Td4tuQzT1unrGk0tghFtSey6kyQMfZxSWnW+8yF7fLUU6aCOj2kC6WL7oVt7
 fTCBlz0kmpn2dgbo4dQKAa05TqC5Y28HrcCQXGhPieInTx7IhJhC0jMZsjrhtGK2R4Y4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6JwRiXt7Z0INDOdagK+P+QdTiJUoiuESrT1A53nUDzg=; b=jUB6lgONpjHT2bG0EySyrs7sBl
 119nK9SRa4/dp7QSBQWGZwC17b502zWMM4nxomiN3JvU9YlEQRTVKgNlJloC/QZGH04HWYJYgnoIZ
 bvy93TVDB2NKEMlRhc3uoYZALiDuiYgB8RX+Zim8PodcA7Wa/3n3KwIFeVLzAI0IWFtk=;
Received: from smtp-out2.suse.de ([195.135.220.29])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1pq0iu-0008N0-Ou for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 22 Apr 2023 00:03:29 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 864681FDEA;
 Sat, 22 Apr 2023 00:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1682121802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6JwRiXt7Z0INDOdagK+P+QdTiJUoiuESrT1A53nUDzg=;
 b=Hh2VIJaS124nZaTolMohKkUM5hDdRHKh/gKSLylf+ks4/JRdorqljW/x+Noa0y5/NWAQlH
 OR3qnqeFqABa9yHtRLBPaBkyE7sLmQpq2Jp7x1WwB0BLvluhFxaRAnYj7hYv8HCpWY1UyJ
 /EWrDBNuGMnsMc3wbQGZmEYhmXaqS08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1682121802;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6JwRiXt7Z0INDOdagK+P+QdTiJUoiuESrT1A53nUDzg=;
 b=2DnnzSmZR58Kp+X+a2SvEJvubUAegf79zBGv5zZ2NFy2kWcYyIb7j3loVuY37T7NiRgRlZ
 j2wYjEwTOivBSeCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EEA51358E;
 Sat, 22 Apr 2023 00:03:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tXvIDUokQ2T5dwAAMHmgww
 (envelope-from <krisman@suse.de>); Sat, 22 Apr 2023 00:03:22 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Date: Fri, 21 Apr 2023 20:03:10 -0400
Message-Id: <20230422000310.1802-8-krisman@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230422000310.1802-1-krisman@suse.de>
References: <20230422000310.1802-1-krisman@suse.de>
MIME-Version: 1.0
X-Headers-End: 1pq0iu-0008N0-Ou
Subject: [f2fs-dev] [PATCH v2 7/7] f2fs: Enable negative dentries on
 case-insensitive lookup
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
Cc: krisman@suse.de, tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Instead of invalidating negative dentries during case-insensitive
lookups, mark them as such and let them be added to the dcache.
d_ci_revalidate is able to properly filter them out if necessary based
on the dentry casefold flag.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/f2fs/namei.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 11fc4c8036a9..57ca7ea86509 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -564,17 +564,8 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		goto out_iput;
 	}
 out_splice:
-#if IS_ENABLED(CONFIG_UNICODE)
-	if (!inode && IS_CASEFOLDED(dir)) {
-		/* Eventually we want to call d_add_ci(dentry, NULL)
-		 * for negative dentries in the encoding case as
-		 * well.  For now, prevent the negative dentry
-		 * from being cached.
-		 */
-		trace_f2fs_lookup_end(dir, dentry, ino, err);
-		return NULL;
-	}
-#endif
+	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
+		d_set_casefold_lookup(dentry);
 	new = d_splice_alias(inode, dentry);
 	err = PTR_ERR_OR_ZERO(new);
 	trace_f2fs_lookup_end(dir, dentry, ino, !new ? -ENOENT : err);
@@ -627,16 +618,6 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	f2fs_delete_entry(de, page, dir, inode);
 	f2fs_unlock_op(sbi);
 
-#if IS_ENABLED(CONFIG_UNICODE)
-	/* VFS negative dentries are incompatible with Encoding and
-	 * Case-insensitiveness. Eventually we'll want avoid
-	 * invalidating the dentries here, alongside with returning the
-	 * negative dentries at f2fs_lookup(), when it is better
-	 * supported by the VFS for the CI case.
-	 */
-	if (IS_CASEFOLDED(dir))
-		d_invalidate(dentry);
-#endif
 	if (IS_DIRSYNC(dir))
 		f2fs_sync_fs(sbi->sb, 1);
 fail:
-- 
2.40.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
