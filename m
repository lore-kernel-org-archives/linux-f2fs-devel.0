Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646CFC54F51
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 29 Jul 2026 11:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YlxB7ylSon/Htrk4hydeXbKw4IyBc7uwVEbEOpCv4vg=; b=iLbmgQWFHCl4Kgfy1ZS4xZjY1/
	4vXXuX1m4wel9BQmLP8zS7DbBN0U1AhRaEXoxOQ5ffDhavwyuc7+fmVg1MwX63JwPuvd7bY9qVIkL
	IkxszAnqXNChOLRBSpBRxMWP1zsJ69A9WfZLAowSZx5duOSxtuQJwTw7qC23iOY1X/Hg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wp2hz-0006eO-FD;
	Wed, 29 Jul 2026 11:44:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wp2hs-0006dh-Jd
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 11:44:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4+Tca2IcSPPZfQSRkigbJtpn7Wv2qQKHxhyLWS7+PRU=; b=EME5KFSBHDHDohPFOZxDox62NA
 8jrsPS5a+ACkad9LDfmecRTvIBEutWloD2/pe8QKqsJaomkkdufIcCA512XHWOhW1UxcU1zxOgwN7
 FJocaNY8lC4V4Tt4OXcYzt3eTBhrQLd427EIxtfEYhw933pq3BuvTA0B7LmXMf9vOx20=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4+Tca2IcSPPZfQSRkigbJtpn7Wv2qQKHxhyLWS7+PRU=; b=llWXN/dM2UtXVA8+NZP2o3Y7a0
 Dwho+FEbxpTwlwFLUrMC35ZPUfegllKNbQJHCKTrNWC4sub+GTscrO44Rsms/pco4bT/z5nsj2/8i
 X31AV9yZQXNwzhfXh8YV7sTjjD+coHsdylZhTKu30rWZAXb4juYqjspyUzrDrxE4RB3E=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp2hu-0004RX-Um for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 11:44:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 00E764243E;
 Wed, 29 Jul 2026 11:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44831F000E9;
 Wed, 29 Jul 2026 11:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785325449;
 bh=4+Tca2IcSPPZfQSRkigbJtpn7Wv2qQKHxhyLWS7+PRU=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=LscUuNsHEOIIOnLYC/EMVAQAcHLC3ylAAbaW0bomLPhd2F3vEa3MXrazHPUCy0vGD
 8vzZMW8dSrXMqGeBgmzPQsMI9QPtmqjgsLfi+/wrrrmfqigfrJwapNhh8AikUxQOEx
 EwJgwX/sgggb+K4JupWpo5or15d7goxob0QVSvAgkQdOEl+bYOl3ZDVUw0Jk3Cwyvj
 kGwKudFD7tmC4peAWbPK6d5xvcz2x/3G57Xi+zFsTqMesCdHnT/EaB3KjjdDTFhpQ2
 8JQ2XHlmW2j26dO7Ajzgm3Y3nUrdQJxFGelD1gI45J1vsCkBhzgWj21zaDzBwR7/b9
 RKa8Aw0hgH6Dg==
Message-ID: <f643492e-b31d-48d4-a721-329c62db42d3@kernel.org>
Date: Wed, 29 Jul 2026 19:44:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260723202008.2581659-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260723202008.2581659-1-daeho43@gmail.com>
X-Headers-End: 1wp2hu-0004RX-Um
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: support dynamic reserve/release for
 device aliasing
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/24/26 04:20, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> This patch adds a dynamic management feature to the existing device
> aliasing functionality. It allows users to dynamically reserve or
> release specific devices from the filesystem's free pool at runtime
> through new ioctls.
> 
> To support this, three new ioctls are introduced:
> - F2FS_IOC_RESERVE_DEV_ALIAS: This reclaims the space occupied by a
>   device aliasing file. It first performs a capacity check, resets GC
>   victim information for the target range, marks the segments as in-use
>   to prevent new allocations, and then triggers GC to migrate existing
>   valid data out of the range. Finally, it reserves these blocks in the
>   SIT to effectively exclude the device from the usable capacity.
> 
> - F2FS_IOC_RELEASE_DEV_ALIAS: This releases the reserved space of a
>   previously reserved device aliasing file. It truncates the blocks
>   associated with the file, which makes them available for general
>   filesystem allocation again.
> 
> - F2FS_IOC_GET_DEV_ALIAS_STATUS: This retrieves the current aliasing
>   status of a device aliasing file, returning whether the file is
>   released (inactive alias) or reserved (active alias, with blocks
>   fully allocated on the device).

Hi Daeho,

BTW, could you please consider to do some coverage test to prevent from
suffering potential corruption.

e.g.:
1. call ioctls in low storage environment
2. race w/ checkpoint={disable,enable}
3. injecting faults in new ioctls + random shutdown

To verify if filesystem or device alias file is corrupted, it needs to
call fsck after the testcase, and find a way to verify whether device alias
status is as expected or not.

Please sharing your thoughts about this. :)

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
