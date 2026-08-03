Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEFBC561F8
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 18:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Gs8Ts3VA0HiEJWaoWsmpznNFLfFtjfGpn1vBi8EKPhA=; b=EdRjed73gZ9H35tZQoGWLKqsn5
	PzFjAOzhn7QkR5W6/ZEJLsCmddw0teYNpnEJXrKJo32ZvxcCEvvHa0Oq5fJELWmVxPmhEXywFXnoK
	rwRseWmiFQnhuKb5ttpuXnFUWMRT+Ytf9sRdKDjdFZ4fubcP/eqq36nMR6xmaE+UEueg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqx2U-0006Ji-1u;
	Mon, 03 Aug 2026 18:05:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wqx2S-0006Jc-4x
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 18:05:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W2kStB1YVLVAsQPtUhw3R9F4+saCiGZ5gertLGOHTy8=; b=ja2FQZw2wTAaIwsCT7PRIug5kZ
 5A/bGlKJRvD9ZRTiwvm39lX+6wWfdFxcEIcgJl8aw2eIPNmawL0W6HVeNyG0Yw30pEAZEqVtDpaLo
 KmlxACFmkJq/okUR419epkbjfD0p3lQuehUCmVkHY1EXWWc4Ai1JBRKUFTTgnA82TS78=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=W2kStB1YVLVAsQPtUhw3R9F4+saCiGZ5gertLGOHTy8=; b=O
 3WiV5E/NCfzj5YKoSS4SSVLt4/OYopPFI8BuGV4TdYPrGn7/8/S/QoE2o6a2vXbw2iiSb3HIWMwxt
 grQy6hXOsrBkWtyfQ4mYNgBcjVtfH9+7pgSTv0CFrVXrcYy3i2Yb9tVLFTQaZroDIT5xALwkOQXu9
 CnOXvFI89go5fkD8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqx2R-0004eu-IN for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 18:05:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 663FF4501A;
 Mon,  3 Aug 2026 18:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4F01F00A3D;
 Mon,  3 Aug 2026 18:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785780314;
 bh=W2kStB1YVLVAsQPtUhw3R9F4+saCiGZ5gertLGOHTy8=;
 h=From:To:Cc:Subject:Date;
 b=JMUECnJP5du5ysAKwoLyMQiDiGNYXlVRUq/jZCqBrv1ijy7sailXgEvXbniKkAgUv
 7CvucJgQ2c/xRqrhe1JGRT3xaN38/honV6cGw/RCu1hMtL1sN4vs3VLIT2sfMkdD9R
 LCY/87XFNb1QnLJu7tfvrWYuzZhIpACYLQCHvI7Ze75HQsWaxFYmfKHbYpqtwIt/Ay
 GT8WPt+dPkX94Ha8/d68fRGAeaFSBS8NsxJHizAOSdkLH5VsWnk+fLI96Y412qKhEB
 JW1LYt7Zf8mhN3d4Y7zp5B+tvU3YsozNo1RVdBAHVc8AOYu4JX/vBVu8UXYtVST7rI
 PxI03tlWuVv5g==
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>
Date: Mon,  3 Aug 2026 11:04:26 -0700
Message-ID: <20260803180426.3123-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Headers-End: 1wqx2R-0004eu-IN
Subject: [f2fs-dev] [PATCH v2] mm/swap: reject swapon() on filesystem-level
 encrypted files
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
Cc: Barry Song <baohua@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <baoquan.he@linux.dev>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Youngjun Park <youngjun.park@lge.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

ext4 and f2fs don't prevent filesystem-level encrypted files from being
set up directly as swap files.  In this case, encryption is bypassed.

No one should be doing this, vs. the methods of encrypted swap that
actually do work (such as swapping to a dm-crypt device, or swapping to
a loopback device on top of a filesystem-level encrypted file).

Nevertheless, to prevent user error, make swapon() explicitly reject
this case.  Document this behavior in fscrypt.rst as well.

Fixes: 9bd8212f981e ("ext4 crypto: add encryption policy and password salt support")
Fixes: f424f664f0e8 ("f2fs crypto: add encryption policy and password salt support")
Cc: stable@vger.kernel.org
Reviewed-by: Baoquan He <baoquan.he@linux.dev>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---

Changed in v2:
   - Added a pr_warn_once
   - Removed unnecessary word from fscrypt.rst
   - Added Reviewed-by

 Documentation/filesystems/fscrypt.rst | 4 ++++
 mm/swapfile.c                         | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index c0dd35f1af12..e4882b73120e 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1238,6 +1238,10 @@ astute users may notice some differences in behavior:
 
 - DAX (Direct Access) is not supported on encrypted files.
 
+- Encrypted files cannot be used directly as swap files.  To swap to
+  an encrypted file, set up a loopback device on top of it.
+  Alternatively, encrypted swap can use a dm-crypt device.
+
 - The maximum length of an encrypted symlink is 2 bytes shorter than
   the maximum length of an unencrypted symlink.  For example, on an
   EXT4 filesystem with a 4K block size, unencrypted symlinks can be up
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 78b49b0658ad..8538659acb9e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3650,6 +3650,13 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		error = -EBUSY;
 		goto bad_swap_unlock_inode;
 	}
+	if (IS_ENCRYPTED(inode)) {
+		pr_warn_once(
+			"Filesystem-level encrypted swapfile '%s' is unsupported. Create a loop device over it, or use dm-crypt\n",
+			name->name);
+		error = -EINVAL;
+		goto bad_swap_unlock_inode;
+	}
 
 	/*
 	 * The swap subsystem needs a major overhaul to support this.

base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
-- 
2.55.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
