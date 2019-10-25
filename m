Return-Path: <SRS0=QQ8V=YS=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A7CCA9EA0
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Oct 2019 03:52:02 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 288FE205F4;
	Fri, 25 Oct 2019 03:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="E8b6ifP3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ArqQkjRE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ExnjMxge";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="Yq7HXJZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288FE205F4
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uP7qwPTYkNmuKDh+KslwFSEJtyWhxvVioCqavpNtlTs=; b=E8b6ifP3tpEzhiBvO8ENeh9R7w
	RW8brI2mllaMXvdAIwVGZSFlP5STsuZyf58mOfUapqD2WixslWcIrW69Vyi+v+8CH9FiMlnu68p1O
	Ov+Ji1gCXW0rjWRKH298vSZ/L+zwit3Q/vqJE2XE1JiNbQ6xgjAtznW4ah728X2vurKE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iNqdt-0003jy-1S; Fri, 25 Oct 2019 03:52:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <hridya@google.com>) id 1iNqdr-0003jr-PO
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Oct 2019 03:51:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ABWD4JUlwawnG2qiFtveO+db3hIzWEPH+BypeNf0bRY=; b=ArqQkjREARHpf35cq1NUdCf4W4
 b+tQxe4qT4tM7RyhkY7SBKGSDv58CPRfSSrF+A33E6HVQ/HxDT0oqdDly+2DLUvUVSg4i60EJbrO9
 OPK5p6we8jeMpdkZB4T2nr7U+aHpAZiYSZeFWDNjySomrMSZ1H+7ZkBG2R/85GMY+cgs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ABWD4JUlwawnG2qiFtveO+db3hIzWEPH+BypeNf0bRY=; b=ExnjMxge8CDrrUyvulQ5Sy+KlW
 NP1iHlpBV/kXUe88KtecyLxWcz5hYQMSx8o9XnkAzADPZT/aLIoLTYOKA1WjaUwQ9MAubSmcRVBhU
 O0+E7Ju7IJVF1hpBj9T4OpiLcebARdPrk8NPt3wlO/2RTcLokK/s7ppWDSBSg+TJ6ZnA=;
Received: from mail-oi1-f193.google.com ([209.85.167.193])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1iNqdq-002yNp-F6
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Oct 2019 03:51:59 +0000
Received: by mail-oi1-f193.google.com with SMTP id i185so539518oif.9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 24 Oct 2019 20:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ABWD4JUlwawnG2qiFtveO+db3hIzWEPH+BypeNf0bRY=;
 b=Yq7HXJZBl+RA4hgkn6HB0lx+lYHPMmKUAVjvxLn+ZL4KAGdNHXsCfTq6DmV9AGIl+z
 kJjLciMvGivbyOB4ExC7SRjS8/IZwaNeV0r6/HFwY9bQdYGCDfTjDpKxb3SrC0uyw9vG
 zoGfp8OJE3jCJPciSrkAp+je6+CbM6uMfF1gRE3J/3VNsmb0p06VKmHIiIGGRHOImgZI
 D6WEr+riL1TOBpypwSw2J4tHpGeq4+huDYNELUPtQocL71Cjhs0cY01cf/iqyRPvqhem
 khUOjCy0Mp5/7aMXX0oQJ1R3LF5EChHfQVSEU49ZAxFexYR7RR6I+jH6WFm0TsHqzAug
 eQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ABWD4JUlwawnG2qiFtveO+db3hIzWEPH+BypeNf0bRY=;
 b=goGYtb2dB4gXhLARqoXMPPAefBk8tq1YMVoHkiFony00S0hlJa1HB0y3EyrrDcHmsC
 F2Z4C1+W/5c2S19/eSitTQruqAa73mesXAlVWSnO5f+t30UvdMDDvEcArVcOZGDib1Hr
 ngrhlkV++jy+GGP+cvx30bcevQz4Fzk8X9hM8/bjbyKYeckNJ4IiSSTMG7ZyOayC1W9P
 y/5jaDNkXVfOOWd9LO6+iJWqUfsHRp3/+4l1DFf4Pv11Db09eUrHa9JLIIpC/rVKuu4L
 baWaA6n1+6baGY3kwVl1yuEOxfcq5HEMwPssl0m5fvyj6NeCclgHFjb4lZq9Xb+xqGBA
 CB+Q==
X-Gm-Message-State: APjAAAX/9p+pCrDP+lCBYDogAQ3cy/lCa1DWIgCLM3zon6+SeMOx/WfZ
 NOOmkvGCjFBv6TaUxVuT+wZauag8Wtd3u6j/AiKaXA==
X-Google-Smtp-Source: APXvYqwp9zH01jLrvIbTsVmItix9HesiPp94IEFA7G7RNVJ8AV+W8rh1y9KxtIERGkFBYLMjB+kKorgQ2RgVKNzjic0=
X-Received: by 2002:a05:6808:1d4:: with SMTP id
 x20mr1174301oic.36.1571975512248; 
 Thu, 24 Oct 2019 20:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191023214821.107615-1-hridya@google.com>
 <20191023214821.107615-2-hridya@google.com>
 <e61510b8-c8d7-349f-b297-9df367c26a9f@huawei.com>
In-Reply-To: <e61510b8-c8d7-349f-b297-9df367c26a9f@huawei.com>
Date: Thu, 24 Oct 2019 20:51:16 -0700
Message-ID: <CA+wgaPNas7ixNtepJE_6e7b6Dcutb9a1Who4WrUfKSw1ZnQhTA@mail.gmail.com>
To: Chao Yu <yuchao0@huawei.com>
X-Headers-End: 1iNqdq-002yNp-F6
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: Add f2fs stats to sysfs
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
From: Hridya Valsaraju via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Hridya Valsaraju <hridya@google.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
 Android Kernel Team <kernel-team@android.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Oct 24, 2019 at 2:26 AM Chao Yu <yuchao0@huawei.com> wrote:
>
> On 2019/10/24 5:48, Hridya Valsaraju wrote:
> > Currently f2fs stats are only available from /d/f2fs/status. This patch
> > adds some of the f2fs stats to sysfs so that they are accessible even
> > when debugfs is not mounted.
>
> Why don't we mount debugfs first?

Thank you for taking a look at the patch Chao. We will not be mounting
debugfs for security reasons.

Regards,
Hridya

>
> Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
