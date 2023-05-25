Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A46C7EE39
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 25 May 2023 10:16:43 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q281R-0004I0-U1;
	Thu, 25 May 2023 10:16:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jack@suse.cz>) id 1q281P-0004Hk-2Q
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 May 2023 10:16:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AOBPab5sBc+U602a0bs2SOLbJwxohD0hSk5muDSlfQg=; b=f8O9TjvPjgU8S0cw7zI1Btd/1d
 gJx6t7DtQW+zOExZjEkkS6m2b5UX3P6arIETDAGmcO01enB53GLxyIxDpoSIoYEWFZ2wWeBY34wTL
 YxCUoG8wHrvYOoWncIGjhvY442JKgOkfrDbrwmJ3yoZocbL6G/hdpDEdrzIlCMk8Dn28=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AOBPab5sBc+U602a0bs2SOLbJwxohD0hSk5muDSlfQg=; b=SjeDqDGeAuAzv2MLnGaAcH6xee
 Wa9Wf9RdOTz78wqw6ig1oI7lnK24fNjIHuO8HMV7UiaIcH7fkMDjSTN2a36dsRA8qIiBIHjvPUEXA
 QunnIFGdZZ2KpRdlnu32IoqL3ibiI8qWKG/xSXZAJgxGSmk0Va3DoPR/dFLYd47z9d6M=;
Received: from smtp-out2.suse.de ([195.135.220.29])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1q281I-0029jS-3a for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 May 2023 10:16:36 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 11DE81FDFA;
 Thu, 25 May 2023 10:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1685009785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AOBPab5sBc+U602a0bs2SOLbJwxohD0hSk5muDSlfQg=;
 b=pe0+3hEzZs7uN2Ol1+io5lGnFYDTh14sFgC0p8Ydn8E6J1k8UmcEA+dOfNAfh1gnrQF31z
 1U9OGFsBqpX4AASin+dz8m9io5sc9GoSnWXVl+wgTuVLSvdyMTrk4PMgcafpzURnp3AQO8
 /hPmuePDSH5Q6vbvtJ6qwbFnIfCNB4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1685009785;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AOBPab5sBc+U602a0bs2SOLbJwxohD0hSk5muDSlfQg=;
 b=v2LWRjHb+z/Fzc1yDbthCZ8Pn4nZRl48BHUTptKXVjiYJyHOzF/e05RnyYm3SQTVozdyHg
 ULbpgWrAA6w+evDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01D64134B2;
 Thu, 25 May 2023 10:16:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BWpWAHk1b2RIdgAAMHmgww
 (envelope-from <jack@suse.cz>); Thu, 25 May 2023 10:16:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 577BCA075D; Thu, 25 May 2023 12:16:24 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@ZenIV.linux.org.uk>
Date: Thu, 25 May 2023 12:16:07 +0200
Message-Id: <20230525101624.15814-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230525100654.15069-1-jack@suse.cz>
References: <20230525100654.15069-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1467; i=jack@suse.cz;
 h=from:subject; bh=XV5CJdcSgiBkW1x4p8thTfL0TVuanLRiOHdfMG5wLnM=;
 b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkbzVnIGpGZWT4yPVsBHE7bfA4OPMkWz6HswnwkkBL
 wMv1XtaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZG81ZwAKCRCcnaoHP2RA2djMB/
 9TuRgCE19tiF4YfdSdVgRs89YRrDmmE3NTXAbSIuixbqPMs/OBoKR+IrdEhocemPpvsbhKgYyq6pde
 GD08bNXqBYlC0N7WtEw16cb4LN/eI/F61YOFBg4KAWdPP2MW1hrfKqRKHgRiuRHCbdmZqLVok3aTFp
 1Qr+X/ew4ZRXZQKMLFXhUsaRRQ+efZvQh7lYWVuVP0wKGwST8ZqSgemvm5nH7h/75mR768e1g414NX
 MYIQoHxmL5RXtLav4o/2MuPeb2D45T1AzoSUYrkMR8J/mTGAc+39zgKAT2B5r8H3rnw95ZrS6ps/N1
 ALUuca31HdAz6ByRtuZyPuvC/Wt2sJ
X-Developer-Key: i=jack@suse.cz; a=openpgp;
 fpr=93C6099A142276A28BBE35D815BC833443038D8C
X-Headers-End: 1q281I-0029jS-3a
Subject: [f2fs-dev] [PATCH 1/6] ext4: Remove ext4 locking of moved directory
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
Cc: Christian Brauner <brauner@kernel.org>, Ted Tso <tytso@mit.edu>,
 Miklos Szeredi <miklos@szeredi.hu>, "Darrick J. Wong" <djwong@kernel.org>,
 Jan Kara <jack@suse.cz>, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Remove locking of moved directory in ext4_rename2(). We will take care
of it in VFS instead. This effectively reverts commit 0813299c586b
("ext4: Fix possible corruption when moving a directory") and followup
fixes.

CC: Ted Tso <tytso@mit.edu>
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/namei.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 45b579805c95..0caf6c730ce3 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3834,19 +3834,10 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			return retval;
 	}
 
-	/*
-	 * We need to protect against old.inode directory getting converted
-	 * from inline directory format into a normal one.
-	 */
-	if (S_ISDIR(old.inode->i_mode))
-		inode_lock_nested(old.inode, I_MUTEX_NONDIR2);
-
 	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de,
 				 &old.inlined);
-	if (IS_ERR(old.bh)) {
-		retval = PTR_ERR(old.bh);
-		goto unlock_moved_dir;
-	}
+	if (IS_ERR(old.bh))
+		return PTR_ERR(old.bh);
 
 	/*
 	 *  Check for inode number is _not_ due to possible IO errors.
@@ -4043,10 +4034,6 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	brelse(old.bh);
 	brelse(new.bh);
 
-unlock_moved_dir:
-	if (S_ISDIR(old.inode->i_mode))
-		inode_unlock(old.inode);
-
 	return retval;
 }
 
-- 
2.35.3



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
