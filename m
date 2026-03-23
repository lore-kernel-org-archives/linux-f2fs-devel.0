Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05315D58CCB
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Mar 2026 03:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7kH6JkkT+aA9dzkk7ss8agxXbzM+x06NJJvum4PGJo4=; b=UHE6aRM0WOvUNKFNt8gLsWEX7I
	USG2wsyNuTWtPM6a6UGI5cqSDxo5eAjNWPQKvj8WB8cgHTl2MkPbWwMMpvDmx7dFm1q/+M84BNk3f
	WivHxwBVobh2s3ojTUKby2EhWH0e2TqKvsUhquTQvrvn2LBwmSWo3vRw2wrumlM3Fd2Y=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w4Vkp-00073a-MW;
	Mon, 23 Mar 2026 03:14:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1w4Vkn-000735-HO
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Mar 2026 03:14:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0uMbHoXkzvBFlJxACWl3bZjVxh5XweLR+jNxROsxi48=; b=kgq27xe64yL9nOGhG3GKtD9tzm
 UhGXPsacH5dPJQd4Zef3iH96nLcysO6axlok69Zr7cwAgeaZy7DOa79chfX1XLMi1EOdRc3swA1Fg
 VJ2wkD22O0OGtkBmO3w2uvFUoJjOBXy2ooiG8v5r6853zy2aRkT3VAkH2xvte+OxOyGU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0uMbHoXkzvBFlJxACWl3bZjVxh5XweLR+jNxROsxi48=; b=FLRAGwkjbCBhs+VS+Dfn5AFWyV
 V3sMkJMZ/p+cRfz3oraRqRVgFfz0hxkF5pOHALHtlom3NmgkpfzAvch1ZgbpuuLHHwUNVYtqBoqgc
 MERpZDXqaPKNzZUtCdhAn62wLcDMWnvYsbbDAuNITOFC7xep4a2jeE7FIhi6oMy5/vSM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w4VkL-00008d-1N for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Mar 2026 03:14:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 709E960008;
 Mon, 23 Mar 2026 03:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF61C19424;
 Mon, 23 Mar 2026 03:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774235658;
 bh=HtTo2MR7FX/XSmMO5nwMt6KFsIRKfj2g+cviNbnmnz4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=qL9O6T6Ym2mvTEu+LupaAfpqWIpxfkZDitTar0GCUBTOqfAzltPKgJrEzhoPHL+An
 egPik7GzlNoLNqBI4zsxrTsjo7Ixc6DDYLpHu8DufUIvfwg1yZ5+a8gJm0YIBxT0Mz
 a5c3s0fxavSi81Ctp4NnnmKzR0X0pTlIW14x3X/27lak3kB2Zb7+uiQt9JjGf1/Gum
 zveN52Mp1H58sOgTRX9uRgDCzFyLS44gHqhc5G70AUQQtSuZKIt5/BYqgt5KREAu2h
 DL5sjr5h5JVoIfnFqafYbwAMy+MD/knk7D5J/Z46oSBy6DkchJa9W6qkv5U3wKUEpc
 vHY6MebBBwtlw==
Message-ID: <37c11065-e055-41b8-82a8-68f2fdf56ac3@kernel.org>
Date: Mon, 23 Mar 2026 11:14:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: kth5965@gmail.com, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <b044d785-cf71-4186-b208-c375c605893b@kernel.org>
 <20260319151121.39737-1-kth5965@gmail.com>
Content-Language: en-US
In-Reply-To: <20260319151121.39737-1-kth5965@gmail.com>
X-Headers-End: 1w4VkL-00008d-1N
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: evict: truncate page cache before
 clear_inode
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
Cc: syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 3/19/26 23:11, kth5965@gmail.com wrote:
> Hi Chao,
> 
> Yes, I agree with your point.
> 
> I also think 2) is useful to detect the corrupted inode earlier and to
> make the issue visible through log and returned error.
> 
> But 2) alone does not seem sufficient, because we can still reach inode
> cleanup later, and then `f2fs_evict_inode()` can still go through the
> inline conversion path.
> 
> So it makes sense to me that we need both:
> 
> 1. earlier detection / guarding in sanity check
> 2. fixing the empty inline conversion path so page #0 cache is not left
>    behind
> 
> If this understanding is correct, I will prepare the fix in that
> direction.

Please go ahead w/ this, thank you!

Thanks,

> 
> Thanks.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
