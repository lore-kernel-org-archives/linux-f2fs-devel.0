Return-Path: <SRS0=bQz1=YX=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5016BCA9EC5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Oct 2019 16:33:28 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17FE2218AC;
	Wed, 30 Oct 2019 16:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="l3zU+LYP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="LkY/EzF0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGba95ge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17FE2218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iPquV-0006Eq-Il; Wed, 30 Oct 2019 16:33:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1iPquU-0006Eh-6X
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 30 Oct 2019 16:33:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sOObYlWZ41xTgAHiCQDNKqzntjN7TJ231wc+n79zdBk=; b=l3zU+LYPEZEAzu69c6rMPxCMGd
 kCA+bvhfUBH/P1mga12ZB1fHCzjngzDLBHoaUaC3frN6MX+APcPgMEulsHkfRrH3E/MewlsknWnrq
 C0RHrsACe8OsWLBgbJzwcq2bvk4yJnFdldI4rFd0W07aKA4VJUs//XLuAb8IeP49bfmU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sOObYlWZ41xTgAHiCQDNKqzntjN7TJ231wc+n79zdBk=; b=LkY/EzF0iHGzDo9z15sjCyPAUY
 XA4I0jGoxJxZ1/6VGSejCLXTuaLbj5e9j/LVRqowG2cbNzFTqxW7lEiHlr7lUz8GRbQzowP/Wxs+0
 Q/YvWNxio+AcLg9dfKrK2AqtGEuTRAlCkAwontfhpHjscJKA6drW7GMEnXTrDs3HzQOI=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iPquO-0090HA-2y
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 30 Oct 2019 16:33:26 +0000
Received: from localhost (unknown [104.132.0.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6BA1D208E3;
 Wed, 30 Oct 2019 16:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572453194;
 bh=R+x/BiJjAABhO4MBomPKbzt94Ok4oo5wUPTX569SJ6g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iGba95geeKSbcCK9GWjQH/AJCr6qa7QkMYrle1YEL/ZwFd5UUcgg+TCYjJYgTBXF6
 PgpoepMXz5caV3srmydmo6B7IvFHf9OuWgvDXgt/sAtNqr7U2TcGYQl8sXUGhz60MW
 MhURFz/qimcPaK+szHYt2Tw0wv62Fvj1P0B5gmsg=
Date: Wed, 30 Oct 2019 09:33:13 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Message-ID: <20191030163313.GB34056@jaegeuk-macbookpro.roam.corp.google.com>
References: <20191030035518.65477-1-gaoxiang25@huawei.com>
 <20aa40bd-280d-d223-9f73-d9ed7dbe4f29@huawei.com>
 <20191030091542.GA24976@architecture4>
 <19a417e6-8f0e-564e-bc36-59bfc883ec16@huawei.com>
 <20191030104345.GB170703@architecture4>
 <20191030151444.GC16197@mit.edu>
 <20191030155020.GA3953@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20191030162243.GA18729@mit.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191030162243.GA18729@mit.edu>
User-Agent: Mutt/1.8.2 (2017-04-18)
X-Headers-End: 1iPquO-0090HA-2y
Subject: Re: [f2fs-dev] [PATCH] f2fs: bio_alloc should never fail
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
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 Gao Xiang <hsiangkao@aol.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/30, Theodore Y. Ts'o wrote:
> On Wed, Oct 30, 2019 at 11:50:37PM +0800, Gao Xiang wrote:
> > 
> > So I'm curious about the original issue in commit 740432f83560
> > ("f2fs: handle failed bio allocation"). Since f2fs manages multiple write
> > bios with its internal fio but it seems the commit is not helpful to
> > resolve potential mempool deadlock (I'm confused since no calltrace,
> > maybe I'm wrong)...
> 
> Two possibilities come to mind.  (a) It may be that on older kernels
> (when f2fs is backported to older Board Support Package kernels from
> the SOC vendors) didn't have the bio_alloc() guarantee, so it was
> necessary on older kernels, but not on upstream, or (b) it wasn't
> *actually* possible for bio_alloc() to fail and someone added the
> error handling in 740432f83560 out of paranoia.

Yup, I was checking old device kernels but just stopped digging it out.
Instead, I hesitate to apply this patch since I can't get why we need to
get rid of this code for clean-up purpose. This may be able to bring
some hassles when backporting to android/device kernels.

> 
> (Hence my suggestion that in the ext4 version of the patch, we add a
> code comment justifying why there was no error checking, to make it
> clear that this was a deliberate choice.  :-)
> 
> 						- Ted


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
