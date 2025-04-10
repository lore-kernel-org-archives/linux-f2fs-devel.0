Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E43C3601E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Apr 2025 07:17:26 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u2mA7-0004LQ-Vw;
	Thu, 10 Apr 2025 07:17:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1u2mA7-0004LF-4Q
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Apr 2025 07:17:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Pe+kNVKhMjevhraWzxy7OkPgX3XRfPhMwx047J8qGRo=; b=VN8YIsoqTC2mlB89kkbezrQ93g
 E/Wcgt2tomC5KB4LO7CXIZqFikQ7NDhTVADJtMruK4U3y0gw4mMsVFX4xUzOJLINw6xkqZDObAiaz
 W3rUP9FQl9YqsES/CsZylo5Vnezhsomw5JgJQXGoVtaBGZAXojCJovia1hSc21fjCtTY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Pe+kNVKhMjevhraWzxy7OkPgX3XRfPhMwx047J8qGRo=; b=BYmHqdQaaDGG/+D+2gJTLNtw4b
 m2m5DG+j6bsMKX1/81pLN8+zOBQOAV4PCf65sIGGKakN6tIaAARLH4FUcfNkB2gxY94smUZ2j8fKF
 S25Rnh3jAZOo+wKKaPokmKdopmtd/zQW7ernzvcMpMCKydODXwBPcUqb5YiJktSGHLkw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1u2m9s-0004PA-AW for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Apr 2025 07:17:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0B0B24498E;
 Thu, 10 Apr 2025 07:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BD0C4CEE9;
 Thu, 10 Apr 2025 07:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744269422;
 bh=wwVXzN1Ow8rhSX2x6ePeZWEPLbiOE1WfCOHjCw74VX0=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=Vfh8kEnpcb+fljvfp+bXwZneGvw8Zs15FQtKRTR7YpBE4MyqN+H7KhMLAh20vSusW
 52R+eFhkkzFX8qfnbXD6aI4q/P8S7uhU5X1c6Wt4M363hysZyxSEZ4Zdk1OsEWmYDj
 YJ37iLbw5dVhKSrsuMe2Gy6XBZy+IaNwzBg7YBav2NvCwcAarOTTuyn5TiFL/MRHys
 ncua4kW44wKiNEpa4BNCl5HyUoMdw6NqTS4kZZZ3tHOhD1gvo0rm9/E1meyArIxV5n
 WmJTcZ/nACyLFY6YqKFb3SPupkrbvjG3ow47pZQJbTeuHPbZ2GOJHCOgIRTnSHhVRH
 ksCK0rvYqLx4A==
Message-ID: <46507541-7e11-435e-b57a-7ed945ddc182@kernel.org>
Date: Thu, 10 Apr 2025 15:17:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: uplinkr@airmail.cc
References: <88f281ff9ff9b1fb899c92d6b32f52b7@airmail.cc>
 <CAD14+f1CYZ-OyKg36b_=VPmbBK0LSiieq1pgtXUy4OV2+KrR_g@mail.gmail.com>
 <6e929f78-ab82-434b-a553-6e56d38fcfcc@kernel.org>
 <80e1ae8eddff0536f09ca07e802fb983@airmail.cc>
Content-Language: en-US
In-Reply-To: <80e1ae8eddff0536f09ca07e802fb983@airmail.cc>
X-Headers-End: 1u2m9s-0004PA-AW
Subject: Re: [f2fs-dev] Resize metadata corruption
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 4/10/25 14:19, uplinkr@airmail.cc wrote:
> On 2025-04-10 08:52, Chao Yu wrote:
>> I checked the log, I guess it actually seems pretty bad... I guess we
>> need to find out those file which has not been migrated correctly, and
>> try to correct them, may be w/ a new tool.
> 
> Hello,
> 
> The issue is the corrupt partition in question contains a lot of unbackupped, valuable data for me. I wasn't aware or informed of the potential issues resizing on F2FS has (the ArchWiki listed none)
> and as such recovery of this partition is a lifeline for me.

Sorry about this, we should give a explicit caution about resize tool
use.

But still I didn't get why we can run into this situation, since as you
said, resize went through successfully. Could you please provide more
details about process of resize? Parameters for resize? Logs you kept
during resize? etc.

> 
> Could you please write this tool or a patch that I can try in fsck?

I will try my best.

> 
> Thanks.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
