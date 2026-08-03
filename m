Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADE8C55196
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 18:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b6NqqPEbpBDs2Db23l5l66tDHzWCs8h8yP9An6ZWJ6w=; b=hbeLiAYOI1Vn+QCE8Oc2v7ugrs
	Of/YPOymQc+rYuPJthSYTSLdFYGWijasr6skAjyboJmT3s7LMxeRhAo/nw8VCxSvLeeIVT0Ta0OU0
	cWByf7+TFa4BEgo4uHRF9RwPJFZqpzyaIHfdWRNVnxVWYLkIR7x/Z4Sus58FfJyDEkvg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqxbi-0004Ew-CD;
	Mon, 03 Aug 2026 18:41:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <usama.anjum@arm.com>) id 1wqxbh-0004Ek-Hh
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 18:41:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HhKBhRE/Ogt+aoCiMYP5CpFhC51oTVXTWdgXC3JbEJM=; b=SaIYMofQZPgoMm6x1GRRlRf3KF
 jzUsvJmXsixxi7rrWuXkjXH2JrArBWMMBRMTpfDwFw57sVcLsiFxNp9J+Y4pXRaeW9MspVkrq1t7E
 G422Bzu9LmI3TJrPyR+rBqbcRNG4x/ZVV8NUdFvFJugK4iSmqqFRtOvpvfJvSLYsMZsc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HhKBhRE/Ogt+aoCiMYP5CpFhC51oTVXTWdgXC3JbEJM=; b=DDaqqvaVDy6aBohh+SPD7/I5zg
 jIP1nvwZNEYEL8d6tKeSNoOOJDYofksgWSKpc+2Sjo9hPqAW+FDbt3MaJ8P8pTwruSCiQsowoZBaC
 nUgndz6xjZbw9JzUzdlFNaClad+6ZTU7hbrvLddNt3gRvAhDU2FS8YwmIxFcs3IPsIkw=;
Received: from foss.arm.com ([217.140.110.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtp (Exim 4.95)
 id 1wqxbg-0006VS-RN for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 18:41:50 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31A3F143D;
 Mon,  3 Aug 2026 11:41:39 -0700 (PDT)
Received: from [10.2.198.93] (e142334-100.cambridge.arm.com [10.2.198.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6860C3F86F;
 Mon,  3 Aug 2026 11:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785782503; bh=uiQBz3mOQUpgseZ4BF2zQ1KUX0+aXrmMQaRmZKtIEvg=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=K99Ctjpq6y2hlz37u/iCbCYcWjnzA7RxwykGj/9EpUCw2VjHCOE67FIFoBWO9wTRV
 jV6Nl4jQzuxB7a1/P1/uoWW0JENbjsv4wt8f0lUV/84T3HhUqwHK1BNJTLlmE8bYVF
 s414pYK9IjtKApzagQxNFMgK7hZ43MgCPl2cGAfM=
Message-ID: <c5edac70-59f9-45a0-b316-c1d987a18ff4@arm.com>
Date: Mon, 3 Aug 2026 19:41:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Eric Biggers <ebiggers@kernel.org>
References: <20260803180426.3123-1-ebiggers@kernel.org>
Content-Language: en-US
From: Usama Anjum <usama.anjum@arm.com>
In-Reply-To: <20260803180426.3123-1-ebiggers@kernel.org>
X-Headers-End: 1wqxbg-0006VS-RN
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
Cc: Barry Song <baohua@kernel.org>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Chris Li <chrisl@kernel.org>,
 Youngjun Park <youngjun.park@lge.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-mm@kvack.org, linux-fscrypt@vger.kernel.org, usama.anjum@arm.com,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 03/08/2026 7:04 pm, Eric Biggers wrote:
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
In the past, I've certainly setup swap wrong. It'll help:

Reviewed-by: Muhammad Usama Anjum <usama.anjum@arm.com>

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



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
