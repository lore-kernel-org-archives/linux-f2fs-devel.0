Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A57CFA457
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Oct 2024 10:27:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t3v48-0001Jj-BI;
	Thu, 24 Oct 2024 10:27:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1t3v41-0001JC-4M
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Oct 2024 10:27:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SYzPp1eegaW+z2By+mHuKYzvY+rxCcVa1pI/128Kfus=; b=kxU3uDYFAksNDJjjcip1j2+0iq
 lHeD6d26NFOCps6aPH6HEn15S+uYhjFtuuBZLYLCJvctzoUZhsNVp2jOF9v4dSX0y2z1eco7aHcO1
 v0zR4X901I6Ij30bVJ3KNsonD9B7XWTbNrYHBVFi0MEnNLYX//mKLWBgdKpb/BrsmkQA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SYzPp1eegaW+z2By+mHuKYzvY+rxCcVa1pI/128Kfus=; b=buJcnCtcv7kKIdshSxzBH9GfIu
 lL3vuz372ZRZYwuQqmxOtRFwKkX9BIOXeh1B2vsMpZef2KkIRJ6xnvvwPRw8gUBTqyqA9radhNkge
 f58UQB+yWPftw9HKDqi+2caUj4SfBFJT4ObqQTUqlsSbWV/aP8gcjGCM+9K9iPCp0PmI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t3v41-0004Py-9A for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Oct 2024 10:27:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 570425C5F9D;
 Thu, 24 Oct 2024 10:27:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DA3C4CEC7;
 Thu, 24 Oct 2024 10:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729765642;
 bh=k9LeMgcldza58yDLbsS6ruy8c8qGZneG7cd9tJZWJJY=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=RqNi6gF5FYTzi0YI1x5URV20UqoBoNdLDDOjOG7DdolVwoy0wo8uZyt+UHGsre4fn
 jN2a/QYCLRh9v6MWtv/nZ3lEFsg4rrW6Q+Na08NKZ978GyBfXBPlZJ4LiN385EumR+
 DGHDT6f3179cudQrO01+IDz0qKC4Y1OmfZwTiWVsPK4GNSW1UuyzYN1y/GNF0Fe98A
 n0/AURn0Iwu8jJiiuLHH6DaCHwv6qpG+nWgesUJCxunfdil+D2QXGD053Ys5YoKQlS
 GeS2UAp9md9zdu6aEtXVRW055C+NPK2IG+CVqiDzFzJcDHmu2pTn2jfl3AzPuYcb9u
 W0go9uAGoDkEw==
Message-ID: <0995728f-7466-464e-a46a-c1ae876b2017@kernel.org>
Date: Thu, 24 Oct 2024 18:27:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zeng Heng <zengheng4@huawei.com>, jaegeuk@kernel.org
References: <20241023094850.1680709-1-zengheng4@huawei.com>
Content-Language: en-US
In-Reply-To: <20241023094850.1680709-1-zengheng4@huawei.com>
X-Headers-End: 1t3v41-0004Py-9A
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix not used variable 'index'
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
Cc: bobo.shaobowang@huawei.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMjAyNC8xMC8yMyAxNzo0OCwgWmVuZyBIZW5nIHdyb3RlOgo+IEZpeCB0aGUgZm9sbG93aW5n
IGNvbXBpbGF0aW9uIHdhcm5pbmc6Cj4gZnMvZjJmcy9kYXRhLmM6MjM5MToxMDogd2FybmluZzog
dmFyaWFibGUg4oCYaW5kZXjigJkgc2V0IGJ1dCBub3QgdXNlZAo+IFstV3VudXNlZC1idXQtc2V0
LXZhcmlhYmxlXQo+ICAgMjM5MSB8ICBwZ29mZl90IGluZGV4Owo+IAo+IE9ubHkgZGVmaW5lIGFu
ZCBzZXQgdGhlIHZhcmlhYmxlIGluZGV4IHdoZW4gdGhlIENPTkZJR19GMkZTX0ZTX0NPTVBSRVNT
SU9OCj4gaXMgZW5hYmxlZC4KPiAKPiBGaXhlczogZGI5MmU2YzcyOWQ4ICgiZjJmczogY29udmVy
dCBmMmZzX21wYWdlX3JlYWRwYWdlcygpIHRvIHVzZSBmb2xpbyIpCj4gU2lnbmVkLW9mZi1ieTog
WmVuZyBIZW5nIDx6ZW5naGVuZzRAaHVhd2VpLmNvbT4KClJldmlld2VkLWJ5OiBDaGFvIFl1IDxj
aGFvQGtlcm5lbC5vcmc+CgpUaGFua3MsCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJm
cy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5u
ZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
