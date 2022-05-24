Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC335C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 May 2022 06:30:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ntO3Z-0002b4-5I; Tue, 24 May 2022 06:30:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1ntO3X-0002ay-CF
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 May 2022 06:30:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G6mNnnv3S7797iEEDsQ9knkhMiX/iHIqDXH6dYF5yzQ=; b=XoKNZMU8EMHLHS8lofK4yHnqQX
 4T2QD9DvTqr6lDZ+3cSyzrm7gdJiRSn+GYBwOTmwT1fpDPe8Qfpce7a75aKnxyU9kicBWP+fKQbW8
 7KIi1xPE3pAAHHYS6eq0kvNiDxQgrVNMuIfMj79CIyZwS7gA4r+v160MJBJEifRNNShM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=G6mNnnv3S7797iEEDsQ9knkhMiX/iHIqDXH6dYF5yzQ=; b=gQYi5O6i3AoFXoB7VeDF76nWLu
 QWur9rxg2VLa9gAW4qy0NQ5ij0Dg9WvzB0oiFXAFEW41r4K5LL6tVZZAb5yFIN401Nfsebe2Fn+WN
 8jn8SEbfBCznqgx6ZD795JadGv6qMIv1e3a7ozaY+9G/edIRLxspMsRElF5zuYkDfqsI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1ntO3R-0001qY-6J
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 May 2022 06:30:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A01E4614F5;
 Tue, 24 May 2022 06:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5513EC385AA;
 Tue, 24 May 2022 06:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653373794;
 bh=pvaK40OKCL4qKe8jz4FmcrdheHkRl9UGB66B2uyK7bo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=b5xeMrfLHjrebDw3mwc5bitrk2GZSMknsjZQqgWSVpId8mYP6sSDGprH20ApTTXrJ
 MaveXMlqu1bzFj/ZKK3ZVo+OcziD6ujfg77tDDuPCYqOa4ToIYEsaGlzzfU0irRcEb
 zKA3fbEPuf6xuypqO9xMpUZfmBLCxqyoF98bt/yG5vOqPcbReuPXvVz+czZDnwBb1A
 FQA2lPrz5p7TQAq3AJdxaEDsLf8H+iUaEWNYQKrfCBNTAA70AhRSBn1tLw+QR82447
 4J115HbswUNBfH68N+GCHkvehmZR9JzL+b6axctW/W13k51nwVZ1famSk+hRITUHq2
 hwQz9nYeyE3Dg==
Message-ID: <227d10d5-2afe-acfa-7cfc-3a2f45331c6f@kernel.org>
Date: Tue, 24 May 2022 14:29:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220428181809.2352352-1-daeho43@gmail.com>
 <dd1ea728-4cb6-e35d-dc76-a1d62bead69a@kernel.org>
 <YovMeQO2n0XAxMhe@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <YovMeQO2n0XAxMhe@google.com>
X-Headers-End: 1ntO3R-0001qY-6J
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: change the current atomic write way
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/5/24 2:03, Jaegeuk Kim wrote:
> On 05/22, Chao Yu wrote:
>> On 2022/4/29 2:18, Daeho Jeong wrote:> +		*old_addr = dn.data_blkaddr;
>>> +		f2fs_truncate_data_blocks_range(&dn, 1);
>>> +		dec_valid_block_count(sbi, F2FS_I(inode)->cow_inode, count);
>>> +		inc_valid_block_count(sbi, inode, &count);
>>> +		f2fs_replace_block(sbi, &dn, dn.data_blkaddr, new_addr,
>>> +					ni.version, true, false);
>>
>> My concern is, if cow_inode's data was persisted into previous checkpoint,
>> and then f2fs_replace_block() will update SSA from cow_inode to inode?
> 
> SSA for original file is intact, so we'll see the orignal file's block addresses
> and SSA, if we flush cow_inode's SSA after committing the atomic writes?
> It'd be good to flush any SSA for cow_inode, since we'll truncate
> cow_inode after powercut by the ohphan recovery?

I think it's safe for recovery flow, but before that, fsck will report inconsistent
status during checking orphan atomic_write inode.

Thanks,

> 
>> it will cause inconsistent status of last valid checkpoint? Or am I mssing
>> something?
>>
>>> -		f2fs_submit_merged_write_cond(sbi, inode, NULL, 0, DATA);
>>> +			new = f2fs_kmem_cache_alloc(revoke_entry_slab, GFP_NOFS,
>>> +							true, NULL);
>>> +			if (!new) {
>>> +				f2fs_put_dnode(&dn);
>>> +				ret = -ENOMEM;
>>> +				goto out;
>>
>> It doesn't need to handle failure of f2fs_kmem_cache_alloc()
>> due to nofail parameter is true.
>>
>> Thanks,
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
