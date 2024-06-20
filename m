Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771DCC2BA18
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Jun 2024 03:43:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sK8hv-0001IQ-1q;
	Thu, 20 Jun 2024 03:43:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <youling.tang@linux.dev>) id 1sK8ho-0001IG-LN
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Jun 2024 03:43:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A63/JYmEm04bcb67Y5GvfbOJO1Si9x3i8LU8CU9/NzY=; b=Eo0v2thxPLDpajsKYDaWYwgHrK
 FM2FClhV//XkE7xFJwze1P7wyyZTaG3Pf784nJqT27YMw2N+RO5u6BAPt8eaYSgliUOF3KDqoY5zV
 oaqD8Vx3BIvencLrJZBzt/3bkPsP0FxLytVwJok+RaRcSPRvssn6RKWOWhCSAIOqgUGo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=A63/JYmEm04bcb67Y5GvfbOJO1Si9x3i8LU8CU9/NzY=; b=i0uIGFVEnk6ObuKJEjyyHBlpwg
 J3S+RnH4P3TyFYFxXsGkTAJ3WBu3xV+HvO1gO8/CVADOBc4OEPZw6OKr7rK9z5CPIEV0sg3+Ww/2u
 vLNOuKFTseeF0bLTTLEM7yDoCnqno2gDig0RJlDdNsStWaYSZfFS/zbQ9bPKExTGnw50=;
Received: from out-175.mta0.migadu.com ([91.218.175.175])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sK8hm-0005ZV-Bj for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Jun 2024 03:43:24 +0000
X-Envelope-To: viro@zeniv.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1718853852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A63/JYmEm04bcb67Y5GvfbOJO1Si9x3i8LU8CU9/NzY=;
 b=Nrv6QlIAtbJvAFP+1oXsWRC1DeAN0TlBs4uI3DH3HwTzcNNBje/scSBAkpzTT6rFblCnQH
 Z5/DdY0cbMS/kJZTAFid8gPYIBuCQKl7D3n3fBLTyH2teuQvCTgBKzCn/UV25b8ooruBBx
 ZIa0cTwwe/Hrn5YVJjlMii3j2sO4IfI=
X-Envelope-To: brauner@kernel.org
X-Envelope-To: jaegeuk@kernel.org
X-Envelope-To: chao@kernel.org
X-Envelope-To: miklos@szeredi.hu
X-Envelope-To: jack@suse.cz
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-f2fs-devel@lists.sourceforge.net
X-Envelope-To: youling.tang@linux.dev
X-Envelope-To: tangyouling@kylinos.cn
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Youling Tang <youling.tang@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 20 Jun 2024 11:23:35 +0800
Message-Id: <20240620032335.147136-3-youling.tang@linux.dev>
In-Reply-To: <20240620032335.147136-1-youling.tang@linux.dev>
References: <20240620032335.147136-1-youling.tang@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Headers-End: 1sK8hm-0005ZV-Bj
Subject: [f2fs-dev] [PATCH 3/3] fuse: Use in_group_or_capable() helper
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
Cc: Youling Tang <tangyouling@kylinos.cn>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 youling.tang@linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Youling Tang <tangyouling@kylinos.cn>

Use the in_group_or_capable() helper function to simplify the code.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 fs/fuse/acl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 3d192b80a561..04cfd8fee992 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -146,8 +146,8 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 * be stripped.
 		 */
 		if (fc->posix_acl &&
-		    !vfsgid_in_group_p(i_gid_into_vfsgid(&nop_mnt_idmap, inode)) &&
-		    !capable_wrt_inode_uidgid(&nop_mnt_idmap, inode, CAP_FSETID))
+		    !in_group_or_capable(&nop_mnt_idmap, inode,
+					 i_gid_into_vfsgid(&nop_mnt_idmap, inode)))
 			extra_flags |= FUSE_SETXATTR_ACL_KILL_SGID;
 
 		ret = fuse_setxattr(inode, name, value, size, 0, extra_flags);
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
