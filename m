Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F86CCF2D5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Oct 2026 11:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o5mkJlb/qIqTZFAZwPEOOo72lKGhL0R850q14rVyjp4=; b=HbM7z33dsCnInDFv/wbwic8FS+
	Dg84TKbGyRY43+vB2DaP9SGLs72pPLe7MHJ828IH5q/9Il3iWDT3q7Ce17JA+rBF/7kQSBOF9SGJL
	ZfEZcU2lEGphQnR5uFXlUzvvIcYSIhgbdAvn3Y3iek2i0YzNSXfwnK93/SeGEveiXOK4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xIlBd-0005ii-Nv;
	Mon, 19 Oct 2026 11:05:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xIlBc-0005ia-3x
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 11:05:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k4q66emTtkmRiUAUpJo6ZluKPMmUw0EN7H7khyWm514=; b=HLqUwW9+NXwEHgHQpdSX4sUn4q
 YYdR+TNHIpYQ42EqfMArXBDFigKXpqB/cL7CuS9S/upHt9t8X2+baxVNPbTMQGxN4gJNGD3h3GzQR
 4ufiXrjh80grlB08kWU/bO+YY+CygtnNJZE9HMYBCIUDPWHdSdVg2l6CNP5Nq85if0FE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=k4q66emTtkmRiUAUpJo6ZluKPMmUw0EN7H7khyWm514=; b=WZkWBEY4K14Adalz+YVHJGQF+H
 2TC56lZrlLCHe7W7rxAH8SbdOc6N8YYu3rgQjzzLqUgNjxCfd+pcVeaibVc2A0FgF4nYsLyEbOgqu
 3vZQDk6EDpPhfahehLg8GsvWnBtaOcHC82LN5HfyIoiohabfNGIMjK70+56iuznrxfvw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIlBZ-0004nk-50 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 11:05:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 73092600CB;
 Mon, 19 Oct 2026 11:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6191F000C4;
 Mon, 19 Oct 2026 11:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792407939;
 bh=k4q66emTtkmRiUAUpJo6ZluKPMmUw0EN7H7khyWm514=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=IrzIY10V8O0NDas70qmNAussg089+Vj/D4jG4Ml9sqcpB8uRB8Q5FPus5LxwJcPa1
 RxtLalxqarvEj6Mb5HtMt67X0SVL3ZFMpzA5l1wBCyJ+FA6Bu0KWVFJwLC6mrizm3x
 EPOrsto//l/AthadeaKhbKh0spe0Q28/m7+mksRo5VgWl1TYKASRnAg7VIA11o9GAU
 4Dgskp4vNQzSHRe1wrRSXyRRwjybrpRi6upQ35ku9ADkS/YD9daXsKJKLLiVj1CAsr
 TvZ+6M9OmqNOHAgBtvufnsxDRVXoKxp1JKgAVNKuFn8tFmmPmvG7O401hv/WOc4P5p
 cTrutJ9fVXKHA==
Message-ID: <b52ee3f7-e849-4444-b870-7f9ec87f8541@kernel.org>
Date: Mon, 19 Oct 2026 19:05:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <cover.1792116883.git.qiwenjie@xiaomi.com>
 <226abf7d629d7345f450753a42e924b436c99ec0.1792116883.git.qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <226abf7d629d7345f450753a42e924b436c99ec0.1792116883.git.qiwenjie@xiaomi.com>
X-Headers-End: 1xIlBZ-0004nk-50
Subject: Re: [f2fs-dev] [PATCH v4 2/2] f2fs: refresh pinned allocation
 boundary after resize
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
> Online shrink updates MAIN_SECS() but leaves resizable_tail_secno and
> pinned_area_max_secno unchanged. The pinned allocation limit can exceed
> the new main area when shrinking beyond the reserved tail.
> 
> Consume the reserved tail by the number of removed sections, clamping
> it to zero, before refreshing the shared pinned allocation boundary.
> This preserves the boundary while shrinking within the reservation and
> limits it to the new main area otherwise, retaining the zoned limit.
> 
> Save the old tail count and restore it before rolling back the geometry
> if the final checkpoint fails.
> 
> Also bound pinned section allocation by the current MAIN_SECS(). Range
> evacuation temporarily reduces it before moving cursegs, while the
> cached pinned boundary still describes the old geometry. Otherwise, a
> pinned curseg can be reallocated into the range being removed.
> 
> Fixes: c966d29e01bb ("f2fs: support resizable tail section and unify pinned allocation")
> Suggested-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
