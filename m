Return-Path: <SRS0=BY5/=FG=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08D2C6369E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Dec 2020 21:08:37 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2467821D91;
	Wed,  2 Dec 2020 21:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2467821D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kkZMY-0001t1-SS; Wed, 02 Dec 2020 21:08:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1kkZMF-0001sN-VY
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 02 Dec 2020 21:08:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5iYedmtrVjqIqbVPNv+CJa7K980k0yraUJgrzA1DCnY=; b=Wv9XzJu9Al2VD3yro2P25jWvUL
 IlpxXW5VRlUAkM2wipE5G0VEnnQN4h3GDpsnDFWbP0hcKSEyOYfxCnlUcLoM6xBTrf1L/jv4AXWAG
 pMldzFkJNQDm2ZY0F8s+NSrfmNQ2WTiRyxOorbSv6xoQTr5+dv7EQHgpZf9VM24bTBww=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5iYedmtrVjqIqbVPNv+CJa7K980k0yraUJgrzA1DCnY=; b=PR5fFr/p/5G8Xw9uLPLmzdcaST
 Qq4AzGt9y8ajq+75UzhEBNSm7E827gGsjqiBAAQ2BHS5fx0tBWacklm70gyiKvPjOabZmQ7WSPHt4
 wa/e99BP7aN+uMekVZJyhT+36fJCm66/8R3LP4IWqWIqeeEFOZeaF3k0TnL+NryiXOXI=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kkZM7-00C5J5-Gp
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 02 Dec 2020 21:08:15 +0000
Date: Wed, 2 Dec 2020 13:07:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1606943277;
 bh=z7aM84uoaVRXDrRTKXVTwdXKK69LzrzJ1yjZQqo3344=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=EZNH/dFHxK112U8asIp9Tyi1NmmUiP3WZ8jKeTdDrVskZASdlAR/S1wDBS3JHVR6j
 3z+pV6U+lXcVEMTt2lE9kKMNWS54qhtKYSyZJ1y/OwNcNYH+2zcwZXXoqTyEQWwNpS
 ZkQymrXas2DHQb0qKTLFm0/3JkDC9FC7r39gbgLcj5+c/ZI+idYLTm/7F/T7NVWXvO
 q4jhvHNzRrrww4sIAKh0IFFHKFWbaAxr6ln+yidV6vyDxnLQUewpajhRHkcPDimBi2
 +7L2ec88F9TKg8MI6yFF0aM//oPxYTD/cl8b1g/XUOyYDXPhM0kBavcUQeTmQOIU7o
 p9GqnFEnkOM7g==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Message-ID: <X8gCKTx96rXUMh0i@gmail.com>
References: <20201125002336.274045-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201125002336.274045-1-ebiggers@kernel.org>
X-Headers-End: 1kkZM7-00C5J5-Gp
Subject: Re: [f2fs-dev] [PATCH 0/9] Allow deleting files with unsupported
 encryption policy
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
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Nov 24, 2020 at 04:23:27PM -0800, Eric Biggers wrote:
> Currently it's impossible to delete files that use an unsupported
> encryption policy, as the kernel will just return an error when
> performing any operation on the top-level encrypted directory, even just
> a path lookup into the directory or opening the directory for readdir.
> 
> It's desirable to return errors for most operations on files that use an
> unsupported encryption policy, but the current behavior is too strict.
> We need to allow enough to delete files, so that people can't be stuck
> with undeletable files when downgrading kernel versions.  That includes
> allowing directories to be listed and allowing dentries to be looked up.
> 
> This series fixes this (on ext4, f2fs, and ubifs) by treating an
> unsupported encryption policy in the same way as "key unavailable" in
> the cases that are required for a recursive delete to work.
> 
> The actual fix is in patch 9, so see that for more details.
> 
> Patches 1-8 are cleanups that prepare for the actual fix by removing
> direct use of fscrypt_get_encryption_info() by filesystems.
> 
> This patchset applies to branch "master" (commit 4a4b8721f1a5) of
> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git.
> 
> Eric Biggers (9):
>   ext4: remove ext4_dir_open()
>   f2fs: remove f2fs_dir_open()
>   ubifs: remove ubifs_dir_open()
>   ext4: don't call fscrypt_get_encryption_info() from dx_show_leaf()
>   fscrypt: introduce fscrypt_prepare_readdir()
>   fscrypt: move body of fscrypt_prepare_setattr() out-of-line
>   fscrypt: move fscrypt_require_key() to fscrypt_private.h
>   fscrypt: unexport fscrypt_get_encryption_info()
>   fscrypt: allow deleting files with unsupported encryption policy
> 
>  fs/crypto/fname.c           |  8 +++-
>  fs/crypto/fscrypt_private.h | 28 ++++++++++++++
>  fs/crypto/hooks.c           | 16 +++++++-
>  fs/crypto/keysetup.c        | 20 ++++++++--
>  fs/crypto/policy.c          | 22 +++++++----
>  fs/ext4/dir.c               | 16 ++------
>  fs/ext4/namei.c             | 10 +----
>  fs/f2fs/dir.c               | 10 +----
>  fs/ubifs/dir.c              | 11 +-----
>  include/linux/fscrypt.h     | 75 +++++++++++++++++++------------------
>  10 files changed, 126 insertions(+), 90 deletions(-)
> 
> 
> base-commit: 4a4b8721f1a5e4b01e45b3153c68d5a1014b25de

Any more comments on this patch series?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
