Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4291CA5FE4
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  4 Oct 2026 00:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:References:In-Reply-To:From:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YoW4CcsVDGVTFzDuQnqWdVrLo308xB6zZM3VLRDebSg=; b=dX8BUsJTZUXlTWN/AYny89TBwY
	181Mz+EiAExymsiEQ5L1/YrMEB/m9Cr7Zh8yt3IEzdCvzGBbDePeKdtJDlp+yRdUZdQHfPM4EJpVW
	rFSB05MgQIyFQwO9JJMwRHM0BfbXvTWWFzqHgNokd0OYy7xP6Ypc8WOzvEnUPY9cflCQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xD9jE-0006K7-0b;
	Sun, 04 Oct 2026 00:05:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <m.wilczynski@samsung.com>) id 1xD9jC-0006K1-I4
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 00:05:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Content-Transfer-Encoding:
 In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZJZTrL5SQnYa6gvVNuN2LjMawlbBBC4EWuE7TxWcKx8=; b=kfHkaGzhRclbWFGgK//JJDxHY3
 zT+q5kxygWiSUfajY/7zzz7BvcS6UTf9Tk1cvdGWNQYp5E/5itMpp3oXL+Gy+6DdQVByKbpwojggO
 DhkPHEz9PU6+bpF6vs5XYbSAAXOY199LLTeKTkoX0QZ68T5v9YEY039CWQ1QOWkKA42Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:Content-Type:Content-Transfer-Encoding:In-Reply-To:From:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZJZTrL5SQnYa6gvVNuN2LjMawlbBBC4EWuE7TxWcKx8=; b=KhwRI5FM/Q+iusWiC39LWoOzlm
 MJaeS2igTU1Q38tDwjLgbtZ895I2/1LoJRPVeIARIj8gwk9bcRJfph7OWdJ3iKrdy85qv9YAHl7Js
 +xM59YvdmZhSPp7WOhy2IFHfvrcvDpKEtgUeLJh2KMWcI+a2CsY+pDkHU6Mw23n8njHY=;
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xD9jB-0000rt-Be for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 00:05:18 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261004000510euoutp013ee4f267ec7b07e822726f0b5d88d0fa~bKsbKQ__B2163921639euoutp01V;
 Sun,  4 Oct 2026 00:05:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261004000510euoutp013ee4f267ec7b07e822726f0b5d88d0fa~bKsbKQ__B2163921639euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1791072310;
 bh=ZJZTrL5SQnYa6gvVNuN2LjMawlbBBC4EWuE7TxWcKx8=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=KFP5LNkza8OoBtj5HTuawzDRYYYBZ/WrfFMAfjXatZRd5ZwpmRtkrpGNteNnFAcFW
 a+pvo77kefjxlg+J0Kbo3aGXfUJFkeO4mBIkzt4cVg0+G6B7j2sqT1cGqS4uI3Kd2H
 +7VeWQwlvnZ97NOV2yx7DRYeXvD3SKk6JpL6yeyc=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20261004000509eucas1p12b906a44a576ad1b1bf6f8099f081cdd~bKsaNgMf72285022850eucas1p1h;
 Sun,  4 Oct 2026 00:05:09 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20261004000507eusmtip2934e51491ae1d0ccbd9db1e873d1df61~bKsYgse7o0742707427eusmtip2n;
 Sun,  4 Oct 2026 00:05:07 +0000 (GMT)
Message-ID: <ff30763b-d39b-450f-82ef-cba10d221ae6@samsung.com>
Date: Sun, 4 Oct 2026 02:05:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <arn9tK5MxxxfH7OW@google.com>
X-CMS-MailID: 20261004000509eucas1p12b906a44a576ad1b1bf6f8099f081cdd
X-Msg-Generator: CA
X-RootMTR: 20260925113456eucas1p136c3cd1f08be7201ad6b3f7b0e8ff02d
X-EPHeader: CA
X-CMS-RootMailID: 20260925113456eucas1p136c3cd1f08be7201ad6b3f7b0e8ff02d
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113456eucas1p136c3cd1f08be7201ad6b3f7b0e8ff02d@eucas1p1.samsung.com>
 <20260925-lz4-vendor-upstream-v1-3-1c7ffbe21c4b@samsung.com>
 <arn9tK5MxxxfH7OW@google.com>
X-Headers-End: 1xD9jB-0000rt-Be
Subject: Re: [f2fs-dev] [PATCH RFC 3/9] lib/lz4: add the build environment
 for the vendored sources
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
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Bill Wendling <morbo@google.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Sungguk <sungguk.na@samsung.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-s390@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>, Helge Deller <deller@gmx.de>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Yann Collet <yann.collet.73@gmail.com>,
 Gao Xiang <xiang@kernel.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, llvm@lists.linux.dev,
 Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 linux-crypto@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 Nick Terrell <terrelln@meta.com>, Borislav Petkov <bp@alien8.de>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Minchan Kim <minchan@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Justin Stitt <justinstitt@google.com>,
 Phillip Lougher <phillip@squashfs.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net



On 9/28/26 07:48, Sergey Senozhatsky wrote:
> On (26/09/25 13:27), Michal Wilczynski wrote:
> [..]
>> +
>> +/* LZ4_decompress_fast() and LZ4_resetStream() are still kernel API. */
>> +#define LZ4_DISABLE_DEPRECATE_WARNINGS 1
> 
> Is this upstream code?  As far as I understand it, LZ4_decompress_fast*()
> deprecated upstream and are strongly discouraged.  Do we want to suppress
> deprecation warnings?
> 

It's ours lz4_deps.h but upstream's lz4.c sets the same switch for
itself lz4.c, since its own code calls deprecated functions. We
include lz4.h before lz4.c, so we have to set it first.

I agree on the direction. The only in-tree _fast() user is the pre boot
path of lib/decompress_unlz4.c, so as a follow-up I'd move it to
LZ4_decompress_safe_partial() and drop the three _fast exports.

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
