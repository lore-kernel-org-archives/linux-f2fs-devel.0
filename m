Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D7DCF0453
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Oct 2024 11:23:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1syUmr-0000lX-1J;
	Wed, 09 Oct 2024 11:23:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ryan.roberts@arm.com>) id 1syUmp-0000lR-9J
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Oct 2024 11:23:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HzaFLehvrFgOkpNROntTS8UmlNbmWPOQ2o2S0/IiQaM=; b=B5ycVYIarYPTlZH9U+kQWkRC4J
 ROJcIZDHXc8KUgmAbPd5cINlqcZT9zTclsTrkRSRuMes8IGpw1eZiclPYqs/cIJXZ32IOTVRnggwM
 ZOWStpDjuuUIQvVGIZJiZFzCRCx8dlVT95jvMm7mMmvVE/r+DZLLXmM4VnA+nWPvewS4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HzaFLehvrFgOkpNROntTS8UmlNbmWPOQ2o2S0/IiQaM=; b=MkmI4V7Y/kVCIuv0fFSpzOgHm0
 JpwZWZ81dB/caGV0nL6TeC0r+FEsbB/OALGxDgaRzlwdtE//2qHlENKTdPWL7jz36Sh4i+6YuY6hF
 851ozFSfjalJuvM1ieChRJuH9AmH2dEzvC+VeU5q+wtIW+PfB1+kVw4fRACiFoDA7eNQ=;
Received: from foss.arm.com ([217.140.110.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtp (Exim 4.95)
 id 1syUmo-0006JL-4w for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Oct 2024 11:23:23 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40508FEC;
 Wed,  9 Oct 2024 04:23:46 -0700 (PDT)
Received: from [10.57.85.216] (unknown [10.57.85.216])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBEF83F64C;
 Wed,  9 Oct 2024 04:23:15 -0700 (PDT)
Message-ID: <816974a2-03ba-4b34-9de2-d19b8fa3675c@arm.com>
Date: Wed, 9 Oct 2024 12:23:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <671e8774-acaf-4c59-b06a-bf1511de022a@arm.com>
 <ZwQOfGaybpdC6_HW@google.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZwQOfGaybpdC6_HW@google.com>
X-Headers-End: 1syUmo-0006JL-4w
Subject: Re: [f2fs-dev] Plans for F2FS Supporting Large Folios
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
Cc: Ian Rickards <ian.rickards@arm.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 07/10/2024 17:38, Jaegeuk Kim wrote:
> Hi Ryan,
> 
> On 10/02, Ryan Roberts wrote:
>> Hi Jaegeuk Kim, Chao Yu,
>>
>> I heard (via Matthew Wilcox) that you may be in the process of forming plans to
>> add large folio support to f2fs? If so, I wonder if you could let me know how
>> those plans are progressing? I saw your v6.12-rc1 pull request did a lot of
>> conversion from struct page to struct folio (of the small variety for now) but
>> wondered if this is intended as pre-work for enabling large folios?
>>
>> I've been doing a lot of work on the anonymous memory side to support large
>> folios ("mTHP") and hook that up to arm64's contpte pgtable support. This
>> improves performance nicely.
>>
>> Additionally I have experimented (on XFS) with ensuring that text mappings are
>> contpte mapped where possible and this reduces pressure in the iTLB to improve
>> performance further. But it all relies on the file system supporting large
>> folios. I'd very much like to realize these performance gains on Android, but
>> that requires the file systems that Android uses to support large folios.
>>
>> It would be great to understand your plans, if any, and figure out if/where Arm
>> may be able to help accelerate activities in this area. I'm not (yet!) an fs
>> expert, but I see that f2fs is already using iomap, so perhaps now that you are
>> supporting small folios, switching up to large folios is not too big of a step?
> 
> Thanks for sharing the background. By any chance, have you talked larg folio
> with Android kernel team? 

Android kernel team are actively working (along with partners) to enable mTHP -
that's large folios for anonymous memory. They haven't yet got to looking
specifically at large-folios for file-backed memory. But I've had some informal
conversations with a couple of Android kernel team folks which have been
positive about the prospect.

If indeed there's a fair benefit from Android side,
> I'd like to circle back supporting it in f2fs seriously.

My own experiments have demonstrated performance uplift in Chromium web browsing
when using contpte-mapped code [1] (about 1.5% improvement on its own). We also
have plans to selectively use 2M THP (that's PMD-sized for 4K pages, or
contpte-sized for 16K pages) for some hot code, which previous experiments have
shown to be beneficial (I see about 2.5% for the same speedometer benchmark).
This all relies upon the filesystem supporting large folios though.

I'd really like to get large-folio support into f2fs to enable gathering more
performance data in a real Android environment. How best can be work together to
add this feature to f2fs?

[1] https://lore.kernel.org/linux-mm/20240717071257.4141363-3-ryan.roberts@arm.com/

Thanks,
Ryan

> 
>>
>> Thanks,
>> Ryan



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
