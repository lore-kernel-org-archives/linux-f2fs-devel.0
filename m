Return-Path: <SRS0=Qhk5=7L=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA192C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 29 May 2020 22:46:41 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B714320721
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 29 May 2020 22:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="N79m5FCQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="L7U5ZQmM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nH1QiA+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B714320721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jenlx-0006Zq-8J; Fri, 29 May 2020 22:46:41 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <axboe@kernel.dk>) id 1jenlv-0006Zb-Cy
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 May 2020 22:46:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3SvGI6+FW1/OhXjcYh+qu+PkvAZr4CU1sl+aHPi5BkI=; b=N79m5FCQsn1O4gGlJpqxEADID5
 mL8TIO1Ch3HcUp/bxJj5r0j+L05JB3O5n8Irr0gBrhGFPeS6yRP2EjZmtUCau4sP0gYQErthaumEW
 an+Fe6cLEVfEWvBPkFOjaOUjLjqO6doVv8450rdAc55RoIAODUC80u0lzL1ftzg62Ijw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3SvGI6+FW1/OhXjcYh+qu+PkvAZr4CU1sl+aHPi5BkI=; b=L7U5ZQmMeNQISSOIr2N0mGmf+d
 7OM7ybWHXV/kIBYj8E5PeiRhSyarIXucPeVr0SBMH5YlGSO0JvqNmeZjHXO675lob7Yj1pxfN8CKN
 7TM8EEJ0L8+9IJa9EtSa8dNA7hnf8vKEeL5KWNrNYuKAuNb2W26CqN8WEg/maHAKN8Ao=;
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jenlt-003H2E-HM
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 May 2020 22:46:39 +0000
Received: by mail-oi1-f195.google.com with SMTP id j145so4055266oib.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 29 May 2020 15:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3SvGI6+FW1/OhXjcYh+qu+PkvAZr4CU1sl+aHPi5BkI=;
 b=nH1QiA+IRSDYm41wzzYncwFaM+lrDNn8Ti2XFcAi4YlaUw9LztwixK0pLNSdeHIyB7
 8bS61hIRSiOulx1iuyKF9nP4gpzLATvREps1+Y8sUHCTsMZ0rY+c1fgY5DukBD+Uegin
 1lLKtDr7RDXHpyWblpi+B9d4Ujuc4xdGVonklbCjbzvYQPtHToJufcxLYyR+p+Kh98lg
 7xb/aOq4xXK0qPSUlE/HFQp1mG3daOYUEb9TuOa7ktkFpy+7p82qFHo7IYkgx6GUZGuH
 8zk1bdAi4lwNOoqsXYgm3MyTYkenX/Q/gJXp2zUQOgLiLCvj9OzabgNt4M4CpTJUiGsP
 5U5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3SvGI6+FW1/OhXjcYh+qu+PkvAZr4CU1sl+aHPi5BkI=;
 b=g9pV5klv2/O9sOTvJXwueYdwc7aQlVYPe917Nbnq0ElKkKWKRzUygEFYSpHEAAB6JN
 uhjGeSj2iRvosCvxdrkF5qi84n+1jE/1LJaVUP94HrhhmUMvgxjC1rE8poIE9lB6kYMM
 fVP15M8N5rRMndeF8ZS5DFcbofr/sP3xMZTo+xDbv8Z6WNVqgnTp0KYZ+coTMffC31wJ
 glJ/5sWzlLhIfs9UydS27+6eiQakpUsN6RiNsaGTM9umOvaNqKsPpyTwzE3yQxBYtvEn
 S9OjyCOARGseeD4j9Vy9iVu0kvV63j+TlJ57kaslaJzBiVaANB3cBhtJSi1DyeyJo3Gh
 5Z3Q==
X-Gm-Message-State: AOAM5336wwp5xVeePv3/9t8cvLjgZruN11ZtanyUQKjjnjxjUoThSzm7
 aYnmc/x3jgDEoGzGjSQIjuy1tFMVW99JfCAf
X-Google-Smtp-Source: ABdhPJx+EbTbp9drKjVT1SBrBX1rRMhZ6tJHpQZ+IXg2BZcRTR0vnvD5aHP3y5FWcW+eFbCDEyco7w==
X-Received: by 2002:a17:90a:68cd:: with SMTP id
 q13mr11465889pjj.177.1590791970211; 
 Fri, 29 May 2020 15:39:30 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id m22sm374695pjv.30.2020.05.29.15.39.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2020 15:39:29 -0700 (PDT)
To: Bart Van Assche <bvanassche@acm.org>, Matthew Wilcox
 <willy@infradead.org>, Kaitao Cheng <pilgrimtao@gmail.com>
References: <20200529141100.37519-1-pilgrimtao@gmail.com>
 <20200529202713.GC19604@bombadil.infradead.org>
 <c7a5bbc4-ffc2-6a63-fed3-9874969afc31@acm.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fe0fc36e-fa67-a6b9-cc7a-d86d3f21cf2c@kernel.dk>
Date: Fri, 29 May 2020 16:39:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <c7a5bbc4-ffc2-6a63-fed3-9874969afc31@acm.org>
Content-Language: en-US
X-Headers-End: 1jenlt-003H2E-HM
Subject: Re: [f2fs-dev] [PATCH v2] blkdev: Replace blksize_bits() with
 ilog2()
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
Cc: hoeppner@linux.ibm.com, heiko.carstens@de.ibm.com,
 linux-nvme@lists.infradead.org, dhowells@redhat.com, clm@fb.com,
 deepa.kernel@gmail.com, houtao1@huawei.com, hch@lst.de,
 linux-s390@vger.kernel.org, chaitanya.kulkarni@wdc.com,
 darrick.wong@oracle.com, mark@fasheh.com, satyat@google.com, hch@infradead.org,
 borntraeger@de.ibm.com, gor@linux.ibm.com, josef@toxicpanda.com,
 ming.lei@redhat.com, viro@zeniv.linux.org.uk, songmuchun@bytedance.com,
 dsterba@suse.com, jaegeuk@kernel.org, jlbec@evilplan.org, sagi@grimberg.me,
 balbi@kernel.org, damien.lemoal@wdc.com, martin.petersen@oracle.com,
 joseph.qi@linux.alibaba.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 asml.silence@gmail.com, linux-btrfs@vger.kernel.org, sth@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/29/20 4:27 PM, Bart Van Assche wrote:
> On 2020-05-29 13:27, Matthew Wilcox wrote:
>> On Fri, May 29, 2020 at 10:11:00PM +0800, Kaitao Cheng wrote:
>>> There is a function named ilog2() exist which can replace blksize.
>>> The generated code will be shorter and more efficient on some
>>> architecture, such as arm64. And ilog2() can be optimized according
>>> to different architecture.
>>
>> We'd get the same benefit from a smaller patch with just:
>>
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -1502,15 +1502,9 @@ static inline int blk_rq_aligned(struct request_queue *q, unsigned long addr,
>>  	return !(addr & alignment) && !(len & alignment);
>>  }
>>  
>> -/* assumes size > 256 */
>>  static inline unsigned int blksize_bits(unsigned int size)
>>  {
>> -	unsigned int bits = 8;
>> -	do {
>> -		bits++;
>> -		size >>= 1;
>> -	} while (size > 256);
>> -	return bits;
>> +	return ilog2(size);
>>  }
>>  
>>  static inline unsigned int block_size(struct block_device *bdev)
> 
> Hi Matthew,
> 
> I had suggested to change all blksize_bits() calls into ilog2() calls
> because I think that a single function to calculate the logarithm base 2
> is sufficient.

I think this should be a two-parter:

1) Use the inode blkbits where appropriate
2) Then do this change

I'm leaning towards just doing it in blksize_bits() instead of updating
every caller, unless there aren't that many left once we've gone
through patch 1.

-- 
Jens Axboe



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
