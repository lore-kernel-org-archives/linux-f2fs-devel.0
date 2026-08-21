Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65300C5DF8C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Aug 2026 23:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b11gjI7fuydXDP3fnC62s6Nh+xfGKrp0WOFYUBJe5E4=; b=idaEmzDUY/G5lJLiqDoDFG+15l
	Ik/IT9LIQO77l3QfI6qB+wZBZOnld2ZWWxq52n1AcgRBuo3LPROXk9K961LdkP02DSzYBV3BRj32t
	fz3jTpOomfO9RyVLMNF+O/siE28OINXdwkG+fd3TP15U8HNgsxyUs5un4hGtX+XOj3HI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wxYzB-00049F-2f;
	Fri, 21 Aug 2026 23:49:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wxYyw-000490-GO
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 23:49:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ma/ef2lZGcYxtUb0BPiUJZjS1WnELcgKip4oPnNAKHQ=; b=czKAwC7MRsOT6R3tuCyVKkMoFT
 D3ALIEm1hbCtqTe8mH+vg7t6ZzIl5uWsoxQFcOmnHSn0qlSoPkjCiNTkl29r8Mnhq8ZCFTakBnaDo
 7htr9zM7DpPtxleki4UoM9Axbx3fBtgIMCP0oW4v1XqH/xjve7KcAYBGDm9gg0SKf2Sk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ma/ef2lZGcYxtUb0BPiUJZjS1WnELcgKip4oPnNAKHQ=; b=IOiZu6KltBef/89Zt8LslJnJK7
 NkMASeiIS+ZGwkCJjuuXUbgaznBkIWX8Xy0f8KUdTQmVLprtRp+OSMlFSDAkA94o7Tq/hdLfxC8rd
 wHaR7m9g3ubkytpHociPgAgjRbObp4P5Rj+/5RiukV0tpN5SJOcNe3RWVtVDnZqMCd1w=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wxYyv-0002Ro-Jh for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 23:49:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 020F3600E2;
 Fri, 21 Aug 2026 23:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D0B1F000E9;
 Fri, 21 Aug 2026 23:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787356139;
 bh=Ma/ef2lZGcYxtUb0BPiUJZjS1WnELcgKip4oPnNAKHQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=jSeI0XYifBHfJnsiTyo1Xw9ytbSoss4ZqzI1RWHqABHsVzI7M4rK2YFr5x1C9JhC4
 OI4RyIOaMe2Of1hc1wiQVm4fLDy6rA6u4o80jHlpCa40POypSbovM4VP/OrKQwWaee
 RMVp5z6WiIaZgz8M2YSWL9DRRS1YKCEwEJtYy/iRO77cQBugq+lHPLRctjlg8RYjSF
 mb1/1XQ9mdNppuMe0pGNIP4TUQFXMD0jhCGBRg28n3JsO4sH2GXTCFqvo5ZbUH+g1p
 L5qpj5YQBFNrF5YYrKdAMdPctsBd3Defoth1tbCpvJ/EPe5OlqJ8OjZZM9ZLDRa6Yn
 M8Al/sWutihPg==
Message-ID: <b04fad97-89ea-43fc-a3b0-951c78838bcb@kernel.org>
Date: Sat, 22 Aug 2026 07:48:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, Daeho Jeong <daeho43@gmail.com>
References: <20260821141742.2678300-1-daeho43@gmail.com>
 <aohuDgLbl5SSnJ9T@google.com>
Content-Language: en-US
In-Reply-To: <aohuDgLbl5SSnJ9T@google.com>
X-Headers-End: 1wxYyv-0002Ro-Jh
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix error handling on device alias
 check in rename and unlink
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
Cc: Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, kernel-team@android.com,
 stable@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/21/26 23:26, Jaegeuk Kim via Linux-f2fs-devel wrote:
> On 08/21, Daeho Jeong wrote:
>> From: Daeho Jeong <daehojeong@google.com>
>>
>> In f2fs_rename() and f2fs_unlink(), directly returning -EPERM when
>> encountering a device aliasing file bypasses the cleanup path.
>>
>> Fix this by setting err to -EPERM and jumping to the proper cleanup
>> labels (out_dir and out) instead of returning immediately.
>>
>> Fixes: a737e409a3d6 ("f2fs: support dynamic reserve/release for device aliasing")
>> Cc: stable@kernel.org
> 
> Applied without Fixes and stable, since the original patch has not been
> upstreamed.

Jaegeuk, if we don't plan to merge them, we'd better keep the Fixes and stable
line, otherwise, once the two patches be upstreamed, we may missed to backport
the fix one due to the missing lines?

Thanks,

> 
>> Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>> Reviewed-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/namei.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>> index 784f636244e1..b9b15c5d28de 100644
>> --- a/fs/f2fs/namei.c
>> +++ b/fs/f2fs/namei.c
>> @@ -571,8 +571,10 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
>>   
>>   	trace_f2fs_unlink_enter(dir, dentry);
>>   
>> -	if (IS_DEVICE_ALIASING(inode))
>> -		return -EPERM;
>> +	if (IS_DEVICE_ALIASING(inode)) {
>> +		err = -EPERM;
>> +		goto out;
>> +	}
>>   
>>   	if (unlikely(f2fs_cp_error(sbi))) {
>>   		err = -EIO;
>> @@ -1025,8 +1027,10 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>>   	}
>>   
>>   	if (new_inode) {
>> -		if (IS_DEVICE_ALIASING(new_inode))
>> -			return -EPERM;
>> +		if (IS_DEVICE_ALIASING(new_inode)) {
>> +			err = -EPERM;
>> +			goto out_dir;
>> +		}
>>   
>>   		err = -ENOTEMPTY;
>>   		if (old_is_dir && !f2fs_empty_dir(new_inode))
>> -- 
>> 2.55.0.766.g2966f0265a-goog
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
