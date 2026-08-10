Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC41EC5B56A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Aug 2026 16:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x4y8WE0P6pOo3rDdWmF51hr6XBfiCMfWc3uOXl5CCa4=; b=XBM147Bn8GKIlRyZ802jKTtt4k
	KKxOMx6U3LYqYSXfz3E+YXq73YsAJXj/B7ZGY3pU3uaBj6YgvJ61kzg6EMkJhZyLx8QjhHqxpJnNX
	fLJgi0Tk8gp5ENX4TtQFvoMm+WV7puOrZBdFCwQJP+b1evpPE1Py3NSS+Ute9tjMLSaU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wtSxj-0003l6-J0;
	Mon, 10 Aug 2026 16:34:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bvanassche@acm.org>) id 1wtSxi-0003l0-PW
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 16:34:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GA+WLiTlvjArbsYCWEM0t+Rl0HCxi12K1ZGpQe+GWcs=; b=DMZvDTdVrtzblFDmZqt3KxPg+L
 YsU7fjGoLrt0BjBE3+OepMfFLykF2rzbsgam6tLaZ4/buPu3E7pHjZyUo5QUaCmPWTNQfrajwHP7U
 DD1CIMxhL/EofcTHTmOjLlzO7pvPY4iBQSn4Q7JDt2MKRtYfIWXqe0FxHudUR25f8ij8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GA+WLiTlvjArbsYCWEM0t+Rl0HCxi12K1ZGpQe+GWcs=; b=gZRKA9TWqFM7FV+jSFIp1RIoMU
 UskNMBym7DLg++pYrAWCYVg1Tkk32bYi5v/McoWG2gd65+vxuGcY4oFRjnP2dObSaFSVgHiX5nnL9
 uvgaRAuZbTAC++2fDGRGnLb0HM+FLNPijIxMEtXhzYhxjJZf/YC/w4FFQT7G3rh63IWM=;
Received: from 011.lax.mailroute.net ([199.89.1.14])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wtSxe-0005h7-MD for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 16:34:52 +0000
Received: from localhost (localhost [127.0.0.1])
 by 011.lax.mailroute.net (Postfix) with ESMTP id 4hJgMT3mvLz1XM30j;
 Mon, 10 Aug 2026 16:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
 content-transfer-encoding:content-type:content-type:in-reply-to
 :from:from:content-language:references:subject:subject
 :user-agent:mime-version:date:date:message-id:received:received;
 s=mr01; t=1786379677; x=1788971678; bh=GA+WLiTlvjArbsYCWEM0t+Rl
 0HCxi12K1ZGpQe+GWcs=; b=wuedhpCelYOQX8TPOIHXkV5XLSVA1UJyIgx33s5G
 5lryYVaJasvQZFr5DJRF4ipPBcwUQnCnA3r48yAA1QGh3FRvUGX7j0QBAx42zeJ6
 TloGPaoDshk2iyFKL8yWCAT47Sst0fLEV5LKKQpc2xaF99DBA0tuQvNSlT0QqL/x
 WyB+VnkUwOIHwz79BGCUVJynMCK76wCGRkiPhgNOYnQsF0mD6GiMvLdeAUU+3S9v
 qdopmSEe1npfMEOQhjLGtEEogYPxMLRAyR+IxoczkjSg2qWzBwa1bk3ySusLkBI1
 AFtjcUEygrtdZcIdKwwvZivpC+Q7OPp4O3WI6Z/oyHHJVg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id sk6PZJJKqySN; Mon, 10 Aug 2026 16:34:37 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2e3b:8:bf02:1d5:26f3:7213] (unknown
 [104.135.204.235])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: bvanassche@acm.org)
 by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hJgMG2MbTz1XM30h;
 Mon, 10 Aug 2026 16:34:34 +0000 (UTC)
Message-ID: <ff74edb1-43c7-485f-ab78-ec13b500a0bb@acm.org>
Date: Mon, 10 Aug 2026 09:34:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christoph Hellwig <hch@infradead.org>, Daeho Jeong <daeho43@gmail.com>
References: <20260806170108.2100312-1-daeho43@gmail.com>
 <ann0OPPglToV_hjs@infradead.org>
Content-Language: en-US
In-Reply-To: <ann0OPPglToV_hjs@infradead.org>
X-Headers-End: 1wtSxe-0005h7-MD
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: quiesce background threads during
 system suspend using PM notifier
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
Cc: Pavel Machek <pavel@kernel.org>, Daeho Jeong <daehojeong@google.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kernel-team@android.com, Len Brown <lenb@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/10/26 8:54 AM, Christoph Hellwig wrote:
> On Thu, Aug 06, 2026 at 10:01:08AM -0700, Daeho Jeong wrote:
>> From: Daeho Jeong <daehojeong@google.com>
>>
>> During system suspend, a race condition can cause f2fs_gc and f2fs_discard
>> threads to call submit_bio() while the underlying block device (e.g., UFS)
>> is in Runtime PM suspend. Because Runtime PM worker threads are already
>> frozen during task freezing, the threads become trapped in
>> __bio_queue_enter() waiting on mq_freeze_wq, leading to a PM freezer
>> timeout.
> 
> That does sound like a general issue with our block device / threading
> handling.

Daeho's description above mixes up unrelated topics. A runtime suspended 
UFS device is resumed automatically by the block layer if necessary. The
issue Daeho is trying to solve is unrelated to runtime suspend according
to my understanding.

>> To prevent this deadlock, register a PM notifier to set SBI_IS_SUSPENDING
>> during PM_SUSPEND_PREPARE. Background GC and discard threads check this
>> flag and immediately stop issuing new bios, allowing them to enter a
>> freezable sleep state cleanly before process freezing begins.
>>
>> In addition, check freezing() as a fast path to stop issuing new I/O
>> when non-PM freezing (e.g. dm-snapshot or cgroup freezer) is requested.
> 
> .. which means that we really sould have all the relevant parties
> invited into figuring out whast is happening here, rather than
> band-aiding something that looks like a horrible hack inside a
> file system.
> 
> Unfortunately I see this a lot with f2fs.  Please reach out to all
> relevant maintainers for something that does not look strictly local
> to f2fs.

This information was shared earlier with Daeho 
(https://b.corp.google.com/issues/515470309#comment45): [ ... ]
Register a Freezable Kernel Thread (Recommended) [ ... ]
Why this works: During suspend, freezer stops freezable kernel threads 
before devices and block queues enter their PM suspend phases. When the 
queue freezes later, your thread is already safely sleeping in 
try_to_freeze() and will not attempt submit_bio(). [ ... ]

PS: I'm no longer subscribed to the f2fs-devel mailing list.

Bart.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
