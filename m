Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23853FF886F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  4 May 2026 12:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LCx4MYP5TUBrycgeq/HGHFt+2IoSmi3Aw4/5mcBhsfE=; b=TGHLV0/02+v6dsSDK3DWd1Xbg+
	VgtQR7NyL2MC2a4EWsKpbLsV10pRpxaLznOdJzrd8Hkin4T7DUqCYc6WC1d7LS53aBrPdYTjVOTgu
	RPKroC9W04xCwPumFLob3wD3BJVqj8hrwjrULLBd9+ntZgBI3ou91G/CBYiUmslMwzhU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wJsjU-0006jw-2P;
	Mon, 04 May 2026 12:49:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wJsjR-0006jd-Sz
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 May 2026 12:49:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bzgkijcppRHSOdV816RzJULEbqm4YMTQiIYf4OHtQNY=; b=l8xPFlPNlzqbZ4Inv5jvQ1eZSh
 rgjClME2pYJC1cUPVbVYcg5J2pSbjmzIkNYn3YeEdgA2SfcWyrttTc0xstSGa3C5m4pFNQS1TB3fP
 333jypVkuz4w0MceLYASx9jL7VzfYtCfwf7aIeN2vVbfFFSQNrZY8c5p1072FTmo0Czw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bzgkijcppRHSOdV816RzJULEbqm4YMTQiIYf4OHtQNY=; b=bsfCBguzsevJgf+IGdkPgslO5J
 ZzDUmxZ4KFteN0IQe4IIYb00r6NRzya90dFKFZFKTSFxEck0dghclk8Ardrj90DHZI/i6rECaeLdq
 XI3NrTIXduqs3ymOXg9aFRhmpx4Dyur2GyR0JZQOGuwHytLxLXu9mMzIZRYkpj8IHuDk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wJsjS-0000hj-3K for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 May 2026 12:49:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5E2A560132;
 Mon,  4 May 2026 12:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E467FC2BCF6;
 Mon,  4 May 2026 12:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777898935;
 bh=gRpYRmrtNS3hGt3FeZ4hVvrZZ5AWY+e8dbVSL7kGQkM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=i5GkrMsyGX12CNuMTkslHNYX7ZhvGXPJPYnuv7V5tmKvTBZPFAfS9bh2aykpGSYHB
 7WYn+pF14DHstecjIkAZDo7WmL0SkBlYQXB1trM7hWv7NoBViW1CS2/lDHXnQkj2al
 C0wFI7ff2uAqrCtUocC8wLgsmhNPTYr8+LA/NjerSbKI6e+Msx+UCuAo5VrdHW4JhY
 LoJu+uL6tjoz3GUlE3Z+FWizQ759YFslxuBFqUnD4yd3Vpi+C/QlLzMRCN+7YJC689
 6QzeJ7sDNEy7v/psme65llsuqPNWxVW2Q/hDsEVX5iY7WpafZeuzE+8bCkWEsIXPgk
 Ee8vswOOEACTw==
Message-ID: <87bdc398-9387-49bf-ace1-7e7101661767@kernel.org>
Date: Mon, 4 May 2026 20:48:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cen Zhang <zzzccc427@gmail.com>
References: <20260503045820.973718-1-zzzccc427@gmail.com>
 <2ba0b3ad-615e-43c8-a165-af631607a4c3@kernel.org>
 <CAFRLqsUirEtA4+xxVkB9B71+eaqHa+nk78HxT-eAHEW2erJBBA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAFRLqsUirEtA4+xxVkB9B71+eaqHa+nk78HxT-eAHEW2erJBBA@mail.gmail.com>
X-Headers-End: 1wJsjS-0000hj-3K
Subject: Re: [f2fs-dev] [PATCH] f2fs: start discard thread after mount
 recovery
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
Cc: quic_stummala@quicinc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, baijiaju1990@gmail.com,
 jaegeuk@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/3/26 18:16, Cen Zhang wrote:
> Dear Chao Yu
> 
> Thanks for taking a look, and sorry for the confusion.
> 
>>
>> On 5/3/26 12:58, Cen Zhang wrote:
>>> The discard command control is built while the segment manager is
>>> constructed, before the node manager is built and before mount recovery
>>> has completed. Starting the discard thread from that constructor lets the
>>> background thread run while f2fs_fill_super() is still publishing and
>>> initializing mount-time state.
>>>
>>> After commit d6d2b491a82e ("f2fs: allow to change discard policy based
>>> on cached discard cmds"), issue_discard_thread() may consult node-manager
>>> memory thresholds through f2fs_available_free_memory(). It can therefore
>>> observe sbi->nm_info while f2fs_build_node_manager() is publishing and
>>> initializing it. The same early-start window also lets the thread test
>>> the superblock read-only state while recovery paths still make temporary
>>> SB_RDONLY transitions.
>>
>> Not sure I understood you correctly, do you mean this?
>>
> No, I did not mean the old UAF-style failure path. That path should
> already be covered by the existing cleanup ordering:
> 
> free_nm:
>          f2fs_stop_discard_thread(sbi);
>          f2fs_destroy_node_manager(sbi);
> 
> What I was trying to describe is an earlier window during mount
> initialization, when the discard thread is actually started:
> 
> - f2fs_fill_super()
>    - f2fs_build_segment_manager()
>      - create_discard_cmd_control()
>        - f2fs_start_discard_thread()
>    - f2fs_build_node_manager()
>      - sbi->nm_info = f2fs_kzalloc(...)
>      - init_node_manager() initializes fields such as ram_thresh, counters,
>        locks/lists/bitmaps, etc.
> 
> At this point issue_discard_thread() may run concurrently and call
> f2fs_available_free_memory(). That helper reads NM_I(sbi), returns true
> only if it is NULL, and otherwise uses node-manager fields such as
> nm_i->ram_thresh. So my concern is that the thread may observe a newly
> published but still being initialized node manager, rather than a freed
> one.

Cen,

I see, thanks for the explanation.

Can you please update commit message w/ the explanation? That will be helpful
for reviewer and git blame.

Thanks,

> 
> The data race report maps to the following paths in v7.0.3:
> 
>    issue_discard_thread()                fs/f2fs/segment.c:1921
>      f2fs_available_free_memory()        fs/f2fs/node.c:50
>        NM_I()                            fs/f2fs/f2fs.h:2228
> 
> racing with mount-time node-manager initialization:
> 
>    f2fs_fill_super()                     fs/f2fs/super.c:5151
>      f2fs_build_node_manager()           fs/f2fs/node.c:3420
> 
> There is also a similar early-start window for the SB_RDONLY check in
> issue_discard_thread(), since mount recovery can still make temporary
> superblock flag transitions before f2fs_fill_super() reaches the stable
> mounted state. The second report maps to:
> 
>    issue_discard_thread()                fs/f2fs/segment.c:1935
>      f2fs_readonly()                     fs/f2fs/f2fs.h:3665
> 
> racing with mount recovery restoring the superblock flags:
> 
>    f2fs_fill_super()                     fs/f2fs/super.c:5267
>      f2fs_recover_fsync_data()           fs/f2fs/recovery.c:953
> 
> So the patch is intended to fix this lifecycle ordering: keep the discard
> command control available early, but defer starting the background
> discard thread until mount recovery and node-manager initialization have
> completed.
> 
> Please let me know if I missed anything here.
> 
> Best regards,
> Cen



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
