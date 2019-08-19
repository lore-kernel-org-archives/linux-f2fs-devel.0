Return-Path: <SRS0=dby8=WP=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C022C3A589
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Aug 2019 03:03:59 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2047D2085A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Aug 2019 03:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="fJ9lHjrg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Bu4s1+Iz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEwvIll5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2047D2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hzXxe-0001xT-OS; Mon, 19 Aug 2019 03:03:58 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1hzXxd-0001xD-7s
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Aug 2019 03:03:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XcJuF5hxfZSJ1C2/MDjHzOh4H4oOVXlUFuS5chf91f8=; b=fJ9lHjrg6BgckVFwh5Q3vrJ62p
 HIxE21og8moa4t8Lu6SZ79NNm5FBetOn/tfNQ3Ew/h4XCIorE5YrQQ/mUvcQwjvznnOP1ergE6rmR
 XTyq9W2BbMCNA4jMzYGgyblFNZ9PlQHjUK5KZ8myeIPWBdqQG+xgNdwUNMa5/HXFIs+o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XcJuF5hxfZSJ1C2/MDjHzOh4H4oOVXlUFuS5chf91f8=; b=Bu4s1+IzdJ9m7K79hVJTe1O1HW
 TCBLatJPufpktu4VLXNMKKy+sM2+zfIoTMlUVFTKoCnEz8PXBzpdJUWcU7YXSUKQERFVJ398x3gS+
 Pt050LFENO/eKi+PAlSJFU04DmBeD78hX4NKhhngdhsLLJouiA5FzKGDB8aGT4ZFmM38=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hzXxb-007p7M-Vz
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Aug 2019 03:03:57 +0000
Received: from localhost (c-98-234-77-170.hsd1.ca.comcast.net [98.234.77.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 560272085A;
 Mon, 19 Aug 2019 03:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1566183830;
 bh=2PL+DHNlOoEUEKPzvBsVDQfBtNfRiI7mXfYi4qJmSh8=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=XEwvIll5Qt5E+me1npCFt6KYh6LIVJJqcJ/RgXEwwuKU7kA15Q/E36c75T1DTidwT
 Y/jYGeHN2fZq6af6r98LR3BPotA4DEJMvaJIU1dPQLAu6YkEHNpvKw6yIMd3EW2uSG
 phQtPi1Y33y4A/OsxBdYQ3AWIxo/IZscD4vE1v5Q=
Date: Sun, 18 Aug 2019 20:03:49 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>, Chao Yu <yuchao0@huawei.com>,
 linux-f2fs-devel@lists.sourceforge.net
Message-ID: <20190819030349.GA44556@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190816055539.30420-1-ebiggers@kernel.org>
 <faefae52-3c06-46b1-8be9-3774a98a212b@huawei.com>
 <26511603-db36-f614-3066-0fcd3f5af483@kernel.org>
 <20190818154250.GB1118@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190818154250.GB1118@sol.localdomain>
User-Agent: Mutt/1.8.2 (2017-04-18)
X-Headers-End: 1hzXxb-007p7M-Vz
Subject: Re: [f2fs-dev] [PATCH 0/3] f2fs: fixes for FS_IOC_{GET,SET}FSLABEL
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 08/18, Eric Biggers wrote:
> On Sun, Aug 18, 2019 at 09:03:21PM +0800, Chao Yu wrote:
> > Hi Eric,
> > 
> > Do you mind folding these fixes into original patch as it's still in dev branch?
> > 
> > BTW, any comment or suggestion is welcome in my original patch.... :)
> > 
> > Thanks,
> > 
> 
> I'm fine with the patches being folded in.

Okay, let me fold them.

> 
> - Eric
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
