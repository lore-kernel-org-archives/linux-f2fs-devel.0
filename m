Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96912CD98C5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2026 03:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nIoXm2GVuj5WHluF+EEOlGwL87GJ7PYjiPcDs9x+P5s=; b=cjn5NYR7x1yofJACTkZsScAmFy
	oEb06WLyMhoB86OCrNocDjwOH15wu12gYpghsjxqholeod/7wkTGKUDMYz7iEI5T1L0jAB8Yo1M1S
	M6vTTFyUWKo2/WinrQZOOKhEbuCbLoiPKRcWVEBAelOKq8KSthdfz5ioQM6bi8+CpB9A=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wYxce-0001jN-G1;
	Mon, 15 Jun 2026 03:04:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wYxcd-0001jH-4n
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 03:04:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7RL67W0QSeHraShNTh9i+t3F4TleR8GK1j7DCrjYmT8=; b=OtURueSFPiQnK+PS8G/3YKFyx1
 OweZOitIZpgFQ6ob0C6zrvSnO5miysJPJqYqrztv8Yhg7NCN8AdhOSEyoVXWeigEpKcC5LOEfnUBf
 QtJztqe7kA1WP17lbVMoIh7Wt4p2SBzSySfVplas0leyFrLTWo9P1J3Wtl9sZGyxy2gU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7RL67W0QSeHraShNTh9i+t3F4TleR8GK1j7DCrjYmT8=; b=mResxtNAlKzR3SK1qI89pMzu68
 4F+CRi5Neyo6Y+Us/RvZT1td9jKXWyAARxEwpsVgDfTp9bp8A5+HBMygseo4Qt/UJsFOM6T2juHWm
 8xRJAl4SFCScDHEtLb3riZdHu0+4ZgD1s/nmkTFhtPHW2FzjKj4O9ihCmIh8VJbyfOLo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wYxcb-0007jX-Om for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 03:04:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5FEBC6008A;
 Mon, 15 Jun 2026 03:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409001F000E9;
 Mon, 15 Jun 2026 03:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781492651;
 bh=7RL67W0QSeHraShNTh9i+t3F4TleR8GK1j7DCrjYmT8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=gieWxAK8BnGfKekugqK7atBoQ/8MpmV/3A4BIsNSGlRBnmxY9AMo5AX3RbezzCzET
 /ao6F2OuEsXIvb6IhEEGvJwMJkGOuLzHllWzeGdpQQPAQc+Ce1rPL43qurssI8aCf7
 seNnhUM7CoGtDuG89kzVgTb7k1TVKugv24Bd2pIezSpzbCqWRztgrt3O0m1A6pUePZ
 YJlIZQogjM6skkLvtez6fl7RF8CdzOduN5Ze5SK8+b06bq83UNfijLma6RxPcjGNAH
 EtstkQsIRZVj9l45KjkCfrKIFrUTqzp/2o9rER56UO0E3e4Da2LeBvOcY1gHXvKMCA
 uZN7CaWmRdzTQ==
Message-ID: <48f1fbdb-fa94-4de1-92e4-8ebfd9e12be0@kernel.org>
Date: Mon, 15 Jun 2026 11:04:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Bart Van Assche <bvanassche@acm.org>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <cover.1780003055.git.bvanassche@acm.org>
 <0e18152026cacd1e61fb5fb5483fc1d3c57bdc51.1780003055.git.bvanassche@acm.org>
 <a3431eb2-6224-401b-9aec-1c0abf840143@kernel.org>
 <7d8cd85c-2aa7-48fd-89af-39adabc89d97@acm.org>
 <acf21183-0505-401e-9a1c-dd91ff147b63@kernel.org>
 <6505b5e3-b4e8-41bb-bfb0-52e6e20f45f0@acm.org>
Content-Language: en-US
In-Reply-To: <6505b5e3-b4e8-41bb-bfb0-52e6e20f45f0@acm.org>
X-Headers-End: 1wYxcb-0007jX-Om
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/13/26 05:03, Bart Van Assche wrote:
> On 6/12/26 5:05 AM, Chao Yu wrote:
>> Actually, I'm worry about whether there is potential performance regression
>> caused by enabling this by default, also a little bit concern about the affection for PC|laptop scenario which is used by individual user.
> 
> According to Gemini F2FS is primarily used on PC's and laptops to
> increase random write IOPS for rotating media (hard disks). I don't
> expect the performance impact of this patch series to be measurable for
> rotating media because the time required to queue and schedule work is
> very small compared to the I/O completion time for these devices.

Hmm, I suspect there is potential non rotating media user, scheduling
can be the bottleneck there, maybe.

> 
> I ran a new set of measurements on a UFS 4 test setup with zoned
> storage (ZUFS). On that test setup I see that the variation between test
> runs is much larger than the variation in test results with or without
> this patch series. In other words, I don't think that we have to worry
> about the performance impact of this patch series.

Well, it needs to be verified for each kernel version you backported, on ZUFS
or non ZUFS, right? I guess Randall or Leo may have time to assist to setup the
performance test. :)

Thanks,

> 
> Bart.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
