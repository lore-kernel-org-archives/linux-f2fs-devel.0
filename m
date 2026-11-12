Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525B7606A327
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Nov 2026 11:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=nG1hi11L;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ewo8FtRB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VctYWs4y;
	dkim=neutral header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=AvhYjNqW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:References:In-Reply-To:From:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=46yX8RKd9jU+L3P28b8k4uXl7sVBksa2Y0f6X15YJJs=; b=nG1hi11L0+AV+lTjiPjLst8q9h
	FCcDCinKB+p6VScwNo8m+18XBLYzwsvqddDuZAn/LHObMelV4wIJ4CVePqSyJ9uy5MmSXYrvSnQbK
	xko2qq2l23yPKkBMWDuE8NlDhGcSflI8Tpp4CFUw2aA/ISEMtongi+z+WI/xlRUzvvvs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRSwF-0000000061G-28JB;
	Thu, 12 Nov 2026 11:25:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <m.wilczynski@samsung.com>) id 1xRSwE-00000000619-0QnR
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 11:25:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Content-Transfer-Encoding:
 In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ipHsKGzdySUFK43kUSa1EUse/xjwdqGzCAkyYU+4IsQ=; b=ewo8FtRBagGHnJ9K1BxvxKBG1B
 wzauAGSyAaT8GCsMgCDjQiwb3u+qOr4FMPdnE06MJIrfwAECGHV/RAIX/t25u8+riBT3LrESiDU/H
 I7gwXsOllcEm/doSVbs2PQaDJnnM3NGeTXly+wrvuDOFwgqd2DXl9HzkS8cuW/5VMJdc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:Content-Type:Content-Transfer-Encoding:In-Reply-To:From:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ipHsKGzdySUFK43kUSa1EUse/xjwdqGzCAkyYU+4IsQ=; b=VctYWs4ypTSXqolyAUaZsI+7JN
 LwYN5zcG/fyt9DFXrIaL/pVENzJuLOznkeS+6efsypkbpq/oyPwe0ZBLlCymyiTrbcVmtL/blEIVh
 uWKR7FeczkwUa1pt1ZI7WhUWIPIxppMckFAmo8JQ+3iiym9tGZcq7zDAigrhV55PFc1g=;
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRSwA-0000000032x-3Ewr
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 11:25:54 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261112112543euoutp010f016eb7fa47ed13835ab3afff799d5d~nSIxA7B940644806448euoutp01J;
 Thu, 12 Nov 2026 11:25:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261112112543euoutp010f016eb7fa47ed13835ab3afff799d5d~nSIxA7B940644806448euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1794482743;
 bh=ipHsKGzdySUFK43kUSa1EUse/xjwdqGzCAkyYU+4IsQ=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=AvhYjNqWqGDSDWciDHfOXU3HOJjD8I0PqyiBFvEino+CXJ/Ts8YCaLP0CTP7r83SV
 D0u2NoLv9bExEfdz3CuNTS48kAhibm5QmC2eYY3NRLEJ1vo1+7ksYjGgKf8B93b7Ln
 eIdw+0vhCIWca8FGDq/+owQFBplfxnoB2Ht47E5M=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261112112543eucas1p2f3aa7565474df56edb967cbecfd1858d~nSIwwzSqJ0570005700eucas1p2G;
 Thu, 12 Nov 2026 11:25:43 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20261112112540eusmtip2793b80df566384250842db8b2aa8054b~nSIuZrphA1705017050eusmtip2o;
 Thu, 12 Nov 2026 11:25:40 +0000 (GMT)
Message-ID: <feca1837-fb17-4d96-b6d9-7e5d413ef222@samsung.com>
Date: Thu, 12 Nov 2026 12:25:40 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Russell King <linux@armlinux.org.uk>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Minchan Kim <minchan@kernel.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, Andrew
 Morton <akpm@linux-foundation.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
X-CMS-MailID: 20261112112543eucas1p2f3aa7565474df56edb967cbecfd1858d
X-Msg-Generator: CA
X-RootMTR: 20261106144247eucas1p15bdd0704f32d1cb3b19f9d2296a0cbc3
X-EPHeader: CA
X-CMS-RootMailID: 20261106144247eucas1p15bdd0704f32d1cb3b19f9d2296a0cbc3
References: <CGME20261106144247eucas1p15bdd0704f32d1cb3b19f9d2296a0cbc3@eucas1p1.samsung.com>
 <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xRSwA-0000000032x-3Ewr
Subject: Re: [f2fs-dev] [PATCH v2 00/15] lib/lz4: stop forking upstream LZ4,
 vendor it instead
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-s390@vger.kernel.org, Nick Terrell <terrelln@meta.com>,
 linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-parisc@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
 David Laight <david.laight.linux@gmail.com>, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-block@vger.kernel.org, Sungguk <sungguk.na@samsung.com>,
 Yann Collet <yann.collet.73@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Gao Xiang <xiang@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-erofs@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi everyone,

On 11/6/26 15:42, Michal Wilczynski wrote:
> 
> The import is the v1.10.0 release tag.

It appears v1.11.0, followed by v1.11.1 were released in the
meantime. The next revision of this patchset will import from the
v1.11.1 release tag to take advantage of the newest code. It already
contains the backported commits so I will drop the backports.

I will redo all the measurements with the newr version for the v3.

> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
