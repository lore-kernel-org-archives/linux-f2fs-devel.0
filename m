Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD84FCD8CB9
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 10 Jun 2026 18:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qR4Xs6sCeAAyKTGr8mb7iDpYVOFdA793MrRvKN+yRHs=; b=WK1ZUpbe1S7BmurXtokMKrYRju
	3eguy9jCooHQUbIBv7SPwl/N3NDTwQKvZEWmjc9MBpfr85qeN3Fr+fzNQ+q7cMA8uKTEdP/WOFMzk
	8ajghYN6hyLUxMn7VIDeCmkpH8XZEDhrT1L/ePGBwbzkULdIeEojUIXfC1mqVAfOXz9Q=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wXNe2-0002m2-Vn;
	Wed, 10 Jun 2026 18:27:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bvanassche@acm.org>) id 1wXNe0-0002lr-RN
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 18:27:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VMfRG3zEvXnd0epK3znZlTDE93VP4IlA6hKVuV5FZ4U=; b=BIWS2iB67bhfUlbh/AxFpGrmLF
 z+KyEPIwsCTWaO7Ih8+qoG9L/Lf1YR3M5us3YbjctkUKzdZ9f4LDUQeWv2vlrCLL9TscQGLXsRdsB
 zyCIO2M9bmuz9/qs3vXQR+MHnLwCZoBIobChLR59Qq52Bs2tCGboXqvjpDhs5eVEigD4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VMfRG3zEvXnd0epK3znZlTDE93VP4IlA6hKVuV5FZ4U=; b=JFSEgHOv5o3WrpnVW6E/gitkJP
 MZErvb++0QtTyFQ/qsVZY1+H5EBMR4MjcDNzkW0O8Q5klxKAIYi81CRx341+2GaPR9jxweKRGJ9yJ
 letoX8etM9X44k07QF/m2CVTZvwZYaA5w8HIto9fvONed2TjXEpFQKm+9rTUkW1JGZfo=;
Received: from 013.lax.mailroute.net ([199.89.1.16])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wXNdw-0001Il-Fq for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 18:27:14 +0000
Received: from localhost (localhost [127.0.0.1])
 by 013.lax.mailroute.net (Postfix) with ESMTP id 4gbDlH69lXzlfl8H;
 Wed, 10 Jun 2026 18:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
 content-transfer-encoding:content-type:content-type:in-reply-to
 :from:from:content-language:references:subject:subject
 :user-agent:mime-version:date:date:message-id:received:received;
 s=mr01; t=1781116025; x=1783708026; bh=VMfRG3zEvXnd0epK3znZlTDE
 93VP4IlA6hKVuV5FZ4U=; b=kON0NXOyKR1Hoomcjk+nxbnmOhWPwWOs8IK5p5Ld
 QSwM1hmN9ybQqooRJbTWRpQby3Gs8m7ZbmZxm5OZ2hZC5dbanrNt+MBN01VmNhbx
 Pxi+CrSDFl5VWyhhjPHW+C0q7GPBpdDlEgEMNHvDilH3Q+1yRzOpwoZDrxpc84uX
 04giqlXz1YVQz61RfcoPBV0SbBXmb1lDyX2lRb2AuJ27hhRXJUXdlIb6fbujPx+Y
 X99r5ofpDHK5/1Dwxnto8FI78O3Z1SaQxYZTzJpvDFh65rR/OfsoyyHSCqbG647t
 JGCKpExX20GD4BwycrxPQvNVSet9nXHcbmMOpSZaeOclaA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id sbRZo2deZCHr; Wed, 10 Jun 2026 18:27:05 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: bvanassche@acm.org)
 by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gbDlF2tc3zlfvpK;
 Wed, 10 Jun 2026 18:27:05 +0000 (UTC)
Message-ID: <7d8cd85c-2aa7-48fd-89af-39adabc89d97@acm.org>
Date: Wed, 10 Jun 2026 11:27:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <cover.1780003055.git.bvanassche@acm.org>
 <0e18152026cacd1e61fb5fb5483fc1d3c57bdc51.1780003055.git.bvanassche@acm.org>
 <a3431eb2-6224-401b-9aec-1c0abf840143@kernel.org>
Content-Language: en-US
In-Reply-To: <a3431eb2-6224-401b-9aec-1c0abf840143@kernel.org>
X-Headers-End: 1wXNdw-0001Il-Fq
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

On 6/10/26 5:14 AM, Chao Yu wrote:
> On 5/29/26 05:20, Bart Van Assche wrote:
>> +	/*
>> +	 * SZ_16K restricts the time spent on completing writes to about 150
>> +	 * microseconds on an Arm Cortex-A520 core.
>> +	 */
>> +	sbi->max_atc_write_bio_size = SZ_16K;
> 
> Actually, I don't see this problem before, can we disable this by default, and
> only enable for your case via sysfs?

The new behavior should be the default because interrupt handlers should
complete quickly.

F2FS is primarily used on Android systems. On an Android system spending
too much time in interrupt context can have the following consequences:
* User interface stuttering and frame drops (jank).
* Audio glitches.
* Application not responding (ANR).
* Connectivity degradation. Interfaces like Wi-Fi and Bluetooth depend
   on fast interrupt handling.

>> +	ATTR_LIST(max_atc_write_bio_size),
> 
> We need to update Documentation/ABI/testing/sysfs-fs-f2fs as well.

Will do.

Thanks,

Bart.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
