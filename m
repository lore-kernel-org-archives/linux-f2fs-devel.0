Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCDBC54EBD
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Jan 2023 23:59:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pG7Tk-0006hm-V7;
	Thu, 12 Jan 2023 23:59:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1pG7Tj-0006hf-U4
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Jan 2023 23:59:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lcbXP+asppRr1xNZOVgHC/D60VbrcwgcDnA9W3xhXRs=; b=OrPTqOZYG1lO93ztLQ1O/HOu1J
 v5ocB+lAyUTu3UoeYkND6pCbdg+jR+3Z+97zcTd3piNNsPyvw4AuIdvDPPmLSvJst0vieHzL7seOZ
 N+L0ExxfFu2CjgXdrtuB9p83tMTl5xN87O5rmrvPINf4ZLn/dJDTfmBvZZSf9qoC3hkI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lcbXP+asppRr1xNZOVgHC/D60VbrcwgcDnA9W3xhXRs=; b=O7bvo/jYOIPU77Of4B1JPo3UHQ
 4469J0x40kS7atNqxkstPK6cRpyzzWCFM//gAsw32sxKyuq43Yz9Q3DX7kVXVCh6t1god/eh/FtC7
 Y+bqIOZ3B8ZWbNhN3z4diG9UDrEX6BuHiKRhZWlzDFhuJ4GjdVZScaQ216AR0ea2M7wM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pG7Ti-001gY1-FN for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Jan 2023 23:59:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 34C80621DE;
 Thu, 12 Jan 2023 23:59:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7498BC433D2;
 Thu, 12 Jan 2023 23:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673567959;
 bh=y5277AjUhOZZfHLc0JpxLjlZ1u6nyxvQMiT0TtO78ic=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oSP7SUQHJ+Y8yvD3tsyOKydc70bLw9Y0q3ew0k/e/iDDDj1KyYnl0O6fnKpbXX5gk
 60QBGDnOcxBGTixPo1jaruDDirh3onpyN3Y8H47e2a4N1PcFXLj043GsnCMaqBIo4C
 qm5WckIkmje3HcqYa16dgNuEadjzdjOXw8RUx1xCS2cgscJwJeWQ9iHkL1Mv19JcRG
 JyORgsyG/T0QiuLOStxFX06ua219Cnr3qcMt888vRU8Fnu4UMlUB6ThOUyjOtbwXgp
 VnXLQz3lMyptT55cK/GaE587Ai8mN8aiO14+JtE7g6lqtTdBYUl9yPESNt2/rMqO2a
 kivWqdkcIzM6g==
Date: Thu, 12 Jan 2023 15:59:17 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Yangtao Li <frank.li@vivo.com>
Message-ID: <Y8Ce1XO0Qeo8AnHh@google.com>
References: <Y78LNobSXGF5N3tn@google.com>
 <20230112151328.29124-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230112151328.29124-1-frank.li@vivo.com>
X-Headers-End: 1pG7Ti-001gY1-FN
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: reset iostat_count in
 f2fs_reset_iostat()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 01/12, Yangtao Li wrote:
> Dear Jaegeuk,
> 
> > Hi Yangtao,
> > 
> > These are all in dev-test branch, which means you don't need to stack up more
> > patches on top of it. I just integrated most of them into two original patches.
> 
> Ok, I'll merge the previous commits and resend next time.
> 
> > Could you please take a look at this?
> 
> LGTM.
> 
> > Applied with the fix.
> 
> Thanks!
> 
> BTW, I would like to ask whether it is possible to maintain discard in separated file.
> 
> https://patchwork.kernel.org/project/f2fs/patch/20221217132318.37718-1-frank.li@vivo.com/

Not worth.

> 
> MBR,
> Yangtao


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
