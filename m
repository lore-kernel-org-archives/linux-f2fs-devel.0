Return-Path: <SRS0=8g9c=DC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789C1C4727D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Sep 2020 23:31:37 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0564120829;
	Fri, 25 Sep 2020 23:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="dkdsLnsx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="NTO32adh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+nnmkpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0564120829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kLxBg-0004XA-CR; Fri, 25 Sep 2020 23:31:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1kLxBf-0004X3-Re
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Sep 2020 23:31:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZUGBJn4VdJLtz+3w157SlvEz0K2lHkJMfRlC10R3zQE=; b=dkdsLnsxd/Mt2adYUx90yK+BPj
 JQr9qngiXMvikf6ynauf9XzsxcqHcEhuJ5SGOrzFOOZqteBjDcw3TMC3Hjw0wMJegc/FSCZ9baTcf
 EcGyH0/NnINkH5tVQcLj1EEf0H1SOHTyd0QlqCjfdZLgsSfsUTagNCzVTmXDurPKOYSY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZUGBJn4VdJLtz+3w157SlvEz0K2lHkJMfRlC10R3zQE=; b=NTO32adhKy3skFomqMTUGtsSN1
 QxrHsr9lqEWcDaxp2muqMAO7b5FWFk6xjiY3SQlU4aj9MAxpjHMYO7NmhSnfYYce9uoNC8ha7qwyE
 UbAZ7t9v9PJY0Vo7cxQo7087LQ5QZOdEZWWEuk6EpeYOX94PR99owDguZ3qSGhwUMUjY=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kLxBb-0067Rp-1Z
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Sep 2020 23:31:35 +0000
Received: from [192.168.0.108] (unknown [49.65.245.23])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 85FCC20829;
 Fri, 25 Sep 2020 23:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601076685;
 bh=TH7CZqiUY/VEc0Y9Aa4ybddrmMZqqc1VEItbbut6hfE=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=n+nnmkpH+lH4dhzkyHWwCTrO/VVYu9Yg8oGcFsifzZoJnf5AtJ7UcGBMNabSetkY8
 ip29ErO/UATsiznustBlRCGTzUCuCsKtZK8o+QAgEvgxDTGnw2SaFQgYjriRpH4LZ0
 RZaQgTDrzLA+IUdu79vP8ycC7MHjmYiS0iPza08k=
To: Eric Biggers <ebiggers@kernel.org>
References: <20200925151926.2658-1-chao@kernel.org>
 <20200925171436.GC3315208@gmail.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <84cb9909-506b-b1e4-a8a6-1c5c7f5b870c@kernel.org>
Date: Sat, 26 Sep 2020 07:31:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200925171436.GC3315208@gmail.com>
X-Headers-End: 1kLxBb-0067Rp-1Z
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix uninit-value in f2fs_lookup
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020-9-26 1:14, Eric Biggers wrote:
> On Fri, Sep 25, 2020 at 11:19:26PM +0800, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> As syzbot reported:
>>
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x21c/0x280 lib/dump_stack.c:118
>>  kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:122
>>  __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:219
>>  f2fs_lookup+0xe05/0x1a80 fs/f2fs/namei.c:503
>>  lookup_open fs/namei.c:3082 [inline]
>>  open_last_lookups fs/namei.c:3177 [inline]
>>  path_openat+0x2729/0x6a90 fs/namei.c:3365
>>  do_filp_open+0x2b8/0x710 fs/namei.c:3395
>>  do_sys_openat2+0xa88/0x1140 fs/open.c:1168
>>  do_sys_open fs/open.c:1184 [inline]
>>  __do_compat_sys_openat fs/open.c:1242 [inline]
>>  __se_compat_sys_openat+0x2a4/0x310 fs/open.c:1240
>>  __ia32_compat_sys_openat+0x56/0x70 fs/open.c:1240
>>  do_syscall_32_irqs_on arch/x86/entry/common.c:80 [inline]
>>  __do_fast_syscall_32+0x129/0x180 arch/x86/entry/common.c:139
>>  do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:162
>>  do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:205
>>  entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
>>
>> In f2fs_lookup(), @res_page could be used before being initialized,
>> because in __f2fs_find_entry(), once F2FS_I(dir)->i_current_depth was
>> been fuzzed to zero, then @res_page will never be initialized, causing
>> this kmsan warning, relocating @res_page initialization place to fix
>> this bug.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/dir.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
>> index 703cf8e21fc0..83630341ffa3 100644
>> --- a/fs/f2fs/dir.c
>> +++ b/fs/f2fs/dir.c
>> @@ -357,16 +357,15 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
>>  	unsigned int max_depth;
>>  	unsigned int level;
>>
>> +	*res_page = NULL;
>> +
>>  	if (f2fs_has_inline_dentry(dir)) {
>> -		*res_page = NULL;
>>  		de = f2fs_find_in_inline_dir(dir, fname, res_page);
>>  		goto out;
>>  	}
>>
>> -	if (npages == 0) {
>> -		*res_page = NULL;
>> +	if (npages == 0)
>>  		goto out;
>> -	}
>>
>>  	max_depth = F2FS_I(dir)->i_current_depth;
>>  	if (unlikely(max_depth > MAX_DIR_HASH_DEPTH)) {
>
> Can't the assignment to *res_page below be removed too?

Now I checked all branches in find_in_level(), it looks safe to remove *res_page
assignment in the loop.

Thanks,

>
>         for (level = 0; level < max_depth; level++) {
>                 *res_page = NULL;
>                 de = find_in_level(dir, level, fname, res_page);
>                 if (de || IS_ERR(*res_page))
>                         break;
>         }
>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
