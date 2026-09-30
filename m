Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3742BCA5FC1
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O7pYyfc+3GGT5jkbChJ8sD4wO/zVSLRVe0cAARlm11k=; b=UuzzDa8TfW+k60uX5omCvwmhB/
	DdClLxv0j7L3vGTxpuITZJsdNgJTdrjUURM/GeoY8u/MYYZQOOb/XexcCMP3i210ZVVfqjRdmlyG3
	g2zZNI2WOuR4xymxeGp4hpQ6LRVqDlJ40GJOxLaoVSKgyzyFgdu03lUzBEDWUeIyOcgE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xBpGN-0002u9-Hm;
	Wed, 30 Sep 2026 08:02:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xBpGM-0002u2-K1
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:02:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mdcJAQl+W8tBL1aeydL1oDL5UIGU1+BTd8hClzUjYEQ=; b=jyw6XpP2Bz67pEy4/KQUkKFMHv
 CR6X1UPjSQiLI9kCjCU1fkHX7Mi7t0UXyhc20XSMi5hWiJTTH0QFRHt9Fp8fRaHK/+pnyHjhBmVOV
 vrjmuYvcSo2KzWyOyNmhwx2TBhRUboRHVrsv6PRw4czL01NfIxU+vpaUGcDpCUKmcJhs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mdcJAQl+W8tBL1aeydL1oDL5UIGU1+BTd8hClzUjYEQ=; b=QO/5Vp8Xr03OaMuKv995Ky9ulJ
 IE3YDEIjRN5Z+505aGTRnCu9HHnbmKgYM9ruUHVfKzhrgjFRQPtNbqyj0NVx7ntMXM7Ajz90xxu9Y
 xjXXgv0Q5P4G9Ix4epjeJSZbfXwMenbngbBrOBQXj4KUM5gTYflQUXsv0QuUE4SWG+e0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xBpGL-0004ep-Ru for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:02:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8712340BC0;
 Wed, 30 Sep 2026 08:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFBF1F000FF;
 Wed, 30 Sep 2026 08:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790755316;
 bh=mdcJAQl+W8tBL1aeydL1oDL5UIGU1+BTd8hClzUjYEQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=fdhSLPfDesTuRyS/RI8wThEM7xi6+mkmSKnRTywZy7NOoDrksGCqNcc+vbgNgaNA2
 K5/aRtrcQjaqa9Cf4v8zh8POdjQV7VhlHsjSluS1DMgo8MQsBnqIbkhAie/aYmMuEh
 8CNm+99yK+3+wDCH30LIcp9BelJ3XFv2YMqPvgLZoYZRKXIq3/73Ce0+ZdTajv9S9w
 qwXpx2osUxuRO68pyfoD39lV7hZE2ScoRk2PGOmeMmk5GjS372Rif+jFG9QRE96Wdr
 xgojF4uGTmpKxSkZBGUQFwxNn0LxYo9uSH+nLkeonWTB71yqIxhg4pR6LMlQ1TMgdR
 3IMMJhUq7Pz2Q==
Message-ID: <c72042df-4b66-4cdd-bccb-5abd1e3b6da7@kernel.org>
Date: Wed, 30 Sep 2026 16:01:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Arnd Bergmann <arnd@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Jianan Huang <jnhuang95@gmail.com>
References: <20260917142222.1591270-1-arnd@kernel.org>
Content-Language: en-US
In-Reply-To: <20260917142222.1591270-1-arnd@kernel.org>
X-Headers-End: 1xBpGL-0004ep-Ru
Subject: Re: [f2fs-dev] [PATCH] f2fs: quota: fix unused-label warning
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
Cc: Kelvin Zhang <zhangxp1998@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Eric Biggers <ebiggers@kernel.org>, Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/17/26 22:21, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added label causes a warning when QUOTA is turned off:
> 
> fs/f2fs/super.c: In function '__f2fs_remount':
> fs/f2fs/super.c:3142:1: error: label 'restore_holder' defined but not used [-Werror=unused-label]
>   3142 | restore_holder:
>        | ^~~~~~~~~~~~~~
> 
> Fixes: 3f140a60c92a ("f2fs: quota: fix stale lock holder on remount failure")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
