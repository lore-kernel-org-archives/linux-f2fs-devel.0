Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D27FC6FD18
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 19 Apr 2023 06:28:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pp1J7-0002Cm-TK;
	Wed, 19 Apr 2023 06:28:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pp1J5-0002Cg-JT
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 19 Apr 2023 06:28:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tCTxIK+SnqDMdz2xoQ1WwnromwLS1x6PtHiwDfeV7RA=; b=ic54OLWh1XRX6LON4g9KG27fFn
 aXDm0sFuQSa2+V0C03kGWBg/Bbw3szc8XhMjIj9Bg7FEkBUTPoj4o+/qEV/93HVD6tQuZU5a/fQun
 gAe+bG7kdrWp/7nYBCOz7Fy29lqH2fy0XJ6ZiKgbULf4gLMr7gsRCddyGNBVWK+45zkg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tCTxIK+SnqDMdz2xoQ1WwnromwLS1x6PtHiwDfeV7RA=; b=eAJuJjgh9iaTk/nKOk1ZfIQow9
 3jwQl05jiVAqbOgdNoSKtukz4QilZfSQZZS85KugttErfo+Xjw0mao+Vn6hUci2dvz9M1OXmaGnXw
 IIiq08SBxRKM+JbMATgokucGPHmJHb3GXIfYFJySUk7KawJ/DBjq5syoOH0GcOvkItjs=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pp1J5-00080j-61 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 19 Apr 2023 06:28:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0803963B6E;
 Wed, 19 Apr 2023 06:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F635C433EF;
 Wed, 19 Apr 2023 06:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1681885716;
 bh=985/Kh3t1ZuC33aqHLJddpQN44KiQbFNY0oeobBOvOY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UCuMd2kWq7lnS3b/8L76RDxr3quWOCJnAaMOBzRrnIBatf+HhJVzCNZWl2XLCDYw5
 Pa9Q0+XRBo0phjqWcZ9dTaZ5l4gmWxTrSSkOFaTgrZ59g6OPCQeJKkQ5KWyiM25O6n
 KOrKXTKWLpw4TcjhmFgHPsiclrrtXE2ALtGFOvlAps7cIY1SJT1AN8IEgMwwmi6zBm
 oKwCkbw20bzWNHEgUVbPZ+f3+fhgrwakSFYKkJkKfh3LKEEWz0p5tOXCSdJ2qC3aI+
 wkDtN5Lfe6/04b20GREdHiWCeiig/UeE1dXajukVS5NmBhkh4JA7RKOypw/MsbHz3m
 tk7SlmerkOqWw==
Message-ID: <91a05857-c916-cae5-d61d-bbec6f1ae052@kernel.org>
Date: Wed, 19 Apr 2023 14:28:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20230414104308.6591-1-bo.wu@vivo.com>
 <e2ec7e19-634c-a065-fe7a-b052d02d4752@kernel.org>
 <ZD7AJT7ZYPji8TWk@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZD7AJT7ZYPji8TWk@google.com>
X-Headers-End: 1pp1J5-00080j-61
Subject: Re: [f2fs-dev] [PATCH 1/1] f2fs: allocate trace path buffer from
 names_cache
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
Cc: wubo.oduw@gmail.com, linux-kernel@vger.kernel.org, Wu Bo <bo.wu@vivo.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/4/19 0:07, Jaegeuk Kim wrote:
> On 04/18, Chao Yu wrote:
>> On 2023/4/14 18:43, Wu Bo wrote:
>>> It would be better to use the dedicated slab to store path.
>>>
>>> Signed-off-by: Wu Bo <bo.wu@vivo.com>
>>> ---
>>>    fs/f2fs/file.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index 15dabeac4690..27137873958f 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -4361,7 +4361,7 @@ static void f2fs_trace_rw_file_path(struct kiocb *iocb, size_t count, int rw)
>>>    	struct inode *inode = file_inode(iocb->ki_filp);
>>>    	char *buf, *path;
>>> -	buf = f2fs_kmalloc(F2FS_I_SB(inode), PATH_MAX, GFP_KERNEL);
>>> +	buf = __getname();
>>
>> How about:
>>
>> buf = f2fs_kmem_cache_alloc(names_cachep, GFP_KERNEL, NULL, F2FS_I_SB(inode));
> 
> This looks like a hack using names_cachep?

names_cachep was exported in fs.h.

 > Using f2fs_kmem_cache_alloc is able to inject malloc error.
 > But here is a trace event, is it ok to inject error in a trace path?

Yes, the fail path handling is very simple, so it's fine to leave it
as it is.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
>>
>>>    	if (!buf)
>>>    		return;
>>>    	path = dentry_path_raw(file_dentry(iocb->ki_filp), buf, PATH_MAX);
>>> @@ -4374,7 +4374,7 @@ static void f2fs_trace_rw_file_path(struct kiocb *iocb, size_t count, int rw)
>>>    		trace_f2fs_dataread_start(inode, iocb->ki_pos, count,
>>>    				current->pid, path, current->comm);
>>>    free_buf:
>>> -	kfree(buf);
>>> +	__putname(buf);
>>
>> kmem_cache_free(names_cachep, buf);
>>
>> Thanks,
>>
>>>    }
>>>    static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
