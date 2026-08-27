Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA90C61DB9
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Aug 2026 06:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oGZhpzsI1CB+Svtir81k/RvEUdABBuP10zneZG/0zSM=; b=ZP9L7qo5BQNUlmpRcOknQramlL
	VF0KYVT3OnLpfGwNo/URYyTp+2e8sGNzQPeplcyOOQiJp4FMfGtr39xjmG7dn1LT86wX6ZhZVpHnp
	lX6LKGEs/G7sgA/7xf6Uhme+9eQgTHYyV8O72d7KZaB9G4EHV5qg2anCXbYImMOIdlmU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzTsm-0004h9-S5;
	Thu, 27 Aug 2026 06:46:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wzTsl-0004h3-FA
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 06:46:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4NgYDT5Y9vB6g5RuCxqn4JmXHRINoMhuAr9KCYvyhwU=; b=aoXbtDL8oH1QyGgozQ/mCoU2uD
 GYf4Q0R6hHd+VoxoqcWSLKryLxnZIJwz4tu8p2kTNNQZDfGB+AgkX2SWQeprKuRJcV+6WsihJVm7F
 PlY87Uxm5j3ZBNynQz96yTy5xQCF7Y5bN3qD5aA7N9to+4IJWD2cnlxY4UUwxIofNvbc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4NgYDT5Y9vB6g5RuCxqn4JmXHRINoMhuAr9KCYvyhwU=; b=OhLmJJuknkD22N3ve6WOfaZGiu
 MKQgWu8cFuNyZa3S2GZOTK4saACBrEmfMiWEH4l90fOTte9oVPmHy3z+Kylamrw/hmp1vrGi014IU
 wAV77ktCLB4/hltXmTknHb1quV+Yn8OJsjcQL+GQw62as9fJ6RUq9q6dKo0aB2VBDobA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzTsh-0002XU-16 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 06:46:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B2275600DB;
 Thu, 27 Aug 2026 06:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8091E1F000E9;
 Thu, 27 Aug 2026 06:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787813188;
 bh=4NgYDT5Y9vB6g5RuCxqn4JmXHRINoMhuAr9KCYvyhwU=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=K/IQaFtjVdvQ5kPDQq/bh4L54z1EuhXrjmVWdFqH5FeGn6xV+6IahnEd6bFVrYA25
 TShFcxY3EtdeEuVJGIgkxg12Fkzc+HQT1vcYnUgCcFqsuHeEi64BZiBVkkJ7RiPcUc
 E6ttpPyl3VtBfRUEajkc8gPhqYw/fAMqBZQSR4NP+fLnCfgm1EgYAW1aBBkVuWLzXo
 +aLqGt0OSi2eoAdkLWe5R5a5OTrR8AylaTIIuILtB0QpcevDfqzKIkAxHnjrmB+4Xz
 ojOP2GN4SYaAUpe1u4vt/F27tNLIf9lCwTiX8nVGZFmcZe6dVMC43YgJ+srlm+7y7e
 /weU2LKoitvvQ==
Message-ID: <a343cdfa-ee3c-4427-97da-bcb9ebfbada0@kernel.org>
Date: Thu, 27 Aug 2026 14:46:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>
References: <20260825130126.2078627-1-chao@kernel.org>
 <20260825130126.2078627-6-chao@kernel.org>
 <CACOAw_xP6eTBE-p2EaHr=C4TggxViYs+axz+8sW6dPw81qbWNg@mail.gmail.com>
 <ae411946-e035-4933-878d-721566c95093@kernel.org>
Content-Language: en-US
In-Reply-To: <ae411946-e035-4933-878d-721566c95093@kernel.org>
X-Headers-End: 1wzTsh-0002XU-16
Subject: Re: [f2fs-dev] [PATCH v3 05/12] f2fs: cache: use meta cache
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/27/26 10:26, Chao Yu wrote:
> On 8/27/26 04:22, Daeho Jeong wrote:>>> +       memcpy(cache_address(tentry), cache_address(sentry), PAGE_SIZE);
>>
>> Use sbi->blocksize or F2FS_BLKSIZE instead?
> 
> Sure, I thought about that before, but considering we have supported
> PAGE_SIZE != sbi->blocksize yet, I didn't touch that.
> 
> If you want, let me change here.
Seems my change is not inconsistent for several places, let me change to
use sbi->blocksize here.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
