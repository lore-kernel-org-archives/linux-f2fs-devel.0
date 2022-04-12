Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF46C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 Apr 2022 09:42:12 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1neD2K-0007Pk-N3; Tue, 12 Apr 2022 09:42:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1neD2J-0007P6-As
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Apr 2022 09:42:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=roq4oqcVsANyaump99KHfP+In4m6tEWKl6BFB/3U+OY=; b=K8+jEsT6UUTp9Oht5EWNftxP9+
 70XGjyvft7giWLVYkMs8up3v2K0MjNSNfMR5sTKBXNbkBCmEO+OTwK8/3IbnhYdCqMfNK3Sa+B0oS
 megX7jx3IVRqZuy4z4VYuE5yVVsMrfIyV96THrg4XuRXDWhpxvIJB+HFTsGfutULMt+c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=roq4oqcVsANyaump99KHfP+In4m6tEWKl6BFB/3U+OY=; b=J3ASBX4v50nCd9KRXB975uVRUW
 5FY6OQiYCPOcSP6+m5KluQk12AkxTlIQJKuDUEs7yXe2zIOHmdBvrnOV6vabMdV0HeAT2v1F2O2FL
 VcqcMAddj2COSXE+08MlAZYHtOutg9SsQAT/Z8WcOFBd9FPkh1adw8AsYceG/SPIZ/gs=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1neD2C-00DtNa-Os
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Apr 2022 09:42:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 262D0CE1C0A;
 Tue, 12 Apr 2022 09:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777A4C385A1;
 Tue, 12 Apr 2022 09:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649756515;
 bh=pi+QmDU26pju7mZ8Fvy5R9dpn1wF+2Rumy0pZTv2pgc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ilvGxvnkvwBu57bFv3FUrX2dp32y3SHgWtdPrIddztOZQet2W4VmhdmcvAyjutvFe
 p4sfXzs1aUNXmoX37Uov4GvETy9t1DX/0L7U+1ryZOZqDAa9d8FEkJM2ezeOYkmUS2
 L3lZVodMWYTrkoJ7wFvV7F9sVJZ2ljCH1fyKkMLu/vg0SzyiaqIE30H9c/EOmYnPPZ
 Cwfgy6SENRltROBLMdu/e1fSBtUSpPDOK7DYeigIS2hSvxK7ofwOEXWNP+z0DH4glB
 vwYk+Wc7UCPgirQh1aqaBWlxPtHrPHSzSOeAmlhafxOWUrtjn32kM7iZfNQW/nlvDj
 pe61lKkOclNlw==
Message-ID: <4fe435c4-6b6f-0223-66b8-45f9549cdc52@kernel.org>
Date: Tue, 12 Apr 2022 17:41:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Jakob Koschel <jakobkoschel@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220331221650.891790-1-jakobkoschel@gmail.com>
 <20220331221650.891790-2-jakobkoschel@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220331221650.891790-2-jakobkoschel@gmail.com>
X-Headers-End: 1neD2C-00DtNa-Os
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: replace usage of found with
 dedicated list iterator variable
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
Cc: linux-kernel@vger.kernel.org, "Bos, H.J." <h.j.bos@vu.nl>,
 Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
 Cristiano Giuffrida <c.giuffrida@vu.nl>,
 linux-f2fs-devel@lists.sourceforge.net, Mike Rapoport <rppt@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/4/1 6:16, Jakob Koschel wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
> 
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
