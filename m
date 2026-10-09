Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B80CA5FED
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2026 08:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PQtbOVCZv8vL7WRAef1l4rxi0tm4IkovW3pwbJfLkP0=; b=ZG1YnViF1ZpB/fQERhy5hrC52b
	uL0GKheNZ16wBdVLrvRWtlXctMwtww6uERY3CdsRD5CEIlbW/IIIXIuS0ZfmZlw38CVRxKbRh5Bb0
	RnRpeE0xMxBY49wwaNSzHX6Bx5kXi6aPuJLToL1gBbqvuAl1z1ok+8S0KKY1ZLIZpoOg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xF656-0002Ff-3p;
	Fri, 09 Oct 2026 08:35:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xF654-0002FY-Vv
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 08:35:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LJp1ABo9XG9ZF+W5UNjHtd6WdeHvlA8w8SgIAeqqbUA=; b=O7+WrDOqe/7tscjbY2dJ1BcYns
 0gcCwR/ZJ9Qe+xHlzDF8kP6WQwrVRp5SuKXM2Zx5np4CHuKJBH9PuhvBq8wzYsXPOH9SCLqZ/JyXM
 URiEZYycp7jLUe7VrnMia6WjB+1zgJ6h0xmvfHXokqwY6S5ubL8/x+5P32biuXyyB8+A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LJp1ABo9XG9ZF+W5UNjHtd6WdeHvlA8w8SgIAeqqbUA=; b=cBRIpHe8MLQvc8r6YpCEuk8wyG
 J3W2IuUt4L/iwaVEfktMdZQipFk+WlsRaGwUsb1RsklcyOdd033aY3zBf2wj75HG7FzMI4CB1/0fB
 qfKpMrqKRrrd4iT0Ri3Ne9ZCYcVkWong0xZntYEKm5AvGBh11H2hR6GPzAtOHAHXQBvY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xF652-0000rD-SB for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 08:35:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 418A6601F9;
 Fri,  9 Oct 2026 08:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F301F000FF;
 Fri,  9 Oct 2026 08:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791534947;
 bh=LJp1ABo9XG9ZF+W5UNjHtd6WdeHvlA8w8SgIAeqqbUA=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=ZrrGn15xHDm0VBgW6cpZpvLBFU48SqjH9iXbyqj1D1FjB9srg4CbU5KN8mODXGbRs
 LAJPTXHifupnXvMnMuB37aOfvA2ATmG6MQdISYboACKENt8IhC5i7FFhj/yE9XyjIm
 YG3SeW6COSUtuv1TQpM4AEIj5hAU0kTxEehtvHvDw71pyUM2JGBjRSJEL6MSQIEgrr
 PrJMGBftKH9kgo+P/Te/wRwyXeJAEoiWFLVX4gH/2vLkUaazpkmEzcbMWoI3ixmXoS
 jWles1FkEFLrmUObz4BJJbMru066TuSZQkj9EV447jKM+AY51OCuyO7kg5uFzjYPT2
 BKvZdBLvvuBpw==
Message-ID: <63812000-4677-4af6-a3e1-4e87e39f0d88@kernel.org>
Date: Fri, 9 Oct 2026 16:35:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261002171704.3652570-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261002171704.3652570-1-daeho43@gmail.com>
X-Headers-End: 1xF652-0000rD-SB
Subject: Re: [f2fs-dev] [PATCH] f2fs: disallow mmap write and data-modifying
 fallocate on atomic files
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/3/26 01:17, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Stores through a shared writable mapping and fallocate with
> FALLOC_FL_PUNCH_HOLE, FALLOC_FL_ZERO_RANGE, FALLOC_FL_COLLAPSE_RANGE or
> FALLOC_FL_INSERT_RANGE do not go through ->write_begin, so they bypass
> the COW inode and modify the original inode directly. Reject them while
> the file is in atomic write mode, as fallocate already does for pinned
> and compressed files. A write fault gets SIGBUS and fallocate gets
> -EOPNOTSUPP.
> 
> fallocate without these flags only preallocates blocks and stays
> allowed.
> 
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/file.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index ef4d218e694..56c686b8580 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -140,6 +140,10 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>  		return VM_FAULT_SIGBUS;
>  	}
>  
> +	/* mmap stores bypass the COW inode and would break atomicity */
> +	if (f2fs_is_atomic_file(inode))
> +		return VM_FAULT_SIGBUS;

Will we suffer race issue due to the check w/o lock?

Thanks,

> +
>  	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
>  		err = -EIO;
>  		goto out;
> @@ -2113,9 +2117,11 @@ static long f2fs_fallocate(struct file *file, int mode,
>  
>  	/*
>  	 * Pinned file should not support partial truncation since the block
> -	 * can be used by applications.
> +	 * can be used by applications. Atomic files should not either, since
> +	 * these modify the original inode directly and break atomicity.
>  	 */
> -	if ((f2fs_compressed_file(inode) || f2fs_is_pinned_file(inode)) &&
> +	if ((f2fs_compressed_file(inode) || f2fs_is_pinned_file(inode) ||
> +	     f2fs_is_atomic_file(inode)) &&
>  		(mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
>  			FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE))) {
>  		ret = -EOPNOTSUPP;



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
