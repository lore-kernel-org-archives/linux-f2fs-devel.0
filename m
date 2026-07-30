Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0652DC5516E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 30 Jul 2026 18:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+Cz+ia4cZIQecMweBxWunU4gyrmPuRt8ElMqSHhSjyw=; b=V0769IRyyIOLij4OikIKi6kRr3
	KBXm+HT+pRSkuoZbh0F0fXlbvt35Xjos20T7jeNELNNQMlg2DYkcGsgTybj/DcwFRFmT8htxcM9qx
	fqrCbNooXANLZyOzpiMbDQS/bhKvBwQ0whRJdwr+8bFbVQIk8aN5F792etmqY1pNZQ8E=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wpVv2-0007iE-78;
	Thu, 30 Jul 2026 18:55:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wpVuf-0007gF-Ak
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 18:55:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Hfg/Gngqd8SEsjmvDZsSbSWbGJu/DBm8x/q7YUwOtSU=; b=DCJfmCZmhPTgxanYiJsbpp5FBH
 fMNsft7L7fiBJBgU+rwIDbXBYkSW9yPmeuOsjDyFZITTqggM5O6kDXrhAJr0zsWh9iJGm44jGSb7T
 kRsKMVkPXRnUPy9XQ7ro0DAdlAf+6QZt9QgknvIvEg2vRl0uXe+NMZ2rLAEvMJx8OBYg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Hfg/Gngqd8SEsjmvDZsSbSWbGJu/DBm8x/q7YUwOtSU=; b=e
 ZCiwXEBQtFZKVl4q7CV/9B2VgLcFnk9JdETtjuBwo8FTnNq4UuiDTtElewQWB/IXCGd2ibSbtm3qg
 RsZYB0gok1U6Yx1ydyS7p0Spoks2gMn2Y1pmHE/iGoHwYhtYOXFnMJYCiBgpthhunLwvSivhMmjqd
 TwMyeGoSYzCxigiQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wpVue-0001mW-Cn for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 18:55:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 44186407DD;
 Thu, 30 Jul 2026 18:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5231F000E9;
 Thu, 30 Jul 2026 18:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785437715;
 bh=Hfg/Gngqd8SEsjmvDZsSbSWbGJu/DBm8x/q7YUwOtSU=;
 h=From:To:Cc:Subject:Date;
 b=UmTfwEIcQAZ86kDM34UYJMbq473z2fsOFlb728dkck+ISBouYAxxdTTa17upWeCAd
 Fa952fHS1lUK5GYeiu4zWH3buJ4uR9EZ7TWSXC2lc9Un/KGctN/G4jrnRsJWN0Z3O4
 icXTXhrMyGzLgaCR3MW4oWiKwMahsSDodIrIUqVBEd2c77lrw/RFUYTdgTB14yJb7J
 AmQmDSvbuqXeefuq7nB6tIdLkstbSL/n0Y6OXGiQH8nG9JbgC7N9vYtzeMuWCwX/Px
 YQzQKRIk/AQZMRzMIxKwr9/DY5gDArP6OBunaEBI0dow0OGiJN54LSNJvA3RVVacLl
 FhFznXM7WnipQ==
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>
Date: Thu, 30 Jul 2026 11:48:53 -0700
Message-ID: <20260730184853.48347-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Headers-End: 1wpVue-0001mW-Cn
Subject: [f2fs-dev] [PATCH] mm/swap: reject swapon() on filesystem-level
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
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 Documentation/filesystems/fscrypt.rst | 4 ++++
 mm/swapfile.c                         | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index c0dd35f1af12..cba1989777da 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1238,6 +1238,10 @@ astute users may notice some differences in behavior:
 
 - DAX (Direct Access) is not supported on encrypted files.
 
+- Encrypted files cannot be used directly as swap files.  To swap to
+  an encrypted file, set up a loopback device on top of it.
+  Alternatively, encrypted swap can use a dm-crypt device instead.
+
 - The maximum length of an encrypted symlink is 2 bytes shorter than
   the maximum length of an unencrypted symlink.  For example, on an
   EXT4 filesystem with a 4K block size, unencrypted symlinks can be up
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 78b49b0658ad..e4991da81b5f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3650,6 +3650,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		error = -EBUSY;
 		goto bad_swap_unlock_inode;
 	}
+	if (IS_ENCRYPTED(inode)) {
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
