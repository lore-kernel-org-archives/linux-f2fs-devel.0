Return-Path: <SRS0=57LO=5E=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59830C4332D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Mar 2020 18:38:38 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28AC920787
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Mar 2020 18:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="DGOpb3uI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="iy//y1WJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWCON0hC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28AC920787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jF03x-0007l7-Ke; Thu, 19 Mar 2020 18:38:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1jF03v-0007l0-Sx
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 Mar 2020 18:38:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a1SRnPYSxFqZ1BkLazOTbQZCjWeel9DwGWz8sghdSLA=; b=DGOpb3uISVi388uWMQpZWEPOyC
 RJ4RdEplQMu1QADSemDwq4POzTj0guDSzSNKj2tF+55nTldaTWtrqXh133UVlRjIS+82z/8FEUZlC
 /R+snbcefDZ1zDbnfQQy57De8nww4M2GZK5OTJJ85rKiFGeQ2uyYiX0ZTusSeljQrPos=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=a1SRnPYSxFqZ1BkLazOTbQZCjWeel9DwGWz8sghdSLA=; b=iy//y1WJW7ppCYS1D7euXXEMGB
 16iI1RJgefZQsjTAtj5sKPVBg3FKP5QcHXwayUfZJxcBl+nAvQTveWZjK/Px1e7jEdHXwXVey3kQv
 NZmb82HPaBj0tvG+/Tcz9RbwQ0rKP+kmYH+I/4MZ67SlPORj9M+oKUtFi4SdtEcSQav8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jF03m-00EPi1-PC
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 Mar 2020 18:38:35 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2245120787;
 Thu, 19 Mar 2020 18:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584643101;
 bh=3FNqg8rB9Mv+3qihS1hlQvSPlVNkCanHUQe5fPdF36M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XWCON0hCR8JWa1QvI0zSziEYCZEtYXMmnmaNxMKCcHvkGANkSPPlObtxwpt8mAlrq
 ddMoW/qFf4wpwTrM8qjElUBw9fl0EgliiUAk3jLvumtt1rjxSf0behI/DEJlJk6Pbm
 svhsAgJAs3rkrDvg05Jm3R7FMXensw07LQUhZp/c=
Date: Thu, 19 Mar 2020 11:38:20 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Message-ID: <20200319183820.GA117496@google.com>
References: <20200311093353.25008-1-tiwai@suse.de>
 <0a18cc80-92cb-a61c-a525-1266c7e3c2b1@huawei.com>
 <s5himj0uyzy.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <s5himj0uyzy.wl-tiwai@suse.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Headers-End: 1jF03m-00EPi1-PC
Subject: Re: [f2fs-dev] [PATCH] f2fs: Use scnprintf() for avoiding potential
 buffer overflow
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 03/19, Takashi Iwai wrote:
> On Thu, 12 Mar 2020 02:08:03 +0100,
> Chao Yu wrote:
> > 
> > On 2020/3/11 17:33, Takashi Iwai wrote:
> > > Since snprintf() returns the would-be-output size instead of the
> > > actual output size, the succeeding calls may go beyond the given
> > > buffer limit.  Fix it by replacing with scnprintf().
> > > 
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > 
> > Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Could you guys apply the patch through your tree, or should I take it?

Sorry, I merged. Thanks~ :)

> 
> 
> thanks,
> 
> Takashi


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
