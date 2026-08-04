Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078C8C55182
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 00:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FawadbrLsmT6u05HUOwt2pkZ6Uo7LuBueukDrzOmEOg=; b=LbeVsZ5aPR6Gzl2eBcGnYj6lO+
	RQkr9LxZV6Vtgd0dvXWrOWf4vHWA+/JMqNOpXbfOSsLXybhpC0vTrTdM1GChC22+KwtWq1tmdqFEa
	y+mfyI1fr6Zh9oNWeMvFmYhrHvwmCjxScYDAYvCsVSv3FdJ+FMelS5qKw3iP1tgfeinU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wr3Q1-0007jq-7e;
	Tue, 04 Aug 2026 00:54:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wr3Pz-0007jj-EI
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 00:54:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9mtyAOozxkrs5lt5Qaj4Fv8f+eSVOgvFX15YH+LWjPE=; b=PchmfNQXlpSOVXntUaDhYtxR2a
 ne8sDnyIal3rJfeHTHSqOKj8nQ5CTlJftgPtPidUH7lrWU/NS4x+7yeS2y7uu1uvDUcs06Fnv99Z4
 PyNCuhMZ7RPqzWqd/LHlEgSHyxlUlNl8BXoqWpxPmHrknblykNN6PMIdVw99O39CKSwg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9mtyAOozxkrs5lt5Qaj4Fv8f+eSVOgvFX15YH+LWjPE=; b=Fc9NciNl+6JdGQ44crrYYxDFWZ
 qiPMNNUiaBGBHRqtlPlPqeImOlwg/2Ua9OUumdACdtI0OLa9BvNWd0zY5EYmco8U62TqQCwxKo0zc
 E7LNGuMnjzWuXlf1LuYr1+8vG3tqWs3WANyadCHTLMTz24aUZS/H048JNks8wPoXgAfw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wr3Q2-0002MP-Fx for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 00:54:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with UTF8SMTP id 6EB1843AEB;
 Tue,  4 Aug 2026 00:54:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4A0FB1F000E9;
 Tue,  4 Aug 2026 00:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785804841;
 bh=9mtyAOozxkrs5lt5Qaj4Fv8f+eSVOgvFX15YH+LWjPE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=APllE/PCHQWGGJrtM7vINNmaN8/ak94vQ7ak8C15VI013xWe5pCbBFiuduN6Fcwrc
 GWzv8QSkQ1Q7+AtpkfgGteHXTmA4wSwA12u5M4FSqeRhxdQFDeIWQLanm3Na+vzgxr
 4VsjLDPzCH53+Z1Kco1tZWCgQyI5ly4zyVyOE+NfEwXmHSKJgT8U7cXIvztT19ftKD
 Zt7jXsIiKnIukVFCsfvAOZQ04fB6IeoTwgdeLPUPhaiuLQCVmzq/QVrDLhVioBo68l
 5nL0XeBpqZUJh/7VDVk3LeYqGewNE+fvFqioFOg4gSu0NO96z5megrkQ0+akDGmURo
 Q4wgYZsdmddHw==
Date: Mon, 3 Aug 2026 17:54:00 -0700
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20260804005400.GB3560112@frogsfrogsfrogs>
References: <20260803180426.3123-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260803180426.3123-1-ebiggers@kernel.org>
X-Headers-End: 1wr3Q2-0002MP-Fx
Subject: Re: [f2fs-dev] [PATCH v2] mm/swap: reject swapon() on
 filesystem-level encrypted files
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
From: "Darrick J. Wong via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Barry Song <baohua@kernel.org>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>,
 Chris Li <chrisl@kernel.org>, Youngjun Park <youngjun.park@lge.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-mm@kvack.org, linux-fscrypt@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Aug 03, 2026 at 11:04:26AM -0700, Eric Biggers wrote:
> ext4 and f2fs don't prevent filesystem-level encrypted files from being
> set up directly as swap files.  In this case, encryption is bypassed.
> 
> No one should be doing this, vs. the methods of encrypted swap that
> actually do work (such as swapping to a dm-crypt device, or swapping to
> a loopback device on top of a filesystem-level encrypted file).
> 
> Nevertheless, to prevent user error, make swapon() explicitly reject
> this case.  Document this behavior in fscrypt.rst as well.
> 
> Fixes: 9bd8212f981e ("ext4 crypto: add encryption policy and password salt support")
> Fixes: f424f664f0e8 ("f2fs crypto: add encryption policy and password salt support")
> Cc: stable@vger.kernel.org
> Reviewed-by: Baoquan He <baoquan.he@linux.dev>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Looks good to me!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
> 
> Changed in v2:
>    - Added a pr_warn_once
>    - Removed unnecessary word from fscrypt.rst
>    - Added Reviewed-by
> 
>  Documentation/filesystems/fscrypt.rst | 4 ++++
>  mm/swapfile.c                         | 7 +++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
> index c0dd35f1af12..e4882b73120e 100644
> --- a/Documentation/filesystems/fscrypt.rst
> +++ b/Documentation/filesystems/fscrypt.rst
> @@ -1238,6 +1238,10 @@ astute users may notice some differences in behavior:
>  
>  - DAX (Direct Access) is not supported on encrypted files.
>  
> +- Encrypted files cannot be used directly as swap files.  To swap to
> +  an encrypted file, set up a loopback device on top of it.
> +  Alternatively, encrypted swap can use a dm-crypt device.
> +
>  - The maximum length of an encrypted symlink is 2 bytes shorter than
>    the maximum length of an unencrypted symlink.  For example, on an
>    EXT4 filesystem with a 4K block size, unencrypted symlinks can be up
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 78b49b0658ad..8538659acb9e 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3650,6 +3650,13 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  		error = -EBUSY;
>  		goto bad_swap_unlock_inode;
>  	}
> +	if (IS_ENCRYPTED(inode)) {
> +		pr_warn_once(
> +			"Filesystem-level encrypted swapfile '%s' is unsupported. Create a loop device over it, or use dm-crypt\n",
> +			name->name);
> +		error = -EINVAL;
> +		goto bad_swap_unlock_inode;
> +	}
>  
>  	/*
>  	 * The swap subsystem needs a major overhaul to support this.
> 
> base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
> -- 
> 2.55.0
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
