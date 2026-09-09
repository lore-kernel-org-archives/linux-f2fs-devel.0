Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555DAC79FAD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v6gCCWuUNGkSx1POBcx/0Li/FI+NUeW6Cwo12I0Qb4I=; b=YV+w/c/EW3tj2re5sSdrsUmGp5
	hAzs5Box2P6U5ktuBRHMUnIaEp+b++zUkzhkdoXi7HvkRxk1xO503eBvURSKR9BjdDcRLcPDhOHNW
	N5B/c7unXSuNCzYQwpti3fBM0+BGOiF9YYlnWjRlKQmZH5KbTs5YJtA9zf6CNyhb9MEQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4DsQ-0005zm-De;
	Wed, 09 Sep 2026 08:41:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x4DsM-0005xp-Sf
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 08:41:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dN+S+OLQ3E9fR3RU3W4nKI6yEw9xqFk69o8z5jA3CAI=; b=ia1+sTj9vFxBJ5MKD8Saf9fZjk
 6WY0d5HWL+rFQOXdLBQ/mpyFD+ufHmtNbTR+cKnpHKrk4FzXIHWHKyZ5ICWLqM9L7qCU1PBH7Ndv5
 4Dycy5RZwXNiJQYbhwoedTep64NCJhml/PtWbQBwbAuLIfZVm7BUktn4MTu0Y9WCqSzk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dN+S+OLQ3E9fR3RU3W4nKI6yEw9xqFk69o8z5jA3CAI=; b=R0wP26UtOPLNgPkuga7SoB7q3g
 Dn8/qbQPdehgEtgiAQ5M8A5BFarfz5VC673rCB6LwTTrAMBnOuZmV3n/4R9jdDoFQVLv4rlulaDPk
 JQkM6/gZHYNZEV5L6nPGa9OPzqO3Ro8usMbElnUKy22yr6+amhQ1Cd+v3CystcOvg0vs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4DsJ-0002hC-5g for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 08:41:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 666B7601FF;
 Wed,  9 Sep 2026 08:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22BD1F00A3A;
 Wed,  9 Sep 2026 08:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788943301;
 bh=dN+S+OLQ3E9fR3RU3W4nKI6yEw9xqFk69o8z5jA3CAI=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=YEcgmrUDQ8a7hmaBKlZ6pZV2G8K6w2s5oBXaWStivF/sVH71YkwrU+ThV8DyyGoVC
 vXIXBEIQJntc8gDbbQA0s/MEBtSg91Q0G/10nKTMkw/NCKknBp7OIzVrXqQ8RL6cWy
 nnfMTMa1KM9ltcqhw74y+fQnTIh4C9ztf63mu6nQTYRaDStINLJSJ1gNLj2yf+iCnY
 w25Bqfd0/NjXjz0Pht5nBrxYx2Aj3JqBBA+GQKNnWj5BIAtBPM19e08Key5A1tpxQP
 yLrIhcordk4QvyrGhFUr5n52e6uayyMyENDji4+kqqx70LLQ38lu1U3yZPwPHxGafE
 nnR83ub6Q4vkA==
Message-ID: <01e67f12-f759-492a-a332-3c9d5d4c7fdf@kernel.org>
Date: Wed, 9 Sep 2026 16:41:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>
References: <83fe187e-e3e8-4328-bbbf-a6751873b9e0@kernel.org>
 <20260907130313.2626386-1-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260907130313.2626386-1-zhaonanzhe@xiaomi.com>
X-Headers-End: 1x4DsJ-0002hC-5g
Subject: Re: [f2fs-dev] [PATCH 03/14] f2fs: support regular file buffered
 writes
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/7/26 21:03, Nanzhe Zhao wrote:
> On Thu, 27 Aug 2026 16:56:53 +0800, Chao Yu wrote:
>> +	/* Wait for pending drops back to bias which indicates all bio have completed. */
>> +	while (READ_ONCE(ffs->read_pages_pending) != 1)
>> +		f2fs_io_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
>>
>> Suspect there will be potential performance issue, as timeout interval
>> is large.
>>
>> Looks hacky.
> 
> Thanks for the review.
> 
> Maybe we can switch this to an event-driven wait instead:
> 
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ includes
>  	#include <linux/fiemap.h>
> +	#include <linux/wait_bit.h>	/* wait_var_event_io / wake_up_var */
>  	#include <linux/iomap.h>
> @@ f2fs_submit_page_read_sync()
> -	/* Wait for pending drops back to bias which indicates all bio have completed. */
> -	while (READ_ONCE(ffs->read_pages_pending) != 1)
> -		f2fs_io_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
> +	/* Wait until all bios have completed (pending drops back to our bias). */
> +	wait_var_event_io(&ffs->read_pages_pending,
> +			  READ_ONCE(ffs->read_pages_pending) == 1);
> @@ f2fs_finish_read_bio()
>  			ffs->read_pages_pending -= nr_pages;
>  			finished = !ffs->read_pages_pending;
>  			spin_unlock_irqrestore(&ffs->state_lock, flags);
> +
> +			/* Wake f2fs_submit_page_read_sync() waiters (if any). */
> +			wake_up_var(&ffs->read_pages_pending);
>  		}
> 
> However, this requires an extra wake_up_var(&ffs->read_pages_pending)
> in f2fs_finish_read_bio(). I'm not sure whether adding an extra
> wake-up in the completion callback is a good practice - what do you
> think?

Sure, IMO, stability has higher priority, we can tune this later if it
takes much time.

Thanks,

> 
> Thanks,
> Nanzhe



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
