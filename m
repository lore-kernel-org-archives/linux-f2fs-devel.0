Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C54606C93E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hdLT06kc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JM7cxWbX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eYPZkc8r;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lDmNFiVB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uh3GUjrMDfcae8REjSsqO0Z1MjM8ejefmGqQ/cqEwJs=; b=hdLT06kcnRanf8tiw7bo5trPh7
	8txMVB6ZVxGlU44gq4HHuYyHbqG/TOMyPhUPXOE17jChgTQXEbD4fNMqH96trreDQuTFiJkvjJsQk
	FS8OJaUOGYjaVo7PAYiB2oBeieIidElq6ww3TC7HLydQF3JezVeZDns1ErIXtZHwRVE8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xIpLJ-0006ob-QR;
	Mon, 19 Oct 2026 15:32:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1xIpLI-0006oO-Oc
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 15:32:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9+c4hrm+9pvKCTcELM62uVCGKKJpquDOsEc8oEk4+g0=; b=JM7cxWbXwKt2/qHfPRCUuThQTF
 aElEfo1Y2M/jsRHvP3IPsAgoJ8RplXsALZz7B4O9PEI8YANlvW/tipzuu6M28smfZh2DtdRZkAMAW
 a0YuI4ZOwSTFj0BcPSDMlIWLfq1RBTU4xBlsLD3PqNj/QcRtwGjk3o+9I2+GVpGgmzAo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9+c4hrm+9pvKCTcELM62uVCGKKJpquDOsEc8oEk4+g0=; b=eYPZkc8r/vwdHMW/uYQ1FB4P3T
 gkVZsNiCZlRk1wZYufgWEOjRZStvIyEVuy9wooiuayeEiyhVGaG3abnUfi5QdXnj5PZzZ8wfwQ4QT
 f3NTJkPiriP+sKBTf5JCdA+NHyFDiPdl1oc4eL3c6S1h4USjB/n6TX2GdLQDrfZQNu3A=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIpLF-0003Xw-Ni for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 15:32:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 135F760AB6;
 Mon, 19 Oct 2026 15:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946B21F0281C;
 Mon, 19 Oct 2026 15:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792423915;
 bh=9+c4hrm+9pvKCTcELM62uVCGKKJpquDOsEc8oEk4+g0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lDmNFiVBwmkw9xVJeWFEMs8sl5rgaYCwa6lFI/kU4Tkeo6okSrVnpFKdriQqKINei
 ugZ0Oun4T5uLLwDcjl2xT8sEw/fn45FyTMQehOi1G1ZoHK7mUy35yz2Fs31WlPBLmg
 YILMFBGsitRO51Ks428prDxTt5PnydjTz9mY50Eln9gojrJXm8jRnoFVG9q7BZkXck
 VTCD/BBRTStcgjX5+9s/Utn/gErcxTD2m5DUpGOu/q4NnQ8e7ayUGamMp4mgAGPFQe
 hlfWDyX76bcy+8xmBoAdC0FDld7eOkSXCPfTDaDeXxBvVbySIzWqnxriU+i9P0Q5pO
 SSzjL8IF4TAkg==
Date: Mon, 19 Oct 2026 15:31:54 +0000
To: Chao Yu <chao@kernel.org>
Message-ID: <atY36oouQpmVHtwJ@google.com>
References: <20261014112629.59861-1-jsjlee1020@gmail.com>
 <d1236f9a-b5ec-434d-9293-54cf9f6364ef@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d1236f9a-b5ec-434d-9293-54cf9f6364ef@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xIpLF-0003Xw-Ni
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix submit accounting for IPU writeback
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19, Chao Yu via Linux-f2fs-devel wrote:
> On 10/14/26 19:26, Seongjae Jeong wrote:
> > f2fs_write_cache_pages() uses the submitted count, which is set to
> > fio.submitted in f2fs_write_single_data_page(), to update nwritten
> > and decrement wbc->nr_to_write.
> > 
> > In the OPU path, f2fs_submit_page_write() sets fio->submitted to 1.
> > However, in the IPU path, fio->submitted is never set and remains zero.
> > As a result, successful IPU writes are not accounted for.
> > This can cause asynchronous writeback to continue beyond its budget.
> > 
> > Set fio->submitted in f2fs_inplace_write_data() after a page is
> > successfully merged into a bio or submitted, so that successful
> > IPU writes are included in the writeback accounting.
> > 
> 
> Missing Fixes and Cc stable line?

    Cc: stable@kernel.org
    Fixes: d68f735b3bc9 ("f2fs: check io submission more precisely")

> 
> > Signed-off-by: Seongjae Jeong <jsjlee1020@gmail.com>
> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Thanks,
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
