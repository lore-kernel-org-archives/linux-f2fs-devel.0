Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5010E68958
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 31 Oct 2024 07:46:02 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t6PsX-00086K-QS;
	Thu, 31 Oct 2024 07:46:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1t6PsW-00086E-MV
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 31 Oct 2024 07:46:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o9CKDxv226/9Z/9rxS2aBZPrjfMxl8SnMnHo0dJmDZY=; b=fGGtrtiIfUN35DSdZTZE/VAFHJ
 +6vzCIfli2rAD2/xQsVYA/+6jXn7it+zsMdZNv7LM7j7IxO9ZD6AS4FZbV9wU9Y7xEg2V2sM/FQFF
 p68D0+ibrqtKpf81EuUcLR0kczOiqnvdc0AAZ+HSW/dmZamHQ39lt2kL7pWQgnNhxIro=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=o9CKDxv226/9Z/9rxS2aBZPrjfMxl8SnMnHo0dJmDZY=; b=MYQOgaHNU5oUHRjN8xzA5++wUR
 juuLxkRgu/ErXMO3dClEwzoNmsJmt1h4A3+k84Yqb++ulfsqpVywjCbjhDeR2/p1ETKKMnw9ed8Dy
 4EyA4DNRNROUrUp0OzK/WjVPJ1pTQLQkJWAThL1Cwr3fiQO0CKe9zXsezy+lfDs/dfu4=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t6PsV-00018D-WB for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 31 Oct 2024 07:46:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id A299EA43A51;
 Thu, 31 Oct 2024 07:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327BDC4CEC3;
 Thu, 31 Oct 2024 07:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730360754;
 bh=sho9nIIOCfABtPuJPyHva71sNksFEkJM2KuErtP/H/Q=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=jvqf3fGZYhbd2KAae77vBahbLuIIzSF8WAyJjxPwQltTxYJYuuLXTfzlRq/X5IxF/
 WdCACLS+xyhzS/0qT0Z6q/KCtjEY7kivT14izy7kUkeKJVnQqJ2rCWr3gYGm0DSx64
 SITTi3PUMYAAvrwacEyz2MBy38mPM+52nBwSRhLyKDxUIi0vWLpHlXLaaV8y+qpk0G
 UpOGxxLez5MrjEc+LO03Lglv3QR8epB5lNOWaBBJwYLaYrtxGKOKWCZMZYIcz7DmZP
 cD4EOAjPxeKR5JjfPC5fPSqvBm2PRiq+qHb5FJrWVjgK4Pmw3+wQ0G1yvhJxZxApGk
 ABziTBK/8bMOg==
Message-ID: <0c03d45e-d62e-4bd8-b9d9-68651dd4179f@kernel.org>
Date: Thu, 31 Oct 2024 15:45:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
References: <1730190466-13015-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
In-Reply-To: <1730190466-13015-1-git-send-email-zhiguo.niu@unisoc.com>
X-Headers-End: 1t6PsV-00018D-WB
Subject: Re: [f2fs-dev] [PATCH V2] f2fs-io: unify default block size
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Hao_hao.Wang@unisoc.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/10/29 16:27, Zhiguo Niu wrote:
> F2FS_BLKSIZE and 4096 are both used in f2fs_io for
> IO/buffer size, but F2FS_BLKSIZE may confuse user becasue
> it may be 4KB, 16KB, so use macro F2FS_DEFAULT_BLKSIZE
> to unify F2FS_BLKSIZE and 4096 in f2fs_io, also adjust
> "-c" parameters in mkfs man, to be consistent with commit
> c35fa8cd75ac ("mkfs.f2fs: change -c option description").
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
