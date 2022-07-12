Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C806C43334
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 Jul 2022 03:20:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oB6S5-0003RE-6T; Tue, 12 Jul 2022 03:20:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1oB6Rv-0003QU-4X
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Jul 2022 03:20:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=szZNUoya9hyOeVlpTYk21XTf4glzGR2vjRotlPdnfc4=; b=Q0+U/DgCx1tEZVV3/+rtZKhC2Q
 kZq2sfwX/pb6ofQe2gQoblt6mgXNGk65vOuyfB25SylHd0f06+kPMMhJ9GTPb3mhZlAwInUrU4SDc
 mcBjYjbwhR4fVLxpHE29s8nHIxLzSv00hpLCUirkkNmpifheJaSPmZsaVB4+eMFU/toU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=szZNUoya9hyOeVlpTYk21XTf4glzGR2vjRotlPdnfc4=; b=gvo8LQIc7Db3MmHc8aJNm0NCGq
 tPXBrltTSsCjcDdu3Td19PQEsqNrhyrzFnW72IJtiiGJGz/KwlFRNZyggoUHNooPFqmOTFv/VinK8
 oI0gWTte8NdW2AyA8cuG+2JiUm2rjMhldaOCOML2zOV7COgGlE5e1uaW9rt4s7QyTWIQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oB6Ru-00ELxS-9v
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Jul 2022 03:20:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5557761713;
 Tue, 12 Jul 2022 03:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B198DC34115;
 Tue, 12 Jul 2022 03:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657596026;
 bh=A94ul8mweh+4BJqDHv4Og+e7RYGSYz/Z21kD0JyUEWw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nNmF6prIjjCZkD+2RNfpv8Yve7XSQpXtIIZSBU1U7YIfd0bS7Fz8ePIKCDYZ7Cjv+
 IJapziuZ6Ensnhb1o0QfsVie+XhXgFx1bOzaz0oHt3Kz68rl9PKEydYp9MSh9UmGQL
 j4Q939pbwRPP0V59MjH5xlrl8kBmQHeHjg6CMKSniqeYTT7Q9FL9fQsXa0yjndBpLo
 7Lm7xMDO+o+qipcj1lO28+PvLdHmTALBG2TzXHa2DHUWAQJ508uhmhSTqqmvl1WARl
 6vqaUfoJhikZaC7YXR5O2raNrw8eEIGKNV6jKSv9qmw5W5mHWD3L9xqCctSBEQbBj8
 vv5ag2UHBPp/w==
Message-ID: <3ee4ce0d-2f50-ca7d-14a9-2368b9db7d13@kernel.org>
Date: Tue, 12 Jul 2022 11:20:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Liu <chaoliu719@gmail.com>
References: <20220707090924.4183376-1-chaoliu719@gmail.com>
 <YszQD8Pk3YTvPgpn@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <YszQD8Pk3YTvPgpn@google.com>
X-Headers-End: 1oB6Ru-00ELxS-9v
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: allow compression of files without
 blocks
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
Cc: Chao Liu <liuchao@coolpad.com>, Wayne Zhang <zhangwen@coolpad.com>,
 Yue Hu <huyue2@coolpad.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/7/12 9:36, Jaegeuk Kim wrote:
> On 07/07, Chao Liu wrote:
>> From: Chao Liu <liuchao@coolpad.com>
>>
>> Files created by truncate(1) have a size but no blocks, so
>> they can be allowed to enable compression.
>>
>> Signed-off-by: Chao Liu <liuchao@coolpad.com>
>> ---
>> v2:
>>   - update commit message: truncate -> truncate(1)
>>
>>   fs/f2fs/file.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 0f29af7876a6..f7a82858486a 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -1879,7 +1879,7 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>>   		if (iflags & F2FS_COMPR_FL) {
>>   			if (!f2fs_may_compress(inode))
>>   				return -EINVAL;
>> -			if (S_ISREG(inode->i_mode) && inode->i_size)
>> +			if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
> 
> What about inline_data case?

How about fixing this w/ a separated patch?

f2fs: fix to check inline_data during compressed inode conversion

Thanks,

> 
>>   				return -EINVAL;
>>
>>   			set_compress_context(inode);
>> --
>> 2.36.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
