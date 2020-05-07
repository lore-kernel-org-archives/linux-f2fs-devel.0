Return-Path: <SRS0=Htwq=6V=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C0AC28CBC
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  7 May 2020 02:45:22 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8012920838;
	Thu,  7 May 2020 02:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="LrMAxi1+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="SwIK+g89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8012920838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jWWXJ-0003a0-3e; Thu, 07 May 2020 02:45:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jWWXH-0003Zs-9v
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 07 May 2020 02:45:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eS3C6H/OkdUKb3Yf4oYqi+TMBXXgqXl78/lJF6x2drs=; b=LrMAxi1+x4Nj1HFqLfnd62mRhZ
 WgJDNffJNG9v6aEKyKoR8DdBxG+K/Yg/ZuXS6wSJGWh8+fw7mbyJZCi1pWXdWX+PsW1FGyN2tD8OX
 vlUDd04ZulcHQN8MCqTZNqdW59qGSDfBuQ1zodH/7yk1JykiORSB9LDHnh2vIZ59VVOw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eS3C6H/OkdUKb3Yf4oYqi+TMBXXgqXl78/lJF6x2drs=; b=SwIK+g890sKhNPTvnNZCPe2xP4
 iGiVk5OpRhtyyQ/Q7ingZ4+hSzNnNeZCJbKmzU8kH4D3EmSoB+nhFq0H9BH1eYDRBAp9HO9szr8Kl
 ZUjZsw/si9SE+B466S1aRlHGFdHPrmfKJ4bkJfVoAlEYIv6evzActUgWFquZ7trp6h4s=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jWWXF-00De9P-5y
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 07 May 2020 02:45:19 +0000
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 0C4169141BF447897676;
 Thu,  7 May 2020 10:45:07 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 7 May 2020
 10:45:05 +0800
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20200502002920.76569-1-jaegeuk@kernel.org>
 <66e59a2f-c877-6952-cae6-645ba18f9f75@huawei.com>
 <20200506143945.GA107238@google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <4cccf2e5-991e-f5b0-eab3-9b65c5003993@huawei.com>
Date: Thu, 7 May 2020 10:45:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200506143945.GA107238@google.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1jWWXF-00De9P-5y
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs_io: add fsync
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/5/6 22:39, Jaegeuk Kim wrote:
> On 05/06, Chao Yu wrote:
>> On 2020/5/2 8:29, Jaegeuk Kim wrote:
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  tools/f2fs_io/f2fs_io.c | 25 +++++++++++++++++++++++++
>>>  1 file changed, 25 insertions(+)
>>>
>>> diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
>>> index c1edef1..c84b6ab 100644
>>> --- a/tools/f2fs_io/f2fs_io.c
>>> +++ b/tools/f2fs_io/f2fs_io.c
>>> @@ -130,6 +130,30 @@ static void full_write(int fd, const void *buf, size_t count)
>>>  	}
>>>  }
>>>  
>>> +#define fsync_desc "fsync"
>>> +#define fsync_help						\
>>> +"f2fs_io fsync [file]\n\n"					\
>>
>> What about supporting fdatasync via an additional argument here?
> 
> I prefer to add another command "fdatasync" for simplicity. :P

LGTM as well. :)

Thanks

> 
>>
>>> +"fsync given the file\n"					\
>>> +
>>> +static void do_fsync(int argc, char **argv, const struct cmd_desc *cmd)
>>> +{
>>> +	int fd;
>>> +
>>> +	if (argc != 2) {
>>> +		fputs("Excess arguments\n\n", stderr);
>>> +		fputs(cmd->cmd_help, stderr);
>>> +		exit(1);
>>> +	}
>>> +
>>> +	fd = xopen(argv[1], O_WRONLY, 0);
>>> +
>>> +	if (fsync(fd) != 0)
>>> +		die_errno("fsync failed");
>>> +
>>> +	printf("fsync a file\n");
>>> +	exit(0);
>>> +}
>>> +
>>>  #define set_verity_desc "Set fs-verity"
>>>  #define set_verity_help					\
>>>  "f2fs_io set_verity [file]\n\n"				\
>>> @@ -780,6 +804,7 @@ static void do_reserve_cblocks(int argc, char **argv, const struct cmd_desc *cmd
>>>  static void do_help(int argc, char **argv, const struct cmd_desc *cmd);
>>>  const struct cmd_desc cmd_list[] = {
>>>  	_CMD(help),
>>> +	CMD(fsync),
>>>  	CMD(set_verity),
>>>  	CMD(getflags),
>>>  	CMD(setflags),
>>>
> .
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
