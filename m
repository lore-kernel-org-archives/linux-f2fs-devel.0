Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C246CC55162
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 04:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IO4AsZ1gBtdCCCSDmeyWBQbvKi7Cix+TAZ7553dRS0Q=; b=KqGAteZv+1wpyj/AVnKKshZSCa
	VGiUqnxwPvXPF5dSAn/I5r4683IdzRHi0Iz9DY79oYit3cpnQ+Cpaz4Se0pVT78tTfVGaJ2y4RrcX
	UZ2ubcJGRBpW30tfcU8lzWwvWtj8DtpVxIVQT1gS/J6UB/syxhl45GG2egRZCjhU8LlA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqkUJ-0005KP-S2;
	Mon, 03 Aug 2026 04:41:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wqkUJ-0005KI-0T
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 04:41:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AlqoGT1SJPxSanZk3gkQZpc7TLqLsmNQXMVBYK1G6cc=; b=QXO8OGgWCVfoi96ckyfIgP6tTB
 ICtYRHUddDs/4geXjYXhrIbUrA5fxQu5Tvquu4oaFEvup7Ya+l7y7RT41DZuuxb4bnC0MmAtSQEnW
 2a/0Ix68pcLSPs/FVzJlxZZcpt1fgkOEB1jKytfV+Y9DtOj7uosgoOJj+hhaNrywzDZU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AlqoGT1SJPxSanZk3gkQZpc7TLqLsmNQXMVBYK1G6cc=; b=BIy9QavKGqu3BGEfFZ9TCUxeqU
 hDzLjlVAGVuJyIxo0CEQnCE7Za+4T0JmKe1IsLv9T8QOAgDGBqs0ZNHyb9rOcUxIcUb6gaMs7A1Y3
 HEIUD52x4z13i6+ijTzlwR14+PV4mOE2bIbDuWzP1KYaWH4hRkvwHVjZmFHI9fLBdsAY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqkUG-0001FU-2t for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 04:41:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B86C840733;
 Mon,  3 Aug 2026 04:41:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CF91F000E9;
 Mon,  3 Aug 2026 04:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785732070;
 bh=AlqoGT1SJPxSanZk3gkQZpc7TLqLsmNQXMVBYK1G6cc=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=LtOCF6RO7OuTuV0QHDy29UnPLwYKyKa+5LAQjSF0PCQ48oKaNXGsX9qZxrcGx7xM3
 1KgsVRtUpdZOhiM1CF+kWCki4kZqgMYdtTngrMXKRXCwD23p0bKxkBIZ73pYBDU8FH
 Chc//XE3AGnIn/1LKoQDHB7wkT3rpOEXtZGJPxD7kLSdz+zJKFHlQKxkOpkovPsrg9
 mur/8J1K9cJLfeB8ONMxpZifA4bKI05ZEPYAwg0DU88WfaGg4AMVp3bG48Cok4l38h
 he1h82GedGtKvG5iw89ay1pd6jf5HdadYN3Hz8CT/dBWBGKFpxPpsDWn+tUrRgwRK+
 2aZ0dsPln0TPw==
Message-ID: <83f0aac0-bfd3-49ff-b6cb-e149d0273b09@kernel.org>
Date: Mon, 3 Aug 2026 12:41:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yangyang Zang <zangyangyang66@gmail.com>, jaegeuk@kernel.org
References: <20260701092850.1247010-1-zangyangyang1@xiaomi.com>
 <20260701092850.1247010-2-zangyangyang1@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260701092850.1247010-2-zangyangyang1@xiaomi.com>
X-Headers-End: 1wqkUG-0001FU-2t
Subject: Re: [f2fs-dev] [PATCH 2/2] fsck.f2fs: read each sit block only once
 in build_sit_entries
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
Cc: Yangyang Zang <zangyangyang1@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/1/26 17:28, Yangyang Zang wrote:
> build_sit_entries() calls get_current_sit_page() for every entry while
> scanning consecutive sit entries. Since each sit block contains multiple
> consecutive sit entries, this causes the same sit block to be read and
> copied repeatedly.
> 
> Read the sit block only when entering a new sit block, and reuse the
> cached block for the remaining sit entries in that block.
> 
> Signed-off-by: Yangyang Zang <zangyangyang1@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
