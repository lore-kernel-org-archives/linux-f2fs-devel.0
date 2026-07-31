Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED152C54F54
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 31 Jul 2026 15:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3WDRPg8lVEUIYmox4yg/frZ1KA7TI+S8cI33R3woUU8=; b=mev9Mq1a07NTNcDZJCdPqx75D3
	wQU4ElJfFFCFPpQTQRrwpFNxEUnLKC9V32VyUnxIUyt0dmFhFwYhU9COGoGqOvYRNAxFAHnur14Xn
	G5DFvHsZVpfyaf0Ad1uCIVZdRFJsnFsuNxJsSFz1lmSoThGidXl7NasivId6AsM/tcOk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wpotT-00016j-52;
	Fri, 31 Jul 2026 15:11:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <baoquan.he@linux.dev>) id 1wpotP-00016a-KP
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 15:11:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qo1LR7qrIwKJFtiU17ykHkbB13kJdtxhqwfYwUfZhvA=; b=NzmOEguSNPiyZd4VRLZr+TFt/Z
 hBEDxPNfLjLBe8dCsnwaVCiZGK0QCjT9llPXguG4Zzxu5CUEUsoOo+6oJqx/iInM/JD0C3tttY7O7
 Gqw+8K3yTjt3FY/22UCxJ3um0yOyQqxsTwdts1z89w0Qu1CYSWmrBSPOUriOQqA5T6ug=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qo1LR7qrIwKJFtiU17ykHkbB13kJdtxhqwfYwUfZhvA=; b=SFHHU85Y4AheKPeelgFZ4Yrj8g
 gBCmfww0JAgeLn2i8XWsdQeQJc5pjfpjGPNDwBndP3Mk5+//wqyAUrSUZnf23g61vqDFvSf6GfU0V
 MwIm0yc7nnvZcjWMBNd2tNvdQZ+v7ol4Bg210Cr+iPjtaRvLOij+g4WpW7x2eEhJ6TfE=;
Received: from out-170.mta1.migadu.com ([95.215.58.170])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wpotN-0004zT-8J for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 15:11:23 +0000
Date: Fri, 31 Jul 2026 23:11:02 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785510674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qo1LR7qrIwKJFtiU17ykHkbB13kJdtxhqwfYwUfZhvA=;
 b=jD5wOdrf8h5mlWbkWIIredTfjWIAiJ71znqBSjQ7zbpML8PWy6RmmcRGZa7BCDL9qZfsqO
 uttlq0r3C6Ao7WiRTJedjWVOP1f4x8cSC63BJ6wDixAojIUP2Bczt0P/nV4vsRWngQ7EiD
 bDcZFs4H/FkW1LFUeXED4/+7zqbkY44=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <amy7Biucbf-et5O2@MiWiFi-R3L-srv>
References: <20260730184853.48347-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260730184853.48347-1-ebiggers@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Headers-End: 1wpotN-0004zT-8J
Subject: Re: [f2fs-dev] [PATCH] mm/swap: reject swapon() on filesystem-level
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
Cc: Barry Song <baohua@kernel.org>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>,
 Youngjun Park <youngjun.park@lge.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
 linux-fscrypt@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 07/30/26 at 11:48am, Eric Biggers wrote:
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
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  Documentation/filesystems/fscrypt.rst | 4 ++++
>  mm/swapfile.c                         | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
> index c0dd35f1af12..cba1989777da 100644
> --- a/Documentation/filesystems/fscrypt.rst
> +++ b/Documentation/filesystems/fscrypt.rst
> @@ -1238,6 +1238,10 @@ astute users may notice some differences in behavior:
>  
>  - DAX (Direct Access) is not supported on encrypted files.
>  
> +- Encrypted files cannot be used directly as swap files.  To swap to
> +  an encrypted file, set up a loopback device on top of it.
> +  Alternatively, encrypted swap can use a dm-crypt device instead.
> +
>  - The maximum length of an encrypted symlink is 2 bytes shorter than
>    the maximum length of an unencrypted symlink.  For example, on an
>    EXT4 filesystem with a 4K block size, unencrypted symlinks can be up
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 78b49b0658ad..e4991da81b5f 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3650,6 +3650,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  		error = -EBUSY;
>  		goto bad_swap_unlock_inode;
>  	}
> +	if (IS_ENCRYPTED(inode)) {
> +		error = -EINVAL;
> +		goto bad_swap_unlock_inode;
> +	}

Sounds reasonable to me.

One minor suggestion: it might be helpful to emit a pr_warn_once()
explaining *why* the swapon was rejected and pointing users to the
dm-crypt / loopback alternatives, so the -EINVAL isn't opaque.
Optional though -- the check itself is what matters.

And this patch updates fscrypt.rst. Would it be good to also
update the swapon(8) man page to document the new -EINVAL
condition?

Other than these,

Reviewed-by: Baoquan He <baoquan.he@linux.dev>


>  
>  	/*
>  	 * The swap subsystem needs a major overhaul to support this.
> 
> base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
> -- 
> 2.55.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
