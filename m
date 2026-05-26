Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4BACD5BB4
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 26 May 2026 04:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+95GRPqq6FQNjtzxSv0LCh84MJL5sQgFFH6CJiz5D7E=; b=R9r/jz675xAmDvCuNZXXLuafCf
	pq44m2GmPpcBfvZseoLUN6OAVX35CeZAceegzhJUhxvAkrKvU+rBBeGtd15hfSM5XS/UML6OOvjdI
	mJWVVqmBwMnB5mzALYPn3/wtP1j9jtVK8fLTJXet9xbOnUtWo/Y1ZVBrK0OzKTbykurU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wRjSP-00079m-QD;
	Tue, 26 May 2026 04:31:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <rdunlap@infradead.org>) id 1wRjRv-00079H-U2
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 26 May 2026 04:31:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=527TQNohQgXTy7ya7qpWQCeh7V6iZfuABrEHgfWiUv0=; b=BhPonD9NuF354+ZhlBZbrOq3Bn
 P16kc5g+h4n6EPH58Wl/R4BdIuSu1Kb/fmB54eaoGuVKI+p9yfkRXB8ItjEf8ed+zp4mjkeiYfyQU
 HOXXbd+xDRYtFFZ0slcgrHBLDvKhuf1HB3ebjhEhCBDDQwkyqrO5uzfDIltSWMMpzMEw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=527TQNohQgXTy7ya7qpWQCeh7V6iZfuABrEHgfWiUv0=; b=WUIVRzLoYizDxHSkqkmKgFuadM
 I9fkK157JN5vkTbdf5oMDugL1KhnzMqPQfIcB0HYmE8Jwah2jNI2NopAkIXRib8yrtaxUR7uzITrn
 FBoB3vyCMPYhxyv36jTnJxcap/6fDDVTWdZWTLdRfhOG88vOYBkaAZjqQtVkIRDqbZsY=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wRjRr-00018K-Kj for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 26 May 2026 04:31:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=527TQNohQgXTy7ya7qpWQCeh7V6iZfuABrEHgfWiUv0=; b=n7//IyJl/zK+ighao5zYHcv2xi
 9yzBpONPFgEHn+jpAeMzWdxE39d6MIzzhkwuotgCXfHy4eZO6iawJEp8vIgipOoGVDKqLx8ntWT37
 UK01O4TKEmSRq/SPGb2BxY4Kc8ynVjr1HEvHZp/e/vktJyuTd9U5DtUK9tD3tHC/UH3IoxnZwpRVs
 JwCVBAKH81qxp8aM6P3A9L5jJahSJkXzfqISPRV/6T5CpWfUwqswoAWHHzzRk3PXWgX/OsfCErbQK
 STsy75nGeF5ZjUSwdkiEnpFARej4s9SSM845gK7T2zKZLyy2MFaPLEczhZMoi6zaiiOuos9pcOQtG
 UqU8YnwA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wRiZS-00000000wa1-1OnB; Tue, 26 May 2026 03:35:10 +0000
Message-ID: <8a42abed-8289-44ec-a144-dfe531a4af71@infradead.org>
Date: Mon, 25 May 2026 20:35:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Tso <tytso@mit.edu>
References: <adhPZxtbZxgU-37v@google.com> <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com> <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org> <20260521155748.GA79343@macsyma-wired.lan>
 <ag_OVwPF49LSZ7rz@google.com> <20260522141115.GA8258@macsyma-wired.lan>
 <ahCNmWbcd_2lAJyk@google.com> <20260522224108.GA18663@macsyma-wired.lan>
 <ahTzHyHBL8t0iNBR@google.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ahTzHyHBL8t0iNBR@google.com>
X-Headers-End: 1wRjRr-00018K-Kj
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
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
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Akilesh Kailash <akailash@google.com>,
 Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net



On 5/25/26 6:10 PM, Jaegeuk Kim wrote:
> On 05/22, Theodore Tso wrote:
>> On Fri, May 22, 2026 at 05:08:41PM +0000, Jaegeuk Kim wrote:
>>>
>>> Thank you for the explanation. It seems I made a wrong assumption on the
>>> usage of "user." prefix where each filesystem can support in different
>>> ways.
>>
>> The "user." prefix is used by all userspace applications that wish to
>> store extended attributes.  For example, user.mime_type,
>> user.xdg.origin_url, user.charset, user.appache_handler, etc
>>
>> For more information, see:
>>
>>     https://www.freedesktop.org/wiki/CommonExtendedAttribute
>>     https://wiki.archlinux.org/title/Extended_attributes
>>
>> I certainly assumed this was common knowledge across all file system
>> maintainers, but this was apparently not true in your case.  I don't
>> know how this could be the case given that f2fs implements extended
>> attributes, and I would have thought you would have known that when
>> testing that feature.
>>
>>> I shared some motivation when replying to Darrick's feedback [1], but yes,
>>> it was not enough for all heads-up. The problem started that some speicific
>>> application needs as many high-order pages as possible mostly for reads. So,
>>> I thought we can turn on large folio on the specific files per hints. One way
>>> for the hints was using immutable bit, but it turned out it's very hard to
>>> manage disabling the bit whenever deleting the files. Along with limited
>>> ioctl() and requiring inode eviction to manage large folio activation, I had
>>> to implement this path.
>>>
>>> [1] https://lore.kernel.org/lkml/aeA5C8byIpXWla7f@google.com/
>>
>> Actually, you still haven't explained your use case, at least, not
>> well enough for me to understand what you are trying to do.
>>
>> So an application wants a particular file to use as many high-order
>> pages as possible.  Why?  What sort of guarantees do you need to
>> provide?  What happens if they can't be provided?  What happens if a
>> possibly malicious, or at least gready, application uses this
>> interface to grab a lot of high-order pages?
>>
>> >From your patch:
>>
>> 1. setxattr(file, "user.fadvise", &value, sizeof(unsigned int), 0)
>>  -> register the inode number for large folio
>> 2. chmod(0400, file)
>>  -> make Read-Only
>> 3. open()
>>  -> f2fs_iget() with large folio
>> 4. open(WRITE), mkwrite on mmap, chmod(WRITE)
>>  -> return error
>> 5. iput() and open()
>>  -> goto #3
>> 6. unlink
>>  -> deregister the inode number
>>
>> Why should making the file read-only matter?  And when you say
>> "derigster the inode number", why should this be related to deleting
>> the inode?
>>
>> This is an interface which seems to be very specific to your use case.
>> What if those requirements change over time?  What if you want pull in
>> a file without making it be read-only?  And what if you want to
>> release the large-order pages without deleting the file?
> 
> Let me try to write more details, helped with Gemini.

[as an interested reader:]

If this idea is so good, why shouldn't it be done in the VFS/MM so that
other filesystems could do the same thing instead of just in f2fs?


-- 
~Randy



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
