Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7AC4CA0EC0
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 10 Aug 2025 08:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=znNhfCP25NQoAi/Y32Rw/iZA5tO3cll7Ssv9Ty4S5is=; b=eckdo+S+JrLLQMCYGYT9Asremy
	A5f3YmlVpuSeDCVfDvNFR18S7QHtH3yTt9AVO92eggXulGVoYbnMn1s5nwVHUAg6hZXGwK2LHUhqZ
	9nZv6Cz+2FpT1YVJEp4/a39zDb6I9+4cYmE/LXaRAWKTgisTmpSpd4femps3Z3yqsiR0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ul0yh-0008O3-2c;
	Sun, 10 Aug 2025 08:00:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1ul0yg-0008Nr-7F
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 10 Aug 2025 08:00:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g9JylLnL0eba7y3HOqAM+3BZqbuw02S5HsaaoPbcRaQ=; b=X+9r4054M+jOj+qJ5bhKSrRsQD
 QEFzgbwSWGjc271h+pQf+B71u+pV+nz1uJ3xGyJdgCwpCAi+qPGDs2y2PuwbTnXdBwdfx3IfD7d9i
 P34pkiyBS3r5t3fsyEZHoEA7GkBLxl7+cKxyQ+dYCZ0FvQmPBl4lHt3+pI52BrAQBlDc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=g9JylLnL0eba7y3HOqAM+3BZqbuw02S5HsaaoPbcRaQ=; b=l6VVcsb26GhewZXvYENAqPthtp
 gu4jhB5JBbWC/by1+dA+1QiP867mLiC6QVa9tFj3W6b2fZQe7KfvzQq0eKXAHyyjciJJBR1ziqjQC
 itcYcZBLwgt8kS/baKzMrPtIGlTmzbe/39SO1Xy+2qOE+NvRxWOYerhAhsw7ZjelOJWY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ul0yf-00012K-SR for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 10 Aug 2025 08:00:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C3D445C59;
 Sun, 10 Aug 2025 08:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199D3C4CEEB;
 Sun, 10 Aug 2025 08:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1754812813;
 bh=rH4xOjWHyO4rXuGnXUPR48o6Mlex3OOttISDvsv5E9s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sMaXqJKa2KxH6f4tMBBaWdPiIEWUPBUacPolQNKXvYj7y1z5EdTS9Ztn04re75Tzb
 Von+ZDv71Est4yhSEseq9WQNpCJ5tYDDeTnayh3M7Ljc6Z5LkP+X1xTHvCmVmnK62o
 3fFoQXIgkxTTpk30YcZ1TJeOyR6HE6cw0xQlu6QUNcpP4gKaVMPy6BWuJYymPZm+si
 9rGzeRe7mySUbOWFc0+2EcQHLZTC4EgyqFre8OARwwRm7N8e3UuA4+gMwWTizV3tt5
 i+cgenU4mq/isXW8C68emNfvbILzzQPczeVWKyKRxfEEbcTnIOkWQnm7zeTHl03ugW
 6uTqLHCGI1q/g==
To: linux-fscrypt@vger.kernel.org,
	fsverity@lists.linux.dev
Date: Sun, 10 Aug 2025 00:57:06 -0700
Message-ID: <20250810075706.172910-14-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250810075706.172910-1-ebiggers@kernel.org>
References: <20250810075706.172910-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1ul0yf-00012K-SR
Subject: [f2fs-dev] [PATCH v5 13/13] fsverity: check IS_VERITY() in
 fsverity_cleanup_inode()
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Since getting the address of the fsverity_info has gotten a bit more
expensive, make fsverity_cleanup_inode() check for IS_VERITY() instead.
This avoids adding more overhead to non-verity files.

This assumes that verity info is never set when !IS_VERITY(), which is
currently true, but add a VFS_WARN_ON_ONCE() that asserts that.  (This
of course defeats the optimization, but only when CONFIG_VFS_DEBUG=y.)

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/linux/fsverity.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 844f7b8b56bbc..5bc7280425a71 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -188,12 +188,19 @@ void __fsverity_cleanup_inode(struct inode *inode);
  *
  * Filesystems must call this on inode eviction to free the inode's verity info.
  */
 static inline void fsverity_cleanup_inode(struct inode *inode)
 {
-	if (*fsverity_info_addr(inode))
+	/*
+	 * Only IS_VERITY() inodes can have verity info, so start by checking
+	 * for IS_VERITY() (which is faster than retrieving the pointer to the
+	 * verity info).  This minimizes overhead for non-verity inodes.
+	 */
+	if (IS_VERITY(inode))
 		__fsverity_cleanup_inode(inode);
+	else
+		VFS_WARN_ON_ONCE(*fsverity_info_addr(inode) != NULL);
 }
 
 /* read_metadata.c */
 
 int fsverity_ioctl_read_metadata(struct file *filp, const void __user *uarg);
-- 
2.50.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
