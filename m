Return-Path: <SRS0=30cE=4C=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAD8C3B199
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 14 Feb 2020 04:33:41 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1317C222C4;
	Fri, 14 Feb 2020 04:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="VGiTDLTT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="NEbUeGmn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="NkFTEsbm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1317C222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j2Sfc-0008RY-JD; Fri, 14 Feb 2020 04:33:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jhubbard@nvidia.com>) id 1j2SfY-0008RM-Do
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 14 Feb 2020 04:33:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5Ey5GwVWyIBJt/+/393UO7Nx1GdweRJOgsCbjE7KjIY=; b=VGiTDLTTcXjpeivukZrgGcYWsk
 2Qhxqe/2Ovyd3mhNTaY56zCvRekb4k4DrKI2uqRMPolWI+kCMaaTSPgcKxde29j+ZWy+skfznnMjo
 JjiYkwtAeOXeGuyblg6SdbHriInkOQJ8D72zmfbBoW8/lwSmrKcZkfcEUulPvOJI8BJY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5Ey5GwVWyIBJt/+/393UO7Nx1GdweRJOgsCbjE7KjIY=; b=NEbUeGmns6rMmbPESJkkBTbLKZ
 7F0coKiv0HmWuXxTPE6sT8HUIOdnwDQQGQjsVO/vcQELvTssDfj1Cr4Sl6TjxTXj1ezCu1i2PNd8K
 SOIJM+dAJZj7VnvnweK2QyqZDOHAhUbsiw+IpSJHH+muAdbmzOOSxfRVhgnpST2Ilf+4=;
Received: from hqnvemgate25.nvidia.com ([216.228.121.64])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1j2SfX-00C89A-B3
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 14 Feb 2020 04:33:36 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e4622f70001>; Thu, 13 Feb 2020 20:32:55 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 13 Feb 2020 20:33:24 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 13 Feb 2020 20:33:24 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Feb
 2020 04:33:23 +0000
To: Matthew Wilcox <willy@infradead.org>
References: <20200211010348.6872-1-willy@infradead.org>
 <20200211010348.6872-2-willy@infradead.org>
 <e0f459af-bb5d-58b9-78be-5adf687477c0@nvidia.com>
 <20200214042137.GX7778@bombadil.infradead.org>
From: John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <ab9d0e43-3fb4-cb14-4974-ad4a8ab57a83@nvidia.com>
Date: Thu, 13 Feb 2020 20:33:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200214042137.GX7778@bombadil.infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1581654775; bh=5Ey5GwVWyIBJt/+/393UO7Nx1GdweRJOgsCbjE7KjIY=;
 h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=NkFTEsbm+clHOSZCX0RL5RspOQeT9W3sLbBgRbLhccmBpDH8wbMqpmqavt71lE50T
 W0r4zoHadn/onXtCLtu33Jw1Lnyb1YLti6uKH/Lqwf3oKwHkMffvnhuXXDp4172iVb
 4JyT1BsemqkZI0x+rarEzerLgE4K30Jj4Akyi8ysj6gTn3vHY411VUJmo07oEAtkVb
 F3culDDOf6MNtFaLukiw3rjiqUenq4Bmkyg4nv/QsS2hRa5xNWUMGZeZaUGVNkKf9z
 beXaG1Dega77Ip/IbGAbpMTTVOuKI2MlLNC56slZlFuJWg4VS8NUVScDIxpxkukqfs
 g+TKG5YT2eP6A==
X-Headers-End: 1j2SfX-00C89A-B3
Subject: Re: [f2fs-dev] [PATCH v5 01/13] mm: Fix the return type of
 __do_page_cache_readahead
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
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2/13/20 8:21 PM, Matthew Wilcox wrote:
> On Thu, Feb 13, 2020 at 07:19:53PM -0800, John Hubbard wrote:
>> On 2/10/20 5:03 PM, Matthew Wilcox wrote:
>>> @@ -161,7 +161,7 @@ unsigned int __do_page_cache_readahead(struct address_space *mapping,
>>>  	unsigned long end_index;	/* The last page we want to read */
>>>  	LIST_HEAD(page_pool);
>>>  	int page_idx;
>>
>>
>> What about page_idx, too? It should also have the same data type as nr_pages, as long as
>> we're trying to be consistent on this point.
>>
>> Just want to ensure we're ready to handle those 2^33+ page readaheads... :)
> 
> Nah, this is just a type used internally to the function.  Getting the
> API right for the callers is the important part.
> 

Agreed that the real point of this is to match up the API, but why not finish the job
by going all the way through? It's certainly not something we need to lose sleep over,
but it does seem like you don't want to have code like this:

        for (page_idx = 0; page_idx < nr_to_read; page_idx++) {

...with the ability, technically, to overflow page_idx due to it being an int,
while nr_to_read is an unsigned long. (And the new sanitizers and checkers are
apt to complain about it, btw.)

(Apologies if there is some kernel coding idiom that I still haven't learned, about this 
sort of thing.)

thanks,
-- 
John Hubbard
NVIDIA


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
