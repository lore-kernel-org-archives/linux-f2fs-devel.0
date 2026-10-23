Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEB5606A31B
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hEYBSDA5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TFoN1xE1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=iwAKg/L9;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfH/qyuZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JT4kdc78ncmXz6fKS12hXBaXX0NHJHV6bWzi+/T1OWI=; b=hEYBSDA5LtADY6efTyr8Ao5zUN
	UxWfRIoK+RWZkw9OsWfe34y0r860Mt4PRl7P5R9NJgeAfOHAAoKZLJ4P6Rf/njcY1tUtaujXRVjEb
	g2iHHuo9gcL5IbbYjqIll+ABMOvYNZCsc6gI83e7tx+lXpjXQ6GsAwC+iAyMBcd9tcOA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xKEeH-000000007um-2pgi;
	Fri, 23 Oct 2026 12:45:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <brauner@kernel.org>) id 1xKEdx-000000007uO-09j3
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 12:45:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f/jgck1/B2jP5Cxin5WuX27Pbk4Su0v7UABSBfjcW6U=; b=TFoN1xE1M0bn1BeTRd4VaC5sHM
 apHnNOBSe4DusP46mu0VhZEtNfkpjzZQ7o6VcHg8+G4mqpUXf3SN+bZs0GuiBJf8u5SF7leMNu507
 nZLuMnoiN2H+vk4Tg62o3XyhRtjZbvfVGdvuaa2nRnOecwzi1Tiy6cCDO8jqJFhZwv2s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f/jgck1/B2jP5Cxin5WuX27Pbk4Su0v7UABSBfjcW6U=; b=iwAKg/L9lLdwvzHmUmbzHEUqys
 HpzBW5txroZXCXlHcfr9zl3UxcecKsilZmlWy7AoF3896dbFHx+Vcg2IQZE+uKiSmMn6PmmbrPNbc
 WfuvPv+AVS+joB0AR9NKx+ESULiRRNV01x+ajKlOOe06Bw9jECzbnZJMv+7eOXGhmytA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xKEdu-000000004AX-0le7
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 12:45:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 885A460142;
 Fri, 23 Oct 2026 12:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930841F01829;
 Fri, 23 Oct 2026 12:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792759500;
 bh=f/jgck1/B2jP5Cxin5WuX27Pbk4Su0v7UABSBfjcW6U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jfH/qyuZd3kejUmi+LHhUQ0Lbt0Z0Q5dfbUYU7ekb7mW5joY66m+94DK4KZVWLEAM
 vC6brHn4cEX1u7aQfAoTpGVteyuiBO7CfhaFOlu743UQqMqLn5WdIq86Epvlam7Zhe
 6cRjxXn04WU3XdFtNncm/RTYvdJ/nwJKZwvdnE+sQTWZ/4HvabUPzpO979kd+h4IME
 VAl5n5PMo3ThrjPVYm2yR8ZtQrALZ7xGIzkUdhVtDf75UvIkmWyO9/Qky/p+zDdvj1
 QDgOiEuS9YKhIe093TNlY8bw5QDSYa+0A3BJp3MUcLite6i7OjH6qVkZrpjtuyqI4w
 ms+TP81QUf7yQ==
Date: Fri, 23 Oct 2026 14:44:22 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261023-work-dcache-casefold-v1-1-1b0bd5c73a69@kernel.org>
References: <20261023-work-dcache-casefold-v1-0-1b0bd5c73a69@kernel.org>
In-Reply-To: <20261023-work-dcache-casefold-v1-0-1b0bd5c73a69@kernel.org>
To: linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5070; i=brauner@kernel.org;
 h=from:subject:message-id; bh=uraFryhr3pXYI4wU9TenrkcrtkF88x7auRzStx88u1E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdDjv2oVz49tkJNl2JXV+dnCKtFrBrLtl0Qmf9av/KC
 7V98w6d6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI8Q9Ghkeqkkcn2hrHL7t7
 jPHItQWbdCyc8uUOBFscOsTM8WpBXyUjw8ZDeRzfZlxIcbdUKLjFXMBS+Y+TYYP1Mh/ZR8XvbKf
 m8QAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xKEdu-000000004AX-0le7
Subject: [f2fs-dev] [PATCH 1/2] dcache: don't leave negative dentries in
 casefolded directories
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Christian Brauner via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Christian Brauner <brauner@kernel.org>
Cc: "Christian Brauner \(Amutable\)" <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Gabriel Krisman Bertazi <krisman@kernel.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ext4, f2fs and tmpfs keep negative dentries out of casefolded
directories. A negative dentry remembers one spelling of the name and
the next create() through it would write that spelling to disk.

So their ->lookup() doesn't cache a miss and their ->unlink() and
->rmdir() call d_invalidate() on the dentry so that d_delete() doesn't
turn it into a negative dentry.

But d_invalidate() is the wrong primitive for that. It's for a name that
went stale. It walks the subtree, prunes it and detaches every mount it
finds, under namespace_sem, and here that runs from inside the
filesystem's own directory operation. ext4_rmdir() does it with the
journal handle still open and ext4_unlink() does it even when the
unlink failed. All anyone wanted is the unhash.

So d_delete() now unhashes the dentry when the parent is casefolded,
next to the dentry-negative sysctl that does the same for every
directory. ext4, f2fs and tmpfs drop their d_invalidate() calls.

Nothing changes for a casefolded directory. A miss still isn't cached
and a removed name still doesn't leave a negative dentry behind. The
target of a rename over an existing name, which tmpfs also passes
through shmem_unlink(), doesn't turn negative either. vfs_rename()
detaches its mounts and d_move() unhashes it. A failed unlink or rmdir
now leaves the dentry hashed and its mounts in place, as in any other
directory.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/dcache.c     |  8 +++++++-
 fs/ext4/namei.c | 18 ------------------
 fs/f2fs/namei.c |  9 ---------
 mm/shmem.c      |  7 -------
 4 files changed, 7 insertions(+), 35 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index efd9332c8407..f5cbb2e24e53 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2746,6 +2746,12 @@ struct dentry *d_hash_and_lookup(struct dentry *dir, struct qstr *name)
 	return d_lookup(dir, name);
 }
 
+static __always_inline bool d_delete_drop(struct dentry *dentry)
+{
+	return dentry_negative_policy ||
+	       IS_CASEFOLDED(d_inode(dentry->d_parent));
+}
+
 /*
  * When a file is deleted, we have two options:
  * - turn this dentry into a negative dentry
@@ -2777,7 +2783,7 @@ void d_delete(struct dentry * dentry)
 	 * Are we the only user?
 	 */
 	if (dentry->d_lockref.count == 1) {
-		if (dentry_negative_policy)
+		if (d_delete_drop(dentry))
 			__d_drop(dentry);
 		dentry->d_flags &= ~DCACHE_CANT_MOUNT;
 		dentry_unlink_inode(dentry);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 6e0630a49e48..c4b1121471e6 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3209,15 +3209,6 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	ext4_fc_track_unlink(handle, dentry);
 	retval = ext4_mark_inode_dirty(handle, dir);
 
-	/* VFS negative dentries are incompatible with Encoding and
-	 * Case-insensitiveness. Eventually we'll want avoid
-	 * invalidating the dentries here, alongside with returning the
-	 * negative dentries at ext4_lookup(), when it is better
-	 * supported by the VFS for the CI case.
-	 */
-	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
-		d_invalidate(dentry);
-
 end_rmdir:
 	brelse(bh);
 	if (handle)
@@ -3320,15 +3311,6 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 
 	retval = __ext4_unlink(dir, &dentry->d_name, d_inode(dentry), dentry);
 
-	/* VFS negative dentries are incompatible with Encoding and
-	 * Case-insensitiveness. Eventually we'll want avoid
-	 * invalidating the dentries here, alongside with returning the
-	 * negative dentries at ext4_lookup(), when it is  better
-	 * supported by the VFS for the CI case.
-	 */
-	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
-		d_invalidate(dentry);
-
 out_trace:
 	trace_ext4_unlink_exit(dentry, retval);
 	return retval;
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 233c07fec171..30f6b8448eee 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -631,15 +631,6 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	if (err)
 		goto out;
 
-	/* VFS negative dentries are incompatible with Encoding and
-	 * Case-insensitiveness. Eventually we'll want avoid
-	 * invalidating the dentries here, alongside with returning the
-	 * negative dentries at f2fs_lookup(), when it is better
-	 * supported by the VFS for the CI case.
-	 */
-	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
-		d_invalidate(dentry);
-
 	if (IS_DIRSYNC(dir))
 		err = f2fs_sync_fs(F2FS_I_SB(dir)->sb, 1);
 out:
diff --git a/mm/shmem.c b/mm/shmem.c
index 0d891ade18b5..5a353ac32573 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3953,13 +3953,6 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 	inode_inc_iversion(dir);
 	simple_unlink(dir, dentry);
 
-	/*
-	 * For now, VFS can't deal with case-insensitive negative dentries, so
-	 * we invalidate them
-	 */
-	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
-		d_invalidate(dentry);
-
 	return 0;
 }
 

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
