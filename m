Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B60C606A321
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Oct 2026 04:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JURooOxw;
	dkim=temperror header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VHGjcult;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WQHsm2dD;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eHRLmm8t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=RqW2m1JvmxfO1wAEGm4yXtQXj6wln5NJhEgA4IWHYaM=; b=JURooOxw2ZeKDY
	YSiQVZKkJ5GFNrcVbWbtWzVR7uTJZ08hKDIg7cndrKJ1eBncouoWSckLLDhTMKIC8anL8VFKr//Hh
	MEjCj1QjEq1OhjSWUBoriJsSMUQ+ODuMN5XDpDvWtKSWFN/ENMqWqbnfuJPaJ0bBTh3tZxNpdnVIn
	6fU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xMeGn-000000007Ny-3Brg;
	Fri, 30 Oct 2026 04:31:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xMeGl-000000007Nq-3cza
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 04:31:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4IW+eTP3qlFhNM2ajwGDdQt1qVWs4834B+J6XwQpvms=; b=VHGjcultZhTxImCyJiBIw3uMNn
 Py1XIaS+pUQ3RC73vvhrRcXyFiXFCZJrdUvFXAkKHcoQFYxKofWySAjz5YIXh80ni+MQaP1Buxw+F
 l6tpEDGt/gNqbRsckF3lYBwrykBXykGaMCfWgxJpkK0FS1I2hl+MEwemqBkeApbdX5EY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4IW+eTP3qlFhNM2ajwGDdQt1qVWs4834B+J6XwQpvms=; b=WQHsm2dDM4STPjkEXwf7bQgpcw
 lt6G+RNAZ0mFtdk2D32Wh/0CngTGcC8nguDBLZoO7L3CHqUg3oP9JQ4IxMd3NggxGvg/J5wSIpjqk
 4T3deXuI0uStp7yrI3KF3GCiEdzdTOWKCaQyp75flZ2pISFqbAXQiRDqHQlI55B1Em+0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMeGk-000000003vY-3l6R
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 04:31:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 814FE42DCD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 04:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527CF1F000C1;
 Fri, 30 Oct 2026 04:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793334665;
 bh=4IW+eTP3qlFhNM2ajwGDdQt1qVWs4834B+J6XwQpvms=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=eHRLmm8tqPMW//AXrXY5DTpcZ5X24nfz4hCUds6P/c4j0RQZSnVRTVw/sf4fShl+6
 b9hpNb9g7UsPsHg9J4lb7Ao8lsPz6euSZXaL1UeX2DOltH4WsvPPPEjFmaIdYdUbFO
 UCRgmBFii4mMPj5L6bpqbyMQp7Sd7FkA8Cl1NkKvFtb5RhMz+aKgGh0+kL33odmvnS
 Ey89o2M7yVxNAkN8jHq68pLWwt1D3GsvnZ6lmc3Qmp6vUBV8VsT0EdzvoHrFEodEFL
 QOW8FAWO8gzANXL+Z/HW5uszLtcf3oNJTGRTTl+e/AlOP9+ErGgXEEUHp+3fJDxuHx
 Lg5Jiozr0TIjw==
Message-ID: <8264bbea-10f9-448b-b88b-529c34ea2f9c@kernel.org>
Date: Fri, 30 Oct 2026 12:31:02 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261028050615.259268-1-jaegeuk@kernel.org>
 <c87b011c-08fa-4e65-8b22-a6bf5a2efd5a@kernel.org>
 <auIUOuuiz3rbwSuZ@google.com>
Content-Language: en-US
In-Reply-To: <auIUOuuiz3rbwSuZ@google.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMeGk-000000003vY-3l6R
Subject: Re: [f2fs-dev] [PATCH] f2fs: do f2fs_zero_post_eof_page for all the
 time
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 23:26, Jaegeuk Kim wrote:
> On 10/28, Chao Yu via Linux-f2fs-devel wrote:
>> On 10/28/26 13:06, Jaegeuk Kim via Linux-f2fs-devel wrote:
>>> This fixes xfstests/generic/794, since the issue is not related to the
>>> posix=strict mode only.
>>
>> Jaegeuk,
>>
>> Actually, I fixed this only in fsync_mode=strict because I don't see such
>> scenario (described in original patch) in Android:
>>
>>      Steps of generic/794:
>>      1. write 4096 bytes to file w/ 0x5a
>>      2. use fiemap to get PBA of first block in file
>>      3. truncate file to 4080
>>      4. umount; write 4096 bytes to file w/ 0x5a directly via PBA; mount

I don't remember there is any case writing via PBA across EOF in Android, let
me know if I missed something.

Ah, it seems a common issue, I can reproduce reading stale data w/ below testcase
which didn't write via PBA:

1. pwrite -S 0x5a 0 4096; fsync; sync
2. truncate 4080
3. Checkpoint without writing back data, then power cut. Two ways to cut power:
  - sysrq-b: f2fs_io checkpoint then echo b > /proc/sysrq-trigger, a real VM reset.
  - shutdown: f2fs_io shutdown 1, which checkpoints and drops dirty data.
4. After recovery, grow the file with truncate 8192, falloc 4096 4096, or pwrite @4096, then f2fs_io checkpoint, umount and mount.
5. Read [4080,4096).

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

>>      5. extend filesize via
>>         a) append 4096 from offset 4096, or
>>         b) truncate 8192, or
>>         c) fallocate 4096 from offset 4096
>>      6. verify the gap is zeroed in memory [4080,4096)
>>      7. sync range 4096 from offset 4096; shutdown -f (flush meta before shutdown)
>>      8. umount; mount; verify [4080,4096) is zeroed or not.
> 
> I saw your comment and I think we should not connect posix=strict to who's
> using that. It was supposed to handle the myth of the recovery on rename().
> This sequence looks general which seems we should guarantee.
> 
>>
>> Maybe we should only enable fsync_mode=strict for 794 to let it pass?
>>
>> Thanks,
>>
>>>
>>> Cc: stable@kernel.org
>>> Fixes: 5eced87b7d19 ("f2fs: fix to zero post-EOF data when extending file size")
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>   fs/f2fs/file.c | 14 ++------------
>>>   1 file changed, 2 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index 8b4a7a9d7dbe..823df06ae0f2 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -74,15 +74,10 @@ static int f2fs_zero_post_eof_page(struct inode *inode,
>>>   					loff_t new_size, bool lock, bool writeback)
>>>   {
>>>   	loff_t old_size = i_size_read(inode);
>>> -	bool strict =
>>> -		F2FS_OPTION(F2FS_I_SB(inode)).fsync_mode == FSYNC_MODE_STRICT;
>>>   
>>>   	if (old_size >= new_size)
>>>   		return 0;
>>>   
>>> -	if (!strict && mapping_empty(inode->i_mapping))
>>> -		return 0;
>>> -
>>>   	if (lock)
>>>   		filemap_invalidate_lock(inode->i_mapping);
>>>   	/* zero or drop pages only in range of [old_size, new_size] */
>>> @@ -90,14 +85,9 @@ static int f2fs_zero_post_eof_page(struct inode *inode,
>>>   	if (lock)
>>>   		filemap_invalidate_unlock(inode->i_mapping);
>>>   
>>> -	if (!writeback || !strict)
>>> +	if (!writeback)
>>>   		return 0;
>>> -	/*
>>> -	 * In fsync_mode=strict, when we expand an unaligned EOF size, we
>>> -	 * should zero post EOF data and writeback the data immediately,
>>> -	 * so that it can avoid exposing stale data after metadata flush
>>> -	 * and POR.
>>> -	 */
>>> +
>>>   	return do_zero_post_eof_page(inode, new_size);
>>>   }
>>>   
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
