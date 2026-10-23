Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A109B606A31F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MWP+LXaO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ge2huUBQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hGkU+lt4;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dBm9hVmb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:MIME-Version:Message-Id:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=YVW5RTVSnNIlvXydaUdSbBiOymyQe6Q9hLOEY0+ql2M=; b=MWP+LXaOMEgsRuCrIPRZbN6auC
	OztkrYa1cKktKCE7B9i6Qwd+eChB05H29yAcVHRleyeQDuA1TBu4eadURyVjsrxE2s4KQDAKyV7Vu
	x8199ECNd0lph3+TcvPvcT6d176YczE6xluPJvfhA434bUNWf/07vOlnoBK1ibC209sk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xKEeE-0000000051P-0qDl;
	Fri, 23 Oct 2026 12:45:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <brauner@kernel.org>) id 1xKEdt-00000000511-0Uoy
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 12:45:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FwsiwRKiI1Uau+Y+PkzA6OeDUQSFcjgWcDHJQI69nMA=; b=Ge2huUBQ61+1PJ6o8B2vVAY9vO
 rKR2MgOPnruP6rqtMK/uTJ3cJMgjhVdObIJbtq5WaaA/V+bwiR6uOVS4fBY3LZcYLBeyrml78Ee0y
 65dRQoFk8z1lo/QSWA5U9p9MfnW223qOBarPXiMkDHLCUKZTvlZ7QZ8JTsuK3bkluwTA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date
 :Subject:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FwsiwRKiI1Uau+Y+PkzA6OeDUQSFcjgWcDHJQI69nMA=; b=hGkU+lt456QKONek+gRkZ8bIc+
 Q1EpZhpV1MlNl16oToMJpSuE62KQ5UUZwJa2dhHLq4dHV2CwHHifwlBuA0PsHQI+5mXtnKV5BwPr1
 Px6N0bxCe2/YTVUpqDiXNjtAQ28TTXS4yNOMomI2fAg+1ZCDZRoCrcl4zdSkF1m0QxeI=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xKEdr-000000004AW-2ipH
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 12:45:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3DE2040313;
 Fri, 23 Oct 2026 12:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A4A1F01825;
 Fri, 23 Oct 2026 12:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792759498;
 bh=FwsiwRKiI1Uau+Y+PkzA6OeDUQSFcjgWcDHJQI69nMA=;
 h=From:Subject:Date:To:Cc;
 b=dBm9hVmbTmxT/mZyPVXQ3yWu0AtZ0D4zG2iG/IMEfQ+Lqbh4iycAWhG3LDRbg4a/q
 alLa5vlpUAVvBLT0KAbuxsAPsfcN6RC7LHa3thjaQPdUFW2iSisZne5MS7u1b1X+LI
 j3DtDumnjEesTL5+RCebpZ6G56BLMnQQLhmVbYGsg7p8Whh7zKTeZLCoiMN+EWfy79
 FWPRrZrzmD9nMj1lOVkkVVVYyJwNqFFDgjxBHk0XxbOTBdKDwq8tNVmb45p0bNlUCu
 kIvZTfGESvh8cK8fpxj+LngmYEoqeP2SMP4p7iASKQyDH7qVz0jGlwDzmq7ZTgJO3f
 SOvJ8M1UKavug==
Date: Fri, 23 Oct 2026 14:44:21 +0200
Message-Id: <20261023-work-dcache-casefold-v1-0-1b0bd5c73a69@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMSw7CMAwFr1J5jaUkiCJxFcQicR0SPgmyy0eqe
 ncSWM7Tm1lAWTIrHIYFhF9Zcy0N7GYASr6cGfPUGJxxozVui+8qV5zIU2IkrxzrbcLoRmd2zDa
 EPTT1IRzz55c9nv6sz3BhmnurP0JTMYgvlPp09zqzwLp+AUZjeLaRAAAA
X-Change-ID: 20261023-work-dcache-casefold-f26205ee1bb7
To: linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2103; i=brauner@kernel.org;
 h=from:subject:message-id; bh=obwKYrdv+CuHpmSgJz0cQ4xOBXMWUIzAFLxt/IHP2aQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdDjvGE+n59XDUZUseP4uX30vFowIbgl9nzFH+phswf
 /LFl5FKHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5o8Lwz3huybO/VRkqGR/l
 n921rmxZ3RM42//il4Jsz+2X89/IaDAybL/gwjf/wow902W8Fp4SqVjwPeBf8yTGCWdjFVvapl2
 cwwwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xKEdr-000000004AW-2ipH
Subject: [f2fs-dev] [PATCH 0/2] dcache: don't leave negative dentries in
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

xfs's ascii-ci doesn't set S_CASEFOLD and can't so it d_drop()s instead.
I did consider setting S_CASEFOLD on ascii-ci directories and didn't.
overlayfs warns when a layer's casefold flag disagrees with the
superblock having an encoding, and xfs has none.

Nothing changes for userspace. A miss still isn't cached and a removed
name still leaves no negative dentry behind. Verified with the same
create, unlink, create, readdir and stat sequence in a plain and in a
casefolded directory on tmpfs and on ext4, before and after.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (2):
      dcache: don't leave negative dentries in casefolded directories
      xfs: unhash a removed name in ascii-ci mode instead of invalidating it

 fs/dcache.c       |  8 +++++++-
 fs/ext4/namei.c   | 18 ------------------
 fs/f2fs/namei.c   |  9 ---------
 fs/xfs/xfs_iops.c |  4 ++--
 mm/shmem.c        |  7 -------
 5 files changed, 9 insertions(+), 37 deletions(-)
---
base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
change-id: 20261023-work-dcache-casefold-f26205ee1bb7



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
