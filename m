Return-Path: <SRS0=kJcA=GC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E33C433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Dec 2020 15:38:14 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6336022242;
	Wed, 30 Dec 2020 15:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6336022242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kudYC-00074e-2T; Wed, 30 Dec 2020 15:38:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <gregkh@linuxfoundation.org>) id 1kudYB-00074P-6m
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 30 Dec 2020 15:38:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:In-Reply-To:Date:From:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5DXY1pM56FlWASZTStVnS7EweO60cWRl83hWAKXlu1w=; b=F4fdvj6y4CmmKyiPFH3DR9fvQK
 10wxDH9otBIOT1+H9Geh12+gEodUroeG/JvFUg/YCyHx+H95+70VZVlt9SzxaJQu7D+6YLurPFrAs
 b0CdWzxUGzykBtnTwJwR2A8Kczforf2Bx0ag8JTb1y7B8HI0of8x0xqpVgZInDY0lHek=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 In-Reply-To:Date:From:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5DXY1pM56FlWASZTStVnS7EweO60cWRl83hWAKXlu1w=; b=fZjYzchjCyRRbzKaYTXa5K25ob
 LQ54w/hFMqjoPMBQdJW4mXLT1iULwpJrOIjMJ5MbDGlG6U8GLJcP/JwaaLVmzJIE5SMek0u4+O6yF
 dwBCPTU1FskJI8RxEmxs5RVD6I3aLiU7LycAaNiaIqnaPIFVa7M/LNAgW4XK1F5HJjQU=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kudY5-0098Ou-VN
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 30 Dec 2020 15:38:11 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4978207A6;
 Wed, 30 Dec 2020 15:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1609342678;
 bh=y+eqjl3sQKL2umSb7bz421DpsNdcAFRKYL1BLs54UtU=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=Qghe72AEB4JnPhcM7hrHJm3m1sm22SnAY3Qf2JDh80+P567UuasRg76FxkZ80IK/m
 oj2HsxjF/WbABpvWq9jek2x8xBIiN0Nsk9CvTYM5HpRafOKMX8SWwOP7ry7Jgoem+s
 +tkFzI94SClYFDs8hsfER8L1aoXoomJnd7mjLHuY=
To: ebiggers@google.com, ebiggers@kernel.org, gregkh@linuxfoundation.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org
From: <gregkh@linuxfoundation.org>
Date: Wed, 30 Dec 2020 16:39:11 +0100
In-Reply-To: <20201228185433.61129-4-ebiggers@kernel.org>
Message-ID: <160934275115840@kroah.com>
MIME-Version: 1.0
X-stable: commit
X-Patchwork-Hint: ignore 
X-Headers-End: 1kudY5-0098Ou-VN
Subject: [f2fs-dev] Patch "f2fs: prevent creating duplicate encrypted
 filenames" has been added to the 5.4-stable tree
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
Cc: stable-commits@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net


This is a note to let you know that I've just added the patch titled

    f2fs: prevent creating duplicate encrypted filenames

to the 5.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     f2fs-prevent-creating-duplicate-encrypted-filenames.patch
and it can be found in the queue-5.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Wed Dec 30 04:37:58 PM CET 2020
From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 28 Dec 2020 10:54:32 -0800
Subject: f2fs: prevent creating duplicate encrypted filenames
To: stable@vger.kernel.org
Cc: linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org
Message-ID: <20201228185433.61129-4-ebiggers@kernel.org>

From: Eric Biggers <ebiggers@google.com>

commit bfc2b7e8518999003a61f91c1deb5e88ed77b07d upstream.

As described in "fscrypt: add fscrypt_is_nokey_name()", it's possible to
create a duplicate filename in an encrypted directory by creating a file
concurrently with adding the directory's encryption key.

Fix this bug on f2fs by rejecting no-key dentries in f2fs_add_link().

Note that the weird check for the current task in f2fs_do_add_link()
seems to make this bug difficult to reproduce on f2fs.

Fixes: 9ea97163c6da ("f2fs crypto: add filename encryption for f2fs_add_link")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20201118075609.120337-4-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/f2fs.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2998,6 +2998,8 @@ bool f2fs_empty_dir(struct inode *dir);
 
 static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
 {
+	if (fscrypt_is_nokey_name(dentry))
+		return -ENOKEY;
 	return f2fs_do_add_link(d_inode(dentry->d_parent), &dentry->d_name,
 				inode, inode->i_ino, inode->i_mode);
 }


Patches currently in stable-queue which might be from ebiggers@kernel.org are

queue-5.4/fscrypt-remove-kernel-internal-constants-from-uapi-header.patch
queue-5.4/fscrypt-add-fscrypt_is_nokey_name.patch
queue-5.4/ext4-prevent-creating-duplicate-encrypted-filenames.patch
queue-5.4/ubifs-prevent-creating-duplicate-encrypted-filenames.patch
queue-5.4/f2fs-prevent-creating-duplicate-encrypted-filenames.patch


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
