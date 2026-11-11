Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7B0606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Nov 2026 07:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ezMTbfUu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=j7Y0bruO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=c5bNWQDL;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QmogyahR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=faNSYtpaG4wY9IF1V7GZEZBemXuOEz68Dcl4/B8uUDY=; b=ezMTbfUuoMETJy
	0Wdl9Vcf9Ok1BU8q4juCo4ootlcUSOKJotSAah+ezBeH4Ak+p5ulSulcVAPvCMhdo7SLWgPD3MErc
	j3vn9O394ZW4/fEkbfR/g+FFyI6WRDJxTFFfWikKWJy+sQEGw6MTKeoALTy7ozLm1FHAcv9zedue3
	VIA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xR2at-000000001fR-1I7M;
	Wed, 11 Nov 2026 07:18:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xR2aj-000000001ex-1re2
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 07:17:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Fg7sBIBBIZeKWJ8/JYY346gWQ9mcOTtew5ZMnNDXvPo=; b=j7Y0bruOHkFDw4bDZ780O/4PdZ
 WTkXR2cZudQWC2aRSiuXyqgw+j+WnTEkbT6fBAHmf0csK31Tn7r6EzEZ9rpTH+z1zDuEUm0b/fSrc
 1kNBqQuvKS5UE+sdsphP/HCKUlFzqFKcMJNdupeHoW1XjYM4IntbSE1XzW6TL+ZnRYuU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Fg7sBIBBIZeKWJ8/JYY346gWQ9mcOTtew5ZMnNDXvPo=; b=c5bNWQDLs5WNzmac7lwUKLlwZw
 Z4Oz2fqRYkDBrYw64huyEvajZ1N6ssYG+T3dIqQjbc3vCH/fQQy8AHfC1hHYgYulq0WBr8h+euRwS
 GbRIXimYkDZQSX/PId4IO+m5wOSwyHCwLommwQxgsSsoDV4J5LYcx0b9bRG+uiZvGAgg=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xR2ai-0000000058h-3OWe
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 07:17:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2E1A4613F9;
 Wed, 11 Nov 2026 07:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29F61F00A05;
 Wed, 11 Nov 2026 07:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794381470;
 bh=Fg7sBIBBIZeKWJ8/JYY346gWQ9mcOTtew5ZMnNDXvPo=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=QmogyahR2S2S+50NxZugt7fuY4axtg3ueDQSY4W8/10+kK5FqEDnuRKiqCJhjjA3W
 sS2UI+NlgNe2HyT81vxGwW6Pc2XLnxY0B3zyAHIDXhuoQxDXogIwD+jTkVmbcaRtKP
 lnSKE93RpH+7VNrFhWAcsGelWnOcCmwofy+IkF/v+a2XZ4x9Opf1MbfSLTnTMKiXfy
 eQupF69MsyuWhssMB5fbiSqH5zgWwypCposzpFk4mYeXI9WtTKu+928pMME7IFCRPK
 xCvhlkEdE6XBAXHwSVcxeHtcqXjE/saTJVutDNnGqiRiPEMfgJiOl3MUEg8bFYSaaY
 +gbzg0MBZSjpQ==
Message-ID: <7547b1e5-11a0-41b2-9762-f11bf76756ce@kernel.org>
Date: Wed, 11 Nov 2026 15:17:48 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
References: <20261103033713.2709978-1-rdunlap@infradead.org>
Content-Language: en-US
In-Reply-To: <20261103033713.2709978-1-rdunlap@infradead.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xR2ai-0000000058h-3OWe
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix various ABI documentation issues
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-f2fs-devel@lists.sourceforge.net,
 Shuah Khan <skhan@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 11:37, Randy Dunlap wrote:
> Clean up the f2fs sysfs ABI documentation:
> - use "number" instead of "#"
> - use "seconds" instead of "secs"
> - remove an extraneous period ('.')
> - add a space for better readability
> - fix grammar, spelling, & punctuation
> - break up comma splices
> - use a list for "gc_urgent"
> - add a blank line for the list in "extension_list" &
>   "effective_lookup_mode"
> 
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
