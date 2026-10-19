Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB11CCF2D6
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6HJ7N0S7ll7vL0eFEvpjMU5YUakxZEWARKoz1o5RXxM=; b=d9kqFhoeXLJpE5YkojOEIda3l6
	tNWgwbpiXq0e/zVK53VUU91kvSLmK3v74g/DzmqAz+TDZpc1hMkBTrcmJ70g25km0Vjb82Zp5K/Wk
	fpnc08kpe5molOlEngnNjsSN0UtU0Ve13QQRYLEGNX83KH9l/NgOzcvEWv5G4YRx1r3M=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xIk7Y-0006Qh-Ga;
	Mon, 19 Oct 2026 09:57:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xIk7X-0006Pd-CA
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 09:57:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WDSRk5kUjz5pRjBwSkrM+9YyUqVFCpvlTWwJQI2J3jk=; b=CKbNSaVgxUWT61epCjgebCDIqd
 IKu53eiqVAoJBFcgHTk2n2JgreBJg0e8ehoxuFASywsm9oFofrGA0qUh+7IvW/HzeX1kgvJRQzOrB
 eE4aA2vxI9cT7wztDroL9oUSA488AWF97agFt6EL+GGqVyU8ESykDP9eXTzi3LNLywsI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WDSRk5kUjz5pRjBwSkrM+9YyUqVFCpvlTWwJQI2J3jk=; b=ji4uqkpdIODCHjPJvjGADB3HqQ
 oIHaA2YJfvYQrWy2VrYRHu03fziqqbjYAU7SMGzOs0IGnWy8Duu/PYHm+/ks5QLF8RTPCNcH44OR6
 7AlQ6TtsS9aIrTNyPJYW7kU6Ndu2Cst/HjjFzuNY8U3+15XdisRX8DwGFxi174ink2q4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIk7T-0003SW-8B for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 09:57:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9A96C600CB;
 Mon, 19 Oct 2026 09:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002241F000C4;
 Mon, 19 Oct 2026 09:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792403841;
 bh=WDSRk5kUjz5pRjBwSkrM+9YyUqVFCpvlTWwJQI2J3jk=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=EslnrHiL7blGfMEwu9R+A4VS7imoLLHHSCBpyDo1py3mmGGP3ZzNc4l5q6K/UiPqg
 Gpd1V6QoQDhyzRC8XwbiFGaJWQT1sVqNSiCkP6ERa/T3DHYSfEH0Au0dty6xlPPe49
 pAx2GLo2spdBltZdhmksmONEFf68fZC9B/28KKX9keYFQU/leMUF3huMqg5quEK05+
 W03PWHUjpzVbg6b04BJiQuMxBUvP3K2WNGfn0Uw8TWQrDhowYj+CgS8oWQM8hU412m
 1JaI+kOypldeR/geb4P3TAlLVJrWCz4V05U+ZQR2ISMGjryqEWsmlXR4TWBFD/+dNa
 MXCuZgFaPiokw==
Message-ID: <4118fc18-b95e-4acc-bf0d-f808ba4f4d37@kernel.org>
Date: Mon, 19 Oct 2026 17:57:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <cover.1792116883.git.qiwenjie@xiaomi.com>
 <7884c62cae6e4b1ad516a9ac351c2604e57d5cc5.1792116883.git.qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <7884c62cae6e4b1ad516a9ac351c2604e57d5cc5.1792116883.git.qiwenjie@xiaomi.com>
X-Headers-End: 1xIk7T-0003SW-8B
Subject: Re: [f2fs-dev] [PATCH v4 1/2] f2fs: flush SIT journal during
 filesystem resize
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
Cc: daehojeong@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 sunqiuyang@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/16/26 13:44, Wenjie Qi wrote:
> During a filesystem resize, SBI_IS_RESIZEFS prevents new SIT entries
> from being added to the journal and forces existing entries to the SIT
> area. However, f2fs_flush_sit_entries() returns early when there are no
> new dirty sentries, leaving existing journal entries behind.
> 
> After the main area shrinks, a later checkpoint can access a journal
> entry whose segment number is outside the new geometry and trigger
> f2fs_bug_on().
> 
> Only take the zero-dirty fast path when entries may be written back to
> the journal. This lets resize drain existing entries through
> remove_sits_in_journal() even when there are no new dirty sentries.
> 

Cc: stable@kernel.org

> Fixes: 04f0b2eaa3b3 ("f2fs: ioctl for removing a range from F2FS")
> Reviewed-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
