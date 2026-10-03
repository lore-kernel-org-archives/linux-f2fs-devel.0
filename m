Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB16CA5FDD
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  3 Oct 2026 22:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:References:In-Reply-To:From:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ve0ITk1Cxq1gAaZQduJq+QuCPN43QySNi2zBOZT1GfE=; b=Y5evV7ZmTY/pjc04kBbdYLM3xg
	tgZSN4utuy2y8N8wwOO/pzz20LOtFhoVeNK2PLQGVotLvTvOPhwre/bJZERJZuYRWwPgmrVkN9s5w
	ic0Qba31usKC2UAXBGqKiLpKyUHDNjmxgzBwE/yBoNIj6MSlj3nh1bydFgKaRWjNOFxY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xD8Tx-00070x-LW;
	Sat, 03 Oct 2026 22:45:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <m.wilczynski@samsung.com>) id 1xD8Tl-00070l-Cf
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 22:45:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Content-Transfer-Encoding:
 In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vFhGMCg6Ji/JXdFQ3B6wXXIZQgQ9xvpb3HvqRmvxgSk=; b=P3BZU8EKs+XsvxDCAzUJ+GHZp4
 d0RoBxjuCLrOwXHR1hnm0mMjCvQdsKyBSwjjPDFfqdr8edcfA8TRYqN7ZTutdys42BqQP6juyHk0r
 PyzPbbKWtE/IQOvycZ6jzSjUssQDC695FoQg6OifeVtYXXxB9zpon2teomRw9ORVRWTM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:Content-Type:Content-Transfer-Encoding:In-Reply-To:From:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vFhGMCg6Ji/JXdFQ3B6wXXIZQgQ9xvpb3HvqRmvxgSk=; b=OSqKl931WE6w6vnZbU0Z3V4kv3
 VFXdF7M9jYf91mx2iHdLQSSgzZgRXnX5AeIgou6vsMj6G+xdKnsVy8xVpvns6M7qG7T2DJbQnNlIW
 /OZQ28n9Sryu3CMRClsPd2cqLKtOdOnG4aOcmHWf0FfJlEkTl9rC7lE27qisl+ImEnA4=;
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xD8Tk-000800-On for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 22:45:18 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261003224508euoutp02c41c30b489eaee9363e860f2478d6027~bJmji_WXc2979329793euoutp02u;
 Sat,  3 Oct 2026 22:45:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261003224508euoutp02c41c30b489eaee9363e860f2478d6027~bJmji_WXc2979329793euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1791067508;
 bh=vFhGMCg6Ji/JXdFQ3B6wXXIZQgQ9xvpb3HvqRmvxgSk=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=RLbFDHwuh3NRChlB5DbAnpf5fbQ/9VI4LqGu4llTjFUiXPQ562rniZUJozx7F6f0C
 O998yLIejmOOpMfO2undeRdQGMIbbwvHHW6qvrglXgdLXRekz3Vq8zAZ0mrAGgSxG4
 yLsO68CPN7a6ZuBi2t//4zMj/AdCV8fhYFGTexlA=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261003224507eucas1p200ece20a05f4aac2eeb0180f041df0fe~bJmigAu1f3080530805eucas1p2D;
 Sat,  3 Oct 2026 22:45:07 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261003224505eusmtip1f6ac4f841c43fd74cce4c31cdfba487f~bJmg3wbbL2072920729eusmtip1D;
 Sat,  3 Oct 2026 22:45:05 +0000 (GMT)
Message-ID: <9c5913c0-11c8-4db8-844b-ea2ef29bf5db@samsung.com>
Date: Sun, 4 Oct 2026 00:45:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Eric Biggers <ebiggers@kernel.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20260925213926.GA1903@quark>
X-CMS-MailID: 20261003224507eucas1p200ece20a05f4aac2eeb0180f041df0fe
X-Msg-Generator: CA
X-RootMTR: 20260925113507eucas1p2ddb94f2077b679426aa86dd1d492eaf3
X-EPHeader: CA
X-CMS-RootMailID: 20260925113507eucas1p2ddb94f2077b679426aa86dd1d492eaf3
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113507eucas1p2ddb94f2077b679426aa86dd1d492eaf3@eucas1p2.samsung.com>
 <20260925-lz4-vendor-upstream-v1-9-1c7ffbe21c4b@samsung.com>
 <20260925213926.GA1903@quark>
X-Headers-End: 1xD8Tk-000800-On
Subject: Re: [f2fs-dev] [PATCH RFC 9/9] MAINTAINERS: add an entry for the
 LZ4 compression library
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
 Herbert Xu <herbert@gondor.apana.org.au>, Minchan Kim <minchan@kernel.org>,
 Helge Deller <deller@gmx.de>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Yann Collet <yann.collet.73@gmail.com>, Gao Xiang <xiang@kernel.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, llvm@lists.linux.dev,
 Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 linux-crypto@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 Nick Terrell <terrelln@meta.com>, Borislav Petkov <bp@alien8.de>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Thomas Gleixner <tglx@kernel.org>, Justin Stitt <justinstitt@google.com>,
 Phillip Lougher <phillip@squashfs.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net



On 9/25/26 23:39, Eric Biggers wrote:
> On Fri, Sep 25, 2026 at 01:27:39PM +0200, Michal Wilczynski wrote:
>> lib/lz4/ has never had one: get_maintainer.pl returns only the LKML
>> fallback for every file in it, including include/linux/lz4.h, which eight
>> subsystems build against.
>>
>> This matters more now than it did. With the previous patches lib/lz4 is
>> vendored upstream sources, and someone has to bump them to new upstream
>> releases and decide what the kernel-side glue may do. I am willing to do
>> that, so add myself as its maintainer.
>>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  MAINTAINERS | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index cc3cae2e378b34aeb705cef654c720ca9f2ba223..989e1b5fab21432dd7042d1e60c4bbad85beb925 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -15606,6 +15606,12 @@ S:	Supported
>>  F:	drivers/net/pcs/pcs-lynx.c
>>  F:	include/linux/pcs-lynx.h
>>  
>> +LZ4 COMPRESSION LIBRARY
>> +M:	Michal Wilczynski <m.wilczynski@samsung.com>
>> +S:	Maintained
>> +F:	include/linux/lz4.h
>> +F:	lib/lz4/
>> +
> 
> Should this entry cover lib/decompress_unlz4.c and
> include/linux/decompress/unlz4.h as well?

Yes I'll add both in v2.
Thanks a lot for looking at the series as a whole.

> 
> - Eric
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
