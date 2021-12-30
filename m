Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72F2C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 30 Dec 2021 04:02:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1n2mdz-0006Lo-U9; Thu, 30 Dec 2021 04:02:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1n2mdy-0006Li-L2
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Dec 2021 04:02:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FgV6jczLwsGtKozj3Ir72GRSzrWM8bs31uIkQl0Lq8I=; b=CZoJw9C6v3+7Ita1oxpTRThfUB
 /rCleA9XOODUCllFsHmDEE/KZdORfB35B0uaGWnhGkkexJ474Q8vicH4A1CphC14C8RHDFDXDpdy1
 uVuFtJvssRwlJDgqznhYUuHb0RM28nmRv+DMwoSd0g3WHQYdLFchHaPMKnFP1wBrdUvc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FgV6jczLwsGtKozj3Ir72GRSzrWM8bs31uIkQl0Lq8I=; b=AVZIGIGKzwKZxYXEE4/b2Q4IB+
 J1C4FWnL3z9ZS0HNH1mqH2PSHMS3cKCYk7z0ZT7WJ7L8rqvh37hQEUqL7Zx3VlTit7Lg56Xu8szav
 LAnBkG6GIn6an5zfwsjBNMMRhb8SyIwWih6Z+er0ynQZKO2BX7PoM7h33an1XKOj32pY=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1n2mdv-0002iv-Fs
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Dec 2021 04:02:23 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5F820B81A74;
 Thu, 30 Dec 2021 04:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326F1C36AE7;
 Thu, 30 Dec 2021 04:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640836927;
 bh=XtZtZ/P5OFQNoowM2KXTDgaVxi7xaRF//iN+xogdeMo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OlC/Jxk78m2UMLCEZQSlHIybCB4fmBdoXEOEMjPFjaXfwX9PmSxxYJv8RXyWxpuKM
 5+E9j6Nd+reDcLRSXsMIUMKtJNLeOzi1GZ7vS0zJoAJHlNB14NasjGXfiSStIU+EKP
 EQNDVjt9D02ReXMolE9dbjdayni3mOUodsReDuok5fMwr9AVhlRqKy6Bsv1Of2xAXA
 Y76X2/0btuyQbWGahoOMiS0Mh43sk3AB4XBwpSO5HF/kPiUGVDCr/IsrvNg9pDmMaq
 EDqpDoaDVLUF29RnxEOTPG4xVsBgnZavnxRuUuK4x7BPLcYaYTQbNV3iTJz2qFYJ5N
 86Zb4CHzLqG1A==
Message-ID: <5b7f107f-7589-ec3a-1d83-130bb8f202ed@kernel.org>
Date: Thu, 30 Dec 2021 12:02:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Fengnan Chang <changfengnan@vivo.com>, jaegeuk@kernel.org
References: <20211229094700.197169-1-changfengnan@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211229094700.197169-1-changfengnan@vivo.com>
X-Headers-End: 1n2mdv-0002iv-Fs
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: remove redunant invalidate compress
 pages
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/12/29 17:47, Fengnan Chang wrote:
> Compress page will invalidate in truncate block process too, so remove
> redunant invalidate compress pages in f2fs_evict_inode.
> 
> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
