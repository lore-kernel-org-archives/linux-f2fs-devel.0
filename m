Return-Path: <SRS0=gGzW=P6=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5DAC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 11 Nov 2021 00:26:54 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D13E6124D;
	Thu, 11 Nov 2021 00:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1D13E6124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mkxvX-0004Ov-HZ; Thu, 11 Nov 2021 00:26:51 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <axboe@kernel.dk>) id 1mkxvV-0004Op-B7
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Nov 2021 00:26:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NyY8bek2WvSGjibqw1QUPQDNaQc/2Apt9v2sF1q2Sv4=; b=WPcWjjytwSKuCs3AQvgUdz6UGG
 39I45w55VPUS2gCnePhTHza2EcXFOTmZJH2j6T4ejAWCdbcqidWXv7kuFfUEvJYrsDNP2T5gicBkO
 mHibhrnA07b0ypXu04K+/Pg0IEqob5yxPcHQqgaDVciPc4jRzGuoSRNz3AQKIWvh5C/s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NyY8bek2WvSGjibqw1QUPQDNaQc/2Apt9v2sF1q2Sv4=; b=H6lJeZLWxDgIKCn9KVW4kfNJm8
 AHDGKz0hCkNkNqvBPAOIwoogcRPxsrZMtMDhdU7SI74ntC6uxsNx4oJfCWU++Ka6GuMghnTAyiFOV
 L33kWnWi8kscdy6yKfDZxq9ZENMRoJODkXKso9EhrZ2ISdbfGXgQaHdDJZO4pTYnFcDg=;
Received: from mail-io1-f47.google.com ([209.85.166.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1mkxvN-0092b6-U7
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Nov 2021 00:26:49 +0000
Received: by mail-io1-f47.google.com with SMTP id m9so5010106iop.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 10 Nov 2021 16:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NyY8bek2WvSGjibqw1QUPQDNaQc/2Apt9v2sF1q2Sv4=;
 b=jl8dCUt7BkCW8ACewdF5osqNI3RRnyRBlDQP+bydLnpGYyQGl6gpUQLfxoxQoh5i6V
 MZBsAXng179VNrfxCM39UGTAJvAJ4/yuK9LxptVUGrVjXh3EuNxWp9CPHDp5/qxXAbUK
 AudU9T1bq4PRSE2Xwcu3+vNRsTRrmfqH8pR7ojn4yKH28l7o9Ysq8/kenSprv+E4r+tD
 hQUx6HWhvEGAk2z+k4uH1bSjsGBesfOspT7wG/rmpTeAvbpPyEVeGUSveLIw56fx3Ifo
 saZYwZiQsc5w+jWXEoA7zR3Kg8fblBc4BMesHGNlJs+5LBQVWbMdqOH4gO1jHXW8FIoB
 t+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NyY8bek2WvSGjibqw1QUPQDNaQc/2Apt9v2sF1q2Sv4=;
 b=R8x1zBdNqrCaqge6L4BmOAfvQW7aUOeOE0GRqYBArUbaxWEfCs+O7J/T8725x/3GIV
 bxhq5sgJOi/mk8cVqem+A+fCBuTWS7xT8lkG63Y4rLWNXe6hCtS4xE12mt3JtT6rDJR+
 8uVTpzXGGDnXn7CdeisDt1BkDLmyyqRIk40yZiIeKQ3cV9VaUW5gTn8EE5/73dSqL8f9
 bmdnPMCptLunKECPJ6RKMPnClVEOW2uU8Gi/R0z8wZ0ewl1a2qEfts1XnaXxbixwnvEE
 2vapQesVDmv891mNyPpArY7HkDEVaw96cM5am1/KDOgr1BsTGgmTHD8uLJD7FWntmk9k
 x44Q==
X-Gm-Message-State: AOAM5306CAhT+l3vFmRJiI6i0ybBeJt1rda3yA/2qNr0ooVGot2MHMtm
 5PQc/dRpfd+tbSb1KwIdMGr0dg==
X-Google-Smtp-Source: ABdhPJxopWi9rf1i9qBVVWTcqIkAhArpHV5fNVB3eoBbngZouc4tphuIfKJZ6Q5OY/IaBbXy3Iy8rw==
X-Received: by 2002:a5d:8903:: with SMTP id b3mr2207722ion.44.1636590396221;
 Wed, 10 Nov 2021 16:26:36 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id s15sm1139630ilu.16.2021.11.10.16.26.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Nov 2021 16:26:35 -0800 (PST)
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20211109021336.3796538-1-jaegeuk@kernel.org>
 <YYqkWWZZsMW49/xu@infradead.org>
 <042997ce-8382-40fe-4840-25f40a84c4bf@kernel.dk>
 <YYwYxv4s1ZzBZRtC@google.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a309f240-e99c-5049-fc67-007a50eb56b3@kernel.dk>
Date: Wed, 10 Nov 2021 17:26:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YYwYxv4s1ZzBZRtC@google.com>
Content-Language: en-US
X-Headers-End: 1mkxvN-0092b6-U7
Subject: Re: [f2fs-dev] [PATCH] f2fs: provide a way to attach HIPRI for
 Direct IO
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
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 11/10/21 12:08 PM, Jaegeuk Kim wrote:
> On 11/09, Jens Axboe wrote:
>> On 11/9/21 9:39 AM, Christoph Hellwig wrote:
>>> On Mon, Nov 08, 2021 at 06:13:36PM -0800, Jaegeuk Kim wrote:
>>>> This patch adds a way to attach HIPRI by expanding the existing sysfs's
>>>> data_io_flag. User can measure IO performance by enabling it.
>>>
>>> NAK.  This flag should only be used when explicitly specified by
>>> the submitter of the I/O.
>>
>> Yes, this cannot be set in the middle for a multitude of reasons. I wonder
>> if we should add a comment to that effect near the definition of it.
> 
> Not surprising. I was wondering we can add this for testing purpose only.
> Btw, is there a reasonable way that filesystem can use IO polling?

Whether an IO is polled or not belongs to the issuer of the IO, as it
comes with certain obligations like "I will actively poll for the
completion of this request", and it incurs certain restrictions in the
block layer in terms of whether or not you can ever sleep for requests.

You could certainly use in in an fs, but only IFF you are the original
issuer of the request, which then also means that you are the one that
needs to poll for completion of it.

It's not a drive-by "let's set this flag to speed things up" kind of
flag, there are a lot more moving parts than that.

I don't think it will be useful for you.

-- 
Jens Axboe



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
