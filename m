Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F6EEE01FF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:06:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1soDgn-00010f-0c;
	Wed, 11 Sep 2024 03:06:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1soDgl-00010Y-1o
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Sep 2024 03:06:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=guhPo1XXOSgiXF7DZhenTVkF1p6gDepr5ov0CHEtAc8=; b=ccMLuzxBzqXz3v63SpKqVlUjUM
 d1dE9Kh9NfRgrsBWy7itGVl7eiuAw5xd3EJiTf2ulHc/UhodYmGULaa/KpO+QYcsrgfPSwYV/oBvH
 1m7O7NY25i3lrkwj/+S8qlvvRAfLlU3Dp6/vVGxpDKlWXs5hvRfQ8+G4gd1jbI0j+USA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=guhPo1XXOSgiXF7DZhenTVkF1p6gDepr5ov0CHEtAc8=; b=Kh0G6m0WzpAe/geNY2czrvGG+k
 AbcCejNiCFog0WKnc1qO8WLwm2tkycawJuYzz5PffH+fY49De8Xxv0ibpE1MB0Ku/CCGHRRiv0d7P
 KmlBsuxPj612JqARYf1toKPi5P+Y4nLRMAXJ3EVZntz21O94T2yv42MLNacB4cJXOxXk=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1soDgj-00077U-N7 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Sep 2024 03:06:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BB7865C02F1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 11 Sep 2024 03:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE57C4CEC3;
 Wed, 11 Sep 2024 03:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726023987;
 bh=ta0cFIxUrVPGw1Tmjosf+SAT1/5RHdhMnYyT7R228b4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=r8bR7mv7IBeFSZZw43d/cTlxDeOIVvFOqHu8zm9TvTUtzJRdjSTcLWNRkgKefYMKm
 DO8GVMgRK1No87sOciBl+/gdgtE8lktLNfyEgIev4xJA41DQ3k2Kfts0Nfb5ZIA7ER
 7KbowNJ9wmWjrKg6q+Oo4LcsgFuNdP5rmjAHpycEFvbpWZ1hNSuJdB1mFi8cSpnlhH
 CJS5Oj49VQHEoITQFokdmDjedUWI80GQDMHCt2sdNucrgKbBvgzfB+Zcnmlj8Uk+O9
 DEAIrXwJC4TBjIRVjIAKEa4GYdzmzpwWTGq+pBWCHJionkvLkEe5uqgQH/IpcGkILR
 aGKxi2YE37g6w==
Message-ID: <44f5168e-3931-438e-8a85-3866f797f9b6@kernel.org>
Date: Wed, 11 Sep 2024 11:06:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Eric Biggers <ebiggers@kernel.org>
References: <20240910125753.80502-1-chao@kernel.org>
 <20240910170600.GB2642@sol.localdomain>
Content-Language: en-US
In-Reply-To: <20240910170600.GB2642@sol.localdomain>
X-Headers-End: 1soDgj-00077U-N7
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to tag STATX_DIOALIGN only if
 inode support dio
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/9/11 1:06, Eric Biggers wrote:
> On Tue, Sep 10, 2024 at 08:57:53PM +0800, Chao Yu via Linux-f2fs-devel wrote:
>> After commit 5c8764f8679e ("f2fs: fix to force buffered IO on inline_data
>> inode"), f2fs starts to force using buffered IO on inline_data inode.
>>
>> And also, it will cause f2fs_getattr() returning invalid zeroed value on
>> .dio_mem_align and .dio_offset_align fields, however, STATX_DIOALIGN flag
>> was been tagged. User may use zeroed .stx_dio_offset_align value
>> since STATX_DIOALIGN was been tagged, then it causes a deadloop during
>> generic/465 test due to below logic:
>>
>> align=stx_dio_offset_align(it equals to zero)
>> page_size=4096
>> while [ $align -le $page_size ]; do
>> 	echo "$AIO_TEST -a $align -d $testfile.$align" >> $seqres.full
>> 	$AIO_TEST -a $align -d $testfile.$align 2>&1 | tee -a $seqres.full
>> 	align=$((align * 2))
>> done
>>
>> Quoted from description of statx manual:
>>
>> " If  a  filesystem  does  not support a field or if it has an
>>    unrepresentable value (for instance, a file with an exotic type),
>>    then the mask bit corresponding to that field will be cleared in
>>    stx_mask even if the user asked for it and a dummy value will be
>>    filled in for compatibility purposes if one is available (e.g.,
>>    a dummy UID and GID may be specified to mount under some
>>    circumstances)."
>>
>> We should not set STATX_DIOALIGN flag in kstat.stx_mask if inode
>> does not support DIO, so that it can indicate related fields contain
>> dummy value, and avoid following incorrect use of them.
>>
>> Fixes: c8c02272a9f7 ("f2fs: support STATX_DIOALIGN")
> 
> When claiming to be Fixing a commit, please make sure to Cc the author of that
> commit.

No problem, will make sure they were Cced.

> 
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/file.c | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 99903eafa7fe..f0b8b77e93ba 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -906,14 +906,11 @@ int f2fs_getattr(struct mnt_idmap *idmap, const struct path *path,
>>   	 * f2fs sometimes supports DIO reads but not DIO writes.  STATX_DIOALIGN
>>   	 * cannot represent that, so in that case we report no DIO support.
>>   	 */
>> -	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
>> -		unsigned int bsize = i_blocksize(inode);
>> -
>> +	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode) &&
>> +				!f2fs_force_buffered_io(inode, WRITE)) {
>> +		stat->dio_mem_align = F2FS_BLKSIZE;
>> +		stat->dio_offset_align = F2FS_BLKSIZE;
>>   		stat->result_mask |= STATX_DIOALIGN;
>> -		if (!f2fs_force_buffered_io(inode, WRITE)) {
>> -			stat->dio_mem_align = bsize;
>> -			stat->dio_offset_align = bsize;
>> -		}
>>   	}
>>   
>>   	flags = fi->i_flags;
> 
> No, this patch is wrong and the existing code is correct.  The cases are:

Yes, you're right, thanks for pointing out this!

> 
>      STATX_DIOALIGN set and stx_dio_*_align nonzero:
>          File supports DIO.
> 
>      STATX_DIOALIGN set and stx_dio_*_align zero:
>          File doesn't support DIO.
> 
>      STATX_DIOALIGN unset:
>          Filesystem doesn't support STATX_DIOALIGN, so it's unknown whether the
>          file supports DIO or not.

Above description is clear to me.

> 
> Please see the statx(2) manual page which explains this too.

However, below manual seems not very clear about explaining what does it
mean about STATX_DIOALIGN is set or not? At least not so clear like above
description.

        stx_dio_mem_align
               The alignment (in bytes) required for user memory buffers for direct I/O (O_DIRECT) on this file, or 0 if direct I/O is not supported on this file.

               STATX_DIOALIGN (stx_dio_mem_align and stx_dio_offset_align) is supported on block devices since Linux 6.1.  The support on regular files varies by filesystem; it is supported by ext4, f2fs, and xfs since  Linux
               6.1.

        stx_dio_offset_align
               The  alignment  (in  bytes)  required  for  file  offsets  and  I/O  segment  lengths  for  direct  I/O  (O_DIRECT)  on this file, or 0 if direct I/O is not supported on this file.  This will only be nonzero if
               stx_dio_mem_align is nonzero, and vice versa.

Thanks,

> 
> - Eric



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
