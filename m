Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AD4ECAAA1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Oct 2022 03:39:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ooGD2-0005p3-SY;
	Fri, 28 Oct 2022 03:39:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ooGCz-0005op-B5
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Oct 2022 03:39:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N0Frx5jnm/3u/6oiT7Vm9MzAhuCX5AMpIeiPUw4BVjs=; b=KNbXhZLEb8B6ZlUBIU/b2IFtN/
 PsBVy+SDbAL8jcUGsjUQIjT8lA16Ez0U+dBUfjkF8hXlAMBfGw9JC0fCHyOomY3Z/lz6K4b6u1g5Q
 Wxcg7HY/FU/HLVe+zERGEhUDd39MrTckgvxGZnTfqiS/klDVtJS6gOy4tcywqruInfYQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=N0Frx5jnm/3u/6oiT7Vm9MzAhuCX5AMpIeiPUw4BVjs=; b=MoKqgPYf3NPcS4N7A6aZLJLa3e
 mcvxJF4UHYUeTDHFeadh0TxHSc5q6p4vZ+uljcWhUq8wGJkHYDBDsrNnv2BVfMclo+v/YNXhjq/XI
 V2716eG3K/iVTJdRdaZYP4U8ekT5FlL8il/PDQp07FyJ1tAf9zk/5k5HbssEvyP9hRls=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ooGCy-0004Jr-Oi for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Oct 2022 03:39:01 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 59D20625AF;
 Fri, 28 Oct 2022 03:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C884C43143;
 Fri, 28 Oct 2022 03:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666928330;
 bh=LlaI4t3FOeyLoIjMSrcnwjGr/jnLctc2/+mhw1nvwvw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hhxzI6gTbO/hJXBbU7Jg9pg0rFmgnnSa7QMZs29ycIObFnUxzdmQBfKlYV4peGvMv
 rI0nZPSIXRDa/jFSxmvWfv4PjAml4mGt+s8piyNpxuK8DPRdOSP032ZA1ne1z31eN6
 fwl9HCp2nNS4zV3T96y+nroFqa6c8uzfNzVAKbWVq1pfD46pmre3aWHr8+kTiurNW9
 b7ITK0pTB/wTUT0QQvAvVJf1WSmNE6Mcpl2AwPIhvR+5WCHWEY/L+k7CSHozLtiyU1
 fcHP1sKy6//NR5oGIKCWvO8STaJBNoeQyWeTy2sTsSKMwBfct0noimqNZuWboYfFw0
 P7g+C5UcnTVsg==
Message-ID: <9b7357f3-5e5e-c1db-fdf8-613b6ad7bac3@kernel.org>
Date: Fri, 28 Oct 2022 11:38:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <ab2f3576-bedd-8c27-5549-f9ff5462aee3@kernel.org>
 <20221028023303.28020-1-frank.li@vivo.com>
 <85b6be9b-5c5b-ace0-8084-4bd52ef64996@kernel.org>
 <Y1tJ4uKBa0ItHCBw@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Y1tJ4uKBa0ItHCBw@google.com>
X-Headers-End: 1ooGCy-0004Jr-Oi
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: fix to f2fs_handle_critical_error
 when errors=remount-ro
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
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Yangtao Li <frank.li@vivo.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/10/28 11:17, Jaegeuk Kim wrote:
> On 10/28, Chao Yu wrote:
>> On 2022/10/28 10:33, Yangtao Li wrote:
>>>> It won't pollute global namespace since it's a static function just be used in f2fs/super.c...
>>>
>>> emm, I think it would be nice to see the f2fs_record_error_work symbol
>>> in the stack, it can be explicitly a function of f2fs. personal opinion for reference only.
>>
>> Oh, yes, let me update in original patch as well.
> 
> Chao,
> 
> It seems there're multiple bugs. Please apply this as well.
> 
> https://lore.kernel.org/linux-f2fs-devel/20221027180416.3786792-1-jaegeuk@kernel.org/T/#u

Jaegeuk,

Thanks, let me merge all those patches and do the test.

Thanks,

> 
>>
>>>
>>>> Do you mind letting me merge these two patches into original patch?
>>>> since original patch is still in dev branch, rather than mainline.
>>>
>>> Glad to see, if resend.
>>
>> Thanks, :)
>>
>>>
>>>> I guess it needs to stop ckpt thread as well...
>>>
>>> agree, :)
>>>
>>> Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
