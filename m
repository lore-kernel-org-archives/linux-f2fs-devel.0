Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6546CD98CE
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 12 Jun 2026 21:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oBHltbO2h2WHWfGAm96gIUWuhquygz7PuBEnHcTQVas=; b=Uky0E78cicFD102bCBdgtqj/ib
	e6rhNKiz+s/dbRSFu9Ji3jW146n/Pj3c4knyfj62cXfgJh1EeG4VDvzNU3cgXkVHjojl1p0YOJDMy
	yr+OOcFa0d8KIjrZOi3ejs7c8fnYbUEaBkFon37huUoPi07I1j7oH+9aFBApT2YJ0ilg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wY92y-0002A0-Ln;
	Fri, 12 Jun 2026 21:04:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bvanassche@acm.org>) id 1wY92x-00029t-Dz
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 21:04:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8+/zLgDlancJ0oPYxx6n5XC4ZduIUirKe7poD9OZl/o=; b=hcxaJTyEwbSbkLqguSK/lLMC+0
 Xzdr37DlnL6r1IEV9KFMWPC3ESVbQaCmzr0ET2czS7bltDobYP/l6zinv8kiVILFthgMl1DmYVMnH
 +WQXTSCpQXFQsbou21AYfJ9VmYzHguJFh6PfXTQe5q8f2GmvwBOiN5sKqFIeTPSrkbQ8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:
 Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8+/zLgDlancJ0oPYxx6n5XC4ZduIUirKe7poD9OZl/o=; b=GTpkGpfvQCw/8T3+6jXBG9uqRZ
 dMZBuuhKIzjA9IGUD+nrRr6v6jvW6F3s5kDfXfQaSpPxXVSapWwjfFJ5SbglOV9dCjHVBVfiOkbve
 jleoUm3s2a6wDi4VlX7G12tP8phic1edKyJEvov+EkAalLji77ecC6ZXBOn+nfCy5v94=;
Received: from 013.lax.mailroute.net ([199.89.1.16])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wY92u-0001gQ-03 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 21:04:08 +0000
Received: from localhost (localhost [127.0.0.1])
 by 013.lax.mailroute.net (Postfix) with ESMTP id 4gcX7R2syHzlgyGK;
 Fri, 12 Jun 2026 21:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
 content-transfer-encoding:content-type:content-type:in-reply-to
 :content-language:references:subject:subject:from:from
 :user-agent:mime-version:date:date:message-id:received:received;
 s=mr01; t=1781298241; x=1783890242; bh=8+/zLgDlancJ0oPYxx6n5XC4
 ZduIUirKe7poD9OZl/o=; b=VmjAvxvXRHPFukCg+pzzHsIs9eeSat8wyfXvI4lm
 H9dij42TZEloq6Xe+qHtNhGqIU3zC5f9FpAM25GxkGwyLuVulR/CqmX+hjPQc5sb
 u63YzEVgyLNZXy4lgr7KvVcuSZGQwz/NuV6m6fAaQy3WvYGXwdwA35tHDtTLbOtM
 FhRTmk8njQsY0NviYYZOzjkE7GQpFDxVGmSyQvd322QaIGCN3eok7v3stgKyZRSZ
 EkAdMJYFt9nRG00S5lOuLl5gFCnAy+SbNNd1rCE/EyJNDcWf6R0rGC13MVUvffRJ
 foF7gI7q3EpTJMnd+q4G5AMFmw5WNwLMzcpZXZ1yf1qj3w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 3lUj17lAzqAX; Fri, 12 Jun 2026 21:04:01 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: bvanassche@acm.org)
 by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gcX7N4sTszlgyGw;
 Fri, 12 Jun 2026 21:04:00 +0000 (UTC)
Message-ID: <6505b5e3-b4e8-41bb-bfb0-52e6e20f45f0@acm.org>
Date: Fri, 12 Jun 2026 14:03:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <cover.1780003055.git.bvanassche@acm.org>
 <0e18152026cacd1e61fb5fb5483fc1d3c57bdc51.1780003055.git.bvanassche@acm.org>
 <a3431eb2-6224-401b-9aec-1c0abf840143@kernel.org>
 <7d8cd85c-2aa7-48fd-89af-39adabc89d97@acm.org>
 <acf21183-0505-401e-9a1c-dd91ff147b63@kernel.org>
Content-Language: en-US
In-Reply-To: <acf21183-0505-401e-9a1c-dd91ff147b63@kernel.org>
X-Headers-End: 1wY92u-0001gQ-03
Subject: Re: [f2fs-dev] [PATCH 4/4] f2fs: Run f2fs_write_end_io()
 asynchronously
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
From: Bart Van Assche via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/12/26 5:05 AM, Chao Yu wrote:
> Actually, I'm worry about whether there is potential performance regression
> caused by enabling this by default, also a little bit concern about the 
> affection for PC|laptop scenario which is used by individual user.

According to Gemini F2FS is primarily used on PC's and laptops to
increase random write IOPS for rotating media (hard disks). I don't
expect the performance impact of this patch series to be measurable for
rotating media because the time required to queue and schedule work is
very small compared to the I/O completion time for these devices.

I ran a new set of measurements on a UFS 4 test setup with zoned
storage (ZUFS). On that test setup I see that the variation between test
runs is much larger than the variation in test results with or without
this patch series. In other words, I don't think that we have to worry
about the performance impact of this patch series.

Bart.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
