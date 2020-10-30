Return-Path: <SRS0=Y/5H=EF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D1AC56201
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:56:20 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3A4120791;
	Fri, 30 Oct 2020 16:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="dBl3nWQp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="LT6wl+dw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z/dVtz0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A4120791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kYXhH-0004Rs-Up; Fri, 30 Oct 2020 16:56:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1kYXhG-0004RW-Ur
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Oct 2020 16:56:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ifp2qz4cPqNbMAV8Hxgta1P/YY27Z4YR76wIVxCLgbQ=; b=dBl3nWQpTNLzPJ+OLbdW7Kz/sL
 WFvpqDlxRWkBPeCbJXFYrxgDpKYzr0t6AwE2abGbmyDk+yuAtoqj1DVd1zKaBAgVimdnKwZalJgx+
 O/mtL39BQbVDcRoFa/W4mxxtp/+RjV0tn3ytWVcQIcCQPqUSV8yDKvxyRqPpTi2PwPg8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ifp2qz4cPqNbMAV8Hxgta1P/YY27Z4YR76wIVxCLgbQ=; b=LT6wl+dwBsge0GExjQpqQbM+TU
 dtX4JGuZwnEVi3w7X8Z5y7ce1Mf5UtSNLnaKDymSvxWE+0lIFrbZC9xCdJzQ6Fgukl6FoQEdTFytT
 v7QcNX9wpv0Uf6srD0hBRq6AQN5CP2UeV7XxXyER27BL7MdWTAFFRVtFEwuDiE65secw=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kYXh5-002osv-Fx
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Oct 2020 16:56:14 +0000
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net
 [172.10.235.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A428C20791;
 Fri, 30 Oct 2020 16:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604076957;
 bh=c3kxm2crOyIhGs6VOfq3cufvcTi+w7SfUEUvU1r33rY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=z/dVtz0GT9NCTXiOc18KE1Mhboa1bxEbGpKvoXfSVKJsFwObuazYrrrC3xCvXH6CV
 Db40/4bQmyR9UKW2S2nHgfys9p/oFsDg1NL35ejqJB8Nd/cLoc1V5SeAhG0+34WkYx
 /vrsq8CmcHZTVbePOkTzfJ8cxf1QjQlEGLOvOADU=
Date: Fri, 30 Oct 2020 09:55:56 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20201030165556.GA1097@sol.localdomain>
References: <20201030072610.57155-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201030072610.57155-1-yuchao0@huawei.com>
X-Headers-End: 1kYXh5-002osv-Fx
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: move ioctl interface definitions to
 separated file
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Oct 30, 2020 at 03:26:10PM +0800, Chao Yu wrote:
> +
> +struct f2fs_gc_range {
> +	u32 sync;
> +	u64 start;
> +	u64 len;
> +};

Userspace headers need to use __u32, __u64, etc. instead of u32, u64, etc.

Did you try installing this header, and including it in a userspace program?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
