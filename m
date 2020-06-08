Return-Path: <SRS0=UwVw=7V=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632C3C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  8 Jun 2020 12:59:12 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E9972076A;
	Mon,  8 Jun 2020 12:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="GMVPJVIh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="DzlbEb7W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYDrFLFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9972076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jiHMt-0001RW-Ms; Mon, 08 Jun 2020 12:59:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1jiHMs-0001RL-3j
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 08 Jun 2020 12:59:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2HIjcQbcjgNwiens4AYoJ4oFc8h550nVcSk3jLrAWJA=; b=GMVPJVIheXfq80D71I2AcUYutJ
 PS7UtDcxDOhApQp6iarAvP3kqp5qc5HT8UGhRH8HtfLZfk22RztVrPGXVAH1ECCTG+xBLfd60VrLr
 QKnPP2dKKyDlvE0SVXJ2WvtJ/Dv8FTzuMOsp5ogF8PwqIt6oT7bk065KG7YOh7EazqzA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2HIjcQbcjgNwiens4AYoJ4oFc8h550nVcSk3jLrAWJA=; b=DzlbEb7W30IiFYuTgJvpQfugwf
 YOPaWPKHEcuC5bToAaL3HABpuNEG3QNT+cXWJ9CGGq4ea1nOXa9cZRVGohUlbnjJQieP0fbb/+/q7
 zu//vSvu6FvbIAkWakxgFroKSyNx8GrI0p7kazXmJSrT/xR1h5O0l0X6vCOGX2fTh9L8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jiHMo-00DSzq-JY
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 08 Jun 2020 12:59:10 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 55BFB206C3;
 Mon,  8 Jun 2020 12:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591621136;
 bh=Udn/ECwZeBtWEDbCfPcTaufza+OKKkyBc9uRmHVaIUM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nYDrFLFHs0ymiK0lI5LCGx3TQEDuGS8cxZw+4zb0RuYOUm6phKPo2d64fksT93qXu
 HvAtjMcjbXK0r1K3yFrGL2pSFBL3/92MDaVZhAxik+NgKnlCKhsOQe7VUgMl9gH0S9
 m3nsn0iZ8GIJR6e72HkSlhfZUodojMR9PhKa4Tsg=
Date: Mon, 8 Jun 2020 05:58:55 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20200608125855.GA200855@google.com>
References: <20200604235023.1954-1-jaegeuk@kernel.org>
 <20200604235023.1954-2-jaegeuk@kernel.org>
 <20200608025125.GA127000@google.com>
 <70f2b6f6-189f-bafe-6db8-7c16a4a7f6ac@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <70f2b6f6-189f-bafe-6db8-7c16a4a7f6ac@huawei.com>
X-Headers-End: 1jiHMo-00DSzq-JY
Subject: Re: [f2fs-dev] [PATCH 2/2 v2] f2fs: attach IO flags to the missing
 cases
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
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 06/08, Chao Yu wrote:
> Jaegeuk,
> 
> This patch should be applied before "f2fs: attach IO flags to the missing cases",
> otherwise, gcc may complain about implicit declaration of "__attach_io_flag".

Yup. Done. :P

> 
> On 2020/6/8 10:51, Jaegeuk Kim wrote:
> > This patch adds another way to attach bio flags to node writes.
> > 
> > Description:   Give a way to attach REQ_META|FUA to node writes
> >                given temperature-based bits. Now the bits indicate:
> >                *      REQ_META     |      REQ_FUA      |
> >                *    5 |    4 |   3 |    2 |    1 |   0 |
> >                * Cold | Warm | Hot | Cold | Warm | Hot |
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
