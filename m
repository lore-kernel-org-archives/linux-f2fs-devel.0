Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52864CF45B7
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Jan 2026 17:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fLi+hNQtO1DfQxwoj58y4a5Ge+2fBtWt3HRGpHYvnTc=; b=ik0Cs3nFGiFd4/9rTxfY9MQb5S
	9eyNxObZKPBsib77n0P7cbRfF7Q1LE4OyHpgas10tZjw/ssrA4sIqSVFFYbwEoFGO/BOikF4MMbnN
	UJ2EWYB8CByI+y962iI2McjLohcQIg9bWFXBY/CVqTm4CBDFuE031XPa3U4EZUZcwzbQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vfM0R-0003nk-12;
	Mon, 12 Jan 2026 17:47:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1vfM0P-0003nW-GV
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Jan 2026 17:47:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TN6mxUhZRIrpmWuSsfEe7dU1vNjGknsbJJ3amkxS2mE=; b=SmXQ4nICuAxNh+9ilLx1aFlnJE
 fFxwQmbUamfbIRL/sdTXnX8wp0SMBLrZDGoASngF701ZkiFFBk+V2wUcJXEJFLmfW4C5zwixikSgr
 84ucklu3wAU0+xRqZg0xzcAUchEKoOFHShUg/ROrFY6K4EADZIM6wFyGJ9LPrpcEOkj4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TN6mxUhZRIrpmWuSsfEe7dU1vNjGknsbJJ3amkxS2mE=; b=d5QqDFHIgOsblibNQaEmLBVfph
 TAvRAq9mjJsFkwY/yL8MOTZYVwn873sGKgcJht5QfEWe98jh4gv7au2UQZ3/OM7DlfbsB9B6sb32s
 iBB1sZmPOysp9Hzt4yIBIV18OpAu13i22/ZeDb7KbyjuNfHCqIYxidgVR7+vUgMzIay4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vfM0P-0008TS-5i for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Jan 2026 17:47:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DCEB643603;
 Mon, 12 Jan 2026 17:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8266BC116D0;
 Mon, 12 Jan 2026 17:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768240014;
 bh=adSYz/aH/JJhedd8LYc9zNP3COoAonVjNEu8GDlmYN0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=H1YEe+sGuhJi2JzEnSEQOyOSwvYlYMSE7wCuiosOgAuf2xeSKcPV45t8RfNFxwfFi
 YpvBLv419Mi7UO+E+WF6n1IFJ47Wb53mx8s4sA7BFIWm6+xyEI0OM7UxdjHlfBdRLg
 Y/fUWVTAKEVJAXsq2nJq+C616NW7vStwnPGwMTVQCImwsbWURRMmSukYqLXKL7rKy0
 SCZYOORfI3aj2e2+wauvVKczlgj0XniWIKwWP9aA6e4SG9sKlVIcA9icjUeGkP0bPY
 o6gGAGvHoA4vOUOjbESXPtOfb3YN7x/bu3x2qWuVPbkN4F+4d/ld04d2Okp9fLvhF2
 OaaVFRp7yK5ww==
To: vira,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Date: Mon, 12 Jan 2026 12:46:20 -0500
Message-ID: <20260112174629.3729358-8-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112174629.3729358-1-cel@kernel.org>
References: <20260112174629.3729358-1-cel@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1vfM0P-0008TS-5i
Subject: [f2fs-dev] [PATCH v3 07/16] ext4: Report case sensitivity in
 fileattr_get
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
From: Chuck Lever via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chuck Lever <cel@kernel.org>
Cc: pc@manguebit.org, yuezhang.mo@sony.com, cem@kernel.org,
 almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
 linux-cifs@vger.kernel.org, sfrench@samba.org, slava@dubeyko.com,
 linux-ext4@vger.kernel.org, linkinjeon@kernel.org, sprasad@microsoft.com,
 frank.li@vivo.com, ronniesahlberg@gmail.com, glaubitz@physik.fu-berlin.de,
 jaegeuk@kernel.org, hirofumi@mail.parknet.co.jp, linux-nfs@vger.kernel.org,
 tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, senozhatsky@chromium.org,
 Chuck Lever <chuck.lever@oracle.com>, hansg@kernel.org, anna@kernel.org,
 linux-fsdevel@vger.kernel.org, sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chuck Lever <chuck.lever@oracle.com>

Report ext4's case sensitivity behavior via file_kattr boolean
fields. ext4 always preserves case at rest.

Case sensitivity is a per-directory setting in ext4. If the queried
inode is a casefolded directory, report case-insensitive; otherwise
report case-sensitive (standard POSIX behavior).

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/ext4/ioctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 7ce0fc40aec2..653035017c7f 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -996,6 +996,14 @@ int ext4_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 	if (ext4_has_feature_project(inode->i_sb))
 		fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
 
+	/*
+	 * ext4 always preserves case. If this inode is a casefolded
+	 * directory, report case-insensitive; otherwise report
+	 * case-sensitive (standard POSIX behavior).
+	 */
+	fa->case_insensitive = IS_CASEFOLDED(inode);
+	fa->case_preserving = true;
+
 	return 0;
 }
 
-- 
2.52.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
