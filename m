Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E25BEC01A1
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Mar 2026 07:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6/qse5PTyK9qS7vQYBkR6IVV8k7fpTlio9IFEzgqR6g=; b=Aq+of7lDrHtoNX9LRDzO3uZdjw
	MppmLjhJ3jWWlaJhCDxNHeZOdbLhEM9+qvYCT5W1H1/I0lEdZEXFamHi9qIMhTpZ1XuP5yvRmWWXV
	KhqXNzL8vyUEt+i593BcIouicYv8ls00kPS85YXUtthUCeGW1gxtcxP210Ul/PAW1S4c=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w4a0w-00050H-HI;
	Mon, 23 Mar 2026 07:47:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gregkh@linuxfoundation.org>) id 1w4a0S-0004zl-Km
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Mar 2026 07:47:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=abVxq2N/XBvoVJ/QKQcKt2BA6Lmh0E+elKJeQJld8/0=; b=cp0xR77m1CFX0Y/q4kCUsaLHh/
 DKp7EqOXpxN32V2JZJEbAavulCIQfkkmr2kDRZ6QGAP6QXaURy4Y8mrrQ3jdeVMCB5ZG4H7ZVlD6g
 VaRsreCYZwSyzrlYLCM32ZClviKYRMuch+1yROg8mocTm1QZv9pWvesK+vcMtGX8hH00=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=abVxq2N/XBvoVJ/QKQcKt2BA6Lmh0E+elKJeQJld8/0=; b=iZmkiiXetOhbyh53XfrJyH19BO
 +oKDjRkUmT0jwctvf+xmjsxn+vM7b+W8afBAsM4F8mBU5u0Hu1uacfmjylrLfT72zdAhpVjGwK7QK
 fly3mFbmZBQEJSYTDd+MGOWYCJg3rTZzy099Akc/Qyh9n/6x9hJCN4obbY3oQw3h/e/c=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w4a0S-0002Lb-0j for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Mar 2026 07:47:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 58B94600C4;
 Mon, 23 Mar 2026 07:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AFAC4CEF7;
 Mon, 23 Mar 2026 07:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1774252038;
 bh=6PZXTdesn371F1xVolbnQ7DHxg1Lz3G/w8zESyH2mQE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JQhgaswC3IzYKGMvmNVGrSkeJDlhb5N317yKKwI7C6C+722wniC/eyLwlh2X231AT
 pHB8/n8XMZ+pMvHOoSuXRicbK9vfF41y/D0DDuT9yvQOzl2Xz9TiACXE9SDP6CztnC
 W/XK2Ku9wXu+d2FJQJs6gs94BDjkP5XZdWFNr6gs=
Date: Mon, 23 Mar 2026 08:46:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: G S <geoo115@gmail.com>
Message-ID: <2026032354-country-saddlebag-5331@gregkh>
References: <CAHor6QJaim=omkU2Uacqrwu5OnzYEcPOseFUoYy3e6KxecdQDA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHor6QJaim=omkU2Uacqrwu5OnzYEcPOseFUoYy3e6KxecdQDA@mail.gmail.com>
X-Headers-End: 1w4a0S-0002Lb-0j
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix use-after-free in
 f2fs_compress_write_end_io()
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
Cc: jaegeuk@kernel.org, security@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sun, Mar 22, 2026 at 09:31:30PM +0000, G S wrote:
> Hi,
> 
> I found a use-after-free in f2fs_compress_write_end_io() that is the
> same class of bug as CVE-2026-23234 (UAF in f2fs_write_end_io()) but
> in the compressed page write completion path. The CVE-2026-23234 fix
> does not cover this function.

As you have sent this to a public list, no need for security@kernel.org
to get involved.

Also:

> Approach 2 (cache sbi fields): Cache sbi->page_array_slab and
> sbi->page_array_slab_size into local variables at function entry
> (before dec_page_count), then use the cached values in the
> page_array_free equivalent at line 1503. This avoids dereferencing
> sbi after it may have been freed:
> 
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1478,6 +1478,8 @@ void f2fs_compress_write_end_io(struct bio *bio,
> struct folio *folio)
>  {
>   struct page *page = &folio->page;
>   struct f2fs_sb_info *sbi = bio->bi_private;
> + struct kmem_cache *pa_slab = sbi->page_array_slab;
> + unsigned int pa_slab_size = sbi->page_array_slab_size;
>   struct compress_io_ctx *cic = folio->private;
>   enum count_type type = WB_DATA_TYPE(folio,
>   f2fs_is_compressed_page(folio));
> @@ -1497,7 +1499,12 @@ void f2fs_compress_write_end_io(struct bio
> *bio, struct folio *folio)
>   end_page_writeback(cic->rpages[i]);
>   }

Can you turn this into a patch that can actually be applied so you get
full credit for the fix?  See
Documentation/process/submitting_patches.rst for how to do that.

thanks,

greg k-h


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
